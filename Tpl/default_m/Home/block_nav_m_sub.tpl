<div class="clearfix"></div> 
<div class="container ff-bg">
  <ul class="row list-unstyled text-center ff-nav-mobile">
    <volist name=":ff_mysql_nav('field:*;limit:120;cache_name:default;cache_time:default;order:nav_pid asc,nav_oid;sort:asc')" id="feifei">
    <li class="col-xs-3">
      <a href="{$feifei.nav_link}" class="btn btn-success btn-block">{$feifei.nav_title}</a>
    </li>
    </volist>
  </ul>
</div>
<div class="clearfix ff-clearfix"></div>