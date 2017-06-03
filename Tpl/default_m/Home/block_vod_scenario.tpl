<notempty name="vod_scenario.info">
  <div class="clearfix ff-clearfix"></div>
  <div class="page-header">
    <h4>
    	<span class="glyphicon glyphicon-th-list ff-text"></span> 
    	<a href="{:ff_url('vod/scenario', array('id'=>$vod_id), true)}" title="{$vod_name}分集剧情">分集剧情</a>
   	</h4>
  </div>
  <ul id="vod_scenario_item" class="row list-unstyled vod_scenario_item">
  </ul>
  <dl id="vod_scenario" class="vod_scenario">
    <volist name="vod_scenario.info" id="feifei">
    <dt id="vod_scenario_title_{$i}" class="vod_scenario_title">
      <a href="{:ff_url_vod_play($list_id,$list_dir,$vod_id,$vod_ename,1,$i)}" class="ff-text">{$vod_name} 第{$i}集</a>
    </dt>
    <dd id="vod_scenario_info_{$i}" class="vod_scenario_info">
      {$feifei}
     </dd>
    </volist>
  </dl>
</notempty>