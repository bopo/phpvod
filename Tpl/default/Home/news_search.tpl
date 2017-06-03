<php>if($search_wd){
	$list = ff_mysql_news('wd:'.$search_wd.';limit:10;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:news_'.$search_order.';sort:desc');
  $params = array('wd'=>urlencode($search_wd),'p'=>'FFLINK');
  $page = ff_url_page('news/search', $params, true, 'search', 4);
}else if($search_remark){
	$list = ff_mysql_vod('remark:'.$search_remark.';limit:10;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:news_'.$search_order.';sort:desc');
  $params = array('remark'=>urlencode($search_remark),'p'=>'FFLINK');
  $page = ff_url_page('news/search', $params, true, 'search', 4);
}else if($search_name){
	$list = ff_mysql_news('name:'.$search_name.';limit:10;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:news_'.$search_order.';sort:desc');
  $params = array('name'=>urlencode($search_name),'p'=>'FFLINK');
  $page = ff_url_page('news/search', $params, true, 'search', 4);
}else if($search_title){
	$list = ff_mysql_news('title:'.$search_title.';limit:10;page_is:true;page_id:search;page_p:'.$search_page.';cache_name:default;cache_time:default;order:news_'.$search_order.';sort:desc');
  $params = array('title'=>urlencode($search_title),'p'=>'FFLINK');
  $page = ff_url_page('news/search', $params, true, 'search', 4);
}
$totalpages = ff_page_count('search', 'totalpages');
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>《{$search_name}{$search_remark}{$search_wd}》第{$search_page}页_{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<body>
<include file="Home:header" />
<div class="container ff-bg ff-news news-search news-list">
<div class="row">
	<div class="col-md-8 ff-col">
  	<div class="page-header">
      <h4><span class="glyphicon glyphicon-pencil ff-text"></span> 搜索结果：{$search_name}{$search_wd}
        <small>共有<span class="ff-text">{:ff_page_count('search', 'records')}</span>篇内容 第<span class="ff-text">{$search_page}</span>页</small>
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
          <gt name="search_page" value="1">
        	<php>$params['p'] = $search_page-1</php>
        	<li><a href="{:ff_url('news/search', $params, true)}">上一页</a></li>
          </gt>
          <lt name="search_page" value="$totalpages">
            <php>$params['p'] = $search_page+1</php>
            <li><a href="{:ff_url('news/search', $params, true)}">下一页</a></li>
          </lt>
       </ul>
      </div>
    </gt>
  </div>
  <div class="col-md-4 ff-col">
  	<div class="page-header ff-border-none">
      <h4><span class="glyphicon glyphicon-signal ff-text"></span> 热门资讯</h4>
    </div>
    <ol class="news-item-hot">
      <volist name=":ff_mysql_news('limit:10;cache_name:default;cache_time:default;order:news_hits;sort:desc')" id="feifei"><li><a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_name'],$feifei['news_jumpurl'],1)}">{$feifei.news_name}</a></li></volist>
     </ol>
  </div>
</div>
</div>
<include file="Home:footer" />
</body>
</html>