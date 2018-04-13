<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>填写说明</title>
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cp/soCp/cpDescForm">填写说明</a></li>
	</ul><br/>
	<form:form id="inputForm"  action="${ctx}/cp/soCp/cacheDesc" method="post" class="form-horizontal">
		<tags:message content="${message}"/>

        <div id="div2" style=" background-color: #f9f9f9; display: block;width: 968px;">
            <span style='text-align: center; margin-left: 450px;font-family:"微软雅黑"'> <h3>填  写  说  明</h3></span>

            <ul style="list-style-type:none;font-size: 16px;" >

                <li>
                    1、本申请表所有内容必须由申请人及所在单位如实填写，内容要具体，申请表封面应有申请人签名，所在单位签署意见并加盖公章。
                </li>
                <li style="margin-top: 5px;">
                    2、封面部分“申请人姓名”一栏由申请人用兰色或黑色钢笔或签字笔签名。申请人如果是首次申请，请在“首次申请”后的方括号内打钩，如果是延期申请，请在“延期申请”后的方括号内打钩。
                </li>
                <li style="margin-top: 5px;">
                    3、“基本情况”部分，“专业”、“学历”栏中应填写符合考核条件的专业、学历，未获得学位的，不应自行填写学位；“证件类型”首次申请的在身份证前打“√”，申请延期的在“考核合格证书”前打“√”。“执业资格”应由项目负责人填写取得建筑施工企业项目经理资质证书或建造师执业资格证书情况。
                </li>
                <li style="margin-top: 5px;">
                    4、“工作简历”、“安全生产业绩”应按时间顺序分别填写，“工作简历”一项最多填写五项；“安全生产业绩”栏的“受处罚情况”填写主要为事故处罚情况。
                </li>
                <li style="margin-top: 5px;">
                    5、“证书使用情况”填写证书被注销、变更和延期等情况。
                </li>
                <li style="margin-top: 15px;" align="center">
                    <input id="btnSubmit"  class="btn btn-primary" type="submit" value="下一步">
                </li>


            </ul>
        </div>
	</form:form>
</body>
</html>