<notempty name="vod_series">
<div class="clearfix ff-clearfix"></div>
<div class="page-header">
  <h4><span class="glyphicon glyphicon-heart-empty ff-text"></span> 相关影片系列</h4>
</div>
<ul class="list-unstyled">
  <volist name=":ff_mysql_vod('ids:'.$vod_series.';limit:12;order:vod_hits_lasttime;sort:desc')" id="feifei" key="k">
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
</notempty>