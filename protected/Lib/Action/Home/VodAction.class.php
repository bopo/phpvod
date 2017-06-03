<?php
class VodAction extends HomeAction{
	// TAG话题
	public function tags(){
		$params = ff_param_url();
		$info = $this->Lable_Tags($params, 'vod');
		$this->assign($info);
		$this->display($info['tag_skin']);
	}	
  // 多分类筛选
	public function type(){
		//参数
		$params = ff_param_url();
		//条件
		$where = array();
		$where['list_status'] = array('eq', 1);
		$where['list_id'] = array('eq', $params['id']);
		$info = D('List')->ff_find('*', $where, 'cache_page_type_'.$params['id']);
		//解析
		$info = $this->Lable_Vod_Type($params, $info);
		$this->assign($info);
		$this->display($info['list_skin_type']);
	}	
	// 影视搜索 get方式
	public function search(){
		$params = ff_param_url();
		$info = $this->Lable_Vod_Search($params);
		$this->assign($info);
		$this->display($info['search_skin']);
  }
	// 按ID获取分类页
  public function show(){
		$info = $this->get_cache_list('id');
		$this->assign($info);
		$this->display($info['list_skin']);
	}
  // 按别名获取分类页
  public function category(){
		$info = $this->get_cache_list('ename');
		$this->assign($info);
		$this->display($info['list_skin']);
	}	
	// 按ID读取影片
  public function read(){
		$detail = $this->get_cache_detail('id');
		$this->assign($detail);
		$this->display($detail['vod_skin_detail']);
  }
	// 按别名读取影片
	public function ename(){
		$detail = $this->get_cache_detail('ename');
		$this->assign($detail);
		$this->display($detail['vod_skin_detail']);
	}	
	// 影片播放页
  public function play(){
		$detail = $this->Lable_Vod_Play($this->get_cache_detail('id'), array('id'=>intval($_GET['id']), 'sid'=>intval($_GET['sid']), 'pid'=>intval($_GET['pid'])));
		$this->assign($detail);
		$this->display($detail['vod_skin_play']);
  }
	// 影片播放页拼音
  public function eplay(){
		$detail = $this->get_cache_detail('ename');
		$detail = $this->Lable_Vod_Play($detail, array('id'=>$detail['vod_id'],'sid'=>intval($_GET['sid']),'pid'=>intval($_GET['pid'])));
		$this->assign($detail);
		$this->display($detail['vod_skin_play']);
  }
	// 按ID读取影片分集
  public function scenario(){
		$detail = $this->Lable_Vod_Scenario($this->get_cache_detail('id'), array('id'=>intval($_GET['id']), 'pid'=>intval($_GET['pid'])));
		$this->assign($detail);
		$this->display($detail['scenario_skin']);
  }
	// 按别名读取影片分集
	public function escenario(){
		$detail = $this->get_cache_detail('ename');
		$detail = $this->Lable_Vod_Scenario($detail, array('id'=>$detail['vod_id'], 'pid'=>intval($_GET['pid'])));
		$this->assign($detail);
		$this->display($detail['scenario_skin']);
	}	
	// 按ID读取影片评论聚合
  public function comment(){
		$detail = $this->Lable_Vod_Comment($this->get_cache_detail('id'));
		$this->assign($detail);
		$this->display($detail['comment_skin']);
  }	
	// 单个影片RSS
  public function rss(){
		$detail = $this->get_cache_detail('id');
		$this->assign($detail);
		$this->display('Home:vod_rss','utf-8','text/xml');
  }
	// 从数据库获取内容数据
	private function get_cache_detail($action='id'){
		//参数
		$params = array();
		//条件
		$where = array();
		$where['vod_status'] = array('eq', 1);
		if($action=='ename'){
			$params['id'] = htmlspecialchars($_GET['id']);
			$where['vod_ename'] = array('eq', $params['id']);
		}else{
			$params['id'] = intval($_GET['id']);
			$where['vod_id'] = array('eq', $params['id']);
		}
		//查库
		$info = D('Vod')->ff_find('*', $where, 'cache_page_vod_'.$params['id'], true);
		if(!$info){
			$this->assign("jumpUrl",C('site_path'));
			$this->error('此影片已经删除，请选择观看其它节目！');
		}
		//解析标签
		return $this->Lable_Vod_Read($info);
	}
	// 从数据库获取分类数据
	private function get_cache_list($action='id'){
		//参数
		$params = array();
		$params['page'] = !empty($_GET['p']) ? intval($_GET['p']) : 1;
		$params['ajax'] = intval($_GET['ajax']);
		//条件
		$where = array();
		$where['list_status'] = array('eq', 1);
		$where['list_sid'] = array('eq', 1);
		if($action=='ename'){
			$params['id'] = htmlspecialchars($_GET['id']);
			$where['list_dir'] = array('eq', $params['id']);
		}else{
			$params['id'] = intval($_GET['id']);
			$where['list_id'] = array('eq', $params['id']);
		}
		$info = D('List')->ff_find('*', $where, 'cache_page_list_'.$params['id']);
		if(!$info){
			$this->assign("jumpUrl",C('site_path'));
			$this->error('该分类已删除，请选择其它分类！');
		}
		//解析标签
		return $this->Lable_Vod_List($params, $info);
	}
}
?>