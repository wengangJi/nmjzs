<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">
        $(document).ready(function() {

            $("#checkall").click(
                function(){
                    if(this.checked){
                        $("input[name='seqs']").attr('checked', true)
                    }else{
                        $("input[name='seqs']").attr('checked', false)
                    }
                }
            );
            $("#batchAssBtn").click(
                    function(){
                        var flag = false;
                        $("input[name='seqs']").each(function(){
                            if(this.checked){
                                flag = true;
                            }
                        });
                        if(!flag){
                            $.jBox.error("请选择记录后操作!");
                            return false;
                        }
                        var html = "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' /></div>";
                        var submit = function (v, h, f) {
                            if (f.auditRemark == '') {
                                $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                                return false;
                            }

                            $("#auditRemark").val(f.auditRemark);
                            $("#inputForm").submit();
                            $.jBox.tip("审核成功!");

                            return true;
                        };

                        $.jBox(html, { title: "审核", submit: submit });
                    }
            )

            $("#forwardBtn").click(
                    function(){
                        alert("正在开发中，请您耐心等待！");
                    }
            )

            $("#publicBtn").click(
                    function(){
                        alert("正在开发中，请您耐心等待！");
                    }
            )

            $("#blackBtn").click(
                    function(){
                        alert("正在开发中，请您耐心等待！");
                    }
            )
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#cpForm").submit();
            return false;
        }

    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/cp/assess/tasks">待办任务</a></li>
    <li><a href="${ctx}/cp/assess/warnTasks">超时待办</a></li>
    <li class="active"><a href="${ctx}/cp/assess/allTasks">所有任务</a></li>
</ul>
<form:form id="cpForm" modelAttribute="soAssess" action="${ctx}/cp/assess/warnTasks" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="companyId" name="companyId" type="hidden" value="${company.companyId}"/>

    <label class="control-label" for="localId">申报地市 ：</label>
    <form:select id="localId" path="so.localId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="batchId">批 次 号 ：</label>
    <form:select id="batchId" path="so.batchId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="startTime">开始时间 ：</label>
    <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
        value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    </br>
    <label class="control-label" for="soType">申报类别 ：</label>
    <form:select id="soType" path="so.soType" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('SO_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="major">申报专业 ：</label>
    <form:select id="major" path="soCpBase.major" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="endTime">结束时间 ：</label>
    <form:input id="endTime" path="endTime" type="text" readonly="readonly" class="input-small Wdate"
        value="${endTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<shiro:hasPermission name="cp:assess:batchAudit">
<div class="btn-group">
    <button class="btn" id="batchAssBtn">批量审核</button>
   <%-- <button class="btn" id="forwardBtn">转发</button>
    <button class="btn" id="publicBtn">公示</button>
    <button class="btn" id="blackBtn">黑名单</button>--%>
</div>
</shiro:hasPermission>

<form:form id="inputForm" action="${ctx}/cp/assess/batchAssess" method="post" >
<input type="hidden" id="auditRemark" name="auditRemark"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th><input type="checkbox" id="checkall" name="checkall"/>选择</th>
        <th>申报单号</th>
        <th>地市</th>
        <th>业务类型</th>
        <th>企业</th>
        <th>申报人</th>
        <th>证件号码</th>
        <th>专业</th>
        <th>申报类别</th>
        <th>申报时间</th>
        <th>审核状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${page.list}" var="soAssess">
        <c:set var="task" value="${soAssess.so.task }" />
        <tr>
            <td><input type="checkbox"  name="seqs" value="${soAssess.so.soid}"/> </td>
            <td><a href="${ctx}/cp/soCp/soCpInfo?soid=${soAssess.so.soid}&soType=${soAssess.so.soType}">${soAssess.so.soid}</a></td>
            <td>${fns:getDictLabel(soAssess.so.localId, 'LOCAL_ID', '')}</td>
            <td>${fns:getDictLabel(soAssess.so.soType, 'SO_TYPE', '')}</td>
            <td>${fns:getCompanyById(soAssess.so.companyId).companyName}</td>
            <td>${soAssess.soCpBase.name}</td>
            <td>${soAssess.soCpBase.idNo}</td>
            <td>${fns:getDictLabel(soAssess.soCpBase.major, 'MAJOR', '')}</td>
            <td>${fns:getDictLabel(soAssess.soCpBase.personType, 'PERSON_TYPE', '')}</td>
            <td><fmt:formatDate value="${soAssess.so.applDate}" type="date"/></td>
            <td>${soAssess.so.processSts}</td>
            <td>
                <c:if test="${soAssess.so.rsrvStr1 ne '已完成' && soAssess.so.sts!='0' }">
                    <a href="${ctx}/sys/workflow/processMap?processInstanceId=${soAssess.so.bpmId}" class="fancybox"  data-fancybox-type="iframe">跟踪</a>
                </c:if>
                &nbsp;
                <c:if test="${empty task.assignee }">
                    <a class="claim" href="${ctx}/cp/assess/task/overclaim/${task.id}">接收</a>
                </c:if>
                <c:if test="${not empty task.assignee }">
                    <a href="${ctx}/cp/assess/detail?soid=${soAssess.so.soid}&audit=1">审核</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</form:form>
<div class="pagination">${page}</div>
</body>
</html>
