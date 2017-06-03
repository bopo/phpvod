      <ul class="nav nav-pills" id="ff-tabs">
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            播放列表 <span class="caret"></span>
          </a>
          <ul class="dropdown-menu">
            <volist name="vod_play_list" id="feifei" key="k">
              <li><a href="#{$feifei.player_name_en}" data-toggle="tab">{$feifei.player_name_zh}</a></li>
            </volist>
          </ul>
        </li>
      </ul>
      <!-- Tab panes -->
      <div class="tab-content" id="ff-tabs-content">
        <volist name="vod_play_list" id="feifei" key="k">
            <div class="tab-pane fade" id="{$feifei.player_name_en}">
              <ul class="list-inline text-center vod-play-list">
                <volist name="feifei.son" id="feifeison" key="pid">
                <li class="col-xs-2"><a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,$feifei['player_sid'],$pid)}">{$feifeison.title}</a></li>
                </volist>
              </ul>
            </div>
        </volist>
      </div><!-- -->
      <script>
			$(function () {
				$('#ff-tabs a[href="#{$play_name_en}"]').tab('show');
			})
		</script>
