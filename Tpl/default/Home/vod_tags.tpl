<php>
$list = ff_mysql_vod('limit:24;tag_name:'.$tag_name.';tag_list:vod_tag;page_is:true;page_id:vodtags;page_p:'.$tag_page.';cache_name:default;cache_time:default;order:vod_addtime;sort:desc');
$page = ff_url_page('vod/tags',array('name'=>urlencode($tag_name),'p'=>'FFLINK'), true, 'vodtags', 4);
$totalpages = ff_page_count('vodtags', 'totalpages');
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>《{$tag_tag}{$tag_type}{$tag_name}》第{$tag_page}页_{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<body><include file="Home:header" />
<div class="container vod-tags ff-bg">
<div class="row">
	<div class="col-xs-12 ff-col">
  	<div class="page-header">
      <h4>
        <span class="ff-text">话题：{$tag_type}{$tag_tag}{$tag_name}</span>
        <small>共有<span class="ff-text">{:ff_page_count('vodtags', 'records')}</span>个影片 第<span class="ff-text">{$tag_page}</span>页</small>
      </h4>
    </div>
	</div>
  <div class="clearfix"></div>
  <ul class="list-unstyled">
    <volist name="list" id="feifei">
    <li class="col-md-2 col-sm-2 col-xs-4 text-center ff-vod-img-new ff-col">
      <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}">
      <p><include file="Home:block_vod_continu_foreach" /></p>
      <img class="img-responsive img-thumbnail ff-img" data-original="{:ff_url_img($feifei['vod_pic'],$feifei['vod_content'])}" alt="{$feifei.vod_name}">
      </a>
      <h4 class="ff-text-hidden text-left">
        <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}" title="{$feifei.vod_name}">{$feifei.vod_name|msubstr=0,8}</a>
      </h4>
      <h6 class="ff-text-hidden text-left ff-link">
        {$feifei.vod_actor|ff_url_search}
      </h6>
    </li>
    </volist>
  </ul>
  <div class="col-xs-12 ff-col text-center">
  	<gt name="totalpages" value="1">
      <ul class="pagination pagination-lg hidden-xs">
        {$page}
      </ul>
      <ul class="pager visible-xs">
      <gt name="tag_page" value="1">
      	<li><a href="{:ff_url('vod/tags', array('name'=>urlencode($tag_name),'p'=>$tag_page-1), true)}">上一页</a></li>
      </gt>
      <lt name="tag_page" value="$totalpages">
      	<li><a href="{:ff_url('vod/tags', array('name'=>urlencode($tag_name),'p'=>$tag_page+1), true)}">下一页</a></li>
      </lt>
      </ul> 
    </gt>
  </div>
</div>
</div>
<include file="Home:footer" />
</body>
</html>