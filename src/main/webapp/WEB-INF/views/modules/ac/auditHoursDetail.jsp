<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>学时审核</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <!-- blueimp Gallery styles -->
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/blueimp-gallery.min.css">
    <script type="text/javascript">
        $(document).ready(function() {
            $("#auditRemarks").val("");
            showBackAct();
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

            $("#listBtn").click(function(){
                $("#thHead").hide();
                $("td[id^=thContent]").hide();
            });
            $("#largeBtn").click(function(){
                $("#thHead").show();
                $("td[id^=thContent]").show();
            });
        });
        function auditPass() {
            /*			top.$.jBox.confirm("确认提交数据？","系统提示",function(v,h,f){
             if (v == 'ok') {
             $("#inputForm").submit();
             }
             });*/
            $("#inputForm").submit();
        }
        function showBackAct(para){
            if(para != null){
                switch (para.value){
                    case "0":
                        $("#backBlock").show();
                        $("#auditRemarks").val("不通过原因：");
                        break;
                    case "1":
                        $("#backBlock").hide();
                        $("#auditRemarks").val("审核通过。");
                        break;
                    default :
                        $("#backBlock").hide();
                        break;
                }
            } else {
                $("#backBlock").hide();
            }
        }
        function setImpId(obj){
            $("#currImgId").val(obj);
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">审核查看</a></li>
</ul>
<tags:message content="${message}"/>
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
<fieldset>

    <legend>建造师信息</legend>
    <table id="servAcInfo" class="table table-bordered table-condensed  table-hover">
        <tbody>
        <tr>
            <td><label class="control-label">姓名</label></td>
            <td>${servAcInfo.name} </td>
            <td><label class="control-label">性别</label></td>
            <td>${fns:getDictLabel(servAcInfo.sex, 'SEX', '')}</td>
            <td><label class="control-label">出生日期</label> </td>
            <td><fmt:formatDate value="${servAcInfo.birthDate}" type="date"/> </td>
            <td rowspan="5"width="120px;"><img src="${servAcInfo.patchId}"/></td>
        </tr>

       <%-- <tr>
            <td><label class="control-label">证件号</label></td>
            <td colspan="3"> ${servAcInfo.idNo}
            <td><label class="control-label">证件类别</label></td>
            <td>${fns:getDictLabel(servAcInfo.idType, 'ID_TYPE', '')} </td>
        </tr>--%>

        <tr>

            <td><label class="control-label">证件类别</label></td>
            <td>${fns:getDictLabel(servAcInfo.idType, 'ID_TYPE', '')} </td>
            <td><label class="control-label">证件号</label></td>
            <td colspan="1"> ${servAcInfo.idNo}</td>
            <td><label class="control-label">联系电话</label></td>
            <td colspan="1"> ${servAcInfo.contactPhone}</td>
        </tr>

        <tr>
            <td ><label class="control-label">所属企业</label></td>
            <td colspan="3">${fns:getCompanyById(servAcInfo.companyId).companyName}</td>
            <td ><label class="control-label">所属地市</label></td>
            <td>${fns:getDictLabel(servAcInfo.localId, 'LOCAL_ID', '')} </td>
        </tr>

        <tr>
            <td><label class="control-label">第一专业</label></td>
            <td> ${fns:getDictLabel(servAcInfo.majorFirst, 'MAJOR', '')} </td>
            <td><label class="control-label">第二专业</label></td>
            <td> ${fns:getDictLabel(servAcInfo.majorSecond, 'MAJOR', '')}  </td>
            <td><label class="control-label">第三专业</label></td>
            <td colspan="1"> ${fns:getDictLabel(servAcInfo.majorThird, 'MAJOR', '')} </td>

        </tr>


        </tbody>
    </table>
    <legend>培训信息</legend>
    <table id="basicInfo" class="table table-bordered table-condensed  table-hover">
        <tbody>
        <tr>
            <td><label class="control-label">申报单号</label></td>
            <td>${soHours.soid}</td>
            <td><label class="control-label">培训项目</label></td>
            <td>${fns:getPlanById(soHours.planId).planName}</td>
        </tr>
        <tr>
            <td><label class="control-label">申报人姓名</label></td>
            <td>${fns:getUserById(soHours.userId).name}</td>
            <td><label class="control-label">课程名称</label></td>
            <td>${fns:getCourseName(soHours.courseId)}</td>
        </tr>
        <tr>
            <td><label class="control-label">课件名称</label></td>
            <td>${fns:getLessonName(soHours.lessonId)}</td>
            <td><label class="control-label">学时数</label></td>
            <td>${soHours.hours}(学时)</td>
        </tr>
         <tr>
            <td><label class="control-label">课件时长</label></td>
            <td colspan="1">${soHours.videoTime}(秒)</td>
             <td><label class="control-label">播放时长</label></td>
             <td colspan="1">${soHours.playedTime}(秒)</td>
        </tr>
        <tr>
            <td><label class="control-label">学习时间</label></td>
            <td colspan="3"><fmt:formatDate value="${soHours.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>

        </tr>
        </tbody>
    </table>
    <legend id="hideme" data-toggle="tooltip" data-placement="top" title="" data-original-title="点击隐藏/显示附件信息">附件信息</legend>
    <div id="fileArea">
<%--                <div class="btn-group" style="float: right">
                    <button class="btn btn-primary" id="listBtn"><i class="icon-th-list icon-white"></i>&nbsp;列表展示</button>
                    <button class="btn btn-primary" id="largeBtn"><i class="icon-th-large icon-white"></i>&nbsp;缩略图展示</button>
                </div>--%>
<%--        <table class="table">
            <tr>
                <th>视频图片</th>
                <th>图片名称</th>
                <th>视频总时长</th>
                <th>图片抓取时点</th>
                <th>当前状态</th>
            </tr>
            <c:forEach items="${files}" var="file">
                <tr>
                    <td><span class="preview"><a href="${file.url}" title="${file.name}" download="${file.name}" data-gallery><img style="height: 80px;width: 120px;"
                                                                                                                                   src="${file.thumbnailUrl}"></a></span></td>
                    <td><a href="${file.url}" title="${file.name}"
                           download="${file.name}" ${empty file.thumbnailUrl?'data-gallery':''}>${file.name}</a></td>
                    <td>${file.size}(秒)</td>
                    <td>${file.thumbnailSize}(秒)</td>
                    <td>${fns:getDictLabel(file.sts, 'IMG_STS', '')}</td>
                </tr>
            </c:forEach>
        </table>--%>
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
    <legend>审核信息</legend>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead><tr>
            <th>环节名称</th>
            <th>审批人</th>
            <th>审批意见</th>
            <th>审批时间</th>
        </tr></thead>
        <tbody>
        <c:forEach items="${soAudits}" var="approve">
            <tr>
                <td><%--学时${fns:getDictLabel(approve.auditLevel-1,"AUDIT_LEVEL","")}--%>
                  <c:if test="${approve.auditLevel eq 2}">学时初审</c:if>
                  <c:if test="${approve.auditLevel eq 3}">学时复审</c:if>
                </td>
                <td>${fns:getUserById(approve.auditBy).name}</td>
                <td>${approve.auditInfo}</td>
                <td><fmt:formatDate value="${approve.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</fieldset>
<c:if test="${soHours.auditLevel eq '0'}">
    <form:form id="inputForm" modelAttribute="soHours" action="${ctx}/audit/hoursFirstAudit" method="post" class="form-horizontal">
        <form:hidden path="id"/>
        <form:hidden path="soid"/>
        <form:hidden path="courseId"/>
        <form:hidden path="lessonId"/>
        <div class="control-group">
            <label class="control-label">是否通过：</label>
            <div class="controls">
                <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                   itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">审核意见：</label>
            <div class="controls">
                <form:textarea id="auditRemarks" path="rsrvStr1"     class="required" rows="5" maxlength="200"/>
            </div>
        </div>
        <div class="form-actions">
            <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
    </form:form>
</c:if>
<c:if test="${soHours.auditLevel eq '1'}">
    <form:form id="inputForm" modelAttribute="soHours" action="${ctx}/audit/hoursSecondAudit" method="post" class="form-horizontal">
        <form:hidden path="id"/>
        <form:hidden path="soid"/>
        <form:hidden path="courseId"/>
        <form:hidden path="lessonId"/>
        <div class="control-group">
            <label class="control-label">是否通过：</label>
            <div class="controls">
                <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                   itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">审核意见：</label>
            <div class="controls">
                <form:textarea id="auditRemarks" path="rsrvStr1"     class="required" rows="5" maxlength="200"/>
            </div>
        </div>
        <div class="form-actions">
            <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
    </form:form>
</c:if>
<c:if test="${soHours.auditLevel eq '2'}">
    <form:form id="inputForm" modelAttribute="soHours" action="${ctx}/audit/hoursThirdAudit" method="post" class="form-horizontal">
        <form:hidden path="id"/>
        <form:hidden path="soid"/>
        <form:hidden path="courseId"/>
        <form:hidden path="lessonId"/>
        <div class="control-group">
            <label class="control-label">是否通过：</label>
            <div class="controls">
                <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                   itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">审核意见：</label>
            <div class="controls">
                <form:textarea id="auditRemarks" path="rsrvStr1"     class="required" rows="5" maxlength="200"/>
            </div>
        </div>
        <div class="form-actions">
            <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
    </form:form>
</c:if>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/load-image.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/canvas-to-blob.min.js"></script>
<!-- blueimp Gallery script -->
<script src="${ctxStatic}/jquery-upload/js/jquery.blueimp-gallery.min.js"></script>
</body>
</html>
