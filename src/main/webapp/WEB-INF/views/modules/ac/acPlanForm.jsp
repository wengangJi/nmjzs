<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>培训项目录入</title>
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
    <link href="${ctxStatic}/print/print.css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jqprint/jquery.jqprint-0.3.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            $("input#biuuu_button").click(function(){

                //$("div#myPrintArea").printArea();
                //$("div#myPrintArea").printPage();
                $("div#cpTitle").jqprint();

            });
        });

    </script>
    <style type="text/css">
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

<div id="rootwizard">
    <ul class="nav nav-tabs">
        <li class="active"><a href="#choosePlan" data-toggle="tab">培训项目录入</a></li>

    </ul>
<form:form id="inputForm" modelAttribute="plan" action="${ctx}/plan/saveAcForm" method="post" class="form-horizontal">
<tags:message content="${message}"/>
<div>
    <div id="saveAcForm1">
        <table id="invoiceTable" class="table table-striped table-bordered table-condensed">
            <thead>
            <tr align="center">
                <td colspan="6" style="text-align: center;font-size: 18px;">培训项目录入</td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="span1"><label class="control-label">专业类型</label></td>
                <td><form:select path="majorId" class="required input-medium">
                        <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
                <td class="span1"><label class="control-label">项目类型</label></td>
                <td><form:select path="planType" class="required input-medium">
                        <form:options items="${fns:getDictList('PLAN_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td><label class="control-label">项目年度</label></td>
                <td><form:select path="year" class="required input-medium">
                        <form:options items="${fns:getDictList('YEAR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
                <td><label class="control-label">项目地市</label></td>
                <td><form:select path="localId" class="required input-medium">
                       <form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td><label class="control-label">项目学时</label></td>
                <td><form:input path="planHours" htmlEscape="false"  class="required number input-medium"/>(学时)
                </td>
                <td><label class="control-label">课件总数</label> </td>
                <td colspan="5"><form:input path="rsrvStr3" htmlEscape="false"  class="required number input-medium"/>(课)</td>
            </tr>
            <tr>
                <td><label class="control-label">费用类型</label></td>
                <td><form:select path="chargeType" class="required input-medium">
                        <form:options items="${fns:getDictList('CHARGE_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </td>
                <td><label class="control-label">项目费用</label> </td>
                <td colspan="5"><form:input path="charge" htmlEscape="false"  class="required  number input-medium"/>(元)</td>
            </tr>

            <tr>
                <td><label class="control-label">生效时间</label></td>
                <td><input id="startDate" name="startDate" type="text"
                            maxlength="50" class=" input-medium Wdate"
                            onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                </td>
                <td><label class="control-label">失效时间</label> </td>
                <td colspan="5"><input id="endDate" name="endDate" type="text"
                                       maxlength="50" class=" input-medium Wdate"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                </td>
            </tr>
            </tbody>

            <tfoot>
            <tr>
                <td colspan="7" style="text-align: center">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" name="submit">
                    <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">
                </td>
            </tr>
            </tfoot>
        </table>
    </div>
</div>
</form:form>


</body>
</html>