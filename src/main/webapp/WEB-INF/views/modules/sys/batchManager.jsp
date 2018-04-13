<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>批次管理</title>
	<meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/sys/initBatch">批次管理</a></li>
       <li><a href="${ctx}/sys/sys/initBatch">批次列表</a></li>
	</ul>
    <form:form id="inputForm" modelAttribute="sysBatch" action="${ctx}/sys/sys/saveBatch" method="post" class="form-horizontal">

    <div class="span10">
        <p style="text-align: center; font-size: 18px;">
           <br>
        </p>
    </div>

<div class=" span10">
    <div class=" span10">
        <div class="control-group">
            <label class="control-label">企业名称:</label>

            <div class="controls">

                <tags:commonselect id="companyId" name="companyId" value="${fns:getUser().userCompany.companyId}" labelName="companyName"
                                   labelValue="${fns:getUser().userCompany.companyName}" title="企业" url="${ctx}/comp/company/findByName"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">所属模块:</label>

            <div class="controls">
                <form:select id="appId" path="appId" class="required input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('APP_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">业务类型:</label>

            <div class="controls">
                <form:select id="batchType" path="batchType" class="required input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('BATCH_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
            </div>
        </div>
    </div>


    <div class="span6" style="text-align: center">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" name="submit">
        <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">
    </div>

    </form:form>

	<tags:message content="${message}"/>

	<div class="pagination">${page}</div>
</body>
</html>
