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
    <li class="active"><a href="#">申报列表</a></li>
</ul>
<%--<form:form id="searchForm" modelAttribute="soCpEntity" action="${ctx}/cp/soCp/query" method="post" class="breadcrumb form-search">
&lt;%&ndash;
    <jsp:useBean id="soAssess"  class="com.zhongxin.cims.modules.cp.entity.SoAssess" scope="request" ></jsp:useBean>
&ndash;%&gt;

    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label class="control-label" for="localId">申报地市 ：</label>
    <form:select id="localId" path="so.localId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="batchId">批 次 号 ：</label>
    <form:select id="batchId" path="so.batchId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getBatchListByCompanyId(fns:getUser().userCompany.companyId)}" itemLabel="batchName" itemValue="batchId" htmlEscape="false"/></form:select>

    <label class="control-label" for="startTime">开始时间 ：</label>
    <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
        value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    </br>
    <label class="control-label" for="soType">业务类型 ：</label>
    <form:select id="soType" path="so.soType" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('SO_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="personType">申报类别 ：</label>
    <form:select id="personType" path="soCpBase.personType" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="endTime">结束时间 ：</label>
    <form:input id="endTime" path="endTime" type="text" readonly="readonly" class="input-small Wdate"
        value="${endTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>--%>
<table id="contentTable" class="table  table-bordered table-condensed table-hover">
    <thead>
    <tr>
        <th>申报单号</th>
        <th>申报地市</th>
        <th>申报人</th>
        <th>证件号码</th>
        <th>申报专业</th>
        <th>申报项目</th>
        <th>申报时间</th>
        <th>项目学时</th>
        <th>项目费用</th>
        <th>缴费情况</th>
<%--
        <th>审核情况</th>
--%>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${soPlans}" var="soPlan">

        <tr>

            <td><a href="${ctx}/plan/findSoAllInfo?soid=${soPlan.soid}">${soPlan.soid}</a></td>
            <td>${fns:getDictLabel(soPlan.localId, 'LOCAL_ID', '')}</td>
            <td>${servAcInfo.name}</td>
            <td>${servAcInfo.idNo}</td>
            <td>${fns:getDictLabel(fns:getPlanById(soPlan.planId).majorId, 'MAJOR', '')}</td>
            <td>${fns:getPlanById(soPlan.planId).planName}</td>
            <td><fmt:formatDate value="${soPlan.applyDate}" pattern="yyyy-MM-dd"/></td>

            <td>${fns:getPlanById(soPlan.planId).planHours}</td>
            <td style="color: red;font-size: 16px;">${soPlan.fee}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.feeState, 'FEE_STATE', '')}</td>
<%--
            <td style="color: red;">${fns:getDictLabel(soPlan.oflineSts, 'OFLINE_STS', '')}</td>
--%>
            <c:if test="${soPlan.feeState eq '0'}">
                <td>
                    <a href="${ctx}/plan/removeSoPlan?soid=${soPlan.soid}">作废</a>
                    <a href="${ctx}/alipay/alipay/alipySubmit?soid=${soPlan.soid}&fee=${soPlan.fee}" target="_blank">在线支付</a>
                    <a href="${ctx}/plan/acPayOffLine?soid=${soPlan.soid}" >线下支付</a>
                    <a href="${ctx}/plan/findCourseByPlanId?planId=${soPlan.planId}">课程列表</a>
               </td>
            </c:if>
            <c:if test="${soPlan.feeState eq '1'}">
                <td>
<%--
                    <a href="${ctx}/learn/findCourseListByPlanId?planId=${soPlan.planId}">在线学习</a>
--%>
                    <a href="${ctx}/plan/findCourseByPlanId?planId=${soPlan.planId}">课程列表</a>
                </td>
            </c:if>






        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
