<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员申报列表</title>
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
    <li class="active"><a href="${ctx}/cp/soCp/query">申报列表</a></li>
    <li><a href="${ctx}/cp/soCp/cpCommitForm">申报提交</a></li>
</ul>
<form:form id="searchForm" modelAttribute="soCpEntity" action="${ctx}/cp/soCp/query" method="post" class="breadcrumb form-search">
<%--
    <jsp:useBean id="soAssess"  class="com.zhongxin.cims.modules.cp.entity.SoAssess" scope="request" ></jsp:useBean>
--%>

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
</form:form>
<table id="contentTable" class="table  table-bordered table-condensed table-hover">
    <thead>
    <tr>
        <th>申报单号</th>
        <th>地市</th>
        <th>业务类型</th>
        <th>申报人</th>
        <th>证件号码</th>
        <th>人员类别</th>
        <th>申报时间</th>
        <th>审核状态</th>
        <th>申报状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${page.list}" var="soCpEntity">

        <tr>

            <td><a href="${ctx}/cp/soCp/soCpInfo?soid=${soCpEntity.so.soid}&soType=${soCpEntity.so.soType}">${soCpEntity.so.soid}</a></td>
            <td>${fns:getDictLabel(soCpEntity.so.localId, 'LOCAL_ID', '')}</td>
            <td>${fns:getDictLabel(soCpEntity.so.soType, 'SO_TYPE', '')}</td>
            <td>${soCpEntity.soCpBase.name}</td>
            <td>${soCpEntity.soCpBase.idNo}</td>
            <td>${fns:getDictLabel(soCpEntity.soCpBase.personType, 'PERSON_TYPE', '')}</td>
            <td><fmt:formatDate value="${soCpEntity.so.applDate}" type="date"/></td>
            <td>${soCpEntity.so.processSts}</td>
            <td>${fns:getDictLabel(soCpEntity.so.sts, 'sts', '')}</td>
            <td>
                <c:if test="${soCpEntity.so.processSts ne '已完成' and soCpEntity.so.processSts ne '填写申请单' and soCpEntity.so.processSts ne '未启动'}">
                    <a href="${ctx}/sys/workflow/processMap?processInstanceId=${soCpEntity.so.bpmId}" class="fancybox"  data-fancybox-type="iframe">跟踪</a>
                </c:if>
                <a href="${ctx}/cp/soCp/queryDetail?soid=${soCpEntity.so.soid}">审核历史</a>
                    <c:if test="${soCpEntity.so.sts eq '1' || soCpEntity.so.sts eq '9'|| soCpEntity.so.sts eq '8'}">
                        <c:if test="${soCpEntity.so.soType ne '04'}">
                          <a href="${ctx}/cp/soCp/soCpChgForm?soid=${soCpEntity.so.soid}&actType=0">修改</a>
                        </c:if>
                    <a href="${ctx}/cp/soCp/removeSoByPrimaryKey?soid=${soCpEntity.so.soid}&actType=0"onclick="return confirmx('确认要删除该申报吗？', this.href)">删除</a>
                    <c:if test="${soCpEntity.so.sts eq '8'}">
                        <a href="${ctx}/cp/assess/soCpReStartProcess?soid=${soCpEntity.so.soid}">重新上报</a>
                    </c:if>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
