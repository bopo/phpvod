<?php
class VodAction extends BaseAction{
	private $id;
	// 影片列表
  public function show(){
		$admin = array();
		//获取地址栏参数
		$admin['cid']= $_REQUEST['cid'];
		$admin['ids']= $_REQUEST['ids'];
		$admin['continu'] = $_REQUEST['continu'];
		$admin['status'] = intval($_REQUEST['status']);
		$admin['player'] = trim($_REQUEST['player']);
		$admin['inputer'] = trim($_REQUEST['inputer']);
		$admin['url'] = intval($_REQUEST['url']);
		$admin['state'] = trim($_REQUEST['state']);
		$admin['version'] = trim($_REQUEST['version']);
		$admin['stars'] = intval($_REQUEST['stars']);
		$admin['type'] = !empty($_GET['type'])?$_GET['type']:C('admin_order_type');
		$admin['order'] = !empty($_GET['order'])?$_GET['order']:'desc';
		$admin['orders'] = 'vod_'.$admin["type"].' '.$admin['order'];
		$admin['wd'] = urldecode(trim($_REQUEST['wd']));
		$admin['tag_name'] = urldecode(trim($_REQUEST['tag_name']));
		$admin['tag_list'] = trim($_REQUEST['tag_list']);
		$admin['p'] = '';
		//生成查询参数
		$limit = 20;
		$order = 'vod_'.$admin["type"].' '.$admin['order'];
		if ($admin['cid']) {
			$where['vod_cid']= array('in',ff_list_ids($admin['cid']));
		}
		if ($admin['ids']) {
			$where['vod_id']= array('in',$admin['ids']);
		}
		if($admin["continu"] == 1){
			$where['vod_isend'] = 0;
		}
		if ($admin['status'] == 2) {
			$where['vod_status'] = array('eq',0);
		}elseif ($admin['status'] == 1) {
			$where['vod_status'] = array('eq',1);
		}elseif ($admin['status'] == 3) {
			$where['vod_status'] = array('eq',-1);
		}			
		if($admin['player']){
			$where['vod_play'] = array('like','%'.trim($admin['player']).'%');
		}
		if($admin['inputer']){
			$where['vod_inputer'] = $admin['inputer'];
		}
		if($admin["url"]){
			$where['vod_url'] = array('eq','');
		}
		if($admin["state"]){
			$where['vod_state'] = array('eq',urldecode($admin["state"]));
		}	
		if($admin["version"]){
			$where['vod_version'] = array('eq',urldecode($admin["version"]));
		}	
		if($admin['stars']){
			$where['vod_stars'] = $admin['stars'];
		}		
		if ($admin['wd']) {
			$search['vod_name'] = array('like','%'.$admin['wd'].'%');
			$search['vod_title'] = array('like','%'.$admin['wd'].'%');
			$search['vod_actor'] = array('like','%'.$admin['wd'].'%');
			$search['vod_director'] = array('like','%'.$admin['wd'].'%');
			$search['_logic'] = 'or';
			$where['_complex'] = $search;
			$admin['wd'] = urlencode($admin['wd']);
		}
		//根据不同条件加载模型
		if($admin['tag_name']){
			$where['tag_list'] = $admin['tag_list'];
			$where['tag_name'] = $admin['tag_name'];
			$rs = D('TagvodView');
			$admin['tag_name'] = urlencode($_REQUEST['tag_name']);
		}else{
			$rs = D('VodView');
		}
		//组合分页信息
		$count = $rs->where($where)->count('vod_id');
		$totalpages = ceil($count/$limit);
		$currentpage = !empty($_GET['p'])?intval($_GET['p']):1;
		$currentpage = ff_page_max($currentpage,$totalpages);//$admin['page'] = $currentpage;
		$pageurl = U('Admin-Vod/Show',$admin,false,false).'FFLINK'.C('url_html_suffix');
		$admin['p'] = $currentpage;$_SESSION['vod_jumpurl'] = U('Admin-Vod/Show',$admin).C('url_html_suffix');
		$pages = '共'.$count.'部影片&nbsp;当前:'.$currentpage.'/'.$totalpages.'页&nbsp;'.getpage($currentpage,$totalpages,8,$pageurl,'pagego(\''.$pageurl.'\','.$totalpages.')');
		$admin['pages'] = $pages;
		//查询数据
		$list = $rs->where($where)->order($order)->limit($limit)->page($currentpage)->select();
		foreach($list as $key=>$val){
		  $list[$key]['list_url'] = '?s=Admin-Vod-Show-cid-'.$list[$key]['vod_cid'];
			$list[$key]['vod_url'] = ff_url_vod_read($list[$key]['list_id'],$list[$key]['list_dir'],$list[$key]['vod_id'],$list[$key]['vod_ename'],$list[$key]['vod_jumpurl']);
			$list[$key]['vod_starsarr'] = admin_star_arr($list[$key]['vod_stars']);
		}
		//dump($rs->getLastSql());
		//变量赋值并输出模板
		$this->assign($admin);
		$this->assign('list',$list);
	  $this->display('./Public/system/vod_show.html');
  }
	// 添加编辑影片
  public function add(){
		$rs = D('Vod');
		$vod_id = intval($_GET['id']);
		if($vod_id){
			$where = array();
      $where['vod_id'] = $vod_id;
			$array = $rs->ff_find('*', $where);
			foreach($array['Tag'] as $key=>$value){
				$tag[$value['tag_list']][$key] = $value['tag_name'];
			}
			foreach(explode('$$$',$array['vod_play']) as $key=>$val){
			  $play[array_search($val,C('play_player'))] = $val;
			}
			$array['vod_play_list'] = F('_feifeicms/player');
			$array['vod_server_list'] = C('play_server');
			$array['vod_play'] = explode('$$$',$array['vod_play']);
			$array['vod_server'] = explode('$$$',$array['vod_server']);	
			$array['vod_url'] = explode('$$$',$array['vod_url']);
			$array['vod_starsarr'] = admin_star_arr($array['vod_stars']);
			$array['vod_type'] = implode(',',$tag['vod_type']);
			$array['vod_keywords'] = implode(',',$tag['vod_tag']);
			$array['vod_tplname'] = '编辑';
			$_SESSION['vod_jumpurl'] = $_SERVER['HTTP_REFERER'];
		}else{
		  $array['vod_cid'] = cookie('vod_cid');
		  $array['vod_stars'] = 1;
		  $array['vod_status'] = 1;
			$array['vod_hits'] = 0;
			$array['vod_addtime'] = time();
			$array['vod_continu'] = 0;
			$array['vod_inputer'] = $_SESSION['admin_name'];
			$array['vod_play_list'] = F('_feifeicms/player');
			$array['vod_server_list'] = C('play_server');
			$array['vod_url']=array(0=>'');
			$array['vod_starsarr'] = admin_star_arr(1);
			$array['vod_tplname'] = '添加';
			//默认配置
			$array["list_extend"]['type'] = C('play_type');
			$array["list_extend"]['area'] = C('play_area');
			$array["list_extend"]['year'] = C('play_year');
			$array["list_extend"]['state'] = C('play_state');
			$array["list_extend"]['language'] = C('play_language');
			$array["list_extend"]['version'] = C('version');
		}
		//模板相关赋值
		$this->assign($array);
		$this->assign("jumpUrl",$_SESSION['vod_jumpurl']);
		$this->display('./Public/system/vod_add.html');
  }
	//新增与编辑前置操作
  public function _before_update(){
		// 完结
		if($_POST["vod_continu"]){
			$_POST["vod_isend"] = 0;
		}else{
			$_POST["vod_isend"] = 1;
		}			
		//播放器组与地址组
		$play = $_POST["vod_play"];
		$server = $_POST["vod_server"];
		foreach($_POST["vod_url"] as $key=>$val){
			$val = trim($val);
			if($val){
			  $vod_play[] = $play[$key];
				$vod_server[] = $server[$key];
				$vod_url[] = $val;
			};
		}
		$_POST["vod_play"] = strval(implode('$$$',$vod_play));
		$_POST["vod_server"] = strval(implode('$$$',$vod_server));
		$_POST["vod_url"] = strval(implode('$$$',$vod_url));
	}
	//新增与更新数据
	public function update(){
		$rs = D('Vod');
		$data = $rs->update($_POST);
		if(!$data){
			$this->error($rs->getError());
		}
		$this->id = $data['vod_id'];
	}
	// 后置操作
	public function _after_update(){
		$vod_id = $this->id;
		if($vod_id){
			//记录最后的主分类ID
			cookie('vod_cid', intval($_POST["vod_cid"]));
			//删除数据缓存
			if(C('cache_page_vod')){
				S('cache_page_vod_'.$vod_id,NULL);
			}
			//删除静态缓存
			if(C('html_cache_on')){
				$id = md5($vod_id).C('html_file_suffix');
				@unlink('./Html/Vod_read/'.$vod_id);
				@unlink('./Html/Vod_play/'.$vod_id);
			}
			//生成网页
			if(C('url_html')){
				echo'<iframe scrolling="no" src="?s=Admin-Create-vod_detail_id-ids-'.$vod_id.'" frameborder="0" style="display:none"></iframe>';
			}
			//最后跳转
			$this->assign("jumpUrl",$_SESSION['vod_jumpurl']);
			$this->success('恭喜您，数据库、缓存、静态所有操作已完成！');
		}else{
			$this->error('数据库操作完成，附加操作不做处理！');
		}		
	}
	// 删除影片
  public function del(){
		$this->delfile($_GET['id']);
		redirect($_SESSION['vod_jumpurl']);
  }
	// 删除影片all
  public function delall(){
		if(empty($_POST['ids'])){
			$this->error('请选择需要删除的影片！');
		}	
		$array = $_POST['ids'];
		foreach($array as $val){
			$this->delfile($val);
		}
		redirect($_SESSION['vod_jumpurl']);
  }
	// 删除静态文件与图片
  public function delfile($id){
		$where = array();
		//删除影片观看记录
		//$rs = D("View");
		//$where['did'] = $id;
		//$rs->where($where)->delete();
		//删除专题收录
		$rs = D("Topic");
		$where['topic_sid'] = 1;
		$where['topic_did'] = $id;
		$rs->where($where)->delete();
		unset($where);					
		//删除影片评论
		$rs = D("Cm");
		$where['cm_cid'] = $id;
		$where['cm_sid'] = 1;
		$rs->where($where)->delete();
		unset($where);	
		//删除影片TAG
		$rs = D("Tag");
		$where['tag_id'] = $id;
		$where['tag_sid'] = 1;
		$rs->where($where)->delete();
		unset($where);
		//删除静态文件与图片
		$rs = D('Vod');
		$where['vod_id'] = $id;
		$array = $rs->field('vod_id,vod_cid,vod_pic,vod_name')->where($where)->find();
		@unlink(ff_url_img($arr['vod_pic']));
		if(C('url_html')){
			@unlink(ff_url_vod_read($array['list_id'],$array['list_dir'],$array['vod_id'],$array['vod_ename'],$array['vod_jumpurl']));
		}
		unset($where);
		//删除影片ID
		$where['vod_id'] = $id;
		$rs->where($where)->delete();
		unset($where);
  }
	// 批量生成数据
  public function create(){
		if($_POST['ids']){
			redirect('?s=Admin-Create-vod_detail_id-ids-'.implode(',',$_POST['ids']));
		}else{
			$this->assign("jumpUrl",$_SESSION['vod_jumpurl']);
			$this->error('操作错误！');
		}
  }	
	// 批量转移影片
  public function pestcid(){
		if(empty($_POST['ids'])){
			$this->error('请选择需要转移的影片！');
		}	
		$cid = intval($_POST['pestcid']);
		if (ff_list_isson($cid)) {
			$rs = D('Vod');
			$data['vod_cid'] = $cid;
			$where['vod_id'] = array('in',$_POST['ids']);
			$rs->where($where)->save($data);
			redirect($_SESSION['vod_jumpurl']);
		}else{
			$this->error('请选择当前大类下面的子分类！');		
		}
  }	
	// 设置状态
  public function status(){
		$where['vod_id'] = $_GET['id'];
		$rs = D('Vod');
		if($_GET['value']){
			$rs->where($where)->setField('vod_status',1);
		}else{
			$rs->where($where)->setField('vod_status',0);
		}
		redirect($_SESSION['vod_jumpurl']);
  }	
	// Ajax设置星级
  public function ajaxstars(){
		$where['vod_id'] = $_GET['id'];
		$data['vod_stars'] = intval($_GET['stars']);
		$rs = D('Vod');
		$rs->where($where)->save($data);		
		echo('ok');
  }	
	// Ajax设置连载
  public function ajaxcontinu(){
		$where['vod_id'] = $_GET['id'];
		$data['vod_continu'] = trim($_GET['continu']);
		$rs = D('Vod');
		$rs->where($where)->save($data);		
		echo('ok');
  }	
	// 锁定采集更新
	public function inputer(){
		$data = array();
		$data['vod_id'] = intval($_GET['id']);
		$data['vod_inputer'] = $_GET['value'];
		D('Vod')->save($data);
		redirect($_SESSION['vod_jumpurl']);
	}		
}
?>