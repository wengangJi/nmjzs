<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>三类人员申报详细信息</title>
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
	<%--<ul class="nav nav-tabs">
		<li><a href="${ctx}/cp/personnel/soCpInfo">申报详细信息</a></li>
	</ul><br/>--%>
    <ul class="nav nav-tabs" id="cpSoInfoPage">
        <li class="active"><a href="#cpTitle" data-toggle="tab">首页申请信息</a></li>
        <li><a href="#cpBase" data-toggle="tab">基本信息</a></li>
        <li><a href="#cpResume" data-toggle="tab">简历信息</a></li>
        <li><a href="#cpAppr" data-toggle="tab">审核信息</a></li>
        <li><a href="#cpUpload" data-toggle="tab">附件信息</a></li>



    </ul>
	<form:form id="inputForm" modelAttribute="so" action="${ctx}/cp/soCp/soCpInfo" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
  <div class="tab-content">
    <div class="tab-pane active" id="cpTitle">
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
                   <%-- <tags:commonselect id="companyId" name="companyId" value="${companyId}" labelName="companyName"
                                       labelValue="" title="企业" url="${ctx}/comp/company/findByName"/>--%>
                       <%--<form:input path="companyId"  value="${fns:getCompanyById(so.companyId).companyName}" class="input-medium" disabled ="true"/>--%>
                           ${fns:getCompanyById(so.companyId).companyName}
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">申请人姓名:</label>

                <div class="controls">
                   <%-- <form:input path="applPerson" class="required input-medium" disabled ="true" />--%>
                    ${so.applPerson}
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">身份证件号:</label>

                <div class="controls">
                   <%-- <form:input path="applIdNo"  class="required input-medium" disabled ="true"/>--%>
                    ${so.applIdNo}
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">申请时间:</label>

               &nbsp;<fmt:formatDate value="${so.applDate}" type="date" />

            </div>
            <div class="control-group">
                <label class="control-label">申报批次:</label>

                <div class="controls">
                        ${fns:getBatchInfoByBatchId(so.batchId).batchName}
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">申报类别:</label>

                <div class="controls">
                    ${fns:getDictLabel(so.soType, 'SO_TYPE', '')}

                </div>
            </div>
        </div>
        <div class="span10">
            <p style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
                内蒙古自治区建设厅编制
            </p>
            <div style="text-align: center;">
                <input id="biuuu_button" type="button" value="打 印" class="btn"/>
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </div>

   </div>

        <!-- 基本信息-->
        <div class="tab-pane" id="cpBase">
            <iframe id="cpBaseFrame" name="cpBaseFrame" src="${ctx}/cp/soCp/cpBasePage?soid=${so.soid}" style="overflow:visible;"
                    scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
        </div>

        <!-- 简历信息-->
        <div class="tab-pane" id="cpResume">
            <iframe id="cpResumeFrame" name="cpResumeFrame" src="${ctx}/cp/soCp/cpResumePage?soid=${so.soid}" style="overflow:visible;"
                    scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
        </div>

        <!-- 审核信息-->
        <div class="tab-pane" id="cpAppr">
            <iframe id="cpApprFrame" name="cpApprFrame" src="${ctx}/cp/soCp/cpApprPage?soid=${so.soid}" style="overflow:visible;"
                    scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
        </div>

      <!-- 附件信息-->
      <div class="tab-pane" id="cpUpload">
          <iframe id="cpUploadFrame" name="cpUploadFrame" src="${ctx}/cp/soCp/cpUploadPage?soid=${so.soid}" style="overflow:visible;"
                  scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
      </div>

    </form:form>
  </div>


</body>
</html>