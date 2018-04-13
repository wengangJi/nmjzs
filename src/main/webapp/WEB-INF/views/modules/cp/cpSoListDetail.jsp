<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>三类人员审核历史</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		function auditPass(isPass) {
			top.$.jBox.confirm("确认提交数据？","系统提示",function(v,h,f){
			    if (v == 'ok') {
					$("#pass").val(isPass);
					$("#inputForm").submit();
			    }
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cp/assess/queryDetail?soid=${soAssess.so.soid}">审核历史</a></li>
	</ul>

    <c:if  test="${not empty soCpApproves}">
        <table id="contentTable" class="table table-striped table-bordered table-condensed">
            <thead><tr>
                <th>环节名称</th>
                <th>审批人</th>
                <th>审批意见</th>
                <th>审批时间</th>
            </tr></thead>
            <tbody>
            <c:forEach items="${soCpApproves}" var="approve">
                <tr>
                    <td>${approve.taskName}</td>
                    <td>${fns:getUserById(approve.apprUserId).name}</td>
                    <td>${approve.content}</td>
                    <td><fmt:formatDate value="${approve.apprDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <div class="form-actions">
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)" />
    </div>
</body>
</html>
