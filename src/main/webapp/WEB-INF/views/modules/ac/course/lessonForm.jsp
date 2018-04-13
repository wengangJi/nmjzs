<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>课件管理</title>
  <meta name="decorator" content="default"/>
  <%@include file="/WEB-INF/views/include/dialog.jsp" %>
  <!-- blueimp Gallery styles -->
  <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/blueimp-gallery.min.css">
  <!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
  <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload.css">
  <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-ui.css">
  <!-- CSS adjustments for browsers with JavaScript disabled -->
  <noscript><link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-noscript.css"></noscript>
  <noscript><link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/jquery.fileupload-ui-noscript.css"></noscript>
  <script type="text/javascript">
    $(document).ready(function() {
      $("#inputForm").validate({
        submitHandler: function(form){
          if ($.isBlank($("#fileUrl").val())) {
            $.jBox.error("您还没有上传课件，请上传课件！");
            return false;
          }
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
            $("#planId").append("<option value=''></option>");//赋值
            $("#planId").select2().select2("val", "");
            $("#courseId option").remove();//先清除数据
            $("#courseId").select2().select2("val", "");
            data = eval('(' + data + ')');
            for (i=0; i< data.length; i++) {
              $("#planId").append("<option value=" + data[i].planId + ">" + data[i].planName + "</option>");//赋值
            }
          }
        });
      });

      $("#planId").change(function () {
        var planId = $("#planId").val();
        $.ajax({
          type: "POST",//提交方式
          url: "${ctx}/course/getCourseByPlan",//获取数据的函数
          data: "planId=" + planId,//查询条件
          error: function () { alert("服务器异常") },//查询失败
          success: function (data) {//查询成功,data为返回的数据
            $("#courseId option").remove();//先清除数据
            $("#courseId").append("<option value=''></option>");//赋值
            $("#courseId").select2().select2("val", "");
            data = eval('(' + data + ')');
            for (i=0; i< data.length; i++) {
              $("#courseId").append("<option value=" + data[i].courseId + ">" + data[i].courseName + "</option>");//赋值
            }
          }
        });
      });
    });
  </script>
</head>
<body>
<ul class="nav nav-tabs">
  <li class="active"><a href="#">课件添加</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="lesson" action="${ctx}/lesson/save" method="post" class="form-horizontal" enctype="multipart/form-data">
  <tags:message content="${message}"/>
  <form:hidden path="lessonId"/>
  <form:hidden path="course.courseId"/>
  <form:hidden path="payTag" value="1"/>
  <%--<div class="control-group">
    <label class="control-label">选择年度:</label>
    <div class="controls">
      <form:select path="course.plan.year" id="yearSel" cssClass="required" disabled="${disabled eq 'true' ? true : false}">
        <form:options items="${fns:getDictList('YEAR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
      </form:select>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">归属计划:</label>
    <div class="controls">
      <form:select path="course.plan.planId" id="planId" cssClass="required" disabled="${disabled eq 'true' ? true : false}">
        <form:option value=""></form:option>
        <form:options items="${planList}" itemValue="planId" itemLabel="planName"/>
      </form:select>
    </div>
  </div>--%>
  <div class="control-group">
    <label class="control-label">归属课程:</label>
    <div class="controls">
        <form:hidden path="courseId" value="${lesson.courseCenter.courseId}"/>
        <form:input path="courseId" htmlEscape="false" maxlength="200"  value="${lesson.courseCenter.courseName}" disabled="true"/>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">课件名称:</label>
    <div class="controls">
      <form:input path="lessonName" htmlEscape="false" maxlength="200" class="required"/>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">排序:</label>
    <div class="controls">
      <form:input path="showIndex" htmlEscape="false" class="required digits"/>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">课件学时:</label>
    <div class="controls">
      <form:input path="playTime" htmlEscape="false" class="required number"/>（学时）
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">内容介绍:</label>
    <div class="controls">
      <form:textarea path="lessonInfo" htmlEscape="false" rows="3" maxlength="1000" class="required input-xlarge"/>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">上传课件:</label>
    <div class="controls">
      <form:hidden path="fileUrl" id="fileUrl" cssClass="required"/>
      <span class="btn btn-success fileinput-button">
        <i class="icon-plus icon-white"></i>
        <span>添加文件...</span>
        <input type="file" id="fileupload" name="files[]" multiple >
      </span>
      <br>
      <br>
      <div id="progress" class="progress progress-striped active">
        <div class="bar" style="width: 0%;"><span class="sr-only">0%</span></div>
      </div>
    </div>
  </div>

  <div class="form-actions">
    <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" name="submit"/>&nbsp;
    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
  </div>
</form:form>
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="${ctxStatic}/jquery-upload/js/vendor/jquery.ui.widget.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="${ctxStatic}/jquery-upload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="${ctxStatic}/jquery-upload/js/jquery.fileupload.js"></script>
<script>
  $(function () {
    'use strict';
    // Change this to the location of your server-side upload handler:
    var url = "${ctx}/lesson/upload";
    $('#fileupload').fileupload({
      url: url,
      dataType: 'json',
      //acceptFileTypes: /(\.|\/)(mp4|avi|rm)$/i,
      maxFileSize: 2147483648, // 2G
      send: function (e, data) {
        if (data.total > 2147483648) {
          $.jBox.error("上传文件的大小超出限制！");
          return false;
        }
      },
      done: function (e, data) {
        $("#fileUrl").val(data.result.file);
      },
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('#progress .bar').css( 'width',progress + '%').children("span").html(progress + "%");
      }
    }).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
  });
</script>
</body>
</html>