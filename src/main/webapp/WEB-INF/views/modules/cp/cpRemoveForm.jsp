e<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>证书注销</title>
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

    </script>
    <style type="text/css">
        #contentTable .control-label {width: 90px;}
        #myPrintArea table td {
        .mine
        font-size: 12px;
            font-family: '仿宋';

            font-size: 13px;
            font-family: '宋体';
            padding: 4px; margin-top: 4px;;
        .r20
        }
    </style>

</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/cp/soCp/cpRemoveForm">证书注销</a></li>
</ul>

<form:form id="searchForm" modelAttribute="servCpEntity" action="${ctx}/cp/soCp/findRemovePerson" method="post" class="breadcrumb form-search">

    <label class="control-label" for="personType">人员类别 ：</label>
    <form:select id="personType" path="personnel.personType" class="required input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="idNo">证件号码 ：</label>
    <form:input id="idNo" path="personnel.idNo"  class="required input-medium" />

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<form:form id="inputForm" modelAttribute="servCpEntity" action="${ctx}/cp/soCp/saveRemoveForm" method="post" class="form-horizontal">
    <tags:message content="${message}"/>
    <form:hidden path="cert.certType" value="${servCpEntity.cert.certType}"/>
    <form:hidden path="cert.issueBy" value="${servCpEntity.cert.issueBy}"/>
    <form:hidden path="personnel.idType" value="${servCpEntity.personnel.idType}"/>
    <form:hidden path="personnel.sex" value="${servCpEntity.personnel.sex}"/>
    <form:hidden path="personnel.personType" value="${servCpEntity.personnel.personType}"/>
    <form:hidden path="personnel.major" value="${servCpEntity.personnel.major}"/>
 <form:hidden path="servid" value="${servCpEntity.servid}"/>



    <div class="tab-content">

        <!-- 基本信息-->
        <div class="tab-pane active" id="cpBase">
            <div id="div" style="  display:block width: 968px;">
                <table id="contentBaseTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr align="center">
                        <td colspan="8" style="text-align: center"><h4>三类人员安全生产考核合格证书注销申请表</h4></td>
                    </tr>
                    </thead>
                    <tbody>
                    <span style="display: none">
                    <input id="effDate" name="cert.effDate" type="text" readonly="true" maxlength="50"  hidden="hidden"
                           class="input-medium Wdate"
                           value="<fmt:formatDate value="${servCpEntity.cert.effDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                    <input id="expDate" name="cert.expDate" type="text" readonly="true" maxlength="50"  hidden="hidden"
                           class="input-medium Wdate"
                           value="<fmt:formatDate value="${servCpEntity.cert.expDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                    <input id="birthDate1" name="personnel.birthDate" type="text" readonly="true" maxlength="50"  hidden="hidden"
                           class="input-medium Wdate"
                           value="<fmt:formatDate value="${servCpEntity.personnel.birthDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                     </span>
                    <tr>
                        <td> <label class="control-label" style="width: 82px;">姓名</label></td>
                        <td> <form:input id="name" path="personnel.name" htmlEscape="false" class="required input-medium" readonly="true"/> </td>
                        <td> <label class="control-label" style="width: 82px;">性别</label> </td>
                        <td><form:radiobuttons id="sex" path="personnel.sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required" disabled="true"></form:radiobuttons>
                        <td> <label class="control-label" style="width: 82px;" >出生日期</label> </td>
                        <td>

                            <input id="birthDate" name="personnel.birthDate" type="text" readonly="true" maxlength="50"
                                   class="input-medium Wdate"
                                 disabled="true"  value="<fmt:formatDate value="${servCpEntity.personnel.birthDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </td>
                        <td><label class="control-label" style="width: 82px;" readonly="true">证件号</label></td>
                        <td >
                            <form:input path="personnel.idNo"  class=" input-medium" readonly="true"/>
                            <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">工作单位</label></td>
                        <td colspan="3">
                            <form:hidden path="personnel.companyId"  value="${servCpEntity.serv.company.companyId}" class="required input-medium"/>
                            <form:input path="serv.company.companyName"  class="input-medium" disabled="true"/>
                        <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

                        <td><label class="control-label" style="width: 82px;">联系电话</label></td>
                        <td colspan="3">
                            <form:input path="personnel.telephone"  class=" input-medium" readonly="true"/>
                            <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>
                        <td>
                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">职务</label></td>
                        <td colspan="7">
                            <form:radiobuttons path="personnel.personType" items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required" disabled="true"></form:radiobuttons>
                        </td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">证书编号</label></td>
                        <td colspan="3"   >                 <form:input path="cert.certNo"  class="required input-medium" readonly="true"/>
                        </td>
                        <td><label class="control-label" style="width: 82px;">核发时间</label></td>
                        <td colspan="3"><input id="issueDate" name="cert.issueDate" type="text"    disabled="true" maxlength="50" class="input-medium Wdate" value="<fmt:formatDate value="${servCpEntity.cert.issueDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> </td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">注销原因</label> </td>
                        <td colspan="7"><form:textarea path="personnel.rsrvStr1"  class="required input-block-level" rows="4" /></td>
                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">注销人诚信证明(注销人签（章))</label> </td>
                        <td colspan="7"><form:textarea path="personnel.rsrvStr2"   class="input-block-level" rows="4" />
<%--
                            <span style="float: right; margin-right: 50px;">负责人(签字)：${fns:getUserById(soCpApprove.apprUserId).name}</span><br />
--%>

                        </td>
                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">单位意见</label></td>
                        <td colspan="3"><form:textarea path="personnel.rsrvStr3" class="required input-block-level" rows="4"/></td>
                        <td><label class="control-label" style="width: 82px;">单位所在地县级建设行政主管部门意见</label></td>
                        <td colspan="3"><form:textarea path="serv.remarks" class="input-block-level" readonly="true" rows="4"/></td>

                    </tr>


                    <tr>
                        <td><label class="control-label" style="width: 82px;">单位所在地市级建设行政主管部门意见</label></td>
                        <td colspan="3"><form:textarea path="serv.remarks" class="input-block-level" readonly="true" rows="4"/></td>
                        <td><label class="control-label" style="width: 82px;">省级建设行政主管部门意见</label></td>
                        <td colspan="3"><form:textarea path="serv.remarks" class="input-block-level" readonly="true" rows="4"/></td>

                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">备注</label> </td>
                        <td colspan="7"><form:textarea path="personnel.remarks" class="input-block-level" rows="4"/></td>
                    </tr>
                    </tbody>
                </table>
                注：注销手续需提供三类人员证书原件和复印件，如申请人劳动关系已经不在三类证书上所标注单位，并且原单位不愿意给予盖章证明，则申请人必须提供劳动合同原价和复印件，并由现劳动关系所在单位给予盖章证明

            </div>
        </div>

        <div class="span10" style="text-align: center;width: 1000px">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存">
            <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">
        </div>
    </div>
</form:form>
</body>
</html>