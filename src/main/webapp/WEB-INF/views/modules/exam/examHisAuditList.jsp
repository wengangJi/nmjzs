<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>考试审核管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">
    $(document).ready(function() {
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
    <li class="active"><a href="#">考试审核信息</a></li>
<%--
    <li class=""><a href="#">已审核</a></li>
--%>
</ul>

<form:form id="cpForm" modelAttribute="examInfo" action="${ctx}/exam/exam/auditHisExamList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>


    <label class="control-label" for="qryStr1">人员姓名 ：</label>
    <form:input id ="qryStr1" path="qryStr1" htmlEscape="false"  class="input-medium"></form:input>
    <label class="control-label" >审核环节 ：</label>
    <form:select id="qryStr4" path="qryStr4" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('AUDIT_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>&nbsp;

    </br>

    <label class="control-label" for="qryStr2">申报单号 ：</label>
    <form:input id="qryStr2" path="qryStr2" htmlEscape="false"  class="input-medium"></form:input>
    <label class="control-label" >审核状态 ：</label>
    <form:select id="qryStr3" path="qryStr3" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('AUDIT_TAG')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>&nbsp;

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>



    <table id="contentTable" class="table table-hover table-bordered table-condensed">
        <thead>
        <tr>
            <th>申报单号</th>
            <th>考试人</th>
            <th>是否补考</th>
            <th>考试开始时间</th>
            <th>考试结束时间</th>
            <th>分数</th>
            <th>是否合格</th>
            <th>审核环节</th>
            <th>审核状态</th>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="item">
            <tr>
                <td>${item.soId}</td>
                <td>${fns:getUserById(item.userId).name}</td>
                <td>${fns:getDictLabel(item.examType,'EXAM_TYPE',"")}</td>
                <td>${item.startTime}</td>
                <td>${item.endTime}</td>
                <td>${item.cores}</td>
                <td>${fns:getDictLabel(item.auditLevel,'PASS_TAG',"")}</td>
                <td>${fns:getDictLabel(item.auditLevel,'AUDIT_LEVEL',"")}</td>
                <td>${fns:getDictLabel(item.auditTag,'AUDIT_TAG',"")}</td>


            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">${page}</div>
</body>
</html>
