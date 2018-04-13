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
    <li class="active"><a href="#">试题情况</a></li>
</ul>

<form:form id="cpForm" modelAttribute="soPlan" action="${ctx}/exam/exam/getCompanySoExamInfo" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>


    <label class="control-label" for="planId">申报项目 ：</label>
    <form:select id="planId" path="planId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getAllPlanByYear('2014')}" itemLabel="planName" itemValue="planId" htmlEscape="false"/></form:select>


    <label class="control-label" for="startTime">开始时间 ：</label>
    <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
                value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    </br>


    <label class="control-label" for="passTag">考试状态 ：</label>
    <form:select id="passTag" path="passTag" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PASS_TAG')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="endTime">结束时间 ：</label>
    <form:input id="endTime" path="endTime" type="text" readonly="readonly" class="input-small Wdate"
                value="${endTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>

    <table id="contentTable" class="table  table-bordered table-condensed table-striped ">
    <thead>
    <tr>
    <th>考试人</th>
    <th>是否补考</th>
    <th>考试项目</th>
    <th>申报单号</th>
    <th>开始时间</th>
    <th>结束时间</th>
    <th>题量</th>
    <th>规定时间</th>
    <th>成绩</th>
    <th>是否合格</th>
    <th>审核状态</th>
    <th>操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${page.list}" var="soExamInfo">

        <tr>
            <td>${fns:getUserById(soExamInfo.userId).name}</td>
            <td>${fns:getDictLabel(soExamInfo.examType, 'EXAM_TYPE', '')}</td>
            <td>${fns:getPlanById(soExamInfo.planId).planName}</td>
            <td>${soExamInfo.soId}</td>
            <td>${soExamInfo.startTime}</td>
            <td>${soExamInfo.endTime}</td>
            <td>${soExamInfo.questionTotals}</td>
            <td>${soExamInfo.requireTime}(分钟)</td>
            <td>${soExamInfo.cores}</td>
            <td>${fns:getDictLabel(soExamInfo.passTag, 'PASS_TAG', '')}</td>
            <td>${fns:getDictLabel(soExamInfo.auditTag, 'AUDIT_TAG', '')}</td>
            <td><a href="${ctx}/exam/exam/getQuestionListByType?examInfoId=${soExamInfo.id}&flag=0&cores=${soExamInfo.cores}">详细</a></td>

        </tr>
    </c:forEach>
    </tbody>
    </table>
</body>
</html>
