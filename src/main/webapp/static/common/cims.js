/*!
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */

(function($){
    $.isBlank = function(obj){
        return(!obj || $.trim(obj) === "");
    };
})(jQuery);
// 引入js和css文件
function include(id, path, file){
	if (document.getElementById(id)==null){
        var files = typeof file == "string" ? [file] : file;
        for (var i = 0; i < files.length; i++){
            var name = files[i].replace(/^\s|\s$/g, "");
            var att = name.split('.');
            var ext = att[att.length - 1].toLowerCase();
            var isCSS = ext == "css";
            var tag = isCSS ? "link" : "script";
            var attr = isCSS ? " type='text/css' rel='stylesheet' " : " type='text/javascript' ";
            var link = (isCSS ? "href" : "src") + "='" + path + name + "'";
            document.write("<" + tag + (i==0?" id="+id:"") + attr + link + "></" + tag + ">");
        }
	}
}

// 打开一个窗体
function windowOpen(url, name, width, height){
	var top=parseInt((window.screen.height-height)/2,10),left=parseInt((window.screen.width-width)/2,10),
		options="location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,"+
		"resizable=yes,scrollbars=yes,"+"width="+width+",height="+height+",top="+top+",left="+left;
	window.open(url ,name , options);
}

// 显示加载框
function loading(mess){
	top.$.jBox.tip.mess = null;
	top.$.jBox.tip(mess,'loading',{opacity:0});
}

// 确认对话框
function confirmx(mess, href){
	top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
		if(v=='ok'){
			loading('正在提交，请稍等...');
			location = href;
		}
	},{buttonsFocus:1});
	top.$('.jbox-body .jbox-icon').css('top','55px');
	return false;
}

function confirmxAlipay(mess, metho1d){

    top.$.jBox.confirm(mess,'系统提示',function(v,h,f){
        if(v=='ok'){
            loading('正在提交，请稍等...');
            metho1d();
        }
    },{buttonsFocus:1});
    top.$('.jbox-body .jbox-icon').css('top','55px');
    return false;
}

function alertObj(data) {
    $.each(data,function(key,val){
        if($.isPlainObject(val) || $.isArray(val)){
            alert(val);
            alertObj(val);
        }else{
            alert(key+'='+val);
        }
    });
}

$(document).ready(function() {
	//所有下拉框使用select2
	$("select").select2();
	$('.fancybox').fancybox();
});

Date.prototype.Format = function (fmt) {
    var o = {
        "M+":this.getMonth() + 1,  //月
        "d+":this.getDay(),        //日
        "h+":this.getHours(),      //小时
        "m+":this.getMinutes(),    //分钟
        "s+":this.getSeconds(),    //秒
        "q+":Math.floor((this.getMonth() +3)/3), //季度
        "S":this.getMilliseconds() //毫秒
    };

    if(/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1,(this.getFullYear() + "").substr(4-RegExp.$1.length));
    for (var k in o){
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]):(("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}

function print(soid,pageNum,w,h) {
    pageNum = pageNum || 1;
    if (LodopTool){
        var printer = new LodopTool("证书打印",'0');
        var param = {};
        printer.preview("/nmjzs/a/print/printHtml?soid=" + soid +"&pageNum=" + pageNum,param,w,h);
    }
}

function rePrintCert(certNo,appId,pageNum,w,h) {
    pageNum = pageNum || 1;
    if (LodopTool){
        var printer = new LodopTool("证书打印",'0');
        var param = {};
        printer.preview("/nmjzs/a/print/rePrintCert?certNo=" + certNo + "&appId=" + appId + "&pageNum=" + pageNum,param,w,h);
    }
}

function printTable(title,htmlStr){
    var LODOP=getLodop();
    var strStyleCSS="<link href='/nmjzs/static/print/print.css' type='text/css' rel='stylesheet'>";
    var strFormHtml=strStyleCSS+"<body>"+htmlStr+"</body>";
    var pTitle = "表样打印-" + title;
    LODOP.PRINT_INIT(pTitle);
    LODOP.SET_PRINT_PAGESIZE(0,0,0,"A4");
    LODOP.ADD_PRINT_TABLE("0cm","1.5cm","RightMargin:1.5cm","BottomMargin:0cm",strFormHtml);
    LODOP.NewPage();
    LODOP.ADD_PRINT_TABLE("0cm","1.5cm","RightMargin:1.5cm","BottomMargin:0cm",strFormHtml);
    //LODOP.SET_PREVIEW_WINDOW(0,0,0,800,1000,"");
    LODOP.PREVIEW();
};

function printByClass(title,obj){
    var LODOP=getLodop();
    var pTitle = "表样打印-" + title;
    LODOP.PRINT_INIT(pTitle);
    LODOP.SET_PRINT_PAGESIZE(0,0,0,"A4");
    obj.each(function(){
        var strStyleCSS="<link href='/nmjzs/static/print/print.css' type='text/css' rel='stylesheet'>";
        var strFormHtml=strStyleCSS+"<body>"+$(this).html()+"</body>";
        LODOP.ADD_PRINT_HTM("2cm","1.5cm","RightMargin:1.5cm","BottomMargin:0cm",strFormHtml);
        LODOP.NewPage();
    });
    /*    var strHtml = "";
     var strStyleCSS="<link href='/cims/static/print/print.css' type='text/css' rel='stylesheet'>";
     obj.each(function(){
     strHtml = strHtml + $(this).html();
     });
     var strFormHtml=strStyleCSS+"<body>"+strHtml+"</body>";
     LODOP.ADD_PRINT_HTM("2cm","1.5cm","RightMargin:1.5cm","BottomMargin:0cm",strFormHtml);*/
    LODOP.PREVIEW();
}

String.prototype.stripHTML = function() {
    var reTag = /<(?:.|\s)*?>/g;
    return this.replace(reTag,"");
}