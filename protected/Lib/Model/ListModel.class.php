<?php 
class ListModel extends AdvModel {
	//自动验证
	protected $_validate=array(
		array('list_name','require','必须填写分类标题！'),
		array('list_oid','number','必须填写排序ID！'),
		array('list_dir','','分类别名已经存在,请重新设定！',1,'unique',1),
	);
	//自动完成
	protected $_auto=array(
		array('list_dir','listdir',3,'callback'),
		array('list_extend','listextend',3,'callback'),
	);
	//处理英文名
	public function listdir(){
		if (empty($_POST['list_dir'])) {
		   return ff_pinyin(trim($_POST['list_name']));
		}else{
		   return trim($_POST['list_dir']);
		}
	}
	//处理扩展配置
	public function listextend($listextend){
		return json_encode($listextend);
	}
	// 通过ID查询详情数据
	public function ff_find($field = '*', $where, $cache_name){
		//优先缓存读取数据
		if( C('cache_page_list') && $cache_name){
			$cache_info = S($cache_name);
			if($cache_info){
				return $cache_info;
			}
		}
		//数据库获取数据
		$info = $this->field($field)->where($where)->find();
		if($info){
			$info['list_extend'] = json_decode($info['list_extend'],true);//转化json格式
			if( C('cache_page_list') && $cache_name ){
				S($cache_name, $array_detail, intval(C('cache_page_list')));
			}
    	return $info;
    }
		$this->error = '数据不存在！';
		return false;
	}
	
	// 查询多个数据 不需要分页 则删除相关的分页判断
	public function ff_select_page($params, $where){
		//优先从缓存调用
		if($params['cache_name'] && $params['cache_time']){
			$infos = S($params['cache_name']);
			if($infos){
				return $infos;
			}
		}		
		$infos = $this->field($params['field'])->where($where)->limit($params['limit'])->order(trim($params['order'].' '.$params['sort']))->select();
		$infos = list_to_tree($infos, 'list_id', 'list_pid', 'list_son');
		//是否写入数据缓存
		if($params['cache_name'] && $params['cache_time']){
			S($params['cache_name'], $infos, intval($params['cache_time']) );
		}
		//dump($this->getLastSql());
		return $infos;
	}
	
	// 新增或更新
	public function ff_update($data){
		// 创建安全数据对象TP
		$data = $this->create($data);
		if(false === $data){
			$this->error = $this->getError();
			return false;
		}
		/* 添加或新增行为 */
		if(empty($data['list_id'])){
			$data['list_id'] = $this->add();
			if(!$data['list_id']){
				$this->error = $this->getError();
				return false;
			}
		} else {
			$status = $this->save();
			if(false === $status){
				$this->error = $this->getError();
				return false;
			}
		}
		return $data;
	}
}
?>