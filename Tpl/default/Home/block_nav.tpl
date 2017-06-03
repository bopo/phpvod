<nav class="navbar navbar-inverse visible-lg visible-md" role="navigation">
  <div class="container">
      <ul class="nav navbar-nav navbar-left">
        <volist name=":ff_mysql_nav('field:*;limit:120;cache_name:default;cache_time:default;order:nav_pid asc,nav_oid;sort:asc')" id="feifei">
        <notempty name="feifei.nav_son">
        	<li class="dropdown">
          	<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">{$feifei.nav_title}<b class="caret"></b></a>
            <ul class="dropdown-menu">
            	<volist name="feifei.nav_son" id="feifeison">
              <eq name="feifeison.nav_target" value="1">
              	<li><a href="{$feifeison.nav_link}" target="_blank">{$feifeison.nav_title}</a></li>
               <else/>
               	<li><a href="{$feifeison.nav_link}">{$feifeison.nav_title}</a></li>
               </eq>
              </volist>
            </ul>
          </li>
        <else/>
        	 <eq name="feifei.nav_target" value="1">
            <li id="nav-{$feifei.nav_tips}"><a href="{$feifei.nav_link}" target="_blank">{$feifei.nav_title}</a></li>
          <else/>
            <li id="nav-{$feifei.nav_tips}"><a href="{$feifei.nav_link}">{$feifei.nav_title}</a></li>
          </eq>
        </notempty>
        </volist>
      </ul>
      <p class="navbar-text navbar-right"><span class="glyphicon glyphicon-phone" data-toggle="popover" data-trigger="hover" data-placement="left" data-container="body" data-title="手机浏览请扫瞄二维码"></span></p>
      <neq name="model" value="index">
      <form class="navbar-form navbar-right ff-search" id="ff-search" role="search" action="{$root}index.php?s=vod-search-name" method="post">
        <div class="form-group">
          <input type="text" class="form-control" id="ff-wd" name="wd" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default" data-module="vod" data-action="{:ff_url('vod/search',array('name'=>'FFWD'), true)}">搜索</button>
        <button type="submit" class="btn btn-default btn-success" data-module="news" data-action="{:ff_url('news/search',array('name'=>'FFWD'), true)}">资讯</button>
      </form>
      </neq>
  </div><!-- /.container -->
</nav><!-- /.navbar -->
<switch name="list_id" >
<case value="1"><script>feifei.nav.active('dianying');</script></case>
<case value="2"><script>feifei.nav.active('tv');</script></case>
<case value="3"><script>feifei.nav.active('dongman');</script></case>
<case value="4"><script>feifei.nav.active('zongyi');</script></case>
<case value="5"><script>feifei.nav.active('gaoxiao');</script></case>
<default /><script>feifei.nav.active('{$model}');</script>
</switch>