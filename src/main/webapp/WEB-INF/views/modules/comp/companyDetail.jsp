<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>企业信息</title>
    <meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="#">企业详细信息</a></li>
</ul>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <td><label class="control-label">单位名称:</label></td>
            <td>${company.companyName}</td>
            <td><label class="control-label">法人:</label></td>
            <td>${company.legPerson}</td>
        </tr>
        <tr>
            <td><label class="control-label">所属盟市:</label></td>
            <td>
                ${fns:getAreaName(company.localId)}
            </td>
            <td><label class="control-label">公司地址:</label></td>
            <td>${company.address}</td>
        </tr>
        <tr>
            <td><label class="control-label">联系人:</label></td>
            <td>${company.contactPerson}</td>
            <td><label class="control-label">注册资金:</label></td>
            <td>${company.registerCapital}</td>
        </tr>
        <tr>
            <td><label class="control-label">手机号码:</label></td>
            <td>${company.contactPhone}</td>
            <td><label class="control-label">税务登记号:</label></td>
            <td>${company.taxNo}</td>
        </tr>
        <tr>
            <td><label class="control-label">组织机构代码证:</label></td>
            <td>${company.orgCode}</td>
            <td><label class="control-label">资质等级:</label></td>
            <td>${company.qualLevel}</td>
        </tr>
        <tr>
            <td><label class="control-label">固定电话:</label></td>
            <td>${company.rsrvStr1}</td>
            <td><label class="control-label">传真:</label></td>
            <td>${company.fax}</td>
        </tr>
        <tr>
            <td><label class="control-label">公司性质:</label></td>
            <td>
            ${fns:getDictLabel(company.companyType,"COMPANY_TYPE" ,"" )}
            </td>
            <td><label class="control-label">营业执照注册号:</label></td>
            <td>${company.licenceNo}</td>
        </tr>
        <tr>
            <td><label class="control-label">网址:</label></td>
            <td colspan="3">${company.portalCode}
            </td>
        </tr>
        <tr>
            <td><label class="control-label">企业简介:</label></td>
            <td colspan="3">${company.profile}</td>
        </tr>
    </table>
    <div class="form-actions">
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</body>
</html>
