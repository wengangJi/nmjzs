app<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

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
<form:form id="cpForm" modelAttribute="company" action="${ctx}/comp/company/cppage" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="companyId" name="companyId" type="hidden" value="${company.companyId}"/>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr><th>证书编号</th><th>姓名</th><%--<th>职务</th>--%><th>专业</th><th>职称</th><th>职业资格</th><th>人员类别</th><th>发证时间</th><th>发证单位</th><th>有效期至</th><th>出生日期</th><th>性别</th><th>身份证号</th><th>证书状态</th></tr></thead>
    <tbody>
    <c:forEach items="${page.list}" var="personnel">
        <tr>
            <td><%--<a href="${ctx}/cp/personnel/form?id=${personnel.servid}">--%>${personnel.cert.certNo}<%--</a>--%></td>
            <td>${personnel.name}</td>
            <%-- <td>${personnel.major}</td>--%>
            <td>${personnel.major}</td>
            <td>${fns:getDictLabel(personnel.titleLevel, 'TITLE_LEVEL', '')}</td>
            <td>${personnel.titleType}</td>
            <td>${fns:getDictLabel(personnel.personType, 'PERSON_TYPE', '')}</td>
            <td><fmt:formatDate value="${personnel.cert.issueDate}" type="date"/></td>
            <td>${personnel.cert.issueBy}</td>
            <td><fmt:formatDate value="${personnel.cert.expDate}" type="date"/></td>
            <td><fmt:formatDate value="${personnel.birthDate}" type="date"/></td>
            <td>${fns:getDictLabel(personnel.sex, 'SEX', '')}</td>
            <td>${personnel.idNo}</td>
            <td>${fns:getDictLabel(personnel.cert.sts, 'STS', '')}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
