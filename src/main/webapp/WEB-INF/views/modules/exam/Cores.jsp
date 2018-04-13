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

    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead><tr><th>姓名</th><th>考试时间</th><th>题量</th><th>答对题数</th><th>答错题数</th><th>成绩</th><th>试卷</th></tr></thead>
        <tbody>
         <c:forEach items="${list}" var="element" varStatus="staus">
          <tr>
              <td>${element.userName}</td>
              <td>${element.createTime}</td>
              <td>${element.questionTotals}</td>
              <td>${element.rightSum}</td>
              <td>${element.questionTotals-element.rightSum}</td>
              <td>
              <c:if test="${element.cores==null}">
                  0
              </c:if>
              <c:if test="${element.cores!=null}">
                  ${element.cores}
              </c:if>
              </td>
              <td>
                  <a href="${ctx}/exam/exam/getQuestionListByType?examInfoId=${element.id}&flag=0&cores=${element.cores}">查看</a>
              </td>
           </tr>
         </c:forEach>
        </tbody>
    </table>
</body>
</html>
