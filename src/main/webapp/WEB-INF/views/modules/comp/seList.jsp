<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>安全许可</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#seForm").submit();
            return false;
        }
    </script>
</head>
<body>
<tags:message content="${message}"/>
<form:form id="seForm" modelAttribute="company" action="${ctx}/comp/company/sepage" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="companyId" name="companyId" type="hidden" value="${company.companyId}"/>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>证书编号</th>
        <th>签发单位</th>
        <th>签发日期</th>
        <th>有效期至</th>
        <th>状态</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="se">
        <tr>
            <td>${se.cert.certNo}</td>
            <td>${se.cert.issueBy}</td>
            <td><fmt:formatDate value="${se.cert.issueDate}" type="date"/></td>
            <td><fmt:formatDate value="${se.cert.expDate}" type="date"/></td>
            <td>${fns:getDictLabel(se.serv.sts, 'STS', '')}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
