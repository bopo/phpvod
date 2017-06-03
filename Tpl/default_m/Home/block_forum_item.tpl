<volist name="list" id="feifei">
<div class="col-xs-12">
  <div class="row">
    <div class="col-xs-2 text-right">
      <img src="/Public/images/face/default.png" class="img-circle forum-face">
    </div>
    <div class="col-xs-10">
      <p class="forum-title">
        {$feifei.user_name|htmlspecialchars}
        <small>{$feifei.forum_addtime|date='Y/m/d',###}</small>
        <a class="btn btn-link btn-xs pull-right ff-report forum-report" id="ff-report-{$feifei.forum_id}" href="javascript:;" data-id="{$feifei.forum_id}" title="举报"><span class="glyphicon glyphicon-flag"></span> 举报</a>
      </p>
      <p class="forum-content">
      	{$feifei.forum_content|htmlspecialchars|msubstr=0,300}
      </p>
      <p class="forum-btn">
        <a class="btn btn-default btn-xs ff-updown" id="ff-up-{$feifei.forum_id}" href="javascript:;" data-id="{$feifei.forum_id}" data-module="forum" data-type="up" data-toggle="tooltip" data-placement="top" title="支持"><span class="glyphicon glyphicon-thumbs-up"></span> <span class="ff-updown-tips">{$feifei.forum_up}</span></a>
        <a class="btn btn-default btn-xs ff-updown" id="ff-down-{$feifei.forum_id}" href="javascript:;" data-id="{$feifei.forum_id}" data-module="forum" data-type="down" data-toggle="tooltip" data-placement="top" title="反对"><span class="glyphicon glyphicon-thumbs-down"></span> <span class="ff-updown-tips">{$feifei.forum_down}</span></a>
        <a class="btn btn-default btn-xs ff-reply" id="ff-reply-{$feifei.forum_id}" href="javascript:;" data-id="{$feifei.forum_id}" data-toggle="collapse" data-target="#forum-reply-{$feifei.forum_id}" title="回复"><span class="glyphicon glyphicon-comment"></span> <span class="ff-reply-tips">{$feifei.forum_reply}</span></a>
        <a class="btn btn-default btn-xs ff-reply-read forum-reply-{$feifei.forum_reply}" href="{:ff_url('forum/detail', array('id'=>$feifei['forum_id']), true)}" target="_blank" title="查看回复"><span class="glyphicon glyphicon-align-right"></span> 查看回复</a>
      </p>
      <p class="collapse forum-reply" id="forum-reply-{$feifei.forum_id}">
      </p>
    </div>
    <div class="clear"></div>
    <div class="col-xs-12 forum-clear"></div>
  </div>
</div>
<div class="clear"></div>
</volist>