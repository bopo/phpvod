<php>
$list = ff_mysql_news('limit:10;tag_name:'.$tag_name.';tag_list:news_tag;page_is:true;page_id:newstag;page_p:'.$tag_page.';cache_name:default;cache_time:default;order:news_addtime;sort:desc');
$page = ff_url_page('news/tags',array('name'=>urlencode($tag_name),'p'=>'FFLINK'), true, 'newstag', 4);
$totalpages = ff_page_count('newstag', 'totalpages');
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>《{$tag_tag}{$tag_type}{$tag_name}》第{$tag_page}页_{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<body>
<include file="Home:header" />
<div class="container ff-bg news-tags news-list">
<div class="row">
  <div class="col-md-8 ff-col">
    <div class="page-header">
      <h4><span class="glyphicon glyphicon-pencil ff-text"></span> 话题：{$tag_type}{$tag_tag}{$tag_name}
      <small>共有<span class="ff-text">{:ff_page_count('newstag', 'records')}</span>篇内容</small>
    	</h4>
    </div>
    <volist name="list" id="feifei">
    <div class="row item">
      <div class="col-xs-8 col-sm-9">
        <h4>
          <a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_name'],$feifei['news_jumpurl'])}">
          {$feifei.news_name|msubstr=0,26,'utf-8',true}
          </a>
        </h4>
        <p class="text-muted hidden-xs">
          {$feifei.news_remark|strip_tags}
        </p>
        <h6 class="visible-xs">
          <span class="glyphicon glyphicon-eye-open"></span> {$feifei.news_hits|default='99'}
          <span class="glyphicon glyphicon-time"></span> {$feifei.news_addtime|date='Y-m-d',###}
        </h6>
      </div>
      <div class="col-xs-4 col-sm-3 text-center">
        <a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_name'],$feifei['news_jumpurl'],1)}">
        <img src="{:ff_url_img($feifei['news_pic'],$feifei['news_content'])}" class="img-responsive img-thumbnail" title="{$feifei.news_name}">
        </a>
      </div>
    </div>
    <div class="news-hr"></div>
    </volist>
    <gt name="totalpages" value="1">
      <div class="text-center">
        <ul class="pagination pagination-lg hidden-xs">
          {$page}
        </ul>
        <ul class="pager visible-xs">
          <gt name="list_page" value="1">
            <li><a href="{:ff_url('news/tags', array('name'=>urlencode($tag_name),'p'=>$tag_page-1), true)}">上一页</a></li>
          </gt>
          <lt name="list_page" value="$totalpages">
            <li><a href="{:ff_url('news/tags', array('name'=>urlencode($tag_name),'p'=>$tag_page+1), true)}">下一页</a></li>
          </lt>
         </ul>
      </div>
    </gt>
  </div><!-- -->
  <div class="col-md-4 ff-col visible-md visible-lg">
    <div class="page-header ff-border-none">
      <h4><span class="glyphicon glyphicon-signal ff-text"></span> 热门话题</h4>
    </div>
    <ul class="row list-unstyled text-center news-item-type">
    <volist name=":ff_mysql_tags('limit:21;cid:4;group:tag_name,tag_list;cache_name:default;cache_time:default;order:tag_count;sort:desc')" id="feifei" mod="7">
    <li class="col-xs-4"><a href="{:ff_url('news/tags',array('name'=>urlencode($feifei['tag_name'])),true)}" class="btn btn-sm btn-default btn-block ff-mod{$mod}">{$feifei.tag_name}({$feifei.tag_count})</a></li>
    </volist>
    </ul>
    <script>
    $(".ff-mod0").removeClass("btn-default").addClass("btn-success");
    $(".ff-mod3").removeClass("btn-default").addClass("btn-info");
    $(".ff-mod6").removeClass("btn-default").addClass("btn-primary").addClass("btn-lg");
    </script>
  </div>
</div>
</div>
<include file="Home:footer" />
</body>
</html>