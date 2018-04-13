<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>申请首页</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

        function checkBathForm(para){
            if(para != null){
                switch (para.value){
                    case "0":
                        $("#batchFrom").hide();
                        break;
                    case "1":
                        $("#batchFrom").show();
                        break;
                    default :
                        $("#batchFrom").hide();
                        break;
                }
            } else {
                $("#backBlock").hide();
            }
        }

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
		<li><a href="${ctx}/cp/soCp/cpTitleForm">申报首页</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="so" action="${ctx}/cp/soCp/cacheTitle" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
        <form:hidden path="companyId" value="${fns:getUser().userCompany.companyId}"/>
        <form:hidden path="pageModule" value="${Constants.GLOBAL_SO_CP_TITLE_PAGE_MODULE}" />
        <form:hidden path="appId" value="${Constants.GLOBAL_CP_APP_ID}" />
        <form:hidden path="sex" value="" />
        <form:hidden path="birthDate" value="" />
        <form:hidden path="idType" value="" />

         <div class="span10">
             <p style="text-align: center;margin-bottom: 20px; font-size: 18px;">
                 内蒙古自治区建筑施工企业<br>
                主要负责人、项目负责人和专职安全<br>
                生产管理人员考核申请表
             </p>
         </div>
         <div class="offset2 span10">
             <div class="control-group">
                 <label class="control-label">企业名称:</label>

                 <div class="controls">
                    <%-- <tags:companyselect  id="companyId" name="companyId" value="${fns:getUser().userCompany.companyId}" labelName="companyName"
                                      labelValue="${fns:getUser().userCompany.companyName}" title="企业" url="${ctx}/comp/company/findByName" />--%>
                        <form:input path="rsrvStr1"  value="${fns:getUser().userCompany.companyName}" class="input-medium" disabled ="true"/>


                 </div>
             </div>

         <%--    <div class="control-group">
                 <label class="control-label">申报方式:</label>

                 <div class="controls">
                     <form:radiobuttons onchange="checkBathForm(this)" id="batchFlag" name="batchFlag" path="batchFlag" items="${fns:getDictList('BATCH_FLAG')}" itemLabel="label"  itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                 </div>
             </div>--%>

             <div class="control-group" id="batchFrom">
                 <label class="control-label">申报批次:</label>

                 <div class="controls">
                     <form:select id="batchId" path="batchId" class="required input-medium" ><form:option value=""
                                                                                                 label=""/><form:options
                             items="${fns:getBatchListByCompanyId(fns:getUser().userCompany.companyId)}" itemLabel="batchName"
                             itemValue="batchId" htmlEscape="false"/></form:select><a id="${id}Button" href="${ctx}/sys/sys/geneBacthPickFast?appId=${Constants.GLOBAL_CP_APP_ID}&soType=${Constants.GLOBAL_SO_TYPE_SO}" class="btn"  onclick="return confirmx('您确实要本次业务生成批次么？', this.href)">创建批次</a>
                 </div>
             </div>
             <div class="control-group">
                 <label class="control-label">申请人姓名:</label>

                 <div class="controls">
                     <form:input path="applPerson"  class="required input-medium" />
                 </div>
             </div>
             <div class="control-group">
                 <label class="control-label">身份证件号:</label>
                 <div class="controls">
                    <%-- <form:input path="applIdNo"  class="required input-medium"/>--%>
                        <tags:idselect id="applIdNo" name="applIdNo" value="" labelName="" labelValue="" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>

                 </div>
             </div>
             <div class="control-group">
                 <label class="control-label">申请时间:</label>

                 <div class="controls">
                     <input id="applDate" name="applDate" type="text" readonly="readonly" maxlength="50" value="" pattern="yyyy-MM-dd"
                            class="required input-medium Wdate" value="${applDate}"
                            onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                 </div>
             </div>

             <div class="control-group">
                 <label class="control-label">申报类别:</label>

                 <div class="controls">
                     <form:radiobutton path="soType" value="01" checked="true" class="required"/>首次申请<form:radiobutton path="soType"
                                                                                                        value="08"
                                                                                                        disabled="true"/>延期申请
                 </div>
             </div>
         </div>
        <div class="span10">
            <p style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
                内蒙古自治区建设厅编制
            </p>
        </div>

        <div class="span10" style="text-align: center">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存">
            <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">
        </div>

     </form:form>
</body>
</html>