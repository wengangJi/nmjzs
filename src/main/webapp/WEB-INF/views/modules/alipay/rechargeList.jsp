<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>交易流水</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#searchForm").validate({
                submitHandler: function (form) {
                    loading('正在查询，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });


        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }


    </script>
</head>
<body>
<tags:message content="${message}"/>
<form:form id="cpForm" modelAttribute="ipsorder" action="${ctx}/alipay/alipay/getIpsorderList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>

</form:form>
<form name="examForm" id="examForm" action=""   >
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead><tr><th>交易流水</th><th>申报流水</th><th>申报项目</th><th>支付人</th><th>交易时间</th><th>交易金额</th><th>交易状态</th><th>操作</th></tr></thead>
        <tbody>
         <c:forEach items="${page.list}" var="element" varStatus="staus">
  <tr>
      <td>${element.alipayId}</td>
      <td><a href="${ctx}/plan/findSoAllInfo?soid=${element.soid}">${element.soid}</a></td>
      <td>${fns:getPlanById(element.planId).planName}</td>
      <td>${fns:getUserById(element.userId).name}</td>
      <td><fmt:formatDate value="${element.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
      <td>${element.fee}(元)</td>
      <td style="color: red;">${fns:getDictLabel(element.feeState, 'FEE_STATE', '')}</td>

      <c:if test="${element.feeState eq '1'}">
          <td>
             <%-- <a href="${ctx}/exam/exam/examQuestionList?planId=${soPlan.planId}&soid=${soPlan.soid}"> <i class="icon-white icon-play-circle"></i></a>--%>
          </td>
      </c:if>

      <c:if test="${element.feeState eq '0'}">
          <td>
              <a href="${ctx}/alipay/alipay/alipayReSubmit?alipayId=${element.alipayId}&soid=${element.soid}&fee=0.1" target="_blank">重新支付</a>
          </td>
      </c:if>

  </tr>

         </c:forEach>
        </tbody>
        </table>
</form>
<div class="pagination">${page}</div>

</body>

</html>
