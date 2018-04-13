<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>注册页面</title>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <meta name="decorator" content="default"/>
    <style type="text/css">
        .wd {
            CLEAR: both;
            MARGIN: 0px auto;
            WIDTH: 800px;
        }
        .loing_title {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#loginName").focus();
            $("#inputForm").validate({
                rules: {
                    loginName: {remote: "${ctx}/signup/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
                },
                messages: {
                    loginName: {remote: "该身份证号已存在"},
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },
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

            $("#companyForm").validate({
                rules: {
                    loginName: {remote: "${ctx}/signup/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
                },
                messages: {
                    loginName: {remote: "企业组织机构代码证已存在"}
                },
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
<div name="Header">

    <div class="wd loing_title" id="topDataTd" style="MARGIN-TOP: 20px; HEIGHT: 46px">
        <div class="loing_title">内蒙古二级建造师继续教育系统注册</div>
    </div>
</div>
<div class="container">
<ul class="nav nav-tabs">
    <li class="active"><a href="#personalArea" data-toggle="tab">个人用户注册</a></li>
    <li><a href="#companyArea" data-toggle="tab">企业用户注册</a></li>
</ul><br/>
<div class="tab-content">
<div class="tab-pane active" id="personalArea">
<form:form id="inputForm" modelAttribute="user" action="${ctx}/signup/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <tags:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">身份证号:</label>
        <div class="controls">
            <form:input path="loginName" htmlEscape="false" maxlength="50" class="required card"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">所属盟市:</label>
        <div class="controls">
            <form:select path="localId">
                <form:options items="${fns:getAreaListByParent('0,1,47,')}" itemLabel="name" itemValue="id" htmlEscape="false"/>
            </form:select>
       </div>
    </div>
    <div class="control-group">
        <label class="control-label">姓名:</label>
        <div class="controls">
            <form:input path="name" htmlEscape="false" maxlength="50" class="required realName"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">密码:</label>
        <div class="controls">
            <input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">确认密码:</label>
        <div class="controls">
            <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">邮箱:</label>
        <div class="controls">
            <form:input path="email" htmlEscape="false" maxlength="100" class="email"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">电话:</label>
        <div class="controls">
            <form:input path="phone" htmlEscape="false" maxlength="100"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">手机:</label>
        <div class="controls">
            <form:input path="mobile" htmlEscape="false" maxlength="100" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" name="submit"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</div>
<div class="tab-pane" id="companyArea">
<form:form id="companyForm" modelAttribute="user" action="${ctx}/signup/saveCompany" method="post" class="form-horizontal">
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <td><label class="control-label">组织结构代码证:</label></td>
            <td><form:input path="loginName" htmlEscape="false" maxlength="50" class="required"/></td>
            <td><label class="control-label">密码:</label></td>
            <td><input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="required"/></td>
        </tr>
        <tr>
            <td><label class="control-label">单位名称:</label></td>
            <td><form:input path="userCompany.companyName" htmlEscape="false" maxlength="50" class="required"/></td>
            <td><label class="control-label">法人:</label></td>
            <td><form:input path="userCompany.legPerson" htmlEscape="false" maxlength="50" class="required"/></td>
        </tr>

        <tr>
            <td><label class="control-label">所属盟市:</label></td>
            <td>
                <form:select path="userCompany.localId">
                    <form:options items="${fns:getAreaListByParent('0,1,47,')}" itemLabel="name" itemValue="id" htmlEscape="false"/>
                </form:select>
            </td>
            <td><label class="control-label">公司地址:</label></td>
            <td><form:input path="userCompany.address" htmlEscape="false" maxlength="50" class="required userName"/></td>
        </tr>
        <tr>
            <td><label class="control-label">联系人:</label></td>
            <td><form:input path="userCompany.contactPerson" htmlEscape="false" maxlength="50" class="required"/></td>
            <td><label class="control-label">注册资金:</label></td>
            <td><form:input path="userCompany.registerCapital" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>
        <tr>
            <td><label class="control-label">手机号码:</label></td>
            <td><form:input path="userCompany.contactPhone" htmlEscape="false" maxlength="50" class="required mobile"/></td>
            <td><label class="control-label">税务登记号:</label></td>
            <td><form:input path="userCompany.taxNo" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>

        <tr>
            <td><label class="control-label">固定电话:</label></td>
            <td><form:input path="userCompany.rsrvStr1" htmlEscape="false" maxlength="50" class="simplePhone"/></td>
            <td><label class="control-label">传真:</label></td>
            <td><form:input path="userCompany.fax" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>
        <tr>
            <td><label class="control-label">公司性质:</label></td>
            <td><form:select path="userCompany.companyType">
                    <form:options items="${fns:getDictList('COMPANY_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>
            </td>
            <td><label class="control-label">营业执照注册号:</label></td>
            <td><form:input path="userCompany.licenceNo" htmlEscape="false" maxlength="50" class=""/></td>
        </tr>
        <tr>
            <td><label class="control-label">网址:</label></td>
            <td colspan="3"><form:input path="userCompany.portalCode" htmlEscape="false" maxlength="50" class="input-block-level"/></td>
        </tr>
        <tr>
            <td><label class="control-label">企业简介:</label></td>
            <td colspan="3"><form:textarea path="userCompany.profile" htmlEscape="false" maxlength="50" class="input-block-level" rows="3"/></td>
        </tr>
    </table>
    <div class="form-actions">
        <input id="cbtnSubmit" class="btn btn-primary" type="submit" value="保 存" name="submit"/>&nbsp;
        <input id="cbtnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</div>
</div>
</div>
</body>
</html>