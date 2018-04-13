e<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>二级建造师注销</title>
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
    <li class="active"><a href="${ctx}/ac/servAc/initRemoveAcForm">二级建造师注销注销</a></li>
</ul>


<form:form id="inputForm" modelAttribute="servAcInfo" action="${ctx}/ac/servAc/removeAcForm" method="post" class="form-horizontal">
    <tags:message content="${message}"/>
    <form:hidden path="certType" value="${servAcInfo.certType}"/>
    <form:hidden path="issueBy" value="${servAcInfo.issueBy}"/>
    <form:hidden path="idType" value="${servAcInfo.idType}"/>
    <form:hidden path="sex" value="${servAcInfo.sex}"/>
    <form:hidden path="gardMajor" value="${servAcInfo.gardMajor}"/>
 <form:hidden path="servid" value="${servAcInfo.servid}"/>



    <div class="tab-content">

        <!-- 基本信息-->
        <div class="tab-pane active" id="cpBase">
            <div id="div" style="  display:block width: 968px;">
                <table id="contentBaseTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr align="center">
                        <td colspan="8" style="text-align: center"><h4>二级建造师注销表</h4></td>
                    </tr>
                    </thead>
                    <tbody>

                    <tr>
                        <td> <label class="control-label" style="width: 82px;">姓名</label></td>
                        <td> <form:input id="name" path="name" htmlEscape="false" class="required input-medium" readonly="true"/> </td>
                        <td> <label class="control-label" style="width: 82px;">性别</label> </td>
                        <td><form:radiobuttons id="sex" path="sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required" disabled="true"></form:radiobuttons>
                        <td> <label class="control-label" style="width: 82px;" >出生日期</label> </td>
                        <td>

                            <input id="birthDate" name="birthDate" type="text" readonly="true" maxlength="50"
                                   class="input-medium Wdate"
                                 disabled="true"  value="<fmt:formatDate value="${servAcInfo.birthDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </td>
                        <td><label class="control-label" style="width: 82px;" readonly="true">证件号</label></td>
                        <td >
                            <form:input path="idNo"  class=" input-medium" readonly="true"/>
                            <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">工作单位</label></td>
                        <td colspan="2">
                            <form:hidden path="companyId"  value="${servAcInfo.companyId}" class="required input-medium"/>
                            <form:input path="rsrvStr3"  class="input-medium" disabled="true" value="${fns:getCompanyById(servAcInfo.companyId).companyName}"/>
                        <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

                        <td><label class="control-label" style="width: 82px;">联系人</label></td>
                        <td colspan="2">
                            <form:input path="contactPerson"  class=" input-medium" readonly="true"/>
                        </td>
                        <td><label class="control-label" style="width: 82px;">联系电话</label></td>
                        <td colspan="2">
                            <form:input path="contactPhone"  class=" input-medium" readonly="true"/>
                            <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>
                        <td>
                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">联系地址</label></td>
                        <td colspan="7">
                            <form:input path="contactAddr"  class=" input-medium" readonly="true"/>
                        </td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">资格证书编号</label></td>
                        <td colspan="3"   >                 <form:input path="certNo"  class="required input-medium" readonly="true"/>
                        </td>
                        <td><label class="control-label" style="width: 82px;">核发时间</label></td>
                        <td colspan="4"><input id="issueDate" name="issueDate" type="text"    disabled="true" maxlength="50" class="input-medium Wdate" value="<fmt:formatDate value="${servAcInfo.issueDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> </td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">注册证书编号</label></td>
                        <td colspan="3"><form:input path="regiNo"   class=" input-medium"/>  </td>
                        <td><label class="control-label" style="width: 82px;">签发日期</label></td>
                        <td colspan="4"><input id="regiDate" name="regiDate" type="text" readonly="readonly"
                                               maxlength="50" class=" input-medium Wdate"              value="<fmt:formatDate value="${servAcInfo.regiDate}" pattern="yyyy-MM-dd"/>"
                                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">继续教育证书编号</label></td>
                        <td colspan="3"><form:input path="educNo"   class=" input-medium"/> </td>
                        <td><label class="control-label" style="width: 82px;">签发日期</label></td>
                        <td colspan="4"><input id="educDate" name="educDate" type="text" readonly="readonly"
                                               maxlength="50" class=" input-medium Wdate"      value="<fmt:formatDate value="${servAcInfo.educDate}" pattern="yyyy-MM-dd"/>"
                                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>  </td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">注销原因</label> </td>
                        <td colspan="7"><form:textarea path="rsrvStr1"  class="required input-block-level" rows="4" /></td>
                    </tr>

                  <%--  <tr>
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

                    </tr>--%>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">备注</label> </td>
                        <td colspan="7"><form:textarea path="remarks" class="input-block-level" rows="4"/></td>
                    </tr>
                    </tbody>
                </table>

            </div>
        </div>

        <div class="span10" style="text-align: center;width: 1000px">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" name="submit">
            <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">
        </div>
    </div>
</form:form>
</body>
</html>