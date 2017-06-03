<php>
$list = ff_mysql_news('cid:'.$list_id.';limit:10;tag_name:'.$type_type.';tag_list:news_type;page_is:true;page_id:list;page_p:'.$type_page.';cache_name:default;cache_time:default;order:news_addtime;sort:desc');
$page = ff_url_page('news/type',array('type'=>urlencode($type_type),'id'=>$list_id,'p'=>'FFLINK'), true, 'list', 4);
$totalpages = ff_page_count('list', 'totalpages');
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>《<notempty name="list_title">{$list_title}_<else/>{$list_name}_</notempty>{$type_type}》第{$list_page}页_{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<body>
<include file="Home:header" />
<div class="container ff-bg news-type news-list">
<div class="row">
	<div class="col-md-8 ff-col">
  	<div class="page-header">
     <h4><span class="glyphicon glyphicon-pencil ff-text"></span> <a href="{:ff_url_news_show($list_id,$list_dir,1)}">{$list_name}</a>
     <small>{$type_type}{$type_name} 共有<span class="ff-text">{:ff_page_count('list', 'records')}</span>篇内容 第<span class="ff-text">{$type_page}</span>页</small>
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
          <gt name="type_page" value="1">
            <li><a href="{:ff_url('news/type',array('type'=>$type_type,'id'=>$list_id,'p'=>$type_page-1))}">上一页</a></li>
          </gt>
          <lt name="type_page" value="$totalpages">
            <li><a href="{:ff_url('news/type',array('type'=>$type_type,'id'=>$list_id,'p'=>$type_page+1))}">下一页</a></li>
          </lt>
         </ul>
      </div>
    </gt>
  </div><!-- -->
  <div class="col-md-4 ff-col visible-md visible-lg">
  	 <div class="page-header ff-border-none">
      <h4><span class="glyphicon glyphicon-th-list ff-text"></span> 相关分类</h4>
    </div>
    <ul class="row list-unstyled text-center news-item-type">
      <volist name=":explode(',',$list_extend['type'])" id="feifei" offset="0" length='12'>
      <li class="col-xs-4"><a href="{:ff_url('news/type',array('type'=>urlencode($feifei),'id'=>$list_id,'p'=>1),true)}" class="btn btn-sm btn-default btn-block" id="type{:md5($feifei)}">{$feifei}</a></li>
      </volist>
    </ul>
    <script>$("#type{$type_type|md5}").removeClass("btn-default").addClass("btn-success");</script>
    <div class="clearfix ff-clearfix"></div>
    <div class="page-header ff-border-none">
      <h4><span class="glyphicon glyphicon-signal ff-text"></span> 热门{$type_type}</h4>
    </div>
    <ol class="news-item-hot">
      <volist name=":ff_mysql_news('cid:'.$list_id.';limit:10;tag_name:'.$type_type.';tag_list:news_type;cache_name:default;cache_time:default;order:news_hits;sort:desc')" id="feifei">
      <li><a href="{:ff_url_news_read($feifei['list_id'],$feifei['list_dir'],$feifei['news_id'],$feifei['news_name'],$feifei['news_jumpurl'],1)}">{$feifei.news_name}</a></li></volist>
    </ol>
  </div>
</div>
</div>
<include file="Home:footer" />
</body>
</html>