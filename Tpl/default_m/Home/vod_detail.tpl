<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title><in name="list_id" value="2,3,4">《{$vod_name}》全集在线观看－{$list_name}<else />《{$vod_name}》高清在线观看-电影{$vod_name}下载</in>－{$site_name}</title>
<meta name="keywords" content="{$vod_name},{$vod_name}在线观看,{$vod_name}全集,电视剧{$vod_name},{$vod_name}下载,{$vod_name}主题曲,{$vod_name}剧情,{$vod_name}演员表">
<meta name="description" content="{$vod_name} {$vod_name}在线观看 {$vod_name}全集 电视剧{$vod_name}；{$vod_name}剧情：{$vod_content|h|msubstr=0,100}">
</head>
<body>
<include file="Home:header" />
<div class="container vod-detail ff-bg">
<div class="row">
	<div class="col-xs-12 ff-col">
  	<div class="page-header">
      <h4><span class="glyphicon glyphicon-film ff-text"></span> <a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$list_name}</a> <small>{$vod_name} <include file="Home:block_vod_continu" /></small></h4>
    </div>
    <ul class="list-unstyled vod-infos">
    	<li class="col-xs-4 ff-col-0">
      	<img class="img-responsive img-thumbnail ff-img vod-pic" data-original="{$vod_pic|ff_url_img=$vod_content}" alt="{$vod_name}全集观看">
      </li>
      <li class="col-xs-8">
      	<h4><a href="{:ff_url_vod_read($list_id,$list_dir,$vod_id,$vod_ename,$vod_jumpurl)}" class="ff-text">{$vod_name}</a></h4>
      	<dl class="dl-horizontal">
          <dt>主演：</dt>
          <dd class="ff-text-hidden ff-link">{$vod_actor|ff_url_search}</dd>
          <dt>类型：</dt>
          <dd class="ff-text-hidden"><a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$list_name}</a><include file="Home:block_vod_tags" /></dd>
          <dt>导演：</dt>
          <dd class="ff-text-hidden ff-link">{$vod_director|ff_url_search='director'}</dd>
          <dt>地区：</dt>
          <dd><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>urlencode($vod_area),'year'=>'','star'=>'','state'=>'','order'=>'hits'),true)}">{$vod_area|default='未录入'}</a></dd>
          <dt>年份：</dt>
          <dd><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>'','year'=>$vod_year,'star'=>'','state'=>'','order'=>'hits'),true)}">{$vod_year|default='2016'}</a></dd>
        </dl>
      </li>
    </ul>
  	<include file="Home:block_vod_playlist" />
    <include file="Home:block_vod_download" />
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
    	<a name="vod_content"></a>
      <h4><span class="glyphicon glyphicon-th-list ff-text"></span> 剧情介绍</h4>
    </div>
    <p class="vod-content">
    	{:ff_url_tags_content(strip_tags($vod_content,'<a>'),$Tag)}
    </p> 
    <include file="Home:block_vod_scenario" />
    <include file="Home:block_vod_series" />
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
      <h4><span class="glyphicon glyphicon-heart-empty ff-text"></span> 大家都在看</h4>
    </div>
    <ul class="list-unstyled">
      <volist name=":ff_mysql_vod('cid:'.$vod_cid.';limit:12;cache_name:default;cache_time:default;order:vod_hits_lasttime;sort:desc')" id="feifei" key="k">
      <li class="col-md-3 col-xs-4 text-center ff-col ff-vod-img-hot">
      <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}">
        <img class="img-responsive ff-img" data-original="{:ff_url_img($feifei['vod_pic'],$feifei['vod_content'])}" alt="{$feifei.vod_name}">
        <p><include file="Home:block_vod_continu_foreach" /></p>
      </a>
      <h4 class="ff-text-hidden">
        <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}" title="{$feifei.vod_name}">{$feifei.vod_name|msubstr=0,10}</a>
      </h4>
      </li>
      </volist>
    </ul>
    <!-- -->
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
      <h4><span class="glyphicon glyphicon-th-list ff-text"></span> 影片评论</h4>
    </div>
    <div class="ff-forum" id="ff-forum" data-id="{$vod_id}" data-sid="{$site_sid}">
      评论加载中...
    </div>
  </div><!-- -->
</div>
</div>
<include file="Home:footer" />
</body>
</html>