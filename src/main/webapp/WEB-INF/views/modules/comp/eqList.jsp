<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>企业资质</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#eqForm").submit();
            return false;
        }
    </script>
</head>
<body>
<tags:message content="${message}"/>
<form:form id="eqForm" modelAttribute="company" action="${ctx}/comp/company/eqpage" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="companyId" name="companyId" type="hidden" value="${company.companyId}"/>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>证书编号</th>
        <th>审批单位</th>
        <th>审批时间</th>
        <th>法人代表</th>
        <th>资质类型</th>
        <th>主项资质</th>
        <th>增项资质</th>
        <th>企业地址</th>
        <th>邮编</th>
        <th>联系电话</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="qualCert">
        <tr>
            <td>${qualCert.cert.certNo}</td>

            <td>${qualCert.cert.issueBy}</td>
            <td>
                <fmt:formatDate value="${qualCert.cert.issueDate}" type="date"/>
            </td>
            <td>${qualCert.serv.company.legPerson}</td>
            <td>${qualCert.qualItems[0].rsrvStr1}</td>
            <td>${qualCert.qualItems[0].rsrvStr2}</td>
            <td>${qualCert.qualItems[0].rsrvStr3}</td>
            <td>${qualCert.serv.company.address}</td>
            <td>${qualCert.serv.company.postCode}</td>
            <td>${qualCert.serv.company.contactPhone}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
