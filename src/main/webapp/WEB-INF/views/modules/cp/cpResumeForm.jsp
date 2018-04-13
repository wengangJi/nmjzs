<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作简历</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $("#addResume").click(function(){

                            var _len = $("#contentTable tr").length-6;
                            $("#contentTable").append("<tr  align='center'>"
                                                +'<td>'+_len+'</td>'
                                                +" <td><input id=\"effDate\" name=\"effDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${effDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                                    +" <td><input id=\"expDate\" name=\"expDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${expDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "

                                     +"<td><input id=\"company\" name=\"company\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                                    +"<td><input id=\"position\" name=\"position\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                                            +"</tr>");
                        })


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
      #contentTable .control-label {width: 70px;}
    </style>

</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cp/soCp/cpResumeForm">工作简历</a></li>
	</ul><br/>
    <div id="div1" style="display: block; width: 968px;">

    <form:form id="inputForm" modelAttribute="soCpResume" action="${ctx}/cp/soCp/cacheResume" method="post" class="form-horizontal">
		<tags:message content="${message}"/>
    <form:hidden path="soid"/>
    <form:hidden path="appId" value="${Constants.GLOBAL_CP_APP_ID}" />
    <form:hidden path="soType" value="${Constants.GLOBAL_SO_TYPE_SO}" />
    <form:hidden path="pageModule" value="${Constants.GLOBAL_SO_CP_RESUME_PAGE_MODULE}" />
        <table id="contentTable" class="table table-striped table-bordered table-condensed">
            <thead>
              <tr align="center"><td colspan="8" style="text-align: center"><h4>工 作 简 历</h4></td></tr>
            </thead>
            <tr style="text-align: center">
                <td>序 号</td><td>聘用开始时间</td><td>聘用结束时间</td><td>工作单位</td><td>职务</td>
            </tr>
            </thead>
            <tbody>
             <tr>
                <td colspan="5" style="text-align:right"> <input id="addResume" class="btn btn-primary" type="submit" value="添加工作简历"> </td>
            </tr>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="7" style="text-align: center">
                    <input id="btnResumeSubmit" class="btn btn-primary" type="submit" value="保存">
                    <input id="btnResumeCancel" class="btn btn-primary" type="reset" value="重置">
                </td>
            </tr>
            </tfoot>
        </table>
   </form:form>
 </div>


    <div id="div2" style="display: block; width: 968px;">

        <form:form id="inputForm" modelAttribute="soCpPerfonmance" action="${ctx}/cp/soCp/cachePerfonmance" method="post" class="form-horizontal">
            <tags:message content="${message}"/>
            <form:hidden path="soid"/>
            <form:hidden path="appId" value="${Constants.GLOBAL_CP_APP_ID}" />
            <form:hidden path="soType" value="${Constants.GLOBAL_SO_TYPE_SO}" />
            <form:hidden path="pageModule" value="${Constants.GLOBAL_SO_CP_RESUME_PAGE_MODULE}" />
            <table id="contentTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr><td colspan="5" style="text-align: center"><h4>安 全 生 产 业 绩</h4></td></tr>
                <tr>
                    <td><label class="control-label">受表彰情况</label></td> <td colspan="4">
                    <form:textarea path="honorCase" class="required input-block-level" rows="4"/></td>
                </tr>
                <tr>
                    <td><label class="control-label">受处罚情况</label></td> <td colspan="4">
                    <form:textarea path="penaltyCase" class="input-block-level" rows="4"/></td>
                </tr>

                </tbody>
                <tfoot>
                <tr>
                    <td colspan="7" style="text-align: center">
                        <input id="btnPerfonmanceSubmit" class="btn btn-primary" type="submit" value="保存">
                        <input id="btnPerfonmanceCancel" class="btn btn-primary" type="reset" value="重置">
                    </td>
                </tr>
                </tfoot>

            </table>
        </form:form>
    </div>

</body>
</html>