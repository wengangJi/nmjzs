<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
  <title>课件列表</title>
  <meta name="decorator" content="default"/>
  <%@include file="/WEB-INF/views/include/dialog.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
  <li class="active"><a href="#">课件列表</a></li>
<%--
  <li><a href="${ctx}/lesson/lessonForm?lessonId=${lesson.lessonId}">课件${not empty lesson.lessonId?'修改':'添加'}</a></li>
--%>
</ul>
<form:form id="searchForm" modelAttribute="course" action="${ctx}/course/findCourseList/" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
  <input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
  <div>

    <label>项目：</label><form:select path="planId" id="planId" cssClass="required"><form:option value=""></form:option><form:options items="${planList}" itemLabel="planName" itemValue="planId" htmlEscape="false"/></form:select>&nbsp;
    <label>课程：</label><form:select path="courseId" id="courseId" cssClass="required"><form:options items="${courseList}" itemLabel="courseName" itemValue="courseId" htmlEscape="false"/></form:select>&nbsp;
<%--
    <label>课件名称：</label><form:input path="lessonName" htmlEscape="false" maxlength="50" class="input-small"/>
--%>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
  </div>
</form:form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-hover table-bordered table-condensed">
  <thead><tr><th>项目计划</th><th>项目课程</th><th>操作</th></tr></thead>
  <tbody>
  <c:forEach items="${page.list}" var="item">
    <tr>
      <td>${fns:getPlanById(item.planId).planName}</td>
      <td>${item.courseName}</td>
     <td>
<%--
        <a href="${ctx}/lesson/lessonForm?lessonId=${item.id}">修改</a>
--%>
        <a href="${ctx}/course/deleteCourseById?id=${item.id}" onclick="return confirmx('确认要解除该项目与课程的绑定关系吗？', this.href)">解除绑定</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
<div class="pagination">${page}</div>

<script type="text/javascript">

  //页面加载完成干的事
  $(document).ready(function () {
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

  }); // end ---$(document)
  function page(n,s){
    $("#pageNo").val(n);
    $("#pageSize").val(s);
    $("#searchForm").attr("action","${ctx}/course/findCourseList/");
    $("#searchForm").submit();
    return false;
  }

</script>



</body>
</html>
