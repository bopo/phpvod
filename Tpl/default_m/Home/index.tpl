<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>{$site_title}</title>
<meta name="keywords" content="{$site_keywords}">
<meta name="description" content="{$site_description}">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<include file="Home:block_nav" />
<include file="Home:block_nav_m" />
<div class="clearfix"></div>
<div class="container ff-bg">
  <div class="row">
    <div class="col-xs-12 ff-col">
    	<div class="m-header text-center">
      {:ff_url_ads('header-m')}
      </div>
    </div>
  </div>
</div>
<div class="container ff-bg">
  <div class="row">
    <div class="col-xs-12 ff-slide-pic">
      <include file="Home:block_slide" />
    </div>
  </div>
</div>
<div class="show" id="ff-nav-btn-item">
<include file="Home:block_nav_m_sub" />
</div>
<volist name=":ff_mysql_list('sid:1;limit:6;cache_name:default;cache_time:default;order:list_pid asc,list_oid;sort:asc')" id="feifeilist">
<div class="container ff-bg">
  <div class="row">
    <div class="col-xs-12 ff-col index-left">
    <div class="page-header">
      <h4>
        <span class="glyphicon glyphicon-film ff-text"></span> <a href="{:ff_url_vod_show($feifeilist['list_id'],$feifeilist['list_dir'],1)}">{$feifeilist.list_name}</a>
        <small class="hidden-xs"><php>$list_extend = json_decode($feifeilist['list_extend'],true);</php><volist name=":explode(',',$list_extend['area'])" id="feifeiarea" offset="0" length="12"><a href="{:ff_url('vod/type',array('id'=>$feifeilist['list_id'],'type'=>'','area'=>urlencode($feifeiarea),'year'=>'','star'=>'','state'=>'','order'=>'hits','p'=>1),true)}">{$feifeiarea}</a></volist><a href="{:ff_url('vod/type',array('id'=>$feifeilist['list_id'],'type'=>'','area'=>'','year'=>'','star'=>'','state'=>'','order'=>'hits','p'=>1),true)}">更多</a></small>
        <small class="pull-right"><a href="{:ff_url('vod/type',array('id'=>$feifeilist['list_id'],'type'=>'','area'=>'','year'=>'','star'=>'','state'=>'','order'=>'hits','p'=>1),true)}">更多</a></small>
      </h4>
    </div>
    <!-- -->
    <ul class="list-unstyled">
      <volist name=":ff_mysql_vod('cid:'.$feifeilist['list_id'].';limit:12;cache_name:default;cache_time:default;order:vod_stars desc,vod_addtime;sort:desc')" id="feifei" key="k">
      <li class="col-md-3 col-xs-4 text-center ff-col ff-vod-img-hot">
      <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}">
        <img class="img-responsive ff-img" data-original="{:ff_url_img($feifei['vod_pic'],$feifei['vod_content'])}" alt="{$feifei.vod_name}">
        <p class="ff-continu"><include file="Home:block_vod_continu_foreach" /></p>
      </a>
      <h4 class="ff-text-hidden">
        <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}" title="{$feifei.vod_name}">{$feifei.vod_name|msubstr=0,10}</a>
      </h4>
      </li>
      </volist>
    </ul>
    </div><!--lg-8end -->
  </div><!--row end -->
</div>
<div class="clearfix ff-clearfix"></div>
</volist>
</div>
</div>
<div class="container ff-bg hidden-xs">
<div class="row">
	<div class="col-xs-12 ff-col">
  	<div class="page-header">
      <h4><span class="glyphicon glyphicon-link ff-text"></span> 友情链接</h4>
    </div>
    <p class="ff-link">
    <volist name=":ff_mysql_link('limit:20;cache_name:default;cache_time:default;order:link_order;sort:asc')" id="feifei"><a href="{$feifei.link_url}" target="_blank">{$feifei.link_name}</a></volist>
    </p>
  </div>
</div>
</div>
<include file="Home:footer" />
</body>
</html>