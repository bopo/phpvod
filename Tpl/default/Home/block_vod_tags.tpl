<volist name="Tag" id="feifei">
<eq name="feifei.tag_list" value="vod_type">&nbsp;<a href="{:ff_url('vod/type',array('id'=>$list_id,'type'=>urlencode($feifei['tag_name']),'area'=>'','year'=>'','star'=>'','state'=>'','order'=>'hits'),true)}">{$feifei.tag_name}</a><else />&nbsp;<a href="{$feifei.tag_name|ff_url_tags}">{$feifei.tag_name}</a>
</eq>
</volist>