<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>减免学时申请</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">减免学时信息</a></li>
</ul>
<form:form id="inputForm" modelAttribute="soHours" action="${ctx}/hours/save" method="post" class="form-horizontal">

    <c:forEach items="${soHourses}" var="soHour">

    <table id="contentTable" class="table table-bordered table-condensed  table-hover">
        <thead>
        <tr align="center">
            <td colspan="6" style="text-align: center"><h3>继续教育冲抵学时申请</h3></td>
        </tr>
        <tr align="center">
            <td colspan="1" style="text-align: left">申请时间：<fmt:formatDate value="${soHour.createDate}" type="date"/>
            </td>
            <td colspan="5" style="text-align: left;color: red;">审核状态：${fns:getDictLabel(soHour.auditTag, 'AUDIT_TAG', '')}
            </td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><label class="control-label">申报单号</label></td>
            <td>${soHour.soid}</td>
            <td><label class="control-label">培训项目</label></td>
            <td>${fns:getPlanById(soHour.planId).planName}</td>
        </tr>
        <tr>
            <td><label class="control-label">申请人姓名</label></td>
            <td>${fns:getUser().name}</td>
            <td><label class="control-label">继续教育证书编号</label></td>
            <td>${soHour.certNo}</td>
        </tr>

        <tr>
            <td><label class="control-label">执业单位</label></td>
            <td colspan="3">${soHour.companyName}</td>
        </tr>
        <tr>
            <td><label class="control-label">申请冲抵的学时数</label></td>
            <td colspan="3">${soHour.hours}</td>
        </tr>

        <tr>
            <td><label class="control-label">冲抵学时的理由</label></td>
            <td colspan="3">${soHour.reduceReason}</td>
        </tr>
        <tr>
            <td><label class="control-label">具体情况说明</label></td>
            <td colspan="3">${soHour.remark}<br/></br></br></td>
        </tr>
        </tbody>
  </table>

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
                <c:if test="${approve.auditType eq '1'}">
                <tr>
                    <td>减免${fns:getDictLabel(approve.auditLevel-1,"AUDIT_LEVEL","")}</td>
                    <td>${fns:getUserById(approve.auditBy).name}</td>
                    <td>${approve.auditInfo}</td>
                    <td><fmt:formatDate value="${approve.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </c:forEach>
</form:form>
</body>
</html>