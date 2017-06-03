<div class="clearfix ff-clearfix"></div>
<div class="container ff-bg">
  <div class="row">
    <div class="col-xs-12 ff-col">
    	<div class="m-footer text-center">
      {:ff_url_ads('footer-m')}
      </div>
    </div>
  </div>
</div>
<div class="clearfix ff-clearfix"></div>
<div class="container ff-bg ff-footer">
  <div class="row">
    <div class="col-xs-12">
      <p>网站简介：{$site_description}</p>
      <p>版权声明：{$site_copyright}</p>
      <p>
        <a href="{:ff_url('map/show',array('id'=>'rss','limit'=>100,'p'=>1),true)}" target="_blank">rss</a>
        <a href="{:ff_url('map/show',array('id'=>'baidu','limit'=>100,'p'=>1),true)}" target="_blank">baidu</a>
        <a href="{:ff_url('map/show',array('id'=>'google','limit'=>100,'p'=>1),true)}" target="_blank">google</a>
        <a href="{:ff_url('map/show',array('id'=>'360','limit'=>100,'p'=>1),true)}" target="_blank">360</a>
        <a href="http://www.feifeicms.com/" target="_blank">feifeicms {%feifeicms_version}</a>
     	</p>
      <p style="display:none">{$site_tongji}</p>
    </div>
  </div>
</div>