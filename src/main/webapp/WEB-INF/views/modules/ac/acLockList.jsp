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
  <li class="active"><a href="${ctx}/plan/lockList">加锁列表</a></li>
</ul>
<%--<form:form id="searchForm" modelAttribute="seal" action="${ctx}/plan/lockList" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
&lt;%&ndash;  <div>

    &lt;%&ndash;<label>培训名称：</label><form:input path="planName" htmlEscape="false" maxlength="50" class="input-small"/>&ndash;%&gt;
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
  </div>&ndash;%&gt;
</form:form>--%>
<div class="btn-group">
    <button class="btn" id="batchAssBtn">批量解锁</button>
</div>
<tags:message content="${message}"/>
<form:form id="inputForm" action="${ctx}/plan/removeBatchLock" method="post" >
<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
<table id="contentTable" class="table table-hover table-bordered table-condensed">
  <thead><tr> <th><input type="checkbox" id="checkall" name="checkall"/>选择</th><th>申报单号</th><th>用户名</th><th>联系方式</th><th>播放课件</th><th>服务器IP</th><th>锁定时间</th><th>状态</th><shiro:hasPermission name="lock:edit"><th>操作</th></shiro:hasPermission></tr></thead>
  <tbody>
  <c:forEach items="${page.list}" var="item">
    <tr>
        <td><input type="checkbox"  name="seqs" value="${item.id}"/> </td>
          <td>${item.localId}</td>
          <td>${fns:getUserById(item.sealId).name}</td>
          <td>${fns:getUserById(item.sealId).phone}</td>
          <td>${fns:getLessonName(item.contentType)}</td>
          <td>${item.name}</td>
          <td><fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
          <td><c:if test="${item.sts eq '0'}">已锁定</c:if></td>
          <shiro:hasPermission name="lock:edit">
        <td>
          <a href="${ctx}/plan/removeLockById?lockId=${item.id}" onclick="return confirmx('确认要解锁该申报吗？', this.href)">解锁</a>
        </td>
      </shiro:hasPermission>
    </tr>
  </c:forEach>
  </form:form>
  </tbody>
</table>
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

      $("#batchAssBtn").click(
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
                  // 如果是盟市审核环节，批量提示对附件是否默认通过
                  loading('正在提交，请稍等...');

                  $("#inputForm").submit();
              }
      );

  }); // end ---$(document)
  function page(n,s){
    $("#pageNo").val(n);
    $("#pageSize").val(s);
    $("#inputForm").attr("action","${ctx}/plan/lockList");
    $("#inputForm").submit();
    return false;
  }


</script>



</body>
</html>
