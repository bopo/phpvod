<php>
$block_actor_name = '同主演作品';
$block_actor_list = ff_mysql_vod('cid:'.$vod_cid.';actor:'.ff_array(explode(',',$vod_actor),0).';limit:5;cache_name:default;cache_time:default;order:vod_id;sort:desc');
if(!$block_actor_list){
  $block_actor_name = '好评榜';
  $block_actor_list = ff_mysql_vod('cid:'.$vod_cid.';limit:5;cache_name:default;cache_time:default;order:vod_gold;sort:desc');
}
</php>
<div class="page-header ff-border-none">
  <h4><span class="glyphicon glyphicon-signal ff-text"></span> {$block_actor_name}</h4>
</div>
<ul class="row list-unstyled ff-play-item">
  <volist name="block_actor_list" id="feifei">
  <li class="col-xs-4 text-center">
    <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}">
      <img class="img-responsive img-thumbnail ff-img" data-original="{:ff_url_img($feifei['vod_pic'],$feifei['vod_content'])}" alt="{$feifei.vod_name}">
    </a>
  </li>
  <li class="col-xs-8">
    <p class="ff-text-hidden">
    <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}" class="ff-text">{$feifei.vod_name}</a></p>
    <p class="ff-text-hidden ff-link">主演：{$feifei.vod_actor|ff_url_search}</p>
    <p>类型：<a href="{:ff_url_vod_show($list_id,$list_dir,1)}">{$feifei.list_name}</a></p>
    <p>评分：{$feifei.vod_gold|ff_gold}</p>
  </li>
  <div class="clearfix ff-clearfix"></div>
  </volist>
</ul>