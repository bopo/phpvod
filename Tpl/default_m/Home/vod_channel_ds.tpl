<!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>《{$list_title|default=$list_name}》_{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<body class="vod-channel">
<include file="Home:header" />
<div class="container ff-bg">
  <div class="row">
    <div class="col-xs-12 ff-slide-pic">
      <include file="Home:block_slide_detail" />
      <div class="clearfix"></div>
      <ul class="list-inline">
        <li class="col-xs-12">
        	<h4 class="ff-text">按类型</h4>
          <ul class="list-inline">
          	<volist name=":explode(',',$list_extend['type'])" id="feifei" offset="0" length="20">
          	<li><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>urlencode($feifei),'area'=>'','year'=>'','star'=>'','state'=>'','order'=>'hits','p'=>1),true)}">{$feifei}</a></li>
            </volist>
          </ul>
        </li>
        <li class="col-xs-12">
        	<h4 class="ff-text">按年份</h4>
          <ul class="list-inline">
          	<volist name=":explode(',',$list_extend['year'])" id="feifei" offset="0" length="11">
          	<li><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>'','year'=>$feifei,'star'=>'','state'=>'','order'=>'hits','p'=>1),true)}">{$feifei}</a></li>
            </volist>
            <li><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>'','year'=>'19901999','star'=>'','state'=>'','order'=>'hits','p'=>1),true)}">更早</a></li>
          </ul>
        </li>
        <li class="col-xs-12">
        	<h4 class="ff-text">按地区</h4>
          <ul class="list-inline">
          	<volist name=":explode(',',$list_extend['area'])" id="feifei" offset="0" length="12">
          	<li><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>urlencode($feifei),'year'=>'','star'=>'','state'=>'','order'=>'hits','p'=>1),true)}">{$feifei}</a></li>
            </volist>
          </ul>
        </li>
      </ul>
    </div>
	</div>
</div>
<div class="clearfix ff-clearfix"></div> 
<volist name=":explode(',',$list_extend['area'])" id="feifeilist" offset="0" length="8">
<div class="container ff-bg">
  <div class="row">
    <div class="col-xs-12 ff-col index-left">
    <div class="page-header">
      <h4>
      <span class="glyphicon glyphicon-film ff-text"></span>
      {:str_replace(array('国','台湾','大陆','香港','日本'),array('剧','台剧','国产剧','港剧','日剧'),$feifeilist)}
      <span class="pull-right"><a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>'','area'=>urlencode($feifeilist),'year'=>'','star'=>'','state'=>'','order'=>'hits','p'=>1),true)}" class="btn btn-success btn-sm">更多</a></span>
      </h4>
    </div>
    <!-- -->
    <ul class="list-unstyled">
      <volist name=":ff_mysql_vod('field:list_id,list_name,list_dir,vod_id,vod_cid,vod_name,vod_pic,vod_ename,vod_jumpurl,vod_isend,vod_continu,vod_total,vod_gold;cid:'.$list_id.';area:'.$feifeilist.';limit:12;cache_name:default;cache_time:default;order:vod_stars desc,vod_addtime;sort:desc')" id="feifei" key="k">
      <li class="col-md-3 col-xs-4 text-center ff-col ff-vod-img-hot">
      <a href="{:ff_url_vod_read($list_id,$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}">
        <img class="img-responsive ff-img" data-original="{:ff_url_img($feifei['vod_pic'],$feifei['vod_content'])}" alt="{$feifei.vod_name}">
        <p><include file="Home:block_vod_continu_foreach" /></p>
      </a>
      <h4 class="ff-text-hidden">
        <a href="{:ff_url_vod_read($feifei['vod_cid'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}" title="{$feifei.vod_name}">{$feifei.vod_name|msubstr=0,10}</a>
      </h4>
      </li>
      </volist>
    </ul>
    </div><!--lg-8end -->
  </div><!--row end -->
</div>
<div class="clearfix ff-clearfix"></div>
</volist>
<include file="Home:footer" />
</body>
</html>