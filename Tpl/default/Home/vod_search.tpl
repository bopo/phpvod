<php>
if($search_wd){
	$list = ff_mysql_vod('wd:'.$search_wd.';limit:24;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:vod_'.$search_order.';sort:desc');
  $params = array('wd'=>urlencode($search_wd),'p'=>'FFLINK');
  $page = ff_url_page('vod/search', $params, true, 'search', 4);
}else if($search_actor){
	$list = ff_mysql_vod('actor:'.$search_actor.';limit:24;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:vod_'.$search_order.';sort:desc');
  $params = array('actor'=>urlencode($search_actor),'p'=>'FFLINK');
  $page = ff_url_page('vod/search', $params, true, 'search', 4);
}else if($search_director){
	$list = ff_mysql_vod('director:'.$search_director.';limit:24;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:vod_'.$search_order.';sort:desc');
  $params = array('director'=>urlencode($search_director),'p'=>'FFLINK');
  $page = ff_url_page('vod/search', $params, true, 'search', 4);
}else if($search_name){
	$list = ff_mysql_vod('name:'.$search_name.';limit:24;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:vod_'.$search_order.';sort:desc');
  $params = array('name'=>urlencode($search_name),'p'=>'FFLINK');
  $page = ff_url_page('vod/search', $params, true, 'search', 4);
}else if($search_title){
	$list = ff_mysql_vod('title:'.$search_title.';limit:24;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:vod_'.$search_order.';sort:desc');
  $params = array('title'=>urlencode($search_title),'p'=>'FFLINK');
  $page = ff_url_page('vod/search', $params, true, 'search', 4);
}
$totalpages = ff_page_count('search', 'totalpages');
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>《{$search_name}{$search_actor}{$search_director}{$search_wd}》第{$search_page}页_{$site_name}</title>
<meta name="keywords" content="{$search_name}{$search_actor}{$search_director}{$search_wd}">
<meta name="description" content="{$search_name}{$search_actor}{$search_director}{$search_wd}">
</head>
<body>
<include file="Home:header" />
<div class="container vod-search ff-bg">
<div class="row">
	<div class="col-xs-12 ff-col">
  	<div class="page-header">
      <h4><span class="glyphicon glyphicon-film ff-text"></span> 搜索结果：<span class="ff-text">{$search_name}{$search_actor}{$search_director}{$search_wd}</span> <small>共有<span class="ff-text">{:ff_page_count('search', 'records')}</span>个视频 第<span class="ff-text">{$search_page}</span>页</small></h4>
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
      <h6 class="ff-text-hidden text-left ff-link">
        {$feifei.vod_actor|ff_url_search}
      </h6>
    </li>
    </volist>
  </ul>
  <div class="clearfix"></div>
  <div class="col-xs-12 ff-col text-center">
    <gt name="totalpages" value="1">
      <ul class="pagination pagination-lg hidden-xs">
        {$page}
      </ul>
      <ul class="pager visible-xs">
        <gt name="search_page" value="1">
        	<php>$params['p'] = $search_page-1</php>
        	<li><a href="{:ff_url('vod/search', $params, true)}">上一页</a></li>
        </gt>
        <lt name="search_page" value="$totalpages">
        	<php>$params['p'] = $search_page+1</php>
        	<li><a href="{:ff_url('vod/search', $params, true)}">下一页</a></li>
        </lt>
     </ul> 
    </gt>
  </div>
</div>
</div>
<include file="Home:footer" />
</body>
</html>