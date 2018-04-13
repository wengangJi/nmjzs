<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>课程管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
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

            $("#yearSel").change(function () {
                var year = $("#yearSel").val();
                $.ajax({
                    type: "POST",//提交方式
                    url: "${ctx}/plan/getPlanByYear",//获取数据的函数
                    data: "year=" + year,//查询条件
                    error: function () { alert("服务器异常") },//查询失败
                    success: function (data) {//查询成功,data为返回的数据
                        $("#planId option").remove();//先清除数据
                        $("#planId").select2().select2("val", null);
                        data = eval('(' + data + ')');
                        for (i=0; i< data.length; i++) {
                            $("#planId").append("<option value=" + data[i].planId + ">" + data[i].planName + "</option>");//赋值
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/course/list/">课程列表</a></li>
    <shiro:hasPermission name="course:edit">
       <li class="active"><a href="${ctx}/course/courseForm?id=${course.courseId}">课程${not empty course.courseId?'修改':'添加'}</a></li>
    </shiro:hasPermission>
</ul><br/>
<form:form id="inputForm" modelAttribute="courseCenter" action="${ctx}/course/save" method="post" class="form-horizontal">
    <form:hidden path="courseId" />
    <tags:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">课程类型:</label>
        <div class="controls">
            <form:select path="courseType" class="required input-medium">
                <form:options items="${fns:getDictList('COURSE_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">专业:</label>
        <div class="controls">
            <form:select path="majorId" class="required input-medium">
                <form:options items="${fns:getDictList('COURSE_MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">课程名称:</label>
        <div class="controls">
            <form:input path="courseName" htmlEscape="false" maxlength="200" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">课程封面:</label>
        <div class="controls">
            <tags:headPhoto id="imagePath" name="imagePath" value="${course.imagePath}" height="300" width="400"></tags:headPhoto>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">学时:</label>
        <div class="controls">
            <form:input path="courseHours" htmlEscape="false" class="required number"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">讲师:</label>
        <div class="controls">
            <form:input path="teacherName" htmlEscape="false" maxlength="50" class="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">讲师介绍:</label>
        <div class="controls">
            <form:textarea path="teacherInfo" htmlEscape="false" rows="3" maxlength="1000" class="required input-xlarge"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">课程介绍:</label>
        <div class="controls">
            <form:textarea path="courseInfo" htmlEscape="false" rows="3" maxlength="1000" class="required input-xlarge"/>
        </div>
    </div>

    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" name="submit"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>