<php>
$list = ff_mysql_vod('cid:'.$list_id.';limit:18;page_is:true;page_id:list;page_p:'.$list_page.';cache_name:default;cache_time:default;order:vod_stars desc,vod_addtime;sort:desc');
if($action == 'category'){
	$page = ff_url_page('vod/category',array('id'=>$list_dir,'p'=>'FFLINK'),true,'list',4);
}else{
  $page = ff_url_page('vod/show',array('id'=>$list_id,'list_dir'=>$list_dir,'p'=>'FFLINK'),true,'list',4);
}
$totalpages = ff_page_count('list', 'totalpages');
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title><notempty name="list_title">{$list_title}<else/>《{$list_name}》</notempty>第{$list_page}页_{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<body><include file="Home:header" />
<div class="container ff-bg vod-list">
  <div class="row">
    <div class="col-xs-12 ff-col">
    	<div class="page-header">
        <h4><span class="glyphicon glyphicon-film ff-text"></span> <a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$list_name}</a> <small>共有<span class="ff-text">{:ff_page_count('list', 'records')}</span>个影片 第<span class="ff-text">{$list_page}</span>页</small> <a class="btn btn-success btn-sm pull-right" href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>'','year'=>'','star'=>'','state'=>'','order'=>'hits','p'=>1),true)}"><span class="glyphicon glyphicon-th-list"></span> 筛选</a></h4>
      </div>
    </div>
    <div class="clearfix"></div>
    <ul class="list-unstyled">
      <volist name="list" id="feifei">
      <li class="col-md-2 col-sm-2 col-xs-4 text-center ff-vod-img-new ff-col">
        <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}">
        <p><include file="Home:block_vod_continu_foreach" /></p>
        <img class="img-responsive img-thumbnail ff-img" data-original="{:ff_url_img($feifei['vod_pic'],$feifei['vod_content'])}" alt="{$feifei.vod_name}">
        </a>
        <h4 class="ff-text-hidden text-left">
          <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}" title="{$feifei.vod_name}">{$feifei.vod_name|msubstr=0,8}</a>
        </h4>
        <h6 class="ff-text-hidden text-left ff-nb">
          {$feifei.vod_actor|ff_url_search}
        </h6>
      </li>
      </volist>
    </ul>
    <!-- -->
    <gt name="totalpages" value="1">
      <div class="clearfix"></div>
      <div class="col-xs-12 ff-col text-center">
        <ul class="pagination pagination-lg hidden-xs">
          {$page}
        </ul>
        <ul class="pager visible-xs">
          <gt name="list_page" value="1">
            <li><a href="{:ff_url_vod_show($list_id,$list_dir,$list_page-1)}">上一页</a></li>
          </gt>
          <lt name="list_page" value="$totalpages">
            <li><a href="{:ff_url_vod_show($list_id,$list_dir,$list_page+1)}">下一页</a></li>
          </lt>
         </ul> 
      </div>
		</gt>
</div>
</div>
<include file="Home:footer" />
</body>
</html>