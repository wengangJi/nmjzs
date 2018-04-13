<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>我的申报</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#searchForm").validate({
                submitHandler: function (form) {
                    loading('正在查询，请稍等...');
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


        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }


    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">减免列表</a></li>
</ul>

<form:form id="cpForm" modelAttribute="soPlanEntity" action="${ctx}/plan/acAllReduceList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>



    <label class="control-label" for="servAcInfo.name">人员姓名 ：</label>
    <form:input id="servAcInfo.name" path="servAcInfo.name" htmlEscape="false" class=" input-medium"/>

    <label class="control-label" for="planId">申报项目 ：</label>
    <form:select id="planId" path="soPlan.planId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getAllPlanByYear('2014')}" itemLabel="planName" itemValue="planId" htmlEscape="false"/></form:select>

    <label class="control-label" for="startTime">开始时间 ：</label>
    <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
                value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    </br>

    <label class="control-label" for="servAcInfo.name">身份证号 ：</label>
    <form:input id="servAcInfo.idNO" path="servAcInfo.idNo" htmlEscape="false" class=" input-medium"/>


    <label class="control-label" for="auditTag">审核状态 ：</label>
    <form:select id="auditTag" path="soPlan.auditTag" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('AUDIT_TAG')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="endTime">结束时间 ：</label>
    <form:input id="endTime" path="endTime" type="text" readonly="readonly" class="input-small Wdate"
                value="${endTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>

<table id="contentTable" class="table  table-bordered table-condensed table-hover">
    <thead>
    <tr>
        <th>申报单号</th>
        <th>申报地市</th>
        <th>申报人</th>
        <th>申报专业</th>
        <th>申报项目</th>
        <th>申报时间</th>
        <th>要求学时</th>
        <th>缴费情况</th>
        <th>学时情况</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${page.list}" var="soPlan">

        <tr>

            <td><a href="${ctx}/plan/findSoAllInfo?soid=${soPlan.soid}">${soPlan.soid}</a></td>
            <td>${fns:getDictLabel(soPlan.localId, 'LOCAL_ID', '')}</td>
            <td>${fns:getUserById(soPlan.userId).name}</td>
            <td>${fns:getDictLabel(fns:getPlanById(soPlan.planId).majorId, 'MAJOR', '')}</td>
            <td>${fns:getPlanById(soPlan.planId).planName}</td>
            <td><fmt:formatDate value="${soPlan.applyDate}" pattern="yyyy-MM-dd"/></td>

            <td>${fns:getPlanById(soPlan.planId).planHours}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.feeState, 'FEE_STATE', '')}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.hourState, 'HOUR_STATE', '')}</td>

            <td>
               <a href="${ctx}/hours/reduceBySoid?soid=${soPlan.soid}"><i class="icon-white icon-play-circle"></i>减免审核查看</a>
            </td>


        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
