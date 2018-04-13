<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
  <title>培训列表</title>
  <meta name="decorator" content="default"/>
  <%@include file="/WEB-INF/views/include/dialog.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
  <li class="active"><a href="${ctx}/plan/list/">培训列表</a></li>
  <li><a href="${ctx}/plan/planForm?planId=${planId}">培训${not empty planId?'修改':'添加'}</a></li>
</ul>
<form:form id="searchForm" modelAttribute="plan" action="${ctx}/plan/list/" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
  <input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
  <div>
   <%-- <label>年份：</label>
    <form:select path="year" id="yearSel" cssClass="required input-small">
       <form:option value=""/>
      <form:options items="${fns:getDictList('YEAR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
    </form:select>&nbsp;--%>
    <label>培训名称：</label><form:input path="planName" htmlEscape="false" maxlength="50" class="input-small"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
  </div>
</form:form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
  <thead><tr><%--<th>年度</th>--%><th>项目名称</th><th>项目类型</th><th>专业</th><th>学时</th><th>价格</th><th>所属地市</th><th>项目状态</th><shiro:hasPermission name="plan:edit"><th>操作</th></shiro:hasPermission></tr></thead>
  <tbody>
  <c:forEach items="${page.list}" var="item">
    <tr>
      <%--<td>${item.year}(年度)</td>--%>
      <td>${item.planName}</td>
      <td>${fns:getDictLabel(item.planType, 'PLAN_TYPE', '')}</td>
      <td>${fns:getDictLabel(item.majorId, 'MAJOR', '')}</td>
      <td>${item.planHours}(学时)</td>
      <td>${item.charge}(元)</td>
      <td>${fns:getDictLabel(item.localId, 'LOCAL_ID', '')}</td>
      <td>${fns:getDictLabel(item.sts, 'AUDIT_STS', '')}</td>
      <shiro:hasPermission name="plan:edit">
        <td>
          <a href="${ctx}/plan/planForm?planId=${item.planId}">修改</a>
<%--
          <a href="${ctx}/plan/auditPlan?planId=${item.planId}">发布</a>
--%>
          <a href="${ctx}/plan/removePlan?planId=${item.planId}" onclick="return confirmx('确认要删除该培训吗？', this.href)">作废</a>
        </td>
      </shiro:hasPermission>
    </tr>
  </c:forEach>
  </tbody>
</table>
<div class="pagination">${page}</div>

<script type="text/javascript">

  //页面加载完成干的事
  $(document).ready(function () {

  }); // end ---$(document)
  function page(n,s){
    $("#pageNo").val(n);
    $("#pageSize").val(s);
    $("#searchForm").attr("action","${ctx}/plan/list/");
    $("#searchForm").submit();
    return false;
  }

</script>



</body>
</html>
