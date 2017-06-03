<php>
$list = ff_mysql_vod('cid:'.$list_id.';limit:24;page_is:true;page_id:list;page_p:'.$list_page.';cache_name:default;cache_time:default;order:vod_addtime;sort:desc');
</php>
<volist name="list" id="feifei">
<li class="col-md-2 col-sm-2 col-xs-4">
  <a href="{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}" class="thumbnail-">
  <img src="{:ff_url_img($feifei['vod_pic'],$feifei['vod_content'])}" alt="{$feifei.vod_name}" class="img-responsive img-rounded img-thumbnail">
  </a>
  <h5 class="ff-text-hidden">
    <a href="{:ff_url('vod/read',array('id'=>$feifei['vod_id']),false,true)}" title="{$feifei.vod_name}">{$feifei.vod_name|msubstr=0,8}</a>
  </h5>
</li>
</volist>