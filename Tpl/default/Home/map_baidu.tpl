<?xml version="1.0" encoding="UTF-8"?>
<urlset>
<volist name=":ff_mysql_vod('limit:'.$limit.';page_is:true;page_id:list;page_p:'.$page.';cache_name:default;cache_time:default;order:vod_addtime;sort:asc')" id="feifei">
<url>
<loc>{$site_url}{:ff_url_vod_read($feifei['list_id'],$feifei['list_dir'],$feifei['vod_id'],$feifei['vod_ename'],$feifei['vod_jumpurl'])}</loc>
<lastmod>{$feifei.vod_addtime|date='Y-m-d',###}</lastmod>
<changefreq>always</changefreq>
<priority>1.0</priority>
</url>
</volist>
</urlset>