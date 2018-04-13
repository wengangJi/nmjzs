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

    <table id="contentTable" class="table  table-bordered table-condensed table-striped ">
    <thead>
    <tr>
    <th>考试人</th>
    <th>考试开始时间</th>
    <th>考试结束时间</th>
    <th>试题数量</th>
    <th>规定时间</th>
    <th>申报单号</th>
    <th>考试项目</th>
    <th>考试专业</th>
    <th>考试状态</th>
    <th>操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${examInfos}" var="soExamInfo">

        <tr>

            <td>${fns:getUserById(soExamInfo.userId).name}</td>
            <td>${soExamInfo.startTime}</td>
            <td>${soExamInfo.endTime}</td>
            <td>${soExamInfo.questionTotals}</td>
            <td>${soExamInfo.requireTime}(分钟)</td>
            <td>${soExamInfo.soId}</td>
            <td>${fns:getPlanById(soExamInfo.planId).planName}</td>
            <td>${fns:getDictLabel(fns:getPlanById(soExamInfo.planId).majorId, 'MAJOR', '')}</td>
            <td>${fns:getDictLabel(soExamInfo.examState, 'EXAM_STATE', '')}</td>
            <td><a href="${ctx}/exam/exam/getQuestionListByType?examInfoId=${soExamInfo.id}&flag=1&cores=${soExamInfo.cores}">查看详细</a></td>

        </tr>
    </c:forEach>
    </tbody>
    </table>
</body>
</html>
