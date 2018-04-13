<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>企业资质</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/blueimp-gallery.min.css">

    <script type="text/javascript">

        $(document).ready(function() {

            $("#name").focus();
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
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
    <fieldset>
        <legend id="hideme" data-toggle="tooltip" data-placement="top" title="" data-original-title="点击隐藏/显示附件信息">点击隐藏/显示附件</legend>
        <div id="fileArea">
            <form id="fileForm">
                <input type="hidden" id="currImgId">
                <table class="table">
                    <tr>
                        <th>缩略图</th>
                        <th>附件名</th>
                        <th>文件大小</th>
                        <th>审核人</th>
                        <th>审核时间</th>
                        <th>是否合格</th>
                    </tr>
                    <c:forEach items="${files}" var="file">
                        <tr>
                            <td><span class="preview"><a href="${file.url}" title="${file.name}" download="${file.name}" data-gallery><img
                                    src="${file.thumbnailUrl}"></a></span></td>
                            <td><a href="${file.url}" title="${file.name}"
                                   download="${file.name}" ${empty file.thumbnailUrl?'data-gallery':''}>${file.name}</a></td>
                            <td>${fns:formatFileSize(file.size)}</td>
                            <td>${fns:getUserById(file.passUserId).name}</td>
                            <td><fmt:formatDate value="${file.passDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>

                                        <c:choose>
                                            <c:when test="${file.sts eq '0'}">
                                                未审核
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${file.pass eq '0'}">
                                                        <strong style="color:red ">不合格</strong>
                                                    </c:when>
                                                    <c:otherwise>
                                                        合格
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </form>
        </div>
    </fieldset>

</div>
</tbody>
<div style="text-align: center;">
    <input id="biuuu_button" type="button" value="打 印" class="btn"/>
    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>

<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/load-image.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/canvas-to-blob.min.js"></script>
<!-- blueimp Gallery script -->
<script src="${ctxStatic}/jquery-upload/js/jquery.blueimp-gallery.min.js"></script>
</body>
</html>
