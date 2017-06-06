<?php 
class VodModel extends RelationModel {
	private $vod_id;
	//自动验证
	protected $_validate = array(
	  array('vod_cid','number','请选择分类！',1,'',3),
		array('vod_cid','ff_list_isson','请选择当前子类栏目！',1,'function',3),
		array('vod_name','require','影片名称必须填写！',1,'',3),
		array('vod_ename','','链接别名标识重复，请重新填写',2,'unique',3),
	);
	//自动完成
	protected $_auto = array(
		array('vod_ename','vod_ename',3,'callback'),
		array('vod_letter','vod_letter',3,'callback'),
		array('vod_gold','vod_gold',3,'callback'),
		array('vod_pic','vod_pic',3,'callback'),
		array('vod_addtime','vod_addtime',3,'callback'),
		array('vod_filmtime','vod_filmtime',3,'callback'),
		array('vod_year','vod_year',3,'callback'),
		array('vod_isend','vod_isend',3,'callback'),
		array('vod_scenario','vod_scenario',3,'callback'),
	);
	//关联定义
	protected $_link = array(
		'List'=>array(
			'mapping_type' => BELONGS_TO,
			'class_name'=> 'List',
			'mapping_name'=>'List',//数据对像映射名称
			'foreign_key' => 'vod_cid',
			'parent_key' => 'list_id',
			'condition' => 'list_status = 1',
			'as_fields' =>'list_id,list_pid,list_name,list_dir,list_title,list_keywords,list_description,list_copyright,list_skin_detail,list_skin_play,list_extend',
		),
		'Tag'=>array(
			'mapping_type' => HAS_MANY,
			'class_name'=> 'Tag',
			'mapping_name'=>'Tag',//数据对像映射名称
			'foreign_key' => 'tag_id',
			'parent_key' => 'vod_id',
			'mapping_fields' => 'tag_id,tag_cid,tag_name,tag_ename,tag_list',
			'condition' => "tag_cid in(1,2)",
			'mapping_order' => 'tag_cid asc',
			//'mapping_limit' => 5,
		)
	);
	//别名处理
	public function vod_ename(){
		if (!$_POST['vod_ename']) {
			return ff_pinyin(trim($_POST["vod_name"]));
		}else{
			return trim($_POST["vod_ename"]);
		}
	}
	//字母处理
	public function vod_letter(){
		if (!$_POST['vod_letter']) {
			return ff_url_letter(trim($_POST["vod_name"]));
		}else{
			return trim($_POST['vod_letter']);
		}
	}
	//图片处理
	public function vod_pic(){
		$img = D('Img');
		return $img->down_load(trim($_POST["vod_pic"]));
	}		
	//积分处理
	public function vod_gold(){
		if($_POST["vod_gold"] > 10){
			$_POST["vod_gold"] = 10;
		}	
		return 	$_POST["vod_gold"];
	}			
	//是否更新时间
	public function vod_addtime(){
		if ($_POST['checktime']) {
			return time();
		}else{
			return strtotime($_POST['vod_addtime']);
		}
	}
	//处理上映日期
	public function vod_filmtime(){
		if ($_POST['vod_filmtime']) {
			return strtotime($_POST['vod_filmtime']);
		}else{
			return 0;
		}
	}
	//处理年代
	public function vod_year(){
		if ($_POST['vod_filmtime']) {
			return date('Y',strtotime($_POST['vod_filmtime']));
		}else{
			return intval($_POST['vod_year']);
		}
	}
	//连载状态
	public function vod_isend(){
		if ($_POST['vod_total'] == $_POST['vod_continu']) {
			return 1;
		}else{
			return 0;
		}
	}
	//分集剧情
	public function vod_scenario($vod_scenario){
		return json_encode($vod_scenario);
	}
	
	// 通过ID查询详情数据
	public function ff_find($field = '*', $where, $cache_name=false, $relation=true, $order=false){
		//优先缓存读取数据
		if( C('cache_page_vod') && $cache_name){
			$cache_info = S($cache_name);
			if($cache_info){
				return $cache_info;
			}
		}
		//数据库获取数据
		$info = $this->field($field)->where($where)->relation($relation)->order($order)->find();
		//dump($this->getLastSql());
		if($info){
			$info['vod_scenario'] = json_decode($info['vod_scenario'], true);
			$info['list_extend'] = json_decode($info['list_extend'], true);
			if( C('cache_page_vod') && $cache_name ){
				S($cache_name, $array_detail, intval(C('cache_page_vod')));
			}
    	return $info;
    }
		$this->error = '数据不存在！';
		return false;
	}

	// 新增或更新
	public function update($data){
		//自动获取关键词tag
		if(empty($data["vod_keywords"]) && C('collect_tags')){
			$data["vod_keywords"] = ff_tag_auto($data["vod_name"],$data["vod_content"]);
		}
		// 创建安全数据对象TP
		$data = $this->create($data);
		if(false === $data){
			$this->error = $this->getError();
			return false;
		}
		/* 添加或新增行为 */
		if(empty($data['vod_id'])){
			$data['vod_id'] = $this->add();
			if(!$data['vod_id']){
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
		// 多分类处理
		if($data['vod_type']){
			D('Tag')->tag_update($data['vod_id'],$data["vod_type"],'vod_type');
		}
		// TAG关系处理
		if($data['vod_keywords']){
			D('Tag')->tag_update($data['vod_id'],$data["vod_keywords"],'vod_tag');
		}		
		return $data;
	}	
}
?>