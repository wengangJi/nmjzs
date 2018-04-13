<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>安全许可管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	/*
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
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
*/
		$(document).ready(function() {
            var $validator = $("#inputForm").validate({
                rules: {
                    emailfield: {
                        required: true,
                        email: true,
                        minlength: 3
                    },
                    namefield: {
                        required: true,
                        minlength: 3
                    },
                    urlfield: {
                        required: true,
                        minlength: 3,
                        url: true
                    }
                }
            });

            $('#rootwizard').bootstrapWizard({
                'tabClass': 'nav nav-pills',
                'onNext': function(tab, navigation, index) {
                    var $valid = $("#commentForm").valid();
                    if(!$valid) {
                        $validator.focusInvalid();
                        return false;
                    }
                }
            });
        });
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/se/safe/">安全许可列表</a></li>
		<li class="active"><a href="${ctx}/se/safe/form?id=${safe.id}">安全许可<shiro:hasPermission name="se:safe:edit">${not empty safe.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="se:safe:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="safe" action="${ctx}/se/safe/save" method="post" class="form-horizontal">
        <div id="rootwizard">
            <ul>
                <li><a href="#tab1" data-toggle="tab">企业基本状况</a></li>
                <li><a href="#tab2" data-toggle="tab">企业经历简介</a></li>
                <li><a href="#tab3" data-toggle="tab">企业技术负责人简历</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane" id="tab1">
                    <table style="border: 1px;">
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">企业名称：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">注册地址及邮箱：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">营业执照注册号：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">经济类型：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">首次批准资质时间：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">电子邮箱：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">职工年平均人数：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td rowspan="3">
                                资质类别及等级
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">主项资质：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">增项资质：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">资质证书编号：</label>
                                    <div class="controls">
                                        <input type="text" name="company" class="required">
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="tab-pane" id="tab2">
                    <fieldset>
                        <legend>法定代表人</legend>


                        <div class="row control-group">
                            <div class="span4">
                                <label>姓名：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span4">
                                <label>性别：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span4">
                                <label>身份证号：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>职务：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>职称：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>最高学历：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>专业：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>固定电话：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>移动电话：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>安全生产考核合格发证单位：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>发证时间：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>证书编号：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>证书有效期：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <legend>经理</legend>
                        <div class="row control-group">
                            <div class="span4">
                                <label>姓名：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span4">
                                <label>性别：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span4">
                                <label>身份证号：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>职务：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>职称：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>最高学历：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>专业：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>固定电话：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>移动电话：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>安全生产考核合格发证单位：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>发证时间：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>证书编号：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>证书有效期：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <legend>分管安全生产经理</legend>
                        <div class="row control-group">
                            <div class="span4">
                                <label>姓名：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span4">
                                <label>性别：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span4">
                                <label>身份证号：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>职务：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>职称：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>最高学历：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>专业：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>固定电话：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>移动电话：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>安全生产考核合格发证单位：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>发证时间：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                        <div class="row control-group">
                            <div class="span6">
                                <label>证书编号：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                            <div class="span6">
                                <label>证书有效期：</label>
                                <input type="text" name="urlfield" class="required ">
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="tab-pane" id="tab3">
                    3
                </div>
                <ul class="pager wizard">
                    <li class="previous first" style="display:none;"><a href="#">First</a></li>
                    <li class="previous"><a href="#">上一步</a></li>
                    <li class="next last" style="display:none;"><a href="#">Last</a></li>
                    <li class="next"><a href="#">下一步</a></li>
                </ul>
            </div>
        </div>
		<div class="form-actions">
			<shiro:hasPermission name="se:safe:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
