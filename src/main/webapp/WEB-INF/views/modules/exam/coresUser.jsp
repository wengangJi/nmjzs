<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>参加考试首页</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">

    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">考试成绩</a></li>
</ul>

<table id="contentTable" class="table  table-bordered table-condensed table-hover">
        <thead><tr><th>考生姓名</th><th>考试项目</th><th>申报单号</th><th>考试成绩(分)</th><th>是否合格</th></tr></thead>
        <tbody>
         <c:forEach items="${list}" var="element" varStatus="staus">
          <tr>
              <td>${fns:getUserById(element.userId).name}</td>
              <td>${fns:getPlanById(element.planId).planName}</td>
              <td>${element.soid}</td>
              <td>
              <c:if test="${element.cores==null}">
                  0(分)
              </c:if>
              <c:if test="${element.cores!=null}">
                  ${element.cores}(分)
              </c:if>
              </td>
            <%--  <td>${element.startTime}</td>
              <td>${element.endTime}</td>--%>
             <%-- <td>
              <c:if test="${element.cores==null}">
                  0(分)
              </c:if>
              <c:if test="${element.cores!=null}">
                  ${element.cores}(分)
              </c:if>
              </td>--%>
              <td style="color: red;">${fns:getDictLabel(element.examState, 'EXAM_STATE', '')}</td>
<%--
              <td style="color: red;">${fns:getDictLabel(element.auditTag, 'AUDIT_TAG', '')}</td>
--%>

          <%-- <td>
                  <a href="${ctx}/exam/exam/getQuestionListByType?examInfoId=${element.id}&flag=0&cores=${element.cores}">试题详细信息</a>
              </td>--%>
           </tr>
         </c:forEach>
        </tbody>
    </table>
</body>
</html>
