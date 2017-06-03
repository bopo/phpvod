<php>$list = ff_mysql_forum('cid:'.$forum_cid.';sid:1;pid:0;limit:20;page_is:true;page_id:forum;page_p:'.$forum_page.';cache_name:default;cache_time:default;order:forum_addtime;sort:desc');
$page_array = $_GET['ff_page_forum'];
if($forum_cid){
	$vod = $list[0];
	$page_info = ff_url_page('forum/vod', array('cid'=>$forum_cid,'p'=>'FFLINK'), true, 'forum', 4);
  $page_this = ff_url('forum/vod', array('cid'=>$forum_cid), true);
  $page_last = ff_url('forum/vod', array('cid'=>$forum_cid,'p'=>($forum_page-1)), true);
  $page_next = ff_url('forum/vod', array('cid'=>$forum_cid,'p'=>($forum_page+1)), true);
}else{
	$page_info = ff_url_page('forum/vod', array('p'=>'FFLINK'), true, 'forum', 4);
  $page_this = ff_url('forum/vod', '', true);
  $page_last = ff_url('forum/vod', array('p'=>($forum_page-1)), true);
  $page_next = ff_url('forum/vod', array('p'=>($forum_page+1)), true);
}
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>{$vod['vod_name']}影评第{$forum_page}页_{$site_name}</title>
<meta name="keywords" content="{$vod['vod_name']}影评,{$vod['vod_name']}观后感">
<meta name="description" content="{$vod['vod_name']}影评共有{$page_array.totalpages}页,为你展示的是第{$forum_page}的精彩评论。">
</head>
<body><include file="Home:header" />
<div class="container ff-bg ff-forum ff-forum-reload forum-vod">
<div class="row">
<div class="col-xs-10 col-xs-offset-1">
  <div class="page-header">
    <h4><span class="glyphicon glyphicon-heart-empty ff-text"></span> <a href="{$page_this}">{$vod['vod_name']}精彩影评</a></h4>
  </div>
</div>
<div class="clear"></div>
<notempty name="forum_cid">
<div class="col-md-10 col-md-offset-1 col-xs-12 vod-detail">
  <ul class="row list-unstyled vod-infos">
    <li class="col-md-4 col-xs-4">
      <img class="img-responsive img-thumbnail ff-img vod-pic" data-original="{$vod.vod_pic|ff_url_img}" alt="{$vod.vod_name}全集观看">
    </li>
    <li class="col-md-8 col-xs-8">
      <dl class="dl-horizontal">
        <dt>主演：</dt>
        <dd class="ff-text-hidden ff-link">{$vod.vod_actor|ff_url_search}</dd>
        <dt>导演：</dt>
        <dd class="ff-text-hidden ff-link">{$vod.vod_director|ff_url_search='director'}</dd>
        <dt class="hidden-xs">地区：</dt>
        <dd class="hidden-xs"><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>urlencode($vod_area),'year'=>'','star'=>'','state'=>'','order'=>'hits'),true)}">{$vod.vod_area|default='未录入'}</a></dd>
        <dt>年份：</dt>
        <dd><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>'','year'=>$vod_year,'star'=>'','state'=>'','order'=>'hits'),true)}">{$vod.vod_year|default='2016'}</a></dd>
        <dt>剧情：</dt>
        <dd class="vod-content">{$vod.vod_content|strip_tags|msubstr=0,200,'utf-8',true}<a class="ff-text" href="{:ff_url_vod_read($vod['list_id'],$vod['list_dir'],$vod['vod_id'],$vod['vod_ename'],$vod['vod_jumpurl'])}" target="_blank">免费观看</a></dd>
      </dl>
    </li>
  </ul>
</div>
<div class="clear"></div>
</notempty>
<div class="ff-forum-post-{$forum_cid}" id="ff-forum-post">
<div class="col-md-10 col-md-offset-1 col-xs-12">
  <form class="form-horizontal col-xs-12 ff-form form-forum" id="form-forum" role="form" action="{$root}index.php?s=forum-update" method="post">
    <input name="forum_cid" type="hidden" value="{$forum_cid}" />
    <input name="forum_sid" type="hidden" value="1" />
    <input name="forum_pid" type="hidden" value="0" />
    <div class="form-group">
      <textarea name="forum_content" class="form-control" rows="5" placeholder="吐槽......"></textarea>
    </div>
    <div class="form-group ff-submit text-right">
      <label>
      	<input class="form-control input-sm text-center ff-vcode ff-vcode-input" name="forum_vcode" maxlength="4" type="text" placeholder="验证码">
      </label>
      <label>
    		<button type="submit" class="btn btn-default btn-sm">发表影评</button>
      </label>
    </div>
    <div class="form-group ff-alert clear">
    </div>
  </form>
</div>
<div class="clear"></div>
</div><!--post end -->
<div id="ff-forum-item">
<volist name="list" id="feifei">
<div class="col-md-10 col-md-offset-1 col-xs-12">
  <div class="row">
    <div class="col-md-1 col-xs-2 text-right">
      <img src="/Public/images/face/default.png" class="img-circle forum-face">
    </div>
    <div class="col-md-11 col-xs-10">
      <p class="forum-title">
      	《<a href="{:ff_url('forum/vod', array('cid'=>$feifei['forum_cid']), true)}">{$feifei.vod_name}</a>》的影评
        <small>{$feifei.user_name|htmlspecialchars} {$feifei.forum_addtime|date='Y/m/d',###}</small>
        <a class="btn btn-link btn-xs pull-right ff-report forum-report" id="ff-report-{$feifei.forum_id}" href="javascript:;" data-id="{$feifei.forum_id}" title="举报"><span class="glyphicon glyphicon-flag"></span> 举报</a>
      </p>
      <p class="forum-content">
      	{$feifei.forum_content|htmlspecialchars|msubstr=0,300}
      </p>
      <p class="forum-btn">
        <a class="btn btn-default btn-xs ff-updown" id="ff-up-{$feifei.forum_id}" href="javascript:;" data-id="{$feifei.forum_id}" data-module="forum" data-type="up" data-toggle="tooltip" data-placement="top" title="支持"><span class="glyphicon glyphicon-thumbs-up"></span> <span class="ff-updown-tips">{$feifei.forum_up}</span></a>
        <a class="btn btn-default btn-xs ff-updown" id="ff-down-{$feifei.forum_id}" href="javascript:;" data-id="{$feifei.forum_id}" data-module="forum" data-type="down" data-toggle="tooltip" data-placement="top" title="反对"><span class="glyphicon glyphicon-thumbs-down"></span> <span class="ff-updown-tips">{$feifei.forum_down}</span></a>
        <a class="btn btn-default btn-xs ff-reply" id="ff-reply-{$feifei.forum_id}" href="javascript:;" data-id="{$feifei.forum_id}" data-toggle="collapse" data-target="#forum-reply-{$feifei.forum_id}" title="回复"><span class="glyphicon glyphicon-comment"></span> <span class="ff-reply-tips">{$feifei.forum_reply}</span></a>
        <a class="btn btn-default btn-xs ff-reply-read forum-reply-{$feifei.forum_reply}" href="{:ff_url('forum/detail', array('id'=>$feifei['forum_id']), true)}" target="_blank" title="查看回复"><span class="glyphicon glyphicon-align-right"></span> 查看回复</a>
        <a class="btn btn-default btn-xs" href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}" target="_blank"><span class="glyphicon glyphicon-play"></span> 免费观看</a>
      </p>
      <p class="collapse forum-reply" id="forum-reply-{$feifei.forum_id}">
      </p>
    	<div class="col-xs-12 clear forum-clear"></div>
    </div>
  </div>
</div>
<div class="clear"></div>
</volist>
</div>
<!-- -->
<div id="ff-forum-page">
<div class="col-md-10 col-md-offset-1 col-xs-12">
  <gt name="page_array.totalpages" value="1">
  <div class="row">
    <div class="col-xs-12 text-center">
      <ul class="pagination pagination-lg hidden-xs">
        {$page_info}
      </ul>
      <ul class="pager visible-xs">
        <gt name="forum_page" value="1">
          <li><a href="{$page_last}">上一页</a></li>
        </gt>
        <lt name="forum_page" value="$page_array['totalpages']">
          <li><a href="{$page_next}">下一页</a></li>
        </lt>
      </ul> 
    </div>
  </div>
  </gt>
</div>
</div><!--pageid end -->
<!-- -->
</div><!--row end -->
</div><!-- -->
<include file="Home:footer" />
</body>
</html>