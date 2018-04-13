<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>参加考试首页</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
        });
    </script>
</head>
<body>
<tags:message content="${message}"/>
    <form name="form1" action="${ctx}/exam/exam/examQuestionList" method="post"  modelAttribute="examinationChoice">
        <table class="table table-striped table-bordered ">
            <tr align="center">
                <td align="center" width="400">欢迎进入在线答题系统,请选择相应题目参加考试！</td>
            </tr>
        </table>
        <table border="0" width="543" height="195" align="center">
            <tr>
                <td>  <label class="control-label" for="type">专 业 ：</label></td>
                <td> <form:select id="type" path="examinationChoice.Profession" class="required input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
                </td>
            </tr>
            <tr>
                <td>  <label class="control-label" for="type">类 别 ：</label></td>
                <td> <form:select id="type" path="examinationChoice.type" class="required input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PLAN_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
                </td>
            </tr>

            <tr>
            <td> <label class="control-label" >题 量 ：</label></td>
            <td> <form:input id="questionTotals" path="examinationChoice.questionTotals" htmlEscape="false" class="required input-medium" readonly="true" /> </td>
   </tr>

            <tr>
                <td> <label class="control-label">时 间 ：</label></td>
                <td> <form:input id="questionTime" path="examinationChoice.questionTime" htmlEscape="false" class="required input-medium" readonly="true" /> </td>
            </tr>
        </table>
        <div class="span10" style="text-align: center;width: 1000px">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="参加考试" name="submit">
        </div>
    </form>

</body>
</html>
