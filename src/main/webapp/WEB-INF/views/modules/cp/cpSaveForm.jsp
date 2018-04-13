<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>三类人员申报提交</title>
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cp/soCp/cpSaveForm">三类人员申报保存</a></li>
	</ul><br/>
  <tags:message content="${message}"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead><tr><th>批次号</th><th>模块</th><th>申报业务</th><th>申报人</th><th>申报人证件号</th><th>申报时间</th><th>申报类别</th><th>联系电话</th></tr></thead>
        <tbody>

            <tr>
                <td>${soCache.so.batchId}</td>
                <td>${fns:getDictLabel(soCache.so.appId, 'APP_ID', '')}</td>
                <td>${fns:getDictLabel(soCache.so.soType, 'SO_TYPE', '')}</td>
                <td>${soCache.so.applPerson}</td>
                <td>${soCache.so.applIdNo}</td>
                <td><fmt:formatDate value="${soCache.so.applDate}" type="date"/></td>
                <td>${fns:getDictLabel(soCache.soCpBase.personType, 'PERSON_TYPE', '')}</td>
                <td>${soCache.soCpBase.telephone}</td>
            </tr>
        </tbody>
    </table>
    <div class="pagination">${page}</div>
	<form:form id="inputForm" modelAttribute="so" action="${ctx}/cp/soCp/save" method="post" class="form-horizontal">
        <form:hidden path="soid"  />
        <form:hidden path="appId" value="${Constants.GLOBAL_CP_APP_ID}" />
        <form:hidden path="soType" value= "${Constants.GLOBAL_SO_TYPE_SO}" />
        <tags:message content="${message}"/>
           <div id="div" style="  display:block width: 968px;">
            <table id="contentTable2" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr align="center">
                    <td colspan="6" style="text-align: center"><h4>申报提交</h4></td>
                </tr>
                </thead>
                <h6 style="color: red"> 以上是您申报填报信息  ，确认后请点击保存申报按钮进行业务保存，若暂不保存，请点击作废申报进行申报作废，作废后的申报不可恢复。保存后申报尚未上报至审核单位，若要上报请到申报提交页面进行业务提交上报。</h6></br>
               <tfoot>
               <tr>
                    <td colspan="7" style="text-align: center">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value=" 保存申报">
                        <a href="${ctx}/cp/soCp/remove?appId=${Constants.GLOBAL_CP_APP_ID}&soType=${Constants.GLOBAL_SO_TYPE_SO}" type="button" class="btn btn-primary" onclick="return confirmx('确认作废该申报吗？', this.href)">作废申报</a>

                    </td>
                </tr>
               </tfoot>
            </table>
        </div>
    </form:form>
</body>
</html>