<?php
class VodXmlModel extends Model {
			
	//采集入库 先检查库里面是否有相同来源地址，再智能判断是否有相同影片，最后都没有的情况才新添加
  public function xml_insert($vod){
	  if(empty($vod['vod_name']) || empty($vod['vod_url']) || empty($vod['vod_play'])){
			return '影片名称或播放器名称或播放地址为空，不做处理!';
		}
		if(!$vod['vod_cid']){
			return '未匹配到对应栏目分类，不做处理!';
		}
		// 要查询检查的字段
		$field = 'vod_id,vod_cid,vod_name,vod_title,vod_actor,vod_continu,vod_isend,vod_total,vod_inputer,vod_play,vod_url';
		// 格式化常规字符
		$vod['vod_name'] = ff_xml_vodname($vod['vod_name']);
		$vod['vod_actor'] = ff_xml_vodactor($vod['vod_actor']);
		$vod['vod_director'] = ff_xml_vodactor($vod['vod_director']);	
		// 检测来源是否完全相同
		$array = M('Vod')->field($field)->where('vod_reurl="'.$vod['vod_reurl'].'"')->find();
		if($array){
			return $this->xml_update($vod, $array);
		}
		// 检测影片名称是否相等(需防止同名的电影与电视冲突所以增加了CID条件)
		$array = M('Vod')->field($field)->where('vod_cid='.$vod['vod_cid'].' and vod_name="'.$vod['vod_name'].'" ')->find();
		if($array){
			//演员完全相等时 更新该影片
			if( $array['vod_actor'] == $vod['vod_actor'] ){
				return $this->xml_update($vod, $array);
			}
			//演员有部份相同时更新该影片
			$arr_actor_1 = explode(',', ff_xml_vodactor($vod['vod_actor']));
			$arr_actor_2 = explode(',', ff_xml_vodactor($array['vod_actor']));
			if(array_intersect($arr_actor_1,$arr_actor_2)){
				return $this->xml_update($vod, $array);
			}
		}
		//  检测影片名称相似度
		if(C('collect_name')){
			$length = ceil(strlen($vod['vod_name'])/3) - intval(C('collect_name'));
			if($length > 1){
				$where = array();
				$where['vod_cid'] = array('eq',$vod['vod_cid']);
				$where['vod_name'] = array('like',msubstr($vod['vod_name'],0,$length).'%');
				$array = M('Vod')->field($field)->where($where)->order('vod_id desc')->find();
				if($array){
					// 主演完全相同 则检查是否需要更新
					if(!empty($array['vod_actor']) && !empty($vod['vod_actor']) ){
						$arr_actor_1 = explode(',', ff_xml_vodactor($vod['vod_actor']));
						$arr_actor_2 = explode(',', ff_xml_vodactor($array['vod_actor']));
						if(!array_diff($arr_actor_1,$arr_actor_2) && !array_diff($arr_actor_2,$arr_actor_1)){//若差集为空
							return $this->xml_update($vod, $array);
						}
					}
					// 不是同一资源库 则标识为相似待审核
					if(!in_array($vod['vod_inputer'],$array)){
						$vod['vod_status'] = -1;
					}
				}
			}
		}
		// 添加影片开始
		unset($vod['vod_id']);
		if(empty($vod['vod_hits'])){
			$vod['vod_hits'] = mt_rand(1,C('collect_hits'));
		}
		if(empty($vod['vod_ename'])){
			$vod['vod_ename'] = ff_pinyin($vod['vod_name']);
		}
		if(empty($vod['vod_up'])){
			$vod['vod_up'] = mt_rand(1,C('collect_updown'));
		}
		if(empty($vod['vod_down'])){
			$vod['vod_down'] = mt_rand(1,C('collect_updown'));
		}
		if( empty($vod['vod_gold']) ){
			$vod['vod_gold'] = mt_rand(1,C('collect_gold'));
		}
		if( empty($vod['vod_golder']) ){
			$vod['vod_golder'] = mt_rand(1,C('collect_golder'));
		}
		if( empty($vod['vod_addtime']) ){
			$vod['vod_addtime'] = time();
		}else{
			$vod['vod_addtime'] = strtotime($vod['vod_addtime']);
		}
		// 随机伪原创
		if(C('collect_original')){
			$vod['vod_content'] = ff_rand_str($vod['vod_content']);
		}
		// 自动下载远程图片
		$vod['vod_pic'] = D('Img')->down_load($vod['vod_pic']);	
		//
		$vod['vod_letter'] 	= ff_url_letter($vod['vod_name']);
		// 入库
		$id = M('Vod')->data($vod)->add();
		// 关联多分类及TAG相关
		if($id){
			// 增加多分类
			if( $vod['vod_type'] ){
				D('Tag')->tag_update($id, $vod["vod_type"], 'vod_type');
			}
			// 自动获取关键词tag
			if(empty($vod['vod_keywords']) && C('collect_tags')){
				$vod['vod_keywords'] = ff_tag_auto($vod["vod_name"], $vod["vod_content"]);
			}
			// 增加关联tag
			if( $vod['vod_keywords'] ){
				D('Tag')->tag_update($id, $vod["vod_keywords"], 'vod_tag');
			}			
			return '视频添加成功('.$id.')。';
		}
		return '视频添加失败。'.M('Vod')->getDbError();
  }	
	
	// 根据影片ID更新数据
	public function xml_update($vod, $vod_old){	
		// 检测是否站长手动锁定更新
		if('feifeicms' == $vod_old['vod_inputer']){
			return '站长手动设置，不更新。';
		}
		$edit = $this->xml_play_url($vod, $vod_old);//return false/array
		if($edit == false){
			return '播放地址组未变化，不需要更新。';
		}
		// 组合更新条件及内容(以最后一次更新的库为检测依据)
		$edit['vod_id'] = $vod_old['vod_id'];
		$edit['vod_addtime'] = time();
		$edit['vod_name'] = $vod['vod_name'];
		$edit['vod_inputer'] = $vod['vod_inputer'];
		$edit['vod_reurl'] = $vod['vod_reurl'];
		// 存在的字段才更新
		if(isset($vod['vod_total'])){
			$edit['vod_total'] = $vod['vod_total'];	
		}
		if(isset($vod['vod_continu'])){
			$edit['vod_continu'] = $vod['vod_continu'];	
		}
		if(isset($vod['vod_isend'])){
			$edit['vod_isend'] = $vod['vod_isend'];	
		}
		if(isset($vod['vod_filmtime'])){ 
			$edit['vod_filmtime'] = $vod['vod_filmtime']; 
		}
		if(isset($vod['vod_length'])){ 
			$edit['vod_length'] = $vod['vod_length']; 
		}		
		if(isset($vod['vod_state'])){ 
			$edit['vod_state'] = $vod['vod_state']; 
		}
		if(isset($vod['vod_version'])){ 
			$edit['vod_version'] = $vod['vod_version']; 
		}
		if(isset($vod['vod_tv'])){ 
			$edit['vod_tv'] = $vod['vod_tv']; 
		}
		if(isset($vod['vod_scenario'])){ 
			$edit['vod_scenario'] = $vod['vod_scenario']; 
		}
		// 更新数据
		M('Vod')->data($edit)->save();
		//删除数据缓存
		if(C('cache_page_vod')){
			S('cache_page_vod_'.$vod_old['vod_id'],NULL);
		}
		return $edit['vod_update_info'];
	}
	
	//根据来源地址更新资料字字段
	public function xml_field($vod, $reurl){
		if($vod['vod_pic']){
			$vod['vod_pic'] = D('Img')->down_load($vod['vod_pic']);
		}
		return M('Vod')->where("vod_inputer !='feifeicms' and vod_reurl='".$reurl."'")->data($vod)->save();
	}
	
	//根据新的播放器与播放地址 检查是否需要更新对应的播放器地址或新增加
	public function xml_play_url($vod, $vod_old){
		$edit = array();
		$edit['vod_update_info'] = false;	
		// 只有一组播放器且地址相同直接跳出
		if($vod_old['vod_url'] == $vod['vod_url']){
			return false;
		}
		// 分解原服务器组
		$array_play_old = explode('$$$', $vod_old['vod_play']);
		$array_url_old = explode('$$$', $vod_old['vod_url']);
		// 旧的播放器组
		if($array_play_old[0]){
			$array_old = array();
			foreach($array_play_old as $play_key=>$play_value){
				$array_url = explode(chr(13),str_replace(array("\r\n", "\n", "\r"), chr(13), $array_url_old[$play_key]));
				$array_play = array();
				foreach($array_url as $key=>$value){
					$array_play[$play_value][$play_key][$key] = $value;
				}
				//如有两个PPTV的情况所以需要重新排序
				foreach($array_play[$play_value] as $key=>$value){
					$array_old[$play_value][] = $value;
				}
			}
		}
		//要处理的新播放地址 有两组PPTV的情况 更新第1个
		$array_url = explode(chr(13),str_replace(array("\r\n", "\n", "\r"), chr(13), $vod['vod_url']));
		$array_url = array_unique($array_url);//去重
		foreach($array_url as $key=>$url_new){
			$play = $vod['vod_play'];
			$url_old = $array_old[$play][0][$key];
			if($url_old && $url_new){
				if($url_old != $url_new){
					$array_old[$play][0][$key] = trim($url_new);
					$edit['vod_update_info'] = strtoupper($vod['vod_play']).'旧播放地址已更新 ';
				}
			}else{
				$array_old[$play][0][$key] = trim($url_new);
				$edit['vod_update_info'] = strtoupper($vod['vod_play']).'播放地址有新增加 ';
			}
		}
		//播放地址没有变化则返回false
		if($edit['vod_update_info'] == false){
			return false;
		}
		// 重新拼装成数据库格式
		$array_new = array();
		foreach($array_old as $play=>$value){
			foreach($value as $key=>$url){
				$array_new['vod_play'][] = $play;
				$array_new['vod_url'][] = implode(chr(13),$url);
			}
		}
		//dump($array_new);
		$edit['vod_play'] = implode('$$$',$array_new['vod_play']);
		$edit['vod_url'] = implode('$$$',$array_new['vod_url']);
		return $edit;
	}
}
?>