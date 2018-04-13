<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
    <title>企业资质</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/blueimp-gallery.min.css">


    <script type="text/javascript">

        $(document).ready(function() {

           $("#inputForm").validate({
                submithandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorcontainer: "#messagebox",
                errorplacement: function(error, element) {
                    $("#messagebox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")){
                        error.appendto(element.parent().parent());
                    } else {
                        error.insertafter(element);
                    }
                }
            });
            $("#hideme").click(function(){
                $("#fileArea").toggle(500);
            });
            $("#hideme").tooltip();

            $("input[name=imgpass]").click(function(){
                $.post("${ctx}/file/auditImg",{id:$("#currImgId").val(),imgpass:$("input[name=imgpass]:checked").val()},function(data){
                    $("input[name=imgpass][value=data]").attr("checked",true);
                })
            })
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#eqForm").submit();
            return false;
        }
    </script>
    <link href="${ctxStatic}/print/print.css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jqprint/jquery.jqprint-0.3.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            $("input#biuuu_button").click(function(){

                //$("div#myPrintArea").printArea();
                //$("div#myPrintArea").printPage();
                $("div#myPrintArea").jqprint();

            });
        });

    </script>


    <style type="text/css">
        #myPrintArea table td {
        .mine
        font-size: 12px;
            font-family: '仿宋';

            font-size: 13px;
            font-family: '宋体';
            padding: 4px; margin-top: 4px;;
        .r20
        }
    </style>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">已确认学时</a></li>
</ul>


<div id="myPrintArea">
    <div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
        <div class="slides"></div>
        <h3 class="title"></h3>
        <a class="prev">‹</a>
        <a class="next">›</a>
        <a class="close">×</a>
        <a class="play-pause"></a>
        <ol class="indicator"></ol>
    </div>

    <div>
        系统提示：</br>
        <p style="color: red">
            </br>学习信息，申报单号：<u>${soHours.soid}</u>&nbsp;课程：<u>${fns:getCourseName(soHours.courseId)}</u>&nbsp;课件：<u>${fns:getLessonName(soHours.lessonId)}</u>。
            </br><strong>本次学时确认完成。已成功提交审核。请到学时查看菜单查看学习及审核进度。</strong>
        </p>
    </div>

    <fieldset>
        <legend id="hideme" data-toggle="tooltip" data-placement="top" title="" data-original-title="点击隐藏/显示附件信息">点击隐藏/显示附件</legend>
        <div id="fileArea">
            <c:forEach items="${files}" var="file">
            <span class="preview">
                <div style="float: left;margin-left: 10px;">
                    <a href="${file.url}" title="${file.thumbnailSize}(秒)" download="${file.name}" data-gallery>
                        <img style="height: 80px;width: 120px;" src="${file.thumbnailUrl}">
                        <p align="center">${file.thumbnailSize}(秒)</p>
                    </a>
                </div>
            </span>
            </c:forEach>
        </div>
    </fieldset>

</div>

<div style="text-align: center;">
    <a href="${ctx}/course/detailBySoid?courseId=${soHours.courseId}&soid=${soHours.soid}" class="btn">返 回</a>
</div>


<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/load-image.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/canvas-to-blob.min.js"></script>
<!-- blueimp Gallery script -->
<script src="${ctxStatic}/jquery-upload/js/jquery.blueimp-gallery.min.js"></script>
</body>
</html>
