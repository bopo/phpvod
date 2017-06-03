<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>{$news_name}<notempty name="list_title">第{$list_page}页</notempty>_{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<include file="Home:header" />
<div class="container ff-bg ff-news news-detail">
<div class="row">
	<div class="col-md-8 col-xs-12 ff-col">
  	<div class="page-header">
      <h3 class="text-center">
      	{$news_name}
      </h3>
      <h5 class="text-muted text-center visible-md visible-lg">
      	来源：{$news_inputer|default='佚名'}
        人气：{$news_hits}
        更新：{$news_addtime|date='Y-m-d H:i:s',###}
      </h5>         
    </div>
    <p class="lead">
    	{$news_remark}
    </p> 
    <div class="content">
    	{:ff_url_tags_content($news_content, $Tag)}
    </div> 
    <p class="text-center">
      <a class="btn btn-default btn-lg ff-updown" href="javascript:;" data-id="{$news_id}" data-module="news" data-type="up" data-toggle="tooltip" data-placement="top" title="有用">
        <span class="glyphicon glyphicon-thumbs-up"></span> 有用（<span class="ff-updown-tips">{$news_up}</span>）
      </a>
  	</p>
    <include file="Home:block_news_page" />
  	<include file="Home:block_news_nextprev" />
    <include file="Home:block_news_tags" />
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header">
      <h4>
      	<small class="pull-right"><a class="text-muted" href="{:ff_url('forum/news', array('cid'=>$news_id), true)}" target="_blank">查看所有评论</a></small>
      	<span class="glyphicon glyphicon-th-list ff-text"></span> 发表评论
      </h4>
    </div>
    <div class="ff-forum" id="ff-forum" data-id="{$news_id}" data-sid="{$site_sid}">
      评论加载中...
    </div>
  </div>
  <div class="col-md-4 ff-col visible-md visible-lg">
    <div class="page-header ff-border-none">
      <h4><span class="glyphicon glyphicon-signal ff-text"></span> 热门{$list_name}</h4>
    </div>
    <ol class="news-item-hot">
    <volist name=":ff_mysql_news('cid:'.$list_id.';limit:15;cache_name:default;cache_time:default;order:news_hits;sort:desc')" id="feifei"><li><a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_name'],$feifei['news_jumpurl'],1)}">{$feifei.news_name}</a></li></volist>
    </ol>
  </div>
</div>
</div>
{$news_hits_insert}
<include file="Home:footer" />
</body>
</html>