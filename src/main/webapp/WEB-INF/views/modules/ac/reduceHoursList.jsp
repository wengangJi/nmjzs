<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>减免学时列表</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <style type="text/css">.sort{color:#0663A2;cursor:pointer;}</style>
    <script type="text/javascript">
        $(document).ready(function() {
        });
    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">申请列表</a></li>
</ul>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr><th>申报单号</th><th>申报项目</th><th>申请人姓名</th><th>继续教育证书编号</th><th>执业单位</th><th>冲抵学时数</th><th>冲抵学时理由</th><th>审核状态</th><th>操作</th></thead>
    <tbody>
    <c:forEach items="${soHoursList}" var="item">
        <tr>
            <td>${item.soid}</td>
            <td>${fns:getPlanById(item.planId).planName}</td>
            <td>${fns:getUser().name}</td>
            <td>${item.certNo}</td>
            <td>${item.companyName}</td>
            <td>${item.hours}(学时)</td>
            <td>${item.reduceReason}</td>
            <td>${fns:getDictLabel(item.auditTag,"AUDIT_TAG" ,"" )}</td>
            <td>
                <c:if test="${item.auditTag eq '0'}">
                   <%-- <a href="${ctx}/hours/initReduceModify?id=${item.id}">修改</a>--%>
                    <a href="${ctx}/hours/delete?id=${item.id}" onclick="return confirmx('确认要删除该申请吗？', this.href)">删除</a>
                </c:if>

            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>