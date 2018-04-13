<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>二级建造师-人员信息</title>
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
<form:form id="acForm" modelAttribute="company" action="${ctx}/comp/company/acpersonpage" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="companyId" name="companyId" type="hidden" value="${company.companyId}"/>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>证书编号</th>
        <th>注册编号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>出生日期</th>
        <th>证件号码</th>
        <th>学历</th>
        <th>学位</th>
        <th>毕业院校</th>
        <th>毕业时间</th>
        <th>所学专业</th>
        <th>签发日期</th>
        <th>有效期至</th>
        <th>专业</th>
        <th>状态</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="ac">
        <tr>
            <td>${ac.certNo}</td>
            <td>${ac.acId}</td>
            <td>${ac.name}</td>
            <td>${fns:getDictLabel(ac.sex, 'SEX', '')}</td>
            <td><fmt:formatDate value="${ac.birthDate}" type="date"/></td>
            <td>${ac.idNo}</td>
            <td>${fns:getDictLabel(ac.degree, 'DEGREE', '')}</td>
            <td>${fns:getDictLabel(ac.education, 'EDUCATION', '')}</td>
            <td>${ac.gardSchool}</td>
            <td><fmt:formatDate value="${ac.gardDate}" type="date"/></td>
            <td>${ac.gardMajor}</td>
            <td><fmt:formatDate value="${ac.issueDate}" type="date"/></td>
            <td><fmt:formatDate value="${ac.expDate}" type="date"/></td>
            <td>${ac.remarks}</td>
            <td>${fns:getDictLabel(ac.sts, 'STS', '')}</td>


        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
