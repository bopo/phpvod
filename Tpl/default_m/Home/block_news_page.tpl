<gt name="news_page_count" value="1">
<ul class="pager">
  <gt name="news_page" value="1">
  	<li><a href="{:ff_url_news_read($list_id,$list_dir,$news_id,$news_ename,$news_jumpurl,$news_page-1)}">上一页</a></li>
  </gt>
  <lt name="news_page" value="$news_page_count">
  	<li><a href="{:ff_url_news_read($list_id,$list_dir,$news_id,$news_ename,$news_jumpurl,$news_page+1)}">下一页</a></li>
  </lt>
</ul>
</gt>