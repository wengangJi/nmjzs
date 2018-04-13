<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>二级建造师-专业信息</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#acForm").submit();
            return false;
        }
    </script>
</head>
<body>
<tags:message content="${message}"/>
<form:form id="acForm" modelAttribute="company" action="${ctx}/comp/company/acmajorpage" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="companyId" name="companyId" type="hidden" value="${company.companyId}"/>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>姓名</th>
        <th>证件号码</th>
        <th>序号</th>
        <th>专业</th>
        <th>有效起始</th>
        <th>有效期至</th>
        <th>状态</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="ac" varStatus="status">

            <tr>
                <td>${ac.name}</td>
                <td>${ac.idNo}</td>
                <td>${ac.seq}</td>
                <td>${fns:getDictLabel(ac.major, 'MAJOR', '')}</td>
                <td><fmt:formatDate value="${ac.effDate}" type="date"/></td>
                <td><fmt:formatDate value="${ac.expDate}" type="date"/></td>
                <td>${fns:getDictLabel(ac.sts, 'STS', '')}</td>
            </tr>

    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
