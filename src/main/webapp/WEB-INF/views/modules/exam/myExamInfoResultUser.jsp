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
    <li class="active"><a href="#">考试信息</a></li>
</ul>

<form name="examForm" id="examForm" action="" >
    <div class="tab-pane" id="cpResume">
        <table id="contentTable" class="table  table-bordered table-condensed table-hover">
            <thead><tr><th>题目列表</th></tr></thead>
            <tbody>
            <c:forEach items="${examQuesiontlist}" var="question" varStatus="status">
                <tr>
                  <td>
                        <label class="control-label">题目${status.index+1}:${question.question}<c:if test="${question.questionStyle==0}">(单选)</c:if>
                        <c:if test="${question.questionStyle==1}">(多选)</c:if>
                        <c:if test="${question.questionStyle==2}">(判断)</c:if>
                            <u style="color: red"> 您的答案：<strong>${question.userAnswer}</strong></u>
                        <c:forEach var="detail" items="${question.detail}" varStatus="status1">
                           <br> ${detail.index}&nbsp;${detail.questionChoice}<br>
                        </c:forEach>
                        <br>
                        </label>
                  </td>

                    <%-- <td><label class="control-label"  >答案</label><c:if test="${question.questionStyle==0}">
                         <input type="radio" name="${status.index+1}" value="A" />A
                         <input type="radio" name="${status.index+1}" value="B" />B
                         <input type="radio" name="${status.index+1}" value="C" />C
                         <input type="radio" name="${status.index+1}" value="D" />D
                     </c:if>
                         <c:if test="${question.questionStyle==2}">
                             <input type="checkbox" name="${status.index+1}" value="A" />A
                             <input type="checkbox" name="${status.index+1}" value="B" />B
                             <input type="checkbox" name="${status.index+1}" value="C" />C
                             <input type="checkbox" name="${status.index+1}" value="D" />D
                         </c:if>
                         <c:if test="${question.questionStyle==3}">
                             <input type="radio" name="${status.index+1}" value="A" />对
                             <input type="radio" name="${status.index+1}" value="B" />错
                         </c:if>
                     </td>--%>
                </tr>
            </c:forEach>
            </tbody>
        </table>
  </div>
</form>
</body>
</html>
