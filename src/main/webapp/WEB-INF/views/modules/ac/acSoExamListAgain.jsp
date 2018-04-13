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
    <li class="active"><a href="#" data-toggle="tab">申报列表</a></li>
</ul>
<li style="color: red;">提示：考试允许两次补考机会，若已完成两次补考，不允许再次补考。</li>
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
        <th>项目费用</th>
        <th>缴费情况</th>
        <th>学时情况</th>
        <th>考试情况</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${soPlans}" var="soPlan">

        <tr>

            <td><a href="${ctx}/plan/findSoAllInfo?soid=${soPlan.soid}">${soPlan.soid}</a></td>
            <td>${fns:getDictLabel(soPlan.localId, 'LOCAL_ID', '')}</td>
            <td>${servAcInfo.name}</td>
            <td>${fns:getDictLabel(fns:getPlanById(soPlan.planId).majorId, 'MAJOR', '')}</td>
            <td>${fns:getPlanById(soPlan.planId).planName}</td>
            <td><fmt:formatDate value="${soPlan.applyDate}" pattern="yyyy-MM-dd"/></td>

            <td>${fns:getPlanById(soPlan.planId).planHours}</td>
            <td>${soPlan.fee}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.feeState, 'FEE_STATE', '')}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.hourState, 'HOUR_STATE', '')}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.examState, 'EXAM_STATE', '')}</td>
           <c:if test="${soPlan.feeState eq '1'  and soPlan.hourState eq '1' and soPlan.examState eq '4'}">
               <c:if test="${soPlan.rsrvStr3 eq '2'}">
                   <td>
                       <i style="color: red;">已完成两次补考</i>
                   </td>
               </c:if>

               <c:if test="${soPlan.rsrvStr3 ne '2'}">
                   <td>
                       <a href="${ctx}/exam/exam/examQuestionListAagin?planId=${soPlan.planId}&soid=${soPlan.soid}"> <i class="icon-white icon-play-circle"></i>进入补考</a>
                   </td>
               </c:if>

            </c:if>



        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
