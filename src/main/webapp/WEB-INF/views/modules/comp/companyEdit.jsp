<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>企业信息修改</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#name").focus();
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
    <li><a href="#">信息修改</a></li>
</ul>
<tags:message content="${message}"/>
<form:form id="inputForm" modelAttribute="company" action="${ctx}/comp/company/editSave" method="post" class="form-horizontal">
    <form:hidden path="companyId" />
    <form:hidden path="provinceId"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <td><label class="control-label">单位名称:</label></td>
            <td><form:input path="companyName" htmlEscape="false" maxlength="50" class="required"/></td>
            <td><label class="control-label">法人:</label></td>
            <td><form:input path="legPerson" htmlEscape="false" maxlength="50" class="required"/></td>
        </tr>
        <tr>
            <td><label class="control-label">所属盟市:</label></td>
            <td>
                <form:select path="localId">
                    <form:options items="${fns:getAreaListByParent('0,1,47,')}" itemLabel="name" itemValue="id" htmlEscape="false"/>
                </form:select>
            </td>
            <td><label class="control-label">公司地址:</label></td>
            <td><form:input path="address" htmlEscape="false" maxlength="50" class="required"/></td>
        </tr>
        <tr>
            <td><label class="control-label">联系人:</label></td>
            <td><form:input path="contactPerson" htmlEscape="false" maxlength="50" class="required"/></td>
            <td><label class="control-label">注册资金:</label></td>
            <td><form:input path="registerCapital" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>
        <tr>
            <td><label class="control-label">手机号码:</label></td>
            <td><form:input path="contactPhone" htmlEscape="false" maxlength="50" class="required mobile"/></td>
            <td><label class="control-label">税务登记号:</label></td>
            <td><form:input path="taxNo" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>
        <tr>
            <td><label class="control-label">组织机构代码证:</label></td>
            <td><form:input path="orgCode" htmlEscape="false" maxlength="50" class=""/></td>
            <td><label class="control-label">资质等级:</label></td>
            <td><form:input path="qualLevel" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>
        <tr>
            <td><label class="control-label">固定电话:</label></td>
            <td><form:input path="rsrvStr1" htmlEscape="false" maxlength="50" class="simplePhone"/></td>
            <td><label class="control-label">传真:</label></td>
            <td><form:input path="fax" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>
        <tr>
            <td><label class="control-label">公司性质:</label></td>
            <td><form:select path="companyType">
                <form:options items="${fns:getDictList('COMPANY_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
            </td>
            <td><label class="control-label">营业执照注册号:</label></td>
            <td><form:input path="licenceNo" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>
        <tr>
            <td><label class="control-label">网址:</label></td>
            <td colspan="3"><form:input path="portalCode" htmlEscape="false" maxlength="50" class="url input-block-level"/></td>
        </tr>
        <tr>
            <td><label class="control-label">企业简介:</label></td>
            <td colspan="3"><form:textarea path="profile" htmlEscape="false" maxlength="50" class="input-block-level" rows="3"/></td>
        </tr>
    </table>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" name="submit"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>
