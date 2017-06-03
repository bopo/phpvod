<php>$list = ff_mysql_vod('cid:'.$type_id.';limit:24;tag_name:'.$type_type.';tag_list:vod_type;area:'.$type_area.';year:'.implode(',',str_split($type_year,4)).';actor:'.$type_star.';state:'.$type_state.';page_is:true;page_id:type;page_p:'.$type_page.';cache_name:default;cache_time:default;order:vod_'.$type_order.';sort:desc');
$params = array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>'FFLINK');
$page = ff_url_page('vod/type', $params, true, 'type', 4);
$totalpages = ff_page_count('type', 'totalpages');
</php><!DOCTYPE html>
<html lang="zh-cn">
<head>
<include file="Home:block_header" />
<title>{$type_type}{$type_area}{$type_year}{$type_star}{$type_state}{$list_name}大全-{$list_name}排行榜-{$site_name}</title>
<meta name="keywords" content="{$list_keywords}">
<meta name="description" content="{$list_description}">
</head>
<body>
<include file="Home:header" />
<div class="container ff-bg vod-type">
  <div class="row">
  	<div class="col-xs-12 ff-col">
      <div class="page-header">
        <h4><span class="glyphicon glyphicon-film ff-text"></span> {$list_name}
        <small>{$type_type} {$type_area} {$type_year} {$type_star} {$type_state} 共有<label class="ff-text">{:ff_page_count('type', 'records')}</label>个影片  第<span class="ff-text">{$type_page}</span>页</small>
        </h4>
      </div>
    </div>
    <div class="clearfix"></div>
  	<dl class="dl-horizontal">
      <dt>类型：</dt>
      <dd class="ff-text-hidden ff-gallery"><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>'','area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default" id="type{:md5('')}">全部</a><volist name=":explode(',',$list_extend['type'])" id="feifei" offset="0" length='15'><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($feifei),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default gallery-cell" id="type{:md5($feifei)}">{$feifei}</a></volist></dd>
      <dt>地区：</dt>
      <dd class="ff-text-hidden ff-gallery"><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>'','year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default" id="area{:md5('')}">全部</a><volist name=":explode(',',$list_extend['area'])" id="feifei" offset="0" length='15'><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($feifei),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default gallery-cell" id="area{:md5($feifei)}">{$feifei}</a></volist></dd>
      <dt>年代：</dt>
      <dd class="ff-text-hidden ff-gallery"><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>'','star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default" id="year{:md5('')}">全部</a><volist name=":explode(',',$list_extend['year'])" id="feifei" offset="0" length='7'><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$feifei,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default gallery-cell" id="year{:md5($feifei)}">{$feifei}</a></volist><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>'20002010','star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default gallery-cell" id="year{:md5('20002010')}">2010-2000</a><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>'19901999','star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default gallery-cell" id="year{:md5('19901999')}">90年代</a><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>'18001989','star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default gallery-cell" id="year{:md5('18001989')}">更早</a></dd>
      <notempty name="list_extend.star">
      <dt>明星：</dt>
      <dd class="ff-text-hidden ff-gallery"><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>'','state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default" id="star{:md5('')}">全部</a><volist name=":explode(',',$list_extend['star'])" id="feifei" offset="0" length='13'><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($feifei),'state'=>urlencode($type_state),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default gallery-cell" id="star{:md5($feifei)}">{$feifei}</a></volist></dd>
      </notempty>
      <notempty name="list_extend.state">
      <dt>资源：</dt>
      <dd class="ff-text-hidden ff-gallery"><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>'','order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default" id="state{:md5('')}">全部</a><volist name=":explode(',',$list_extend['state'])" id="feifei" offset="0" length='15'><a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($feifei),'order'=>$type_order,'p'=>1),true)}" class="btn btn-sm btn-default gallery-cell" id="state{:md5($feifei)}">{$feifei}</a></volist></dd>
      </notempty>
    </dl>
  </div>
</div>
<div class="clearfix ff-clearfix"></div>
<div class="container ff-bg vod-type">
<div class="row">
  <div class="btn-toolbar" role="toolbar">
    <div class="btn-group">
      <a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>hits,'p'=>1),true)}" class="btn btn-default" id="orderhits">最近热播</a>
      <a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>addtime,'p'=>1),true)}" class="btn btn-default" id="orderaddtime">最新上映</a>
      <a href="{:ff_url('vod/type',array('id'=>$type_id,'type'=>urlencode($type_type),'area'=>urlencode($type_area),'year'=>$type_year,'star'=>urlencode($type_star),'state'=>urlencode($type_state),'order'=>gold,'p'=>1),true)}" class="btn btn-default" id="ordergold">评分最高</a>
    </div>
  </div>
  <script>
  $("#type{$type_type|md5}").removeClass("btn-default").addClass("btn-success");
  $("#area{$type_area|md5}").removeClass("btn-default").addClass("btn-success");
  $("#year{$type_year|md5}").removeClass("btn-default").addClass("btn-success");
  $("#star{$type_star|md5}").removeClass("btn-default").addClass("btn-success");
  $("#state{$type_state|md5}").removeClass("btn-default").addClass("btn-success");
  $("#order{$type_order}").removeClass("btn-default").addClass("btn-success");
  </script>
  <!-- -->
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
        {$feifei.vod_actor|default='主演'|ff_url_search}
      </h6>
    </li>
    </volist>
  </ul>
  <!-- -->
  <div class="clearfix"></div>
  <div class="col-xs-12 text-center">
  	<gt name="totalpages" value="1">
    <ul class="pagination pagination-lg hidden-xs">
      {$page}
    </ul>
    <ul class="pager visible-xs">
      <gt name="page.totalpages" value="1">
        <php>$params['p'] = $type_page-1</php>
        <li><a href="{:ff_url('vod/type', $params, true)}">上一页</a></li>
      </gt>
      <lt name="list_page" value="$totalpages">
      	<php>$params['p'] = $type_page+1</php>
        <li><a href="{:ff_url('vod/type', $params, true)}">下一页</a></li>
      </lt>
    </ul> 
    </gt>
  </div>
</div>
</div>
<include file="Home:footer" />
</body>
</html>