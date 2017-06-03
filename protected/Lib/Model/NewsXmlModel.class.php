<?php
class NewsXmlModel extends Model {
			
	//采集入库 先智能判断是否有相同文章，最后都没有的情况才新添加
  public function xml_insert($news){
	  if(empty($news['news_name']) || empty($news['news_content'])){
			return '文章名称或文章内容为空，不做处理!';
		}
		if(!$news['news_cid']){
			return '未匹配到对应栏目分类，不做处理!';
		}
		// 要查询检查的字段
		$field = 'news_id,news_cid,news_name,news_remark,news_content';
		// 格式化常规字符
		if(empty($news['news_remark'])){
			$news['news_remark'] = msubstr(trim($news['news_content']),0,100,'utf-8',false);
		}		
		// 检测文章名称是否相等(需防止同名的冲突所以增加了CID条件)
		$array = M('News')->field($field)->where('news_cid='.$news['news_cid'].' and news_name="'.$news['news_name'].'" ')->find();		
		if($array){
			return $this->xml_update($news, $array);
		}
		// 添加文章开始
		unset($news['news_id']);		
		if( empty($news['news_hits']) ){
			$news['news_hits'] = mt_rand(1,C('collect_hits'));
		}
		if( empty($news['news_up']) ){
			$news['news_up'] = mt_rand(1,C('collect_updown'));
		}
		if( empty($news['news_down']) ){
			$news['news_down'] = mt_rand(1,C('collect_updown'));
		}
		if( empty($news['news_gold']) ){
			$news['news_gold'] = mt_rand(1,C('collect_gold'));
		}
		if( empty($news['news_golder']) ){
			$news['news_golder'] = mt_rand(1,C('collect_golder'));
		}
		if( empty($news['news_ename']) ){
			$news['news_ename'] = ff_pinyin($news['news_name']);
		}
		if( empty($news['news_addtime']) ){
			$news['news_addtime'] = time();
		}else{
			$news['news_addtime'] = strtotime($news['news_addtime']);
		}
		// 自动下载远程海报图片
		$img = D('Img');
		$news['news_pic'] = $img->down_load($news['news_pic']);	
		// 入库接口	
		$id = M('News')->data($news)->add();
		// 关联多分类及TAG相关
		if($id){
			// 增加多分类
			if( $news['news_type'] ){
				D('Tag')->tag_update($id, $news["news_type"], 'news_type');
			}
			// 增加关联tag
			if( $vod['vod_keywords'] ){
				D('Tag')->tag_update($id, $vod["vod_keywords"], 'news_tag');
			}	
			return '文章添加成功。';
		}
		return '文章添加失败。';
  }	
	
	// 更新数据
	public function xml_update($news, $news_old){	
		// 检测是否站长手动锁定更新
		if('feifeicms' == $news_old['news_inputer']){
			return '站长手动设置，不更新。';
		}
		$edit = array();
		if($news['news_content'] == $news_old['news_content']){
			return '文章内容未变化，不需要更新。';
		}else{
			$edit['news_content'] = $news['news_content'];
		}
		// 组合更新条件及内容(以最后一次更新的库为检测依据)
		$edit['news_id'] = $news_old['news_id'];
		$edit['news_name'] = $news['news_name'];
		$edit['news_reurl'] = $news['news_reurl'];
		$edit['news_addtime'] = time();
		// 更新数据
		M('News')->data($edit)->save();
		//删除数据缓存
		if(C('cache_page_news')){
			S('cache_page_news_'.$news_old['news_id'],NULL);
		}
		return '文章已更新。';
	}					
}
?>