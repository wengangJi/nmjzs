<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业管理</title>
	<meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

            $("#param").focus();
            $("#searchForm").validate({
                submitHandler: function(form){
                    loading('正在查询，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });


		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/comp/company/">企业列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="company" action="${ctx}/comp/company/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <label>所属地市 ：</label><form:select id="localId" path="localId" class="input-medium"><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/>所属地市</form:select>
        <label>企业类型 ：</label><form:select id="companyType" path="companyType" class="input-medium"><form:options items="${fns:getDictList('COMPANY_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>企业类型</form:select>
        <label>企业名称 ：</label><input type="text" id="param" name="param"  value="${params.param}">
        &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>企业名称</th><th>所属地市</th><th>组织机构代码</th><th>营业执照号</th><th>企业类型</th><th>资质等级</th><th>企业法人</th><th>联系人</th><th>联系电话</th><shiro:hasPermission name="comp:company:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="company"   >

			<tr>
				<td><a href="${ctx}/comp/company/detail?id=${company.companyId}">${company.companyName}</a></td>
                <td>${fns:getDictLabel(company.localId, 'LOCAL_ID', '')}</td>
                <td>${company.orgCode}</td>
                <td>${company.licenceNo}</td>
                <td>${company.companyType}</td>
                <td>${company.qualLevel}</td>
                <td>${company.legPerson}</td>
                <td>${company.contactPerson}</td>
                <td>${company.contactPhone}</td>
                <shiro:hasPermission name="comp:company:edit">
                 <td>
                     <a href="${ctx}/comp/company/edit?id=${company.companyId}">修改</a>
                     <a href="${ctx}/comp/company/delete?id=${company.companyId}" onclick="return confirmx('确认要删除该企业吗？', this.href)">删除</a>
                 </td>
                </shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
