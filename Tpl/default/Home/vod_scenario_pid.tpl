<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>{$list_name}《{$vod_name}》第{$scenario_pid}集剧情介绍－{$site_name}</title>
<meta name="keywords" content="{$vod_name}第{$scenario_pid}集剧情,{$vod_name}第{$scenario_pid}集在线观看,{$vod_name}剧情介绍">
<meta name="description" content="{$list_name}{$vod_name}第{$scenario_pid}集剧情介绍，{$vod_name}简要剧情介绍：{$vod_content|strip_tags|msubstr=0,100}">
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
    	<li class="col-md-3 col-xs-4">
      	<img class="img-responsive img-thumbnail ff-img vod-pic" data-original="{$vod_pic|ff_url_img=$vod_content}" alt="{$vod_name}全集观看">
      </li>
      <li class="col-md-9 col-xs-8">
      	<h4><a href="{:ff_url('vod/scenario', array('id'=>$vod_id,pid=>$scenario_pid), true)}" class="ff-text">{$vod_name}第{$scenario_pid}集剧情介绍</a></h4>
      	<dl class="dl-horizontal">
          <dt>主演：</dt>
          <dd class="ff-text-hidden ff-link">{$vod_actor|ff_url_search}</dd>
          <dt>类型：</dt>
          <dd class="ff-text-hidden"><a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$list_name}</a><include file="Home:block_vod_tags" /></dd>
          <dt>导演：</dt>
          <dd class="ff-text-hidden ff-link">{$vod_director|ff_url_search='director'}</dd>
          <dt class="hidden-xs">地区：</dt>
          <dd class="hidden-xs"><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>urlencode($vod_area),'year'=>'','star'=>'','state'=>'','order'=>'hits'),true)}">{$vod_area|default='未录入'}</a></dd>
          <dt class="hidden-xs">详情：</dt>
          <dd class="hidden-xs"><a href="{:ff_url_vod_read($list_id,$list_dir,$vod_id,$vod_ename,$vod_jumpurl)}">{$vod_name}</a></dd>
          <dt class="hidden-xs">年份：</dt>
          <dd class="hidden-xs"><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>'','year'=>$vod_year,'star'=>'','state'=>'','order'=>'hits'),true)}">{$vod_year|default='2016'}</a></dd>
          <dd class="vod_scenario_btn">
          	<a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,1,$scenario_pid)}" class="btn btn-default btn-success btn-lg">立即播放第{$scenario_pid}集</a>
          </dd>
        </dl>
      </li>
    </ul>
    <div class="clearfix ff-clearfix"></div>
    <notempty name="vod_scenario.info">
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
      <h4><span class="glyphicon glyphicon-th-list ff-text"></span> {$vod_name}第{$scenario_pid}集剧情介绍</h4>
    </div> 
    <p class="lead vod-content">
    	{:ff_url_tags_content(strip_tags($vod_scenario['info'][$scenario_pid-1],'<a>'),$Tag)}
    </p>
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
      <h4><span class="glyphicon glyphicon-th-list ff-text"></span> {$vod_name}分集剧情介绍列表</h4>
    </div>
    <div class="vod_scenario col-md-6">
    	<volist name="vod_scenario.info" id="feifei">
      <li class="vod_scenario_item">
      	<a href="{:ff_url('vod/scenario', array('id'=>$vod_id,pid=>$i), true)}" class="ff-text">{$vod_name} 第{$i}集 剧情介绍</a>
      </li>
      </volist>
    </div>
    <div class="vod_scenario col-md-6">
    	<volist name="vod_scenario.info" id="feifei">
      <li class="vod_scenario_item">
        <a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,1,$i)}" class="ff-text">{$vod_name} 第{$i}集 在线观看</a>
      </li>
      </volist>
    </div>
    </notempty>
  </div><!-- -->
</div>
</div>
<include file="Home:footer" />
</body>
</html>