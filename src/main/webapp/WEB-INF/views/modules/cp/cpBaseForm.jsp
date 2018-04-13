<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>基本信息</title>
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
    <style type="text/css">
        #contentTable .control-label {width: 90px;}
    </style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cp/soCp/cpBaseForm">基本信息</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="soCpBase" action="${ctx}/cp/soCp/cacheBase" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
        <form:hidden path="soid"  />
        <form:hidden path="appId" value="${Constants.GLOBAL_CP_APP_ID}" />
        <form:hidden path="soType" value="${Constants.GLOBAL_SO_TYPE_SO}" />
        <form:hidden path="pageModule" value="${Constants.GLOBAL_SO_CP_BASE_PAGE_MODULE}" />
           <div id="div" style="  display:block width: 968px;">
            <table id="contentTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr align="center">
                    <td colspan="6" style="text-align: center"><h4>基 本 情 况</h4></td>
                </tr>
                </thead>
                <tbody>
                  <tr>
                    <td> <label class="control-label">姓名</label></td>
                    <td> <form:input id="name" path="name" htmlEscape="false" class="required input-medium"/> </td>
                    <td> <label class="control-label">性别</label> </td>
                    <td><form:radiobuttons id="sex" path="sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                           itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                    <td> <label class="control-label">出生日期</label> </td>
                    <td>
                        <input id="birthDate" name="birthDate" type="text" readonly="readonly" maxlength="50"
                               class="input-medium Wdate"
                               value="<fmt:formatDate value="${soCpBase.birthDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                    </td>
                    <td rowspan="3"width="60px;">照片</td>
                </tr>

                <tr>
                    <td><label class="control-label">证件号</label></td>
                    <td colspan="3">
                        <form:input path="idNo"  class="required input-medium"/>
                        <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>
                    <td><label class="control-label">证件类别</label></td>
                    <td><form:radiobuttons id="idType" path="idType" items="${fns:getDictList('ID_TYPE')}" itemLabel="label"
                                           itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>

                    </td>
                </tr>
                <tr>
                    <td><label class="control-label">人员类别</label></td>
                    <td colspan="5">
                        <form:radiobuttons path="personType" items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label"
                                           itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                    </td>
                </tr>

                <tr>
                    <td><label class="control-label">参加考试时间</label></td>
                    <td colspan="2"><input id="examDate" name="examDate" type="text" readonly="readonly"
                                           maxlength="50" class="input-medium Wdate"
                                           value="${examDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></td>
                    <td><label class="control-label">考试成绩</label></td>
                    <td colspan="3"><form:input path="examScore"  class="input-medium"/></td>
                </tr>

                <tr>
                    <td ><label class="control-label">所在企业名称</label></td>
                    <td colspan="6"> <tags:commonselect id="companyId" name="companyId" value="${fns:getUser().userCompany.companyId}" labelName="companyName" labelValue="${fns:getUser().userCompany.companyName}" title="查询企业" url="${ctx}/comp/company/findByName"/></td>
                </tr>

                <tr>
                    <td><label class="control-label">企业联系电话</label></td>
                    <td colspan="2"><form:input path="telephone"  value="${fns:getUser().userCompany.contactPhone}" class="input-medium"/></td>
                    <td><label class="control-label">资质等级</label></td>
                    <td colspan="3"><form:input path="qualLevel"  value="${fns:getUser().userCompany.qualLevel}"   class="input-medium"/></td>
               </tr>

               <tr>
                    <td><label class="control-label">通讯地址</label></td>
                    <td colspan="2"><form:input path="address" value="${fns:getUser().userCompany.address}" class="input-medium"/></td>
                    <td><label class="control-label">邮政编码</label></td>
                    <td colspan="3"><form:input path="postCode" value="${fns:getUser().userCompany.postCode}" class="input-medium"/></td>
               </tr>

               <tr> <td ><label class="control-label">电子邮箱</label></td>
                    <td colspan="6"><form:input path="mail"  value="${fns:getUser().userCompany.email}" class="input-medium"/></td>
               </tr>

               <tr>
                    <td><label class="control-label">毕业院校</label></td>
                    <td colspan="6"><form:input path="gardSchool"  class="input-medium"/></td>
               </tr>

               <tr>
                    <td><label class="control-label">毕业时间</label></td>
                    <td>
                        <input id="gardDate" name="gardDate" type="text" readonly="readonly" maxlength="50"
                               class="input-medium Wdate"
                               value="${gardDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> </td>
                    <td><label class="control-label">专业</label></td>
                    <td>
                        <form:select path="major" class="input-medium">
                            <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>
                    <td><label class="control-label">职称</label></td>
                    <td colspan="2">
                        <form:select path="titleLevel" class="input-medium">
                            <form:options items="${fns:getDictList('TITLE_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>
               </tr>

               <tr>
                    <td><label class="control-label">学 历</label></td>
                    <td>
                        <form:select path="degree" class="input-medium">
                            <form:options items="${fns:getDictList('DEGREE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>
                    <td><label class="control-label">学位</label></td>
                    <td><form:select path="education" class="input-medium">
                            <form:options items="${fns:getDictList('EDUCATION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>
                    <td><label class="control-label">执业资格</label></td>
                    <td colspan="2"><form:input path="titleType"  class="input-medium"/></td>
                </tr>

                <tr>
                    <td><label class="control-label">参加工作时间</label></td>
                    <td colspan="2">
                        <input id="workingDate" name="workingDate" type="text" readonly="readonly"
                               maxlength="50" class="input-medium Wdate"
                               value="${workingDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>

                    </td>
                    <td><label class="control-label">累计安全生产管理工作年限</label></td>
                    <td colspan="3"><form:input path="workExpe"  class="input-medium"/></td>
               </tr>
               <tr>
                    <td><label class="control-label">接受安全教育、培训及考核情况</label></td>
                    <td colspan="6"><form:textarea path="learnExpe" class="input-block-level" rows="4"/></td>
               </tr>
               <tr>
                    <td><label class="control-label">证书使用情况</label> </td>
                    <td colspan="6"><form:textarea path="certExpe" class="input-block-level" rows="4"/></td>
               </tr>

               </tbody>
               <tfoot>
               <tr>
                    <td colspan="7" style="text-align: center">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存">
                        <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">
                    </td>
                </tr>
               </tfoot>
            </table>
        </div>
    </form:form>
</body>
</html>