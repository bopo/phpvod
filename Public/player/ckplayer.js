//需要使用jquery库 配置为普通地址调用 帮助：http://www.ckplayer.com/tool/flashvars.htm
var flashvars = {
	f:cms_player.url,
	c:0,
	p:1
};
var params = {
	bgcolor:'#FFF',allowFullScreen:true,allowScriptAccess:'always',wmode:'transparent'
};
var video = [
	cms_player.url+'->video/mp4',
	cms_player.url+'->video/webm',
	cms_player.url+'->video/ogg'
];
$.getScript("http://www.ckplayer.com/ckplayer/6.8/ckplayer.js", function(response, status) {
	$("#cms_player").append('<div id="a1"></div>');
	CKobject.embed('http://www.ckplayer.com/ckplayer/6.8/ckplayer.swf','a1','ckplayer_a1','100%','100%',false,flashvars,video,params);
});