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

<table id="contentTable" class="table  table-bordered table-condensed table-hover">
    <thead>
    <tr>
        <th>申报单号</th>
        <th>申报人</th>
        <th>申报专业</th>
        <th>申报项目</th>
<%--
        <th>申报年度</th>
--%>
        <th>申报时间</th>
<%--
        <th>合格证情况</th>
--%>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${soPlans}" var="soPlan">

        <tr>

            <td><a href="${ctx}/plan/findSoAllInfo?soid=${soPlan.soid}">${soPlan.soid}</a></td>
            <td>${servAcInfo.name}</td>
            <td>${fns:getDictLabel(fns:getPlanById(soPlan.planId).majorId, 'MAJOR', '')}</td>
            <td>${fns:getPlanById(soPlan.planId).planName}</td>
<%--
            <td>${fns:getPlanById(soPlan.planId).year}(年)</td>
--%>
            <td><fmt:formatDate value="${soPlan.applyDate}" pattern="yyyy-MM-dd"/></td>

<%--
            <td style="color: red;">${fns:getDictLabel(soPlan.certState, 'CERT_STATE', '')}</td>
--%>

            <c:if test="${soPlan.feeState eq '1'  and soPlan.hourState eq '1' and soPlan.examState eq '1' and soPlan.certState eq '0'}">
               <td>
                   <a href="javascript:void(0)" onclick="print('${soPlan.soid}','1',1000,600);" class="btn"><i class="icon-print"></i>&nbsp;打印</a>
               </td>
            </c:if>

         <%--   <c:if test="${soPlan.feeState eq '1' and soPlan.learnState eq '1' and soPlan.hourState eq '1' and soPlan.examState eq '1' and soPlan.certState eq '1'}">
                <td>
                    <a href="${ctx}/exam/exam/examQuestionList?planId=${soPlan.planId}&soid=${soPlan.soid}"> <i class="icon-white icon-play-circle"></i>查看证书</a>
                </td>
            </c:if>--%>

        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
