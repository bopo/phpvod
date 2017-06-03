<div class="clearfix"></div>
<div class="container ff-bg">
  <div class="row">
    <div class="col-xs-12 ff-col">
    	<div class="ff-ads-footer text-center">
      {:ff_url_ads('footer')}
      </div>
    </div>
  </div>
</div>
<div class="clearfix ff-clearfix"></div>
<div class="container ff-bg ff-footer">
  <div class="row">
    <div class="col-md-10 col-sm-12 col-xs-12">
      <p>友情提示：请勿长时间观看影视，注意保护视力并预防近视，合理安排时间，享受健康生活。</p>
      <p>网站简介：{$site_description}</p>
      <p>版权声明：{$site_copyright}</p>
      <p>免责声明：本网站将逐步删除和规避程序自动搜索采集到的不提供分享的版权影视。本站仅供测试和学习交流。请大家支持正版。</p>
    </div>
    <ul class="col-md-2 hidden-sm hidden-xs">
      <li><a href="{:ff_url('map/show',array('id'=>'rss','limit'=>100,'p'=>1),true)}" target="_blank">rss</a></li>
      <li><a href="{:ff_url('map/show',array('id'=>'baidu','limit'=>100,'p'=>1),true)}" target="_blank">baidu</a></li>
      <li><a href="{:ff_url('map/show',array('id'=>'google','limit'=>100,'p'=>1),true)}" target="_blank">google</a></li>
      <li><a href="{:ff_url('map/show',array('id'=>'360','limit'=>100,'p'=>1),true)}" target="_blank">360</a></li>
      <li><a href="http://www.feifeicms.com/" target="_blank">feifeicms {%feifeicms_version}</a></li>
    </ul>  
  </div>
</div>
<span style="display:none">{$site_tongji}</span>