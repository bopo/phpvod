<!-- Nav tabs -->
<div class="clearfix ff-clearfix"></div>
<ul class="nav nav-tabs" id="ff-tab">
  <volist name="vod_play_list" id="feifei" key="k">
  	<neq name="feifei.player_name_en" value="down">
      <eq name="k" value="1"><li class="active"><else/><li></eq>
      <a href="#{$feifei.player_name_en}" data-toggle="tab"><span class="glyphicon glyphicon-film"></span> {$feifei.player_name_zh}</a>
      </li>
    </neq>
  </volist>
</ul>
<!-- Tab panes -->
<php>
if($action == 'read' || $action == 'ename'){
	$target="_ffplay";
}else{
	$target="_top";
}
</php>
<div class="tab-content" id="ff-tab-content">
  <volist name="vod_play_list" id="feifei" key="k">
  	<neq name="feifei.player_name_en" value="down">
      <eq name="k" value="1">
        <div class="tab-pane fade in active" id="{$feifei.player_name_en}">
          <ul class="list-unstyled text-center play-list">
            <volist name="feifei.son" id="feifeison" key="pid">
            <eq name="list_id" value="4">
              <li class="col-xs-6"><a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,$feifei['player_sid'],$pid)}" class="btn btn-default btn-sm" id="{$vod_id}_{$feifei.player_sid}_{$pid}" target="{$target}">{$feifeison.title}</a></li>
            <else/>
              <li class="col-md-2 col-sm-2 col-xs-4"><a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,$feifei['player_sid'],$pid)}" class="btn btn-default btn-sm" id="{$vod_id}_{$feifei.player_sid}_{$pid}" target="{$target}">{$feifeison.title}</a></li>
            </eq>
            </volist>
          </ul>
        </div>
      <else/>
        <div class="tab-pane fade" id="{$feifei.player_name_en}">
          <ul class="list-unstyled text-center play-list">
            <volist name="feifei.son" id="feifeison" key="pid">
            <eq name="list_id" value="4">
            <li class="col-xs-6"><a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,$feifei['player_sid'],$pid)}" class="btn btn-default btn-sm" id="{$vod_id}_{$feifei.player_sid}_{$pid}" target="{$target}">{$feifeison.title}</a></li>
            <else/>
            <li class="col-md-2 col-sm-2 col-xs-4"><a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,$feifei['player_sid'],$pid)}" class="btn btn-default btn-sm" id="{$vod_id}_{$feifei.player_sid}_{$pid}" target="{$target}">{$feifeison.title}</a></li>
            </eq>
            </volist>
          </ul>
        </div>
      </eq>
    </neq>
  </volist>
</div>
<script>
$('#ff-tab a[href="#{$play_name_en}"]').tab('show');
$("#{$vod_id}_{$play_sid}_{$play_pid}").removeClass("btn-default").addClass("btn-success");
</script>