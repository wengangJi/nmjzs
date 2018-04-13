<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					//loading('正在提交，请稍等...');
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
	</script>
  <%--  <style type="text/css">
        #contentTable .control-label {width: 45px;}
    </style>
--%>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cp/soCp/cpApprForm">审批信息</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="soCpApprove" action="${ctx}/cp/soCp/cacheAppr" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
        <from:hidden path="soid"/>
        <form:hidden path="appId" value="${Constants.GLOBAL_CP_APP_ID}" />
        <form:hidden path="soType" value="${Constants.GLOBAL_SO_TYPE_SO}" />
        <form:hidden path="pageModule" value="${Constants.GLOBAL_SO_CP_APPROVE_PAGE_MODULE}" />

             <table id="contentTable" class="table table-striped table-bordered table-condensed">
                 <thead>
                 <tr align="center"><td colspan="8" style="text-align: center"><h4>审 核 信 息</h4></td></tr>
                 </thead>
                 <tr>
                     <td class="span2"><label class="control-label">企业审核意见</label></td>
                     <td><form:textarea path="content" class="required input-block-level" rows="4"/></td>
                 </tr>
                 <tr>
                     <td class="span2"><label class="control-label">省辖市建设行政主管部门</label></td>
                     <td><form:textarea path="contentLoc" class=" input-block-level" rows="4" readonly="true"/></td>
                 </tr>
                 <tr>
                     <td class="span2"><label class="control-label">建设厅审查意见</label></td>
                     <td><form:textarea path="contentMon" class=" input-block-level" rows="4" readonly="true"/></td>
                 </tr>
                 <tr>
                     <td class="span2"><label class="control-label">备注</label></td>
                     <td><form:textarea path="remarks" class=" input-block-level" rows="4" /></td>
                 </tr>

                 <tfoot>
                 <tr>
                     <td colspan="7" style="text-align: center">
                         <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存">
                         <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">
                     </td>
                 </tr>
                 </tfoot>
             </table>


	</form:form>
</body>
</html>