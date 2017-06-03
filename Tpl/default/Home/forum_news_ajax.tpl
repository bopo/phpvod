<php>$list = ff_mysql_forum('cid:'.$forum_cid.';sid:'.$forum_sid.';pid:0;limit:10;page_is:true;page_id:forum;page_p:'.$forum_page.';cache_name:default;cache_time:default;order:forum_addtime;sort:desc');$page_array = $_GET['ff_page_forum'];
if($forum_page > 1){
  if($forum_page > $page_array['totalpages']){
   exit();
  }
}
</php>
<gt name="forum_page" value="1">
<include file="Home:block_forum_item" />
<else/>
<div class="row">
<div id="ff-forum-post">
<div class="col-xs-12">
  <form class="form-horizontal col-xs-12 ff-form form-forum" id="form-forum" role="form" action="{$root}index.php?s=forum-update" method="post">
    <input name="forum_cid" type="hidden" value="{$forum_cid}" />
    <input name="forum_sid" type="hidden" value="{$forum_sid|default=1}" />
    <input name="forum_pid" type="hidden" value="{$forum_pid}" />
    <div class="form-group">
      <textarea name="forum_content" class="form-control" rows="5" placeholder="吐槽......"></textarea>
    </div>
    <div class="form-group ff-submit text-right">
      <label>
      	<input class="form-control input-sm text-center ff-vcode ff-vcode-input" name="forum_vcode" maxlength="4" type="text" placeholder="验证码">
      </label>
      <label>
    		<button type="submit" class="btn btn-default btn-sm">发表评论</button>
      </label>
    </div>
    <div class="form-group ff-alert clear">
    </div>
  </form>
</div>
</div>
<div class="clear"></div>
<div id="ff-forum-item">
<include file="Home:block_forum_item" />
</div><!-- forum-item end-->
<div id="ff-forum-page">
<gt name="page_array.records" value="10">
<div class="col-xs-12">
  <h6>
    <a class="btn btn-default btn-block ff-page-more" id="ff-page-more" data-id="ff-forum-item" data-page="{$forum_page}" data-url="{$root}index.php?s=forum-news_ajax-sid-{$forum_sid}-cid-{$forum_cid}-p-" href="javascript:;">查看更多评论...</a>
  </h6>
</div>
<div class="clear"></div>
</gt>
</div><!--pageid end -->
<!-- -->
</div><!--row end -->
</gt>