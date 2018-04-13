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
    <li class="active"><a href="#">证书注销信息</a></li>
</ul>


<form:form id="inputForm" modelAttribute="soCpEntity" action="${ctx}/cp/soCp/saveRemoveForm" method="post" class="form-horizontal">
    <tags:message content="${message}"/>
    <div class="tab-content">

        <!-- 基本信息-->
        <div class="tab-pane active" id="cpBase">
            <div id="div" style="  display:block width: 968px;">
                <table id="contentBaseTable" class="table  table-bordered table-condensed table-hover">
                    <thead>
                    <tr align="center">
                        <td colspan="8" style="text-align: center"><h4>三类人员安全生产考核合格证书注销申请表</h4></td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td> <label class="control-label" style="width: 82px;">姓名</label></td>
                        <td> ${soCpEntity.soCpBase.name}</td>
                        <td> <label class="control-label" style="width: 82px;">性别</label> </td>
                        <td>${fns:getDictLabel(soCpEntity.soCpBase.sex, 'SEX', '')}</td>
                        <td> <label class="control-label" style="width: 82px;" >出生日期</label> </td>
                        <td>
                            <fmt:formatDate value="${soCpEntity.soCpBase.birthDate}" type="date"/> </td>
                        <td><label class="control-label" style="width: 82px;" readonly="true">证件号</label></td>
                        <td> ${soCpEntity.soCpBase.idNo}</td>
                    </tr>
                     <tr>
                        <td><label class="control-label" style="width: 82px;">工作单位</label></td>
                        <td colspan="3">${fns:getCompanyById(soCpEntity.soCpBase.companyId).companyName}</td>

                        <td><label class="control-label" style="width: 82px;">联系电话</label></td>
                        <td colspan="3">${soCpEntity.soCpBase.telephone} </td>
                        <td>
                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">职务</label></td>
                        <td colspan="7">
                                ${fns:getDictLabel(soCpEntity.soCpBase.personType, 'PERSON_TYPE', '')}

                        </td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">证书编号</label></td>
                        <td colspan="3"   > ${soCpEntity.soMainCert.certNo}
                        </td>
                        <td><label class="control-label" style="width: 82px;">核发时间</label></td>
                        <td colspan="3">    <fmt:formatDate value="${soCpEntity.soMainCert.issueDate}" type="date"/> </td>
                        </td>
                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">注销原因</label> </td>
                        <td colspan="7">${soCpEntity.so.rsrvStr1}</br></br></br></td>
                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">注销人诚信证明</label> </td>
                        <td colspan="7">此注销手续已经本人同意并核实，保证其真实性，如有不实以及因此造成的一切后果由本人承担。</br></br></br>
                            </br><span style="float: left; height: 20px;margin-right: 50px;">负责人(签字)：<img src="${ctxStatic}/images/li.png"/></span>
                            <span style='float: right;height: 95px; width: 95px;margin-right: 50px; background:url("${ctxStatic}/images/jst.png")'> <h6>单 位 (公章)：</h6></span>

                        </td>
                    </tr>


                    <tr>
                            <td><label class="control-label" style="width: 82px;">单位意见</label></td>
                            <td colspan="3">
                                <c:forEach items="${soCpEntity.soCpApprove}" var="soCpApprove">
                                    <c:if test="${soCpApprove.apprType eq '02' }" >
                                    ${soCpApprove.content}<span style="float: right"></br></br></br></br><h6>${fns:getYear(soCpApprove.apprDate)}年${fns:getMonth(soCpApprove.apprDate)}月${fns:getDay(soCpApprove.apprDate)}日&nbsp;&nbsp;</h6></span>
                                   </c:if>
                               </c:forEach>
                            </td>

                        <td><label class="control-label" style="width: 82px;">单位所在地县级建设行政主管部门意见</label></td>
                        <td colspan="3">
                                <span style="float: right"></br></br></br></br><h6>年  月  日</h6></span>
                        </td>

                    </tr>
                    <tr>
                        <td><label class="control-label" style="width: 82px;">单位所在地市级建设行政主管部门意见</label></td>
                        <td colspan="3">
                            <c:forEach items="${soCpEntity.soCpApprove}" var="soCpApprove">
                            <c:if test="${soCpApprove.apprType eq '01' and soCpApprove.taskName eq '盟市分管局长审核' }" >
                                ${soCpApprove.content}<span style="float: right"></br></br></br></br><h6>${fns:getYear(soCpApprove.apprDate)}年${fns:getMonth(soCpApprove.apprDate)}月${fns:getDay(soCpApprove.apprDate)}日&nbsp;&nbsp;</h6></span>
                            </c:if>
                            <c:if test="${soCpApprove.apprType ne '01'and soCpApprove.taskName eq '盟市分管局长审核' }" >
                                <span style="float: right"></br></br></br></br><h6>年  月  日</h6></span>
                            </c:if>
                            </c:forEach>
                        </td>
                        <td><label class="control-label" style="width: 82px;">省级建设行政主管部门意见</label></td>
                        <td colspan="3">
                            <c:forEach items="${soCpEntity.soCpApprove}" var="soCpApprove">
                            <c:if test="${soCpApprove.apprType eq '00' and soCpApprove.taskName eq '厅长审核' }" >
                                ${soCpApprove.content}<span style="float: right"></br></br></br></br><h6>${fns:getYear(soCpApprove.apprDate)}年${fns:getMonth(soCpApprove.apprDate)}月${fns:getDay(soCpApprove.apprDate)}日&nbsp;&nbsp;</h6></span>
                            </c:if>
                            <c:if test="${soCpApprove.apprType ne '00' and soCpApprove.taskName eq '厅长审核' }" >
                                <span style="float: right"></br></br></br></br><h6>年  月  日</h6></span>
                            </c:if>
                            </c:forEach>
                        </td>

                    </tr>

                    <tr>
                        <td><label class="control-label" style="width: 82px;">备注</label> </td>
                        <td colspan="7">${soCpEntity.so.remarks}</br></br></br></br></td>
                    </tr>
                    </tbody>
                </table>
                注：注销手续需提供三类人员证书原件和复印件，如申请人劳动关系已经不在三类证书上所标注单位，并且原单位不愿意给予盖章证明，则申请人必须提供劳动合同原价和复印件，并由现劳动关系所在单位给予盖章证明

            </div>
        </div>

        <div style="text-align: center;">
            <input id="biuuu_button" type="button" value="打 印" class="btn"/>
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
    </div>
</form:form>
</body>
</html>