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
  <li class="active"><a href="#">列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="synJxjyCase" action="${ctx}/plan/synlist" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
  <input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
  <div>
   <%-- <label>年份：</label>
    <form:select path="year" id="yearSel" cssClass="required input-small">
       <form:option value=""/>
      <form:options items="${fns:getDictList('YEAR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
    </form:select>&nbsp;--%>
    <label>姓名：</label><form:input path="xm" htmlEscape="false" maxlength="50" class="input-small"/>
    <label>身份证号：</label><form:input path="zjhm" htmlEscape="false" maxlength="50" class="input-small"/>
    <label class="control-label" for="localId">同步状态 ：</label>
    <form:select id="localId" path="pass" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('JXJY_PASS')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

       &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
  </div>
</form:form>
<tags:message content="${message}"/>
<div class="btn-group">
    <button class="btn" id="batchSyn">批量同步</button>
</div>
<form:form id="inputForm" action="${ctx}/plan/syn" method="post" >
<table id="contentTable" class="table table-striped table-bordered table-condensed">
  <thead><tr><th><input type="checkbox" id="checkall" name="checkall"/>选择</th><th>姓名</th><th>证件号码</th><th>注册编号</th><th>专业类别</th><th>合格证编号</th><th>签发日期</th><th>必修学时</th><th>选修学时</th><th>工作单位</th><th>同步状态</th><th>反馈状态</th><th>反馈时间</th><th>操作</th></tr></thead>
  <tbody>
  <c:forEach items="${page.list}" var="item">
    <tr>
        <td><input type="checkbox"  name="seqs" value="${item.id}"/> </td>
      <td>${item.xm}</td>
      <td>${item.zjhm}</td>
      <td>${item.zcbh}</td>
      <td>${item.zylb}</td>
      <td>${item.hgzbh}</td>
      <td><fmt:formatDate value="${item.qfrq}" pattern="yyyy-MM-dd"/></td>
      <td>${item.bxxs}</td>
      <td>${item.xxxs}</td>
      <td>${item.gzdw}</td>
        <td>
        <c:if test="${item.pass eq '0'}">未同步</c:if>
        <c:if test="${item.pass eq '2'}">已同步</c:if></td>
        <td>
            <c:if test="${item.state eq '0'}">未反馈</c:if>
            <c:if test="${item.state eq '1'}">已反馈</c:if></td>
        <td><fmt:formatDate value="${item.updatedate}" pattern="yyyy-MM-dd"/></td>
        <td>
            <a href="${ctx}/plan/syn?id=${item.id}" onclick="return confirmx('确认要同步吗？', this.href)">同步</a>
        </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
 </form:form>
<div class="pagination">${page}</div>

<script type="text/javascript">

  //页面加载完成干的事
  $(document).ready(function () {

      $("#checkall").click(
              function(){
                  if(this.checked){
                      $("input[name='seqs']").attr('checked', true)
                  }else{
                      $("input[name='seqs']").attr('checked', false)
                  }
              }
      );

      $("#batchSyn").click(
              function(){
                  var flag = false;
                  $("input[name='seqs']").each(function(){
                      if(this.checked){
                          flag = true;
                      }
                  });
                  if(!flag){
                      $.jBox.error("请选择记录后操作!");
                      return false;
                  }
                  $("#inputForm").attr("action","${ctx}/plan/batchSyn");
                  $("#inputForm").submit();
              }
      );

  }); // end ---$(document)
  function page(n,s){
    $("#pageNo").val(n);
    $("#pageSize").val(s);
    $("#searchForm").attr("action","${ctx}/plan/synlist");
    $("#searchForm").submit();
    return false;
  }

</script>



</body>
</html>
