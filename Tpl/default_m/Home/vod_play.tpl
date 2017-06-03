<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title><in name="list_id" value="2,3,4">《{$vod_name}》第{$play_pid}集在线观看－{$list_name}<else />《{$vod_name}》高清在线观看</in>－{$site_name}</title>
<meta name="keywords" content="{$vod_name},{$vod_name}在线观看,{$vod_name}全集,电视剧{$vod_name},{$vod_name}下载,{$vod_name}主题曲,{$vod_name}剧情,{$vod_name}演员表">
<meta name="description" content="{$vod_name} {$vod_name}在线观看 {$vod_name}全集 电视剧{$vod_name}，剧情介绍：{$vod_scenario['info'][$play_pid]|default=$vod_content|h|msubstr=0,100}">
</head>
<body>
<include file="Home:header" />
<div class="container vod-play ff-bg">
<div class="row">
	<div class="col-xs-12 ff-col">
    <div class="page-header">
      <h4>
      <dl class="dl-horizontal pull-right ff-raty text-right hidden-xs">
        <dd>
        <div id="ff-raty" data-module="vod" data-id="{$vod_id}" data-score="{$vod_gold/2}" data-toggle="tooltip" data-placement="bottom" title="评分"></div>
        <sup id="ff-raty-tips">{$vod_gold}</sup>
        </dd>
        <dt>评分</dt>
      </dl>
      <span class="glyphicon glyphicon-film ff-text"></span> 
      <a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$list_name}</a>
      <small><a href="{:ff_url_vod_read($list_id,$list_dir,$vod_id,$vod_ename,$vod_jumpurl)}" class="ff-text">{$vod_name}</a> 第{$play_pid}集</small>
      </h4>
    </div>
    <div class="clearfix"></div>
    <div class="ff-player">
    	<div class="embed-responsive embed-responsive-4by3" id="cms_player">
      {$vod_player}
      </div>
    </div>
    <div class="clearfix"></div>
    <include file="Home:block_vod_updown" />
    <div class="clearfix ff-clearfix"></div>
    <ul class="list-unstyled text-center m-play">
    	{:ff_url_ads('play-m')}
    </ul>
 		<include file="Home:block_vod_playlist" />
    <include file="Home:block_vod_download" />
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
{$vod_hits_insert}
<include file="Home:footer" />
</body>
</html>