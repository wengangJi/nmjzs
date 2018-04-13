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


        function updateExamInfoAgain(v) {
            $.ajax({
                type: "post",
                url: "${ctx}/exam/exam/updateExamInfoAgain",
                data: { "examInfoId": v},
                dataType: "json",
                success: function (flag) {
                    if (flag.flag == 1) {
                        $.jBox.tip("补考数据作废成功！");
                        window.location.href="${ctx}/exam/exam/getSoExamInfo";
                    }

                }

            });
        }

    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">考试情况查询</a></li>
</ul>

<form:form id="cpForm" modelAttribute="soPlan" action="${ctx}/exam/exam/getSoExamInfo" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>


<%--
    <label class="control-label" for="localId">申报地市 ：</label>
    <form:select id="localId" path="localId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
--%>

    <label class="control-label" for="rsrvStr3">人员姓名 ：</label>
    <form:input id="rsrvStr3" path="rsrvStr2" htmlEscape="false" class=" input-medium"/>

    <label class="control-label" for="passTag">考试状态 ：</label>
    <form:select id="passTag" path="passTag" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PASS_TAG')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>


    <label class="control-label" for="startTime">开始时间 ：</label>
    <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
                value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    </br>

    <label class="control-label" for="soid">申报单号 ：</label>
    <form:input id="soid" path="soid" htmlEscape="false" class=" input-medium"/>


    <label class="control-label" for="examType">是否补考 ：</label>
    <form:select id="examType" path="examType" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('EXAM_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>


    <label class="control-label" for="endTime">结束时间 ：</label>
    <form:input id="endTime" path="endTime" type="text" readonly="readonly" class="input-small Wdate"
                value="${endTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
</form:form>

    <table id="contentTable" class="table  table-bordered table-condensed table-hover ">
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
<%--
    <th>审核状态</th>
--%>
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
<%--
            <td>${fns:getDictLabel(soExamInfo.auditTag, 'AUDIT_TAG', '')}</td>
--%>
            <td><a href="${ctx}/exam/exam/getQuestionListByType?examInfoId=${soExamInfo.id}&flag=0&cores=${soExamInfo.cores}">详细</a>
                <c:if test="${soExamInfo.examType eq '1' and soExamInfo.passTag eq '0'}">
                   <a href="#" onclick="updateExamInfoAgain(${soExamInfo.id})">再次补考</a>
                </c:if>

            </td>

        </tr>
    </c:forEach>
    </tbody>
    </table>

<div class="pagination">${page}</div>
</body>
</html>
