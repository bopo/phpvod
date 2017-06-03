<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0">
<channel>
<title>{$site_name}</title> 
<description>{$site_name}</description> 
<link>{$site_url}</link> 
<language>zh-cn</language> 
<docs>{$site_name}</docs> 
<generator>Rss Powered By {$site_url}</generator> 
<image>
<url>{$site_url}/Public/images/logo.gif</url> 
</image>
<volist name=":ff_mysql_vod('limit:'.$limit.';page_is:true;page_id:list;page_p:'.$page.';cache_name:default;cache_time:default;order:vod_addtime;sort:asc')" id="feifei">
<item>
<title>{$feifei.vod_name|htmlspecialchars}{$feifei.vod_title|htmlspecialchars}</title> 
<link>{$site_url}{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}</link>
<author>{$feifei.vod_actor|htmlspecialchars}</author>
<pubDate>{$feifei.vod_addtime|date='Y-m-d H:i:s',###}</pubDate>
<description><![CDATA["{$feifei.vod_content|msubstr=0,200}"]]></description> 
</item>
</volist>
</channel>
</rss>