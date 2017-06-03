<?php
/*项目入口根模块*/
class AllAction extends Action{
  //构造函数
  public function _initialize(){
    header("Content-Type:text/html; charset=utf-8");
  }
	// 标签话题
	public function Lable_Tags($params, $module = 'vod'){
		$params = ff_param_url();
		foreach($params as $key=>$value){
			if(in_array($key, array('name','id','type','tag','cid','ename','page','ajax')) ){
				$array['tag_'.$key] = $value;
			}
		}
		$array['tag_module'] = $module;
		$array['tag_skin'] = $module.'_tags';
		if($params['ajax']){
			$array['tag_skin'] .= '_ajax';
		}
		$array['tag_skin'] = 'Home:'.$array['tag_skin'];
		$array['site_sid'] = 4;
		return $array;
	}	
	// 影视多分类筛选变量定义
	public function Lable_Vod_Type($params, $array){
		foreach($params as $key=>$value){
			if(in_array($key, array('id','type','area','year','star','state','order','limit','letter','language','page','ajax')) ){
				$array['type_'.$key] = $value;
			}
		}
		//模板名称定义
		if (empty($array['list_skin_type'])) {
			$array['list_skin_type'] = 'vod_type';
		}
		if($params['ajax']){
			$array['list_skin_type'] .= '_ajax';
		}
		$array['list_skin_type'] = 'Home:'.$array['list_skin_type'];
		$array['site_sid'] = 1;
		return $array;
  }
	// 影视搜索变量定义
	public function Lable_Vod_Search($params){
		$array = array();
		foreach($params as $key=>$value){
			if(in_array($key, array('wd','name','title','actor','director','play','inputer','order','limit','page','ajax')) ){
				$array['search_'.$key] = $value;
			}
		}
		$array['search_skin'] .= 'vod_search';
		if($params['ajax']){
			$array['search_skin'] .= '_ajax';
		}
		$array['search_skin'] = 'Home:'.$array['search_skin'];
		$array['site_sid'] = 1;
		return $array;
  }
	// 影视栏目页变量定义
	public function Lable_Vod_List($params, $array){
		$array['list_page'] = $params['page'];
		$array['list_ajax'] = $params['ajax'];
		if (empty($array['list_skin'])) {
			$array['list_skin'] = 'vod_list';
		}
		if($params['ajax']){
			$array['list_skin'] .= '_ajax';
		}
		$array['list_skin'] = 'Home:'.$array['list_skin'];
		$array['site_sid'] = 1;
		return $array;
  }
	/*****************影视内容,播放页公用变量定义******************************
	* @$array/具体的内容信息
	* @$array_play 为解析播放页
	* @返回赋值后的arrays 多维数组*/
	public function Lable_Vod_Read($array){
		$array['vod_hits_insert'] = ff_get_hits('vod','insert',$array);
		$array['vod_hits_month'] = ff_get_hits('vod','vod_hits_month',$array);
		$array['vod_hits_week'] = ff_get_hits('vod','vod_hits_week',$array);
		$array['vod_hits_day'] = ff_get_hits('vod','vod_hits_day',$array);
		if($array['vod_skin']){
			$array['vod_skin_detail'] = 'Home:'.trim($array['vod_skin']);
			$array['vod_skin_play'] = 'Home:'.trim($array['vod_skin']).'_play';
		}else{
			$array['vod_skin_detail'] = !empty($array['list_skin_detail']) ? 'Home:'.$array['list_skin_detail'] : 'Home:vod_detail';
			$array['vod_skin_play'] = !empty($array['list_skin_play']) ? 'Home:'.$array['list_skin_play'] : 'Home:vod_play';
		}
		//播放列表解析
		$array_play = $this->ff_play_list($array['vod_server'],$array['vod_play'],$array['vod_url']);
		$array['vod_play_sid'] = $array_play[0];
		$array['vod_play_list'] = $array_play[1];
		unset($array['vod_server'],$array['vod_play'],$array['vod_url']);
		//
		$array['site_sid'] = 1;
		return $array;
	}
	/*****************影视播放页变量定义 适用于动态与合集为一个播放页******************************<br />
	* @$array 内容页解析好后的内容页变量 arrays['read']
	* @$array_play 为播放页URL参数 array('id'=>558,'sid'=>1,'pid'=>1)
	* @返回$array 内容页重新组装的数组*/
	public function Lable_Vod_Play($array, $array_play){
		// 点击数调用
		$array['vod_hits_month'] = ff_get_hits('vod','vod_hits_month',$array,C('url_html_play'));
		$array['vod_hits_week'] = ff_get_hits('vod','vod_hits_week',$array,C('url_html_play'));
		$array['vod_hits_day'] = ff_get_hits('vod','vod_hits_day',$array,C('url_html_play'));
		// 播放器相关默认配置
		$array['play_sid'] = $array_play['sid'];
		$array['play_pid'] = $array_play['pid'];
		$array['play_width'] = C('play_width');
		$array['play_height'] = C('play_height');
		$array['play_buffer'] = C('play_playad');
		$array['play_second'] = intval(C('play_second'));
		$array['play_jiexi'] = trim(C('play_jiexi'));
		// 通过sid定义到当前播放器组的相关变量
		$play = $array['vod_play_list'][$array['vod_play_sid'][$array_play['sid']-1]];
		$array['play_name_en'] = $play['player_name_en'];
		$array['play_name_zh'] = $play['player_name_zh'];
		$array['play_copygiht'] = $play['player_copyright'];
		$array['play_info'] = $play['player_info'];
		$array['play_title'] = $play['son'][$array['play_pid']-1]["title"];
		$array['play_url'] = $play['son'][$array['play_pid']-1]["url"];
		$array['play_url_next'] = $play['son'][$array['play_pid']]["url"];
		$array['play_url_prev'] = $play['son'][$array['play_pid']-2]["url"];
		$array['play_count'] = count($play['son']);
		//copyright 版权处理
		$copyright = 0;
		if($play['player_copyright'] > 0){
			$copyright = intval($play['player_copyright']);
		}
		if($array['list_copyright'] > 0){
			$copyright = intval($array['list_copyright']);
		}else if($array['list_copyright'] < 0){
			$copyright = 0;
		}
		if($array['vod_copyright'] > 0){
			$copyright = intval($array['vod_copyright']);
		}else if($array['vod_copyright'] < 0){
			$copyright = 0;
		}
		// 解析服务器变量处理
		if($array['play_jiexi']){
			$array['play_jiexi'] = str_replace('{name}', $array['play_name_en'], $array['play_jiexi']);
		}
		// 云播放器与本地播放器
		if(C('play_cloud')){
			$array['vod_player'] = '<script src="'.C('play_cloud').'?u='.base64_encode($array['play_url']).'&p='.$array['play_name_en'].'&c='.$copyright.'&j='.base64_encode($array['play_jiexi']).'&x='.$array['play_second'].'&y='.base64_encode($array['play_buffer']).'&z='.base64_encode($array['play_url_next']).'"></script>'."\n";
		}else{
			$json = array();
			$json['url'] = $array['play_url'];
			$json['copyright'] = $copyright;
			$json['name'] = $array['play_name_en']; if($copyright){ $json['name'] = 'copyright'; }	
			$json['jiexi'] = $array['play_jiexi'];
			$json['time'] = $array['play_second'];
			$json['buffer'] = $array['play_buffer'];
			$json['next_url'] = $array['play_url_next'];
			$array['vod_player'] = '<script>var cms_player = '.json_encode($json).';</script><script src="'.C('site_path').'Public/player/'.$json['name'].'.js"></script>';
			unset($json);
		}
		$array['site_sid'] = 1;
		return $array;
	}
	//组合播放地址组列表为二维数组
	public function ff_play_list($server, $play, $url){
		//加载配置文件
		$conf_play = F('_feifeicms/player');
		$conf_server = C('play_server');
		//分解播放器组
		$array_server = explode('$$$',$server);
		$array_play = explode('$$$',$play);
		$array_url = explode('$$$',$url);
		//定义播放器每一组对应的地址合集
		$array = array();
		foreach($array_play as $sid=>$val){
			$array[$val][$sid] = $array_url[$sid];
		}
		// 按配置排序组合成前台循环的二维数组
		$play_list = array();
		$play_sid = array();
		foreach($conf_play as $conf_key=>$conf_value){
			if($play_one = $array[$conf_key]){
				foreach($play_one as $sid=>$url_one){
					$play_list[$conf_key.$sid] = array(
						'server_name' => $array_server[$sid],
						'server_url' => $conf_server[$array_server[$sid]],
						'player_name_en' => $conf_key,
						'player_name_zh' => $conf_value[0],
						'player_copyright' => $conf_value[2],
						'player_info' => $conf_value[1],
						'player_sid' => $sid+1,
						'son' => $this->ff_play_list_one($url_one, $conf_server[$array_server[$sid]]),
					);
					$play_sid[$sid] = $conf_key.$sid;
				}
			}
		}
		return array($play_sid, $play_list);
	}
	//分解单组播放地址链接
	public function ff_play_list_one($url_one, $server_url){
		$url_list = array();
	  $array_url = explode(chr(13),str_replace(array("\r\n", "\n", "\r"),chr(13),$url_one));
		foreach($array_url as $key=>$val){
			list($title, $url, $logo, $rc_title) = explode('$', $val);
		  if ( empty($url) ) {
			  $url_list[$key]['title'] = '第'.($key+1).'集';
				$url_list[$key]['url'] = $server_url.$title;
			}else{
				$url_list[$key]['title'] = $title;
				$url_list[$key]['url'] = $server_url.$url;
			}
			$url_list[$key]['logo'] = $logo;
			$url_list[$key]['rc_title'] = $rc_title;
		}
	  return $url_list;
	}
	// 分集变量定义
	public function Lable_Vod_Scenario($array, $params){
		//$array = array();
		foreach($params as $key=>$value){
			if(in_array($key, array('id','pid')) ){
				$array['scenario_'.$key] = $value;
			}
		}
		$array['scenario_skin'] = str_replace('vod_detail_scenario','vod_scenario',$array['vod_skin_detail'].'_scenario');
		if($params['pid']){
			$array['scenario_skin'] .= '_pid';
		}
		if($params['ajax']){
			$array['scenario_skin'] .= '_ajax';
		}
		$array['site_sid'] = 7;
		return $array;
  }
	// 文章多分类筛选变量定义
	public function Lable_News_Type($params, $array){
		foreach($params as $key=>$value){
			if(in_array($key, array('id','type','limit','order','page','ajax')) ){
				$array['type_'.$key] = $value;
			}
		}
		//模板名称定义
		if (empty($array['list_skin_type'])) {
			$array['list_skin_type'] = 'news_type';
		}
		if($params['ajax']){
			$array['list_skin_type'] .= '_ajax';
		}
		$array['list_skin_type'] = 'Home:'.$array['list_skin_type'];
		$array['site_sid'] = 2;
		return $array;
  }
	// 文章搜索变量定义
	public function Lable_News_Search($params){
		$array = array();
		$array['search_skin'] .= 'news_search';
		foreach($params as $key=>$value){
			if(in_array($key, array('wd','name','title','remark','order','limit','page','ajax')) ){
				$array['search_'.$key] = $value;
			}
		}
		if($params['ajax']){
			$array['search_skin'] .= '_ajax';
		}
		$array['search_skin'] = 'Home:'.$array['search_skin'];
		$array['site_sid'] = 2;
		return $array;
  }
	// 文章分类页变量定义
	public function Lable_News_List($params, $array){
		$array['list_page'] = $params['page'];
		$array['list_ajax'] = $params['ajax'];
		if (empty($array['list_skin'])) {
			$array['list_skin'] = 'news_list';
		}
		if($params['ajax']){
			$array['list_skin'] .= '_ajax';
		}
		$array['list_skin'] = 'Home:'.$array['list_skin'];
		$array['site_sid'] = 2;
		return $array;
  }
	//资讯内容页变量定义
	public function Lable_News_Read($params, $array){
		$array['news_hits_insert'] = ff_get_hits('news','insert',$array);
		$array['news_hits_month'] = ff_get_hits('news','news_hits_month',$array);
		$array['news_hits_week'] = ff_get_hits('news','news_hits_week',$array);
		$array['news_hits_day'] = ff_get_hits('news','news_hits_day',$array);
		//正则分割是否有分页
		$array_content = preg_split("/<div style=\"page-break-after:always\">([\s\S]*?)<\/div>/", $array['news_content']);
		$array['news_page'] = $params['page'];
		$array['news_page_count'] = count($array_content);
		$array['news_content'] = $array_content[$params['page']-1];
		//模板路径
		if(empty($array['news_skin'])){
			$array['news_skin_detail'] = !empty($array['list_skin_detail']) ? $array['list_skin_detail'] : 'news_detail';
		}
		if($params['ajax']){
			$array['news_skin_detail'] .= '_ajax';
		}
		$array['news_skin_detail'] = 'Home:'.$array['news_skin_detail'];
		$array['site_sid'] = 2;
		return $array;
	}
	//专题列表页变量定义
	public function Lable_Special_List($params){
		$array = array();
		$array['special_type'] = $params['type'];
		$array['special_page'] = $params['page'];
		$array['special_skin'] = 'Home:'.'special_list';
		if($params['ajax']){
			$array['special_skin'] .= '_ajax';
		}
		$array['site_sid'] = 3;
		return $array;
  }
	//专题内容页变量定义
	public function Lable_Special_Read($array,$array_play = false){
		$array_ids = array();$where = array();
		$array['special_skin'] = !empty($array['special_skin']) ? 'Home:'.$array['special_skin'] : 'Home:special_detail';
		$array['special_hits_insert'] = ff_get_hits('special','insert',$array);
		$array['special_hits_month'] = ff_get_hits('special','special_hits_month',$array);
		$array['special_hits_week'] = ff_get_hits('special','special_hits_week',$array);
		$array['special_hits_day'] = ff_get_hits('special','special_hits_day',$array);
		$array['site_sid'] = 3;
		return $array;
	}
	//讨论模块普通变量定义
	public function Lable_Forum($params){
		$array = array();
		foreach($params as $key=>$value){
			if(in_array($key, array('id','cid','sid','uid','pid','page')) ){
				$array['forum_'.$key] = $value;
			}
		}
		$array['forum_seo_title'] = C('forum_seo_title');
		$array['forum_seo_keywords'] = C('forum_seo_keywords');
		$array['forum_seo_description'] = C('forum_seo_description');
		$array['site_sid'] = 6;
		return $array;
  }
	//评论详情页解析
	public function Lable_Forum_Detail($params, $array){
		$array['forum_skin'] = 'Home:';
		$array['forum_skin'] .= 'forum_'.ff_sid2module($array['forum_sid']).'_detail';
		$array['site_sid'] = 6;
		return $array;
  }
	//首页标签定义
	public function Lable_Index(){
		$array = array();
		if(!C('site_title')){
			$array['site_title'] = C('site_name').'_网站首页';
		}
		return $array;
	}
	//全局标签定义
	public function Lable_Style(){
		C('TOKEN_ON',false);//C('TOKEN_NAME','form_'.$array['model']);取消前端的表单令牌
		$array = array();
		$array['root'] = C('site_path');	
		$array['model'] = strtolower(MODULE_NAME);
		$array['action'] = strtolower(ACTION_NAME);	
		$array['public_path'] = $array['root'].'Public/';	
		$array['tpl_path'] = $array['root'].str_replace('./','',TEMPLATE_PATH).'/';	
		$array['site_name'] = C('site_name');
		$array['site_domain'] = C('site_domain');
		$array['site_domain_m'] = C('site_domain_m');
		$array['site_url'] = 'http://'.C('site_domain');
		$array['site_title'] = C('site_title');
		$array['site_keywords'] = C('site_keywords');
		$array['site_description'] = C('site_description');
		$array['site_email'] = C('site_email');
		$array['site_copyright'] = C('site_copyright');
		$array['site_tongji'] = C('site_tongji');
		$array['site_icp'] = C('site_icp');
		$array['site_hot'] = ff_hot_key(C('site_hot'));	
		$array['site_sid'] = intval(ff_module2sid($array['model']));	
		return $array;		
	}
}
?>