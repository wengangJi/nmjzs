<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>模板配置初始化</title>
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
    <li><a href="${ctx}/print/list">模板列表</a></li>
    <li class="active"><a href="${ctx}/print/init/">模板新增</a></li>
    <li><a href="${ctx}/print/form">模板元素增加</a></li>
</ul>
<form:form id="inputForm" modelAttribute="printTemplate" action="${ctx}/print/initSave" method="post" class="form-horizontal">
    <tags:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">证书类型：</label>
        <div class="controls">
            <form:select path="certType" >
                <form:options items="${fns:getDictList('APP_ID')}" itemLabel="label" itemValue="value" htmlEscape="false" />
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">申请类型：</label>
        <div class="controls">
            <form:select path="soType" >
                <form:options items="${fns:getDictList('SO_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false" />
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">打印页码：</label>
        <div class="controls">
            <form:input  path="pageNum"  class="required digits" />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">字体：</label>
        <div class="controls">
<%--            <form:input  path="paraCode1"  class="required " />--%>
            <form:select path="paraCode1" class="required" >
                <form:option value="宋体">宋体</form:option>
                <form:option value="黑体">黑体</form:option>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">字体大小：</label>
        <div class="controls">
            <form:input  path="paraCode2"  class="required digits" placeholder="字体大小，单位（pt）"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">打印宽度：</label>
        <div class="controls">
            <form:input  path="paraCode3"  class="required digits" placeholder="打印宽度，单位（px）"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">打印高度：</label>
        <div class="controls">
            <form:input  path="paraCode4"  class="required digits" placeholder="打印高度，单位（px）"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">背景图片：</label>
        <div class="controls">
            <form:input  path="paraName"  class="required " placeholder="背景图片路径" />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">任务名称：</label>
        <div class="controls">
            <form:input  path="paraCode5"  class="required " placeholder="打印任务名称"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">纸张宽度：</label>
        <div class="controls">
            <form:input  path="paraCode6"  class="required number" placeholder="纸张宽度，单位（0.1mm）"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">纸张高度：</label>
        <div class="controls">
            <form:input  path="paraCode7"  class="required number" placeholder="纸张高度，单位（0.1mm）"/>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>

</body>
</html>
