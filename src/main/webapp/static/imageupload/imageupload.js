//Create variables (in this scope) to hold the API and image size
var jcrop_api, boundx, boundy, path;  
/** 
 * 更新缩略图，实现原理：根据原图框选的内容，显示到缩略图上，而缩略图也是原图是进行了放大，只是超过img范围的部分被隐藏 
 */  
function updatePreview(c) {  
	if (parseInt(c.w) > 0) {  
		$('#x1').val(c.x);  
		$('#y1').val(c.y);  
		$('#x2').val(c.x2);  
		$('#y2').val(c.y2);  
		$('#w').val(c.w);  
		$('#h').val(c.h);  

		var rx = xsize / c.w;  
		var ry = ysize / c.h;  

		// 精确计算图片的位置  
		$pimg.css({  
			width : Math.round(rx * boundx) + 'px',  
			height : Math.round(ry * boundy) + 'px',  
			marginLeft : '-' + Math.round(rx * c.x) + 'px',  
			marginTop : '-' + Math.round(ry * c.y) + 'px'  
		});  
	}  
}  

/** 
 * 异步上传图片 
 * @returns {Boolean} 
 */  
function ajaxFileUpload() {  
	$("#loading").ajaxStart(function() {  
		$(this).show();  
	})//开始上传文件时显示一个图片    
	.ajaxComplete(function() {
		$(this).hide();
	});//文件上传完成将图片隐藏起来    

	var file = $("#realPicFile").val();  
	if(!/\.(gif|jpg|jpeg|png|JPG|PNG)$/.test(file))  
	{
        $.jBox.error("不支持的图片格式.图片类型必须是.jpeg,jpg,png,gif格式.");
		return false;  
	}  

	$.ajaxFileUpload({  
		url : '/nmjzs/a/file/uploadHeaderPicTmp?inputId=realPicFile&width='+$("#width").val() + "&height=" + $("#height").val(),//用于文件上传的服务器端请求地址
		secureuri : false,//一般设置为false    
		type: 'POST',
		fileElementId : 'realPicFile',//文件上传空间的id属性  <input type="file" id="file" name="file" />    
		dataType : 'json',//返回值类型 一般设置为json    
		success : function(data, status) //服务器成功响应处理函数    
		{
            data = eval('(' + data + ')');
            if (data.error) {
                $.jBox.error(data.error);
                return false;
            }
			// 图片在服务器上的相对地址，加随机数防止不刷新  
			path = data.path + "?" + Math.random();
			$("#realPic").attr("src", path);
			$("#realPic").attr("style", "width:"+data.width+"px;height:" + data.height + "px");

			var imgs = $(".jcrop-holder").find("img");  
			// 原本有图片，重新上传后，所有的img都需要刷新
			imgs.each(function (i, v) {  
				$(this).attr("src", path);
			});  
			$('#preview-pane .preview-container img').attr("src", path);

			// 切图样式  
			// Grab some information about the preview pane  
			$preview = $('#preview-pane'), $pcnt = $('#preview-pane .preview-container'), $pimg = $('#preview-pane .preview-container img'),  
			xsize = $pcnt.width(), ysize = $pcnt.height();
			//console.log('init', [ xsize, ysize ]);  

			$('#realPic').Jcrop({  
				onChange : updatePreview, //切图框改变事件  
				onSelect : updatePreview, // 切图框选择事件  
				onRelease: clearCoords, // 切图框释放的事件  
				keySupport:true,//支持键盘控制。
//				bgFade   : true,  
				bgOpacity: 0.8, // 截图框以外部分的透明度  
				setSelect: [0, 0, $("#width").val(), $("#height").val()], // 默认选择的区域
				aspectRatio : $("#width").val()/$("#height").val() //xsize / ysize 截图比例，这里我采用1 : 1 的比例，即切出来的为正方形
			}, function() {  
				// Use the API to get the real image size  
				var bounds = this.getBounds();  
				boundx = bounds[0];
				boundy = bounds[1];
				// Store the API in the jcrop_api variable  
				jcrop_api = this;  
				// Move the preview into the jcrop container for css positioning  
				$preview.appendTo(jcrop_api.ui.holder);  
			});  
		},  
		error : function(data, status, e)//服务器响应失败处理函数    
		{
            $.jBox.error("上传照片异常：" + e);
		}  
	});  
	return false;  
}  

function _getShowWidth(str) {  
	return _getValue(str, "width");  
}  

function _getShowHeight(str) {  
	return _getValue(str, "height");  
}  

function _getValue (st, key) {  
	var str = st.replace(/\:|\;|\s/g, '').toLowerCase();  
	var pos = str.indexOf(key);  
	if (pos >= 0) {  
		// 截取
		var tmp = str.substring(pos, str.length);  
		var px = tmp.indexOf("px");  
		if (px > 0){  
			var width = tmp.substring(key.length, px);  
			return width;  
		}  
		return 0;  
	}  
	return 0;  
}  

/** 
 * 裁剪图片 
 */  
function cutPic() {
	// 初始化数据  
	var x1 = $('#x1').val() == "" ? 0 : parseInt($('#x1').val());
	var y1 = $('#y1').val() == "" ? 0 : parseInt($('#y1').val());
	var x2 = $('#x2').val();  
	var y2 = $('#y2').val();  
	var w = $('#w').val() == "" ? 150 : parseInt($('#w').val());
	var h= $('#h').val() == "" ? 150 : parseInt($('#h').val());
	var destWidth = $("#resizeWidth").val() == "" ? 0 : parseInt($("#resizeWidth").val());

	var srcFile = $("#realPic").attr("src");  
	if (srcFile == "" || !srcFile) {
        $.jBox.error("没有选择任何图片.");
		return;  
	}  

	var showDiv = $(".jcrop-holder > .jcrop-tracker");  
	// 从压缩存放图片的div中获取压缩后显示的宽度和高度，用来交给后台同比例进行裁剪  
	// width: 404px; height: 304px; position: absolute; top: -2px; left: -2px; z-index: 290; cursor: crosshair;  
	var style = showDiv.attr("style");  
	// 原图片页面显示的宽度  
	var showWidth = _getShowWidth(style);  
	// 原图片页面显示的高度  
	var showHeight = _getShowHeight(style);
	// console.log(showWidth + " " + showHeight);  
	// 原地图的src地址，去掉后边防止不刷新的随机数  
	srcFile = srcFile.substring(0, srcFile.indexOf("?"));  
	$.ajax({  
		type : "post",  
		dataType : "json",  
		url : "/nmjzs/a/file/uploadHeaderPic",
		data : {
			srcImageFile : srcFile,
			x : x1,
			y : y1,
			destWidth : w,
			destHeight : h,
			srcShowWidth : showWidth,
			srcShowHeight : showHeight,
			resizeWidth : destWidth
		},
		success : function(data) {
//			var okCallBack = function () {
//				this.top.window.location = Util.getContentPath() + "/user/pcModiInfoInit.do";
//			};
			if(data.code == "success"){
				$.jBox.success(data.msg);
                $("#filename").val(data.filename);
			}else{
				$.jBox.error("上传失败,请稍后重试.");
				return;
			}
		},
		error : function (data,e) {
			$.jBox.error ("上传失败,请稍后重试.");
			return;
		}
	});
}  

function clearCoords()  
{  
	$('#coords input').val('');  
};  