/*QQ:271513820 Up:2017.04.25*/
var feifei = {
//start
'browser':{//浏览器信息
	'url': document.URL,
	'domain': document.domain,
	'title': document.title,
	'language': (navigator.browserLanguage || navigator.language).toLowerCase(),//zh-tw|zh-hk|zh-cn
	'canvas' : function(){
		return !!document.createElement('canvas').getContext;
	}(),
	'useragent' : function(){
		var ua = navigator.userAgent;//navigator.appVersion
		return {
			'mobile': !!ua.match(/AppleWebKit.*Mobile.*/), //是否为移动终端 
			'ios': !!ua.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
			'android': ua.indexOf('Android') > -1 || ua.indexOf('Linux') > -1, //android终端或者uc浏览器 
			'iPhone': ua.indexOf('iPhone') > -1 || ua.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器 
			'iPad': ua.indexOf('iPad') > -1, //是否iPad
			'trident': ua.indexOf('Trident') > -1, //IE内核
			'presto': ua.indexOf('Presto') > -1, //opera内核
			'webKit': ua.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
			'gecko': ua.indexOf('Gecko') > -1 && ua.indexOf('KHTML') == -1, //火狐内核 
			'weixin': ua.indexOf('MicroMessenger') > -1 //是否微信 ua.match(/MicroMessenger/i) == "micromessenger",			
		};
	}()
},
'mobile':{//移动端专用
	'jump': function(){
		if(cms.domain_m){
			self.location.href = feifei.browser.url.replace(feifei.browser.domain,cms.domain_m);
		}
	},
	'nav': function(){
		$("#ff-nav-btn").bind('click', function(){
			$('#ff-nav-btn-item').toggleClass("hidden");
		});
	},
	'goback': function(){
		if(history.length > 0 && document.referrer){
			$("#ff-goback").show();
			$('#ff-goback').attr('href','javascript:history.go(-1);');
		}else{
			$("#ff-goback").hide();
		}
	},
	'flickity':function(){//手机滑动
		if($(".ff-gallery").length){
			$.ajaxSetup({ 
				cache: true 
			});
			$("<link>").attr({ rel: "stylesheet",type: "text/css",href: "https://cdnjs.cloudflare.com/ajax/libs/flickity/1.1.1/flickity.min.css"}).appendTo("head");
			$.getScript("https://cdnjs.cloudflare.com/ajax/libs/flickity/1.1.1/flickity.pkgd.min.js", function(response, status) {
				$('.ff-gallery').flickity({
					cellAlign: 'left',
					freeScroll: true,
					contain: true,
					prevNextButtons: false,
					pageDots: false
				});
			});
		}
	}
},
'nav': {//导航
	'active': function($id){
		$('#nav-'+$id).addClass("active");
	}
},
'alert':{
	'success':function($id, $tips){
		$($id).html('<div class="alert alert-success fade in"><a href="#" class="close" data-dismiss="alert">&times;</a><strong>成功！</strong>'+$tips+'</label>');
	},
	'warning':function($id, $tips){
		$($id).html('<div class="alert alert-warning fade in"><a href="#" class="close" data-dismiss="alert">&times;</a><strong>警告！</strong>'+$tips+'</label>');
	}
},
'page': {//分页
	'more': function(){
		$('body').on('click', '.ff-page-more', function(){
			$this = $(this);
			$page = $(this).attr('data-page')*1+1;
			$id = $this.attr('data-id');
			$.get($(this).attr('data-url')+$page, function(data){
				if(data){
					$("#"+$id).append(data);
					$this.attr('data-page',$page);
				}else{
					$("#ff-page-more").hide();
					$(this).unbind("click");
				}
			},'html');
		});
	}
},
'search': {//搜索
	'submit': function(){
		$("#ff-search button").on("click", function(){
			$action = $(this).attr('data-action');
			if($action){
				$("#ff-search").attr('action', $action);
			}
		});
		$("#ff-search").on("submit", function(){
			$action = $(this).attr('action');
			if(!$action){
				$action = cms.root+'index.php?s=vod-search';
			}
			$wd = $('#ff-search #ff-wd').val();
			if($wd){
				location.href = $action.replace('FFWD',encodeURIComponent($wd));
			}else{
				$("#ff-wd").focus();
				$("#ff-wd").attr('data-toggle','tooltip').attr('data-placement','bottom').attr('title','请输入关键字').tooltip('show');
			}
			return false;
		});
	},
	'keydown': function(){//回车
		$("#ff-search input").keyup(function(event){
			if(event.keyCode == 13){
				location.href = cms.root+'index.php?s=vod-search-wd-'+encodeURIComponent($('#ff-search #ff-wd').val())+'-p-1.html';
			}
		});
	},
	'autocomplete': function(){
		$.ajaxSetup({ 
			cache: true 
		});
		$.getScript("http://cdn.bootcss.com/jquery.devbridge-autocomplete/1.2.26/jquery.autocomplete.min.js", function(response, status) {
			$('#ff-wd').autocomplete({
				serviceUrl : cms.root+'index.php?s=search-vod',
				params: {'limit': 10},
				paramName: 'wd',
				maxHeight: 400,
				transformResult: function(response) {
					var obj = $.parseJSON(response);
					return {
						suggestions: $.map(obj.data, function(dataItem) {
								return { value: dataItem.vod_name, data: dataItem.vod_link };
						})
					};
				},
				onSelect: function (suggestion) {
					location.href = suggestion.data;
					//alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
				}
			});
		});
	}
},
'image': {//图片
	'lazyload': function(){//延迟加载
		$.ajaxSetup({
			cache: true
		});
		$.getScript("http://cdn.bootcss.com/jquery_lazyload/1.9.7/jquery.lazyload.min.js", function(response, status) {
			$("img.ff-img").lazyload({
				placeholder : cms.root+"Public/images/no.jpg",
				effect : "fadeIn",
				failurelimit: 15
				//threshold : 400
				//skip_invisible : false
				//container: $(".carousel-inner"),
			}); 
		});
	},
	'qrcode': function(){//生成二维码
		$("[data-toggle='popover']").popover({
				html: true
		});
		$("[data-toggle='popover']").on('show.bs.popover', function () {
			$("[data-toggle='popover']").attr('data-content','<img src="http://cdn.feifeicms.com/qrcode/1.0/?w=150&h=150&url='+encodeURIComponent(feifei.browser.url)+'"/>');
		})
	},
	'vcode':function(){//安全码
		return '<label><img class="ff-vcode-img" src="'+cms.root+'index.php?s=Vcode-Index"></label>';
	}
},
'vcode': {//验证码
	'load': function(){
		feifei.vcode.focus();
		feifei.vcode.click();
	},
	'focus': function(){//验证码框焦点
		$('body').on("focus", ".ff-vcode", function(){
			$(this).removeClass('ff-vcode').parent().after(feifei.image.vcode());
			$(this).unbind();
		});
	},
	'click': function(){//点击刷新
		$('body').on('click', 'img.ff-vcode-img', function(){
			$(this).attr('src', cms.root+'index.php?s=Vcode-Index');
		});
	}
},
'updown': {//顶踩
	'click': function(){
		$('body').on('click', 'a.ff-updown', function(e){
			var $this = $(this);
			if($(this).attr("data-id")){
				$.ajax({
					url: cms.root+'index.php?s=updown-'+$(this).attr("data-module")+'-id-'+$(this).attr("data-id")+'-type-'+$(this).attr("data-type"),
					cache: false,
					dataType: 'json',
					success: function(json){
						$this.addClass('disabled');
						if(json.status == 1){
							if($this.attr("data-type")=='up'){
								$this.find('.ff-updown-tips').html(json.data.up);
							}else{
								$this.find('.ff-updown-tips').html(json.data.down);
							}
						}else{
							$this.attr('title', json.info);
							$this.tooltip('show');
						}
					}
				});
			}
		});
	}
},
'star': {//评分
	'raty': function(){
		$.ajaxSetup({ 
			cache: true 
		});
		if($("#ff-raty").length ){
			$("<link>").attr({ rel: "stylesheet",type: "text/css",href: "http://cdn.bootcss.com/raty/2.7.1/jquery.raty.min.css"}).appendTo("head");
			$.getScript("http://cdn.bootcss.com/raty/2.7.1/jquery.raty.min.js", function(response, status) {
				$('#ff-raty').raty({ 
					starType: 'i',
					number: 5,
					numberMax : 5,
					half: true,
					score : function(){
						return $(this).attr('data-score');
					},
					click: function(score, evt) {
						$.ajax({
							type: 'get',
							url: cms.root+'index.php?s=gold-'+$('#ff-raty').attr('data-module')+'-id-'+$('#ff-raty').attr('data-id')+'-score-'+(score*2),
							timeout: 5000,
							dataType:'json',
							error: function(){
								$('#ff-raty').attr('title', '网络异常！').tooltip('show');
							},
							success: function(json){
								if(json.status == 1){
									$('#ff-raty-tips').html(json.data.gold);
								}else{
									$('#ff-raty').attr('title', json.info).tooltip('show');
								}
							}
						});
					}
				});
			});
		}
	}
},
'scenario': {//分集剧情
	'load': function($max){
		$count = $("#vod_scenario>dd").length;
		if($count > 0 && $max>0){
			var $list = '<li class="col-md-2 col-xs-4"><a href="javascript:;" data-startid="1" data-endid="'+$max+'" class="ff-text">第1-'+$max+'集</a></li>';
			for($i=1; $i<$count; $i++){
				if(($i+$max) > $count){
					$max_ji = $count;
				}else{
					$max_ji = $i+$max;
				}
				if($i % $max == 0){
					$list+='<li class="col-md-2 col-xs-4"><a href="javascript:;" data-startid="'+($i+1)+'" data-endid="'+$max_ji+'">第'+($i+1)+'-'+$max_ji+'集</a></li>';
				}
			}
			$('#vod_scenario_item').html($list);
			feifei.scenario.tabs(1,$max);
			feifei.scenario.click();
		}
	},
	'tabs': function($startid, $endid){
		$(".vod_scenario_title").hide();
		$(".vod_scenario_info").hide();
		for($i=$startid; $i<=$endid; $i++){
			$("#vod_scenario_title_"+$i).show();
			$("#vod_scenario_info_"+$i).show();
		}
	},	
	click: function(){
		$('#vod_scenario_item').on('click', 'a', function(e){
			$startid = $(this).attr('data-startid')*1;
			$endid = $(this).attr('data-endid')*1;
			feifei.scenario.tabs($startid,$endid);
			$('#vod_scenario_item a').removeClass('ff-text');
			$(this).addClass('ff-text');
		});
	}
},
'share':{//分享
	'baidu': function(){
		if($("#ff-share").length ){
			$("#ff-share").html('<div class="bdsharebuttonbox"><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_bdysc" data-cmd="bdysc" title="分享到百度云收藏"></a><a href="#" class="bds_copy" data-cmd="copy" title="分享到复制网址"></a></div>');
			window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
		}
	}
},
'forum': {//讨论模块功能
	'load': function(){
		if($('.ff-forum-reload').html()){
			feifei.forum.reload();
		}else{
			feifei.forum.comment();
		}
	},
	'reload': function(){//发表后刷新网页 留言本特殊版块 sid=5
		feifei.forum.form();//回复表单框
		feifei.forum.report();//举报事件
		$("body").on("submit", '.form-forum', function(){ //表单提交
			feifei.forum.submit($(this), 'guestbook', false);
			return false;
		});
	},		
	'comment': function(){//评论发表后 容器AJAX功能
		$cid = $("#ff-forum").attr('data-id');
		$sid = $("#ff-forum").attr('data-sid');
		if($cid && $sid){
			$.ajax({
				type: 'get',
				url: cms.root+'index.php?s=forum-config-sid-'+$sid+'-cid-'+$cid,
				timeout: 3000,
				dataType:'json',
				error: function(){
					$("#ff-forum").html('评论加载失败');
				},
				success:function(json){
					if(json.data.forum_type == 'uyan'){
						feifei.forum.uyan(json.data.uyan_uid);
					}else if(json.data.forum_type == 'changyan'){
						feifei.forum.changyan($cid, json.data.changyan_appid, json.data.changyan_appconf);
					}else{
						feifei.forum.show($cid, $sid, json.data.forum_module+'_ajax', 1);//ajax加载
						feifei.forum.form();//回复表单框
						feifei.forum.report();//举报事件
						$("body").on("submit", '.form-forum', function(){
							feifei.forum.submit($(this), json.data.forum_module+'_ajax', 3000);
							return false;
						});
					}
				}
			});
		}
	},
	'show': function($cid, $sid, $module, $page){//AJAX加载系统评论
		$.ajax({
			type: 'get',
			url: cms.root+'index.php?s=forum-'+$module+'-sid-'+$sid+'-cid-'+$cid+'-p-'+$page,
			timeout: 3000,
			error: function(){
				$("#ff-forum").html('评论加载失败，请刷新...');
			},
			success:function($html){
				$("#ff-forum").html($html);
			}
		});
	},
	'report':function(){//举报
		$('body').on('mouseenter', '#ff-forum-item .forum-title', function(){
			$(this).find('.ff-report').fadeIn();
		});
		$('body').on('mouseleave', '#ff-forum-item .forum-title', function(){
			$(this).find('.ff-report').fadeOut();
		});
		$('body').on('click', 'a.ff-report', function(){
			var $id = $(this).attr("data-id");
			if($id){
				$.ajax({
					type: 'get',
					url: cms.root+'index.php?s=forum-report-id-'+$id,
					timeout: 3000,
					dataType:'json',
					success:function(json){
						feifei.alert.success($('.form-forum').eq(0).find('.ff-alert'), json.info);
					}
				});
			}
		});
	},
	'reply': function($id){//更新回复数及显示回复链接
		$.ajax({
			type: 'get',
			url: cms.root+'index.php?s=forum-reply-id-'+$id,
			timeout: 3000,
			dataType:'json',
			success:function(json){
				if(json.status==200){
					$('#ff-reply-'+$id).find('.ff-reply-tips').html(json.data);//更新回复数
					$('#ff-reply-'+$id).parent().find('.ff-reply-read').fadeIn();//显示查看回复链接
				}
			}
		});
	},
	'form' : function(){ //回复表单加载
		$('body').on('click', 'a.ff-reply', function(){
			var $id = $(this).attr("data-id");
			if($id){
				//$(this).removeClass('ff-vcode');
				var $form = $($(".form-forum").eq(0).parent().html());
				$form.find("input[name='forum_pid']").val($id);
				$('#forum-reply-'+$id).html($form);
			}
		});
	},
	'submit': function($this, $module, $timeout){//发布
		$.post($this.attr('action'), $this.serialize(), function(json){
			if(json.status >= 200){
				feifei.alert.success($this.find('.ff-alert'), json.info);//发布成功提示
				//$this.find("button[type='submit']").addClass('disabled');//禁止再次提交
				if(json.data.forum_pid){
					//该讨论为回复时不需要全局刷新或重加载
					feifei.forum.reply(json.data.forum_pid);//更新回复数及显示回复链接按钮
					setTimeout(function(){$('#forum-reply-'+json.data.forum_pid).fadeOut('slow')}, 2000);//移除回复表单容器
				}else{
					//不需要审核的情况才更新列表或刷新 201为需要审核
					if(json.status == 200){
						if($timeout){
							setTimeout(function(){feifei.forum.show(json.data.forum_cid, json.data.forum_sid, $module, 1)}, $timeout);
						}else{
							location.reload();//刷新网页
						}
					}
				}
			}else{
				feifei.alert.warning($this.find('.ff-alert'), json.info);
			}
		 },'json');
	},
	'uyan': function($uid){
		$("#ff-forum").html('<div id="uyan_frame"></div>');
		$.getScript("http://v2.uyan.cc/code/uyan.js?uid="+$uid);
	},
	'changyan': function($sourceid, $appid, $conf){
		$("#ff-forum").html('<div id="SOHUCS" sid="'+$sourceid+'"></div>');
		var appid = $appid; 
		var conf = $conf; 
		var width = window.innerWidth || document.documentElement.clientWidth; 
		if (width < 960) { 
			window.document.write('<script id="changyan_mobile_js" charset="utf-8" type="text/javascript" src="https://changyan.sohu.com/upload/mobile/wap-js/changyan_mobile.js?client_id=' + appid + '&conf=' + conf + '"><\/script>'); 
		} else { 
			var loadJs=function(d,a){var c=document.getElementsByTagName("head")[0]||document.head||document.documentElement;var b=document.createElement("script");b.setAttribute("type","text/javascript");b.setAttribute("charset","UTF-8");b.setAttribute("src",d);if(typeof a==="function"){if(window.attachEvent){b.onreadystatechange=function(){var e=b.readyState;if(e==="loaded"||e==="complete"){b.onreadystatechange=null;a()}}}else{b.onload=a}}c.appendChild(b)};loadJs("https://changyan.sohu.com/upload/changyan.js",function(){window.changyan.api.config({appid:appid,conf:conf})}); 
		}
	}
},
'playurl': {//播放地址
	'download': function(){
		if($(".ff-down-list").length ){
			$.getScript("http://cdn.feifeicms.com/download/xunlei.js");
		}
	},
	'tongji': function(){
		if($("#cms_player").length ){
			$.getScript("http://cdn.feifeicms.com/tongji/3.3/");
		}
	}
},
'scroll':{//滚动条
	'fixed' : function($id, $top, $width){// 悬浮区域
		var offset = $('#'+$id).offset();
		if(offset){
			if(!$top){
				$top = 5;
			}
			if(!$width){
				$width = $('#'+$id).width();
			}			
			$(window).bind('scroll', function(){
				if($(this).scrollTop() > offset.top){
					$('#'+$id).css({"position":"fixed","top":$top+"px","width":$width+"px"});
				}else{
					$(('#'+$id)).css({"position":"relative"});
				}
			});		
		}
	},
	'totop':function($id, $top){ //返回顶部
		// $id:dc-totop $top:偏移值
		$('body').append('<a href="#" class="'+$id+'" id="'+$id+'"><i class="glyphicon glyphicon-chevron-up"></i></a>');
		$(window).bind('scroll', function(){
			if($(this).scrollTop() > $top){
				$('#'+$id).fadeIn("slow");
			}else{
				$('#'+$id).fadeOut("slow");
			}
		});	
	}
}
//end
};
/*#ff-search #wd #ff-goback .ff-gallery .ff-raty .ff-img .ff-share .ff-safecode .ff-reply*/
$(document).ready(function(){
	feifei.mobile.nav();
	feifei.mobile.goback();
	feifei.mobile.flickity();
	feifei.search.submit();
	feifei.search.keydown();
	feifei.search.autocomplete();
	feifei.image.lazyload();
	feifei.image.qrcode();
	feifei.page.more();
	feifei.vcode.load();
	feifei.updown.click();
	feifei.star.raty();
	feifei.scenario.load(5);
	feifei.share.baidu();
	feifei.forum.load();
	feifei.playurl.download();
	feifei.playurl.tongji();
	feifei.scroll.totop('ff-totop',5);
});