<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>模板配置</title>
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
    <li><a href="${ctx}/print/init/">模板新增</a></li>
    <li class="active"><a href="${ctx}/print/form">模板元素增加</a></li>
</ul>
<form:form id="inputForm" modelAttribute="printTemplate" action="${ctx}/print/save" method="post" class="form-horizontal">
    <tags:message content="${message}"/>
    <form:hidden path="id"/>
<%--    <div class="control-group">
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
    </div>--%>
    <div class="control-group">
        <label class="control-label">打印页：</label>
        <div class="controls">
            <form:input  path="pageNum"  class="required " />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">索引顺序：</label>
        <div class="controls">
            <form:input  path="indexItem"  class="required " />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">参数类型：</label>
        <div class="controls">
            <form:select path="paraType" class="required" >
                <form:option value="ADD_PRINT_TEXT">ADD_PRINT_TEXT</form:option>
                <form:option value="ADD_PRINT_SETUP_BKIMG">ADD_PRINT_SETUP_BKIMG</form:option>
                <form:option value="PRINT_INITA">PRINT_INITA</form:option>
                <form:option value="SET_PRINT_MODE">SET_PRINT_MODE</form:option>
                <form:option value="SET_PRINT_STYLE">SET_PRINT_STYLE</form:option>
                <form:option value="SET_PRINT_STYLEA">SET_PRINT_STYLEA</form:option>
                <form:option value="SET_PRINT_PAGESIZE">SET_PRINT_PAGESIZE</form:option>
                <form:option value="SET_SHOW_MODE">SET_SHOW_MODE</form:option>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">参数数量：</label>
        <div class="controls">
            <form:input  path="paraNum"  class="required " />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">参数名：</label>
        <div class="controls">
            <form:input  path="paraName"  class="required " />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE1：</label>
        <div class="controls">
            <form:input  path="paraCode1" />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE2：</label>
        <div class="controls">
            <form:input  path="paraCode2"   />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE3：</label>
        <div class="controls">
            <form:input  path="paraCode3"   />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE4：</label>
        <div class="controls">
            <form:input  path="paraCode4"  />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE5：</label>
        <div class="controls">
            <form:input  path="paraCode5"  />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE6：</label>
        <div class="controls">
            <form:input  path="paraCode6" />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE7：</label>
        <div class="controls">
            <form:input  path="paraCode7"  />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE8：</label>
        <div class="controls">
            <form:input  path="paraCode8" />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE9：</label>
        <div class="controls">
            <form:input  path="paraCode9"  />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PARA_CODE10：</label>
        <div class="controls">
            <form:input  path="paraCode10"  />
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>
