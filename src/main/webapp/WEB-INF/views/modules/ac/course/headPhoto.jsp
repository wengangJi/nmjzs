<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>上传图片</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <link rel="stylesheet" href="${ctxStatic}/imageupload/imageupload.css" type="text/css" />
    <link rel="stylesheet" href="${ctxStatic}/jquery-jcrop/css/jquery.Jcrop.min.css"/>
</head>
<body>
<div style="margin-left: 30px;">
    <fieldset>
        <!-- 显示图片的img -->
<%--        <img src="" id="realPic" width="400px" height="400px"/>--%>
        <img src="" id="realPic" style="width:${width}px;height: ${height}px" />
        <input type="hidden" id="filename" value="${filename}" />
        <input type="hidden" id="width" value="${width}" />
        <input type="hidden" id="height" value="${height}" />
        <input type="hidden" id="resizeWidth" value="${resizeWidth}" />
        <!-- 缩略图预览 -->
        <div id="preview-pane">
            <div class="preview-container">
                <img src="" width="${width/2}px" height="${height/2}px"/>
            </div>
        </div>
        <div class="container">
            <!-- 打开图片控制 -->
				<span class="btn btn-success fileinput-button">
                    <i class="icon-plus icon-white"></i>
                    <span>选择图片</span>
                    <input type="file" onchange="ajaxFileUpload()" name="realPicFile" id="realPicFile" multiple/>
				</span>
            <!-- 上传并裁剪图片 -->
            <img src="${ctxStatic}/SuperSlide/images/loading.gif" id="loading" style="display: none;">
            <a class="btn btn-success" href="javascript:cutPic();" id="savePhoto"><i class="icon-picture icon-white"></i>保存图片</a>
            <!-- 获取裁剪的起始坐标和宽度、高度给后台 -->
            <form id="coords" class="coords">
                <div class="inline-labels">
                    <input type="hidden" size="4" id="x1" name="x1"/>
                    <input type="hidden" size="4" id="y1" name="y1"/>
                    <input type="hidden" size="4" id="x2" name="x2"/>
                    <input type="hidden" size="4" id="y2" name="y2"/>
                    <input type="hidden" size="4" id="w" name="w"/>
                    <input type="hidden" size="4" id="h" name="h"/>
                </div>
            </form>
        </div>
    </fieldset>
</div>
<script type="text/javascript" src="${ctxStatic}/jquery-jcrop/js/jquery.Jcrop.js"></script>
<script type="text/javascript" src="${ctxStatic}/imageupload/imageupload.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#preview-pane").css("width",$("#width").val()/2);
        $("#preview-pane").css("height",$("#height").val()/2);
        $("#preview-pane").css("right",-200 - ($("#width").val()/2 - 156));

        $(".preview-container").css("width",$("#width").val()/2);
        $(".preview-container").css("height",$("#height").val()/2);
    });
</script>
</body>
</html>
