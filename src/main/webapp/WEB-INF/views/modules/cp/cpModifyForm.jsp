e<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员申报</title>
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

        function addResume(){
            var _len = $("#contentResumeTable tr").length-1;
            var _size= $("#contentResumeTable tr").length-2;
            $("#contentResumeTable").append("<tr  align='center'>" +'<td>'+_len+'</td>'
                    +" <td><input id=\"effDate\" name=\"soCpResume["+_size+"]\.effDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${effDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                    +" <td><input id=\"expDate\" name=\"soCpResume["+_size+"]\.expDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${expDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                    +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                    +"<td><input id=\"position\" name=\"soCpResume["+_size+"]\.position\" class=\"required input-medium\" type=\"text\" value=\"\">&nbsp;&nbsp;<a href='javascript:void(0)' onclick='javascript:del(this);'>删除</a></td>"
                    +"</tr>");
        };
        function del(obj) {
            var inRowIndex = obj.parentNode.parentNode.rowIndex;
            //alert(inRowIndex);
            var delRow=obj.parentNode.parentNode.parentNode;
            delRow.deleteRow(inRowIndex-1);
        }
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
    <li class="active"><a href="${ctx}/cp/soCp/cpModifyForm">证书变更</a></li>
</ul>

<form:form id="inputForm" modelAttribute="soCpEntity" action="${ctx}/cp/soCp/saveForm" method="post" class="form-horizontal">
    <tags:message content="${message}"/>
    <form:hidden path="so.companyId" value="${fns:getUser().userCompany.companyId}"/>
    <form:hidden path="so.appId" value="${Constants.GLOBAL_CP_APP_ID}" />
    <div class="tab-content">

        <!-- 基本信息-->
        <div class="tab-pane active" id="cpBase">
            <div id="div" style="  display:block width: 968px;">
                <table id="contentBaseTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr align="center">
                        <td colspan="8" style="text-align: center"><h4>三类人员安全生产考核合格证变更、遗失补办申请表</h4></td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td> <label class="control-label" style="width: 82px;">姓名</label></td>
                        <td> <form:input id="name" path="soCpBase.name" htmlEscape="false" class="required input-medium"/> </td>
                        <td> <label class="control-label" style="width: 82px;">性别</label> </td>
                        <td><form:radiobuttons id="sex" path="soCpBase.sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                        <td> <label class="control-label" style="width: 82px;">出生日期</label> </td>
                        <td>
                            <input id="birthDate" name="soCpBase.birthDate" type="text" readonly="readonly" maxlength="50"
                                   class="input-medium Wdate"
                                   value="<fmt:formatDate value="${soCpBase.birthDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </td>
                        <td><label class="control-label" style="width: 82px;">证件号</label></td>
                        <td >
                            <form:input path="soCpBase.idNo"  class="required input-medium"/>
                                <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">工作单位</label></td>
                        <td colspan="3">
                            <form:input path="soCpBase.idNo"  class="required input-medium"/>
                                <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

                        <td><label class="control-label" style="width: 82px;">联系电话</label></td>
                        <td colspan="3">
                            <form:input path="soCpBase.idNo"  class="required input-medium"/>
                                <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>
                        <td>
                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">职务</label></td>
                        <td colspan="7">
                            <form:radiobuttons path="soCpBase.personType" items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                        </td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">原证书编号</label></td>
                        <td colspan="3"   >                 <form:input path="soCpBase.idNo"  class="required input-medium"/>
                        </td>
                        <td><label class="control-label" style="width: 82px;">核发时间</label></td>
                        <td colspan="3"><form:input path="soCpBase.examScore"  class="input-medium"/></td>
                    </tr>
                    <tr >
                        <td   ><label class="control-label" style="width: 82px;">申请内容</label></td>
                        <td  colspan="3"><input type="radio" value="0"><label class="control-label" style="width: 82px;float: none;text-align:left">变更</label><input type="radio" value="0"><label class="control-label" style="width: 82px;float: none;text-align:left">遗失补办</label></td>

                        <td  ><label class="control-label" style="width: 82px;">本人签字</label></td>
                        <td  colspan="3"><form:input path="soCpBase.examScore"  class="input-medium"/></td>
                    </tr>
                   <tr>
                        <td><label class="control-label" style="width: 82px;">调出单位意见</label></td>
                        <td colspan="3"><form:textarea path="soCpBase.learnExpe" class="input-block-level" rows="4"/></td>
                        <td><label class="control-label" style="width: 82px;">调入单位意见</label></td>
                        <td colspan="3"><form:textarea path="soCpBase.learnExpe" class="input-block-level" rows="4"/></td>

                    </tr>


                    <tr>
                        <td><label class="control-label" style="width: 82px;">调出单位所在盟市级建设行政主管部门或自治区专业厅局意见</label></td>
                        <td colspan="3"><form:textarea path="soCpBase.learnExpe" class="input-block-level" rows="4"/></td>
                        <td><label class="control-label" style="width: 82px;">调入单位所在盟市级建设行政主管部门或自治区专业厅局意见</label></td>
                        <td colspan="3"><form:textarea path="soCpBase.learnExpe" class="input-block-level" rows="4"/></td>

                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">自治区建设厅意见</label> </td>
                        <td colspan="7"><form:textarea path="soCpBase.certExpe" class="input-block-level" rows="4"/></td>
                    </tr>

                    </tbody>
                </table>
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