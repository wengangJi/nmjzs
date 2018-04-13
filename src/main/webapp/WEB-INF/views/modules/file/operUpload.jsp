<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<meta name="decorator" content="default"/>
<%@include file="/WEB-INF/views/include/dialog.jsp" %>

<html>
<head>
    <!-- Force latest IE rendering engine or ChromeFrame if installed -->
    <!--[if IE]>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <![endif]-->
    <meta charset="utf-8">
    <meta name="decorator" content="default"/>
    <title>文件上传</title>
    <!-- blueimp Gallery styles -->
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/blueimp-gallery.min.css">
    <!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload.css">
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-ui.css">
    <!-- CSS adjustments for browsers with JavaScript disabled -->
    <noscript><link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-noscript.css"></noscript>
    <noscript><link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-ui-noscript.css"></noscript>
</head>
<body>


<div class="container">
    <!-- The file upload form used as target for the file upload widget -->

    <form id="fileupload" action="${ctx}/file/upload" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="soid" value="${soAttachment.soid}"/>
        <input type="hidden" name="appId" value="${soAttachment.appId}"/>
        <input type="hidden" name="soType" value="${soAttachment.soType}"/>
        <input type="hidden" name="pageModule" value="${soAttachment.pageModule}"/>
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="row fileupload-buttonbar">
            <div class="span7">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <i class="icon-plus icon-white"></i>
                    <span>添加文件...</span>
                    <input type="file" name="files[]" multiple>
                </span>
                <button type="submit" class="btn btn-primary start">
                    <i class="icon-white icon-upload"></i>
                    <span>开始上传</span>
                </button>
                <button type="reset" class="btn btn-warning cancel">
                    <i class="icon-ban-circle icon-white"></i>
                    <span>取消上传</span>
                </button>
                <button type="button" class="btn btn-danger delete">
                    <i class="icon-trash icon-white"></i>
                    <span>删除</span>
                </button>
                <!--写死标记，后续更改-->
               <%-- <c:if test="${soAttachment.soType eq '01'}" >
                  <a href="${ctx}/cp/soCp/cpSaveForm?soid=${soAttachment.soid}&appId=CP&soType=01&pageModule=cpSaveForm&repage"  type="button" class="btn btn-primary">保存</a>
                 </c:if>--%>
                <input type="checkbox" class="toggle">
                <!-- The global file processing state -->
                <span class="fileupload-process"></span>
            </div>
            <!-- The global progress state -->
            <div class="span5 fileupload-progress fade">
                <!-- The global progress bar -->
                <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                    <div class="bar progress-success" style="width:0%;"></div>
                </div>
                <!-- The extended global progress state -->
                <div class="progress-extended">&nbsp;</div>
            </div>
        </div>
        <!-- The table listing the files available for upload/download -->
        <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
    </form>
</div>
<!-- The blueimp Gallery widget -->
<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>

<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td>
            <span class="preview"></span>
        </td>
        <td>
            <p class="name">{%=file.name%}</p>
            <strong class="error text-danger"></strong>
        </td>
        <td>
            <p class="size">处理中...</p>
            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar progress-success" style="width:0%;"></div></div>
        </td>
        <td>
            {% if (!i && !o.options.autoUpload) { %}
                <button class="btn btn-primary start">
                    <i class="icon-upload icon-white"></i>
                    <span>开始</span>
                </button>
            {% } %}
            {% if (!i) { %}
                <button class="btn btn-warning cancel">
                    <i class="icon-ban-circle icon-white"></i>
                    <span>取消</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                {% } %}
            </span>
        </td>
        <td>
            <p class="name">
                {% if (file.url) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                {% } else { %}
                    <span>{%=file.name%}</span>
                {% } %}
            </p>
            {% if (file.error) { %}
                <div><span class="label label-danger">错误</span> {%=file.error%}</div>
            {% } %}
        </td>
        <td>
            <span class="size">{%=o.formatFileSize(file.size)%}</span>
        </td>
        <td>
            {% if (file.deleteUrl) { %}
                <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                    <i class="icon-trash"></i>
                    <span>删除</span>
                </button>
                <input type="checkbox" name="delete" value="1" class="toggle">
            {% } else { %}
                <button class="btn btn-warning cancel">
                    <i class="icon-ban-circle"></i>
                    <span>取消</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="${ctxStatic}/jquery-upload/js/vendor/jquery.ui.widget.js"></script>
<!-- The Templates plugin is included to render the upload/download listings -->
<script src="${ctxStatic}/jquery-upload/js/tmpl.min.js"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/load-image.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/canvas-to-blob.min.js"></script>
<!-- blueimp Gallery script -->
<script src="${ctxStatic}/jquery-upload/js/jquery.blueimp-gallery.min.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="${ctxStatic}/jquery-upload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="${ctxStatic}/jquery-upload/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script src="${ctxStatic}/jquery-upload/js/jquery.fileupload-process.js"></script>
<!-- The File Upload image preview & resize plugin -->
<script src="${ctxStatic}/jquery-upload/js/jquery.fileupload-image.js"></script>
<!-- The File Upload audio preview plugin -->
<script src="${ctxStatic}/jquery-upload/js/jquery.fileupload-audio.js"></script>
<!-- The File Upload video preview plugin -->
<script src="${ctxStatic}/jquery-upload/js/jquery.fileupload-video.js"></script>
<!-- The File Upload validation plugin -->
<script src="${ctxStatic}/jquery-upload/js/jquery.fileupload-validate.js"></script>
<!-- The File Upload user interface plugin -->
<script src="${ctxStatic}/jquery-upload/js/jquery.fileupload-ui.js"></script>
<!-- The main application script -->
<%--<script src="${ctxStatic}/jquery-upload/js/main.js"></script>--%>
<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE 8 and IE 9 -->
<!--[if (gte IE 8)&(lt IE 10)]>
<script src="${ctxStatic}/jquery-upload/js/cors/jquery.xdr-transport.js"></script>
<![endif]-->
<script type="text/javascript">
    $(document).ready(function() {
        // Initialize the jQuery File Upload widget:
        $('#fileupload').fileupload({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: "${ctx}/file/operUpload"
        });

        // Load existing files:
        $('#fileupload').addClass('fileupload-processing');
        $.ajax({
            // Uncomment the following to send cross-domain cookies:
            //xhrFields: {withCredentials: true},
            url: $('#fileupload').fileupload('option', 'url'),
            dataType: 'json',
            context: $('#fileupload')[0]
        }).always(function () {
            $(this).removeClass('fileupload-processing');
        }).done(function (result) {
            $(this).fileupload('option', 'done')
                    .call(this, $.Event('done'), {result: result});
        });
    });

    $("#hideme").click(function(){
        $("#fileArea").toggle(500);
    });
    $("#hideme").tooltip();

    function deleteByPk(obj){

        $.ajax({
            type:"post",
            url:"${ctx}/file/deleteByPk",
            data:{"id":obj},
            dataType:"json",
            success:function (flag) {
                window.location.reload();
            }
        });
    }
</script>

<c:if test="${files ne null}">
  <%--  <table class="table">
        <tr>
            <th>附件名</th>
            <th>文件大小</th>
&lt;%&ndash;            <th>操作</th>&ndash;%&gt;
        </tr>
        <c:forEach items="${files}" var="file">
            <tr>
                <td><a href="${file.url}" title="${file.name}"
                       download="${file.name}">${file.name}</a></td>
                <td>${fns:formatFileSize(file.size)}</td>
&lt;%&ndash;                <td>
                    <a class="btn btn-danger delete" data-type="${file.deleteType}" href="${file.deleteUrl}">
                    <i class="icon-trash"></i>
                    <span>删除</span>
                    </a>
                </td>&ndash;%&gt;
            </tr>
        </c:forEach>
    </table>--%>

    <legend id="hideme" data-toggle="tooltip" data-placement="top" title="" data-original-title="点击隐藏/显示附件信息">附件信息</legend>
    <div id="fileArea">
        <c:forEach items="${files}" var="file">
            <span class="preview">
                <div style="float: left;margin-left: 10px;">
                    <a href="${file.url}" title="${file.thumbnailSize}(秒)" download="${file.name}" data-gallery>
                        <img style="height: 80px;width: 120px;" src="${file.thumbnailUrl}">
                        <p align="center">${file.thumbnailSize}(秒)</p>
                    </a>
                </div>

                <div style="float: left;margin-left: 10px;">
                    <a href="javascript:void(0)" onclick="deleteByPk('${file.id}')">删除</a>
                </div>
            </span>
        </c:forEach>
    </div>
</c:if>

<legend id="hideme" data-toggle="tooltip" data-placement="top" title="" data-original-title="点击隐藏/显示附件信息"></legend>
<div id="return"  style="text-align: center;">

    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>

</div>


</body>

</html>


