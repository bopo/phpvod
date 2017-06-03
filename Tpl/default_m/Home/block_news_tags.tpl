<h5 class="tags text-right">
  <span class="glyphicon glyphicon-tags"></span>
  <volist name="Tag" id="feifei">
  <eq name="feifei.tag_list" value="news_type">
 	<span class="label label-default"><a href="{:ff_url('news/type',array('type'=>urlencode($feifei['tag_name']),'id'=>$list_id),true)}">{$feifei.tag_name}</a></span>
  <else/>
  <span class="label label-success"><a href="{:ff_url_tags($feifei['tag_name'],$feifei['tag_list'])}">{$feifei.tag_name}</a></span>
  </eq>
  </volist>
</h5>