<?php
//超时时间
@set_time_limit(120);
//内存限制 取消内存限制
@ini_set("memory_limit",'-1');
//ThinkPHP路径
define('THINK_PATH','./framework');
//缓存路径
define('RUNTIME_PATH','./runtime/');
//项目名称
define('APP_NAME','phpvod');
//项目路径
define('APP_PATH','./protected/');
//加载入口文件
require(THINK_PATH.'/ThinkPHP.php');
//实例化项目
$App = new App();
//初始化
$App->run();
