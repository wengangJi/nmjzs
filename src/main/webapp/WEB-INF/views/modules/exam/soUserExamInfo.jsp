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


        </tr>
    </c:forEach>
    </tbody>
    </table>

<div class="pagination">${page}</div>
</body>
</html>
