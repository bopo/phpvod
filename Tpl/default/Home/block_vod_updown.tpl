<div class="row hidden-xs">
  <h5 class="col-xs-4 ff-mark">
    <!--<button class="btn btn-default btn-sm"><span class="glyphicon glyphicon-eye-open"></span> {$vod_hits+999|number_format}</button> -->
    <a class="btn btn-default btn-sm ff-updown" href="javascript:;" data-id="{$vod_id}" data-module="vod" data-type="up" data-toggle="tooltip" data-placement="top" title="支持"><span class="glyphicon glyphicon-thumbs-up"></span> 顶：<span class="ff-updown-tips">{$vod_up}</span></a>
    <a class="btn btn-default btn-sm ff-updown" href="javascript:;" data-id="{$vod_id}" data-module="vod" data-type="down" data-toggle="tooltip" data-placement="top" title="反对"><span class="glyphicon glyphicon-thumbs-down"></span> 踩：<span class="ff-updown-tips">{$vod_down}</span></a>
  </h5>
  <!--<dl class="col-xs-4 dl-horizontal ff-raty">
  	<dt>影片评分</dt>
    <dd>
    <div id="ff-raty" data-module="vod" data-id="{$vod_id}" data-score="{$vod_gold/2}" data-toggle="tooltip" data-placement="bottom" title="评分"></div>
    <sup id="ff-raty-tips">{$vod_gold}</sup>
    </dd>
  </dl> -->
  <div class="col-xs-4 ff-share" id="ff-share">
  </div>
  <h5 class="col-xs-4 text-right">
    <a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,$play_sid,$play_pid-1)}" class="btn btn-default btn-sm <eq name="play_pid" value="1">disabled</eq>">上一集</a>
    <a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,$play_sid,$play_pid+1)}" class="btn btn-default btn-sm <eq name="play_pid" value="$play_count">disabled</eq>">下一集</a>
   </h5>      
</div>