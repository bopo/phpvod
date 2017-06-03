<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>{$list_name}《{$vod_name}》分集剧情介绍－{$site_name}</title>
<meta name="keywords" content="{$vod_name}分集剧情,{$vod_name}在线观看,{$vod_name}剧情介绍">
<meta name="description" content="{$list_name}{$vod_name}分集剧情，{$vod_name}简要剧情介绍：{$vod_content|strip_tags|msubstr=0,100}">
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
      	<h4><a href="{:ff_url_vod_read($list_id,$list_dir,$vod_id,$vod_ename,$vod_jumpurl)}" class="ff-text">{$vod_name}</a></h4>
      	<dl class="dl-horizontal">
          <dt>主演：</dt>
          <dd class="ff-text-hidden ff-link">{$vod_actor|ff_url_search}</dd>
          <dt>类型：</dt>
          <dd class="ff-text-hidden"><a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$list_name}</a><include file="Home:block_vod_tags" /></dd>
          <dt>导演：</dt>
          <dd class="ff-text-hidden ff-link">{$vod_director|ff_url_search='director'}</dd>
          <dt class="hidden-xs">地区：</dt>
          <dd class="hidden-xs"><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>urlencode($vod_area),'year'=>'','star'=>'','state'=>'','order'=>'hits'),true)}">{$vod_area|default='未录入'}</a></dd>
          <dt>年份：</dt>
          <dd><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>'','year'=>$vod_year,'star'=>'','state'=>'','order'=>'hits'),true)}">{$vod_year|default='2016'}</a></dd>
          <dt class="hidden-xs">剧情：</dt>
          <dd class="hidden-xs vod-content">{:ff_url_tags_content(strip_tags($vod_content,'<a>'),$Tag)}</dd>
        </dl>
      </li>
    </ul>
    <div class="clearfix ff-clearfix"></div>
    <notempty name="vod_scenario.info">
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
      <h4><span class="glyphicon glyphicon-th-list ff-text"></span> {$vod_name}分集剧情</h4>
    </div>   
    <dl class="vod_scenario">
    	<volist name="vod_scenario.info" id="feifei">
      <dt id="vod_scenario_title_{$i}" class="vod_scenario_title">
      	<a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,1,$i)}" class="ff-text">{$vod_name} 第{$i}集</a>
      </dt>
      <dd id="vod_scenario_info_{$i}" class="vod_scenario_info">
      	{$feifei}<a href="{:ff_url('vod/scenario', array('id'=>$vod_id,pid=>$i), true)}" class="ff-text">详情...</a>
       </dd>
      </volist>
    </dl>
    </notempty>
  </div><!-- -->
</div>
</div>
<include file="Home:footer" />
</body>
</html>