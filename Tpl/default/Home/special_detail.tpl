<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>{$special_title|default=$special_name.'－影视专题'}－{$site_name}</title>
<meta name="keywords" content="{$special_keywords|default='专题'.$special_name}">
<meta name="description" content="{$special_description|default=msubstr(h($special_content),0,100)}">
</head>
<include file="Home:header" />
<div class="container ff-bg ff-special special-detail">
<div class="row">
  <div class="col-xs-12 ff-col">
    <div class="page-header">
      <h4><span class="ff-text">专题：{$special_name}</span></h4> 
    </div>
    <div class="media">
      <a class="pull-left" href="javascript:;">
        <img class="media-object" src="{$special_banner|ff_url_img}">
      </a>
      <div class="media-body content">
        {$special_content}
      </div>
    </div>
    <div class="clearfix ff-clearfix"></div>
  </div>
</div>
</div>
<php>
if($special_tag_name){
	$special_vods = ff_mysql_vod('limit:24;tag_name:'.$special_tag_name.';tag_list:vod_tag;cache_name:default;cache_time:default;order:vod_hits desc');
  $special_news = ff_mysql_news('limit:20;tag_name:'.$special_tag_name.';tag_list:news_tag;cache_name:default;cache_time:default;order:news_hits desc');
}else{
	$special_vods = ff_mysql_vod('limit:24;ids:'.$special_ids_vod.';cache_name:default;cache_time:default;order:vod_hits desc');
  $special_news = ff_mysql_news('limit:20;ids:'.$special_ids_news.';cache_name:default;cache_time:default;order:news_hits desc');
}
</php>
<div class="clearfix ff-clearfix"></div>
<div class="container ff-bg ff-special special-detail">
<div class="row">
  <div class="col-md-8 ff-col">
  	<div class="page-header">
      <h4><span class="glyphicon glyphicon-heart-empty ff-text"></span> 相关影片</h4>
    </div>
    <ul class="list-unstyled">
      <volist name="special_vods" id="feifei">
      <gt name="k" value="8">
      <li class="col-md-3 col-sm-2 col-xs-4 text-center ff-col ff-vod-img-hot hidden-md hidden-lg">
      <else/>
      <li class="col-md-3 col-sm-2 col-xs-4 text-center ff-col ff-vod-img-hot">
      </gt>
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
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
      <h4>
      	<small class="pull-right"><a class="text-muted" href="{:ff_url('forum/special', array('cid'=>$special_id), true)}" target="_blank">查看所有评论</a></small>
      	<span class="glyphicon glyphicon-th-list ff-text"></span> 发表评论
      </h4>
    </div>
    <div class="ff-forum" id="ff-forum" data-id="{$special_id}" data-sid="{$site_sid}">
      评论加载中...
    </div>
  </div>
  <div class="clearfix ff-clearfix visible-xs visible-sm"></div>
 	<div class="col-md-4 ff-col">
  	<div class="page-header">
      <h4><span class="glyphicon glyphicon-signal ff-text"></span> 相关资讯</h4>
    </div>
    <notempty name="special_news">
    <ol class="news-item-hot">
      <volist name="special_news" id="feifei">
      <li><a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_ename'],$feifei['news_jumpurl'],1)}">{$feifei.news_name}</a></li></volist>
    </ol>
		</notempty>
  </div>
</div>
</div>
{$special_hits_insert}
<include file="Home:footer" />
</body>
</html>