<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>参加考试首页</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>

    <script type="text/javascript">
    function deleteQuestion(obj){

        $.ajax({
            type:"post",
            url:"${ctx}/exam/exam/deleteQuestionByQuestionId",
            data:{"questionId":obj},
            dataType:"json",
            success:function (msg) {
               if(msg==1){ $.jBox.tip('试题删除失败')}
                else{
                   $.jBox.tip('试题删除成功')
               }
                window.location.reload();
            }
        });
    }

    function modify(questionId,chaoiceId,old){
        $.jBox.confirm("您确定修改该试题？","系统提示",function(v,h,f){
            if (v == 'ok') {
                var html = "<div style='padding:10px;'>" +
                        "原  来：<em style='color: red'>"+old+"</em><br/><br/>"+
                        "修改为：<textarea id='new' name='new' rows='4' /></div>";
                var submit = function (v, h, f) {
                    if (f.auditRemark == '') {
                        $.jBox.tip("不能把试题修改为空", 'error', { focusId: "new" });
                        return false;
                    }

                  /*  $("#auditRemark").val(f.auditRemark);
                    $("#inputForm").submit();
                    $.jBox.tip("审核成功!");*/
                   // 修改试题
                    $.ajax({
                        type:"post",
                        url:"${ctx}/exam/exam/updQuestionById",
                        data:{"questionId":questionId,"choiceId":chaoiceId,"newQuestion":$('#new').val()},
                        dataType:"json",
                        success:function (msg) {
                            if(msg==1){ $.jBox.tip('试题修改失败')}
                            else{
                                $.jBox.tip('试题修改成功')
                            }
                            window.location.reload();
                        }
                    });



                    return true;
                };

                $.jBox(html, { title: "修改试题", submit: submit });
            }
        });

    }


    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
    </script>
</head>
<body>
<tags:message content="${message}"/>
<form:form id="searchForm" modelAttribute="question" action="${ctx}/exam/exam/questionList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <tr>
        <td>  <label class="control-label" for="type">专业 ：</label></td>
        <td> <form:select id="type" path="profession" class="required input-medium" ><form:option value="" label=""/><form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
        </td>
     <%--   <td>  <label class="control-label" for="type">项目类别 ：</label></td>
        <td> <form:select id="type" path="type" class="required input-medium" ><form:option value="" label=""/><form:options items="${fns:getDictList('MAIN_FLAG')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
        </td>--%>
        <td>  <label class="control-label" for="type">试题类别 ：</label></td>
        <td> <form:select id="type" path="QuestionStyle" class="required input-medium" ><form:option value="" label=""/><form:options items="${fns:getDictList('QUESTION_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
        </td>
        <td>    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询">
        </td>
    </tr>

</form:form>
<form name="examForm" id="examForm" action="" >
    <div class="tab-pane" id="cpResume">

    <table class="table table-striped table-bordered table-condensed">
        <thead><tr><th>题目列表</th><th>操作</th></tr></thead>
        <tbody>        <c:forEach items="${page.list}" var="question" varStatus="status">
            <tr>
                <input style="display: none" id="examInfoId" value="${examInfo.id}"/>
                <td  ><label class="control-label">题目${status.index+1}:
                <span>
                ${question.question}
                </span>
                    <c:if test="${question.questionStyle==0}">(单选)</c:if>
                    <c:if test="${question.questionStyle==1}">(多选)</c:if>
                    <c:if test="${question.questionStyle==2}">(对错)</c:if>
                    <a href="javascript:void(0)" onclick="modify('${question.id}',null,'${question.question}')">[修改]</a>
                    <br>
                    <c:forEach var="detail" items="${question.detail}" varStatus="status1">
                        <br>
                        ${detail.index}&nbsp;${detail.questionChoice}&nbsp;<a href="javascript:void(0)" onclick="modify('${question.id}','${detail.index}','${detail.questionChoice}')">[修改]</a>
                        <br>
                    </c:forEach>
                    <br>
                </label>

                </td>
                <td><a href="javascript:void(0)" onclick="deleteQuestion('${question.id}')">删除</a></td>
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
<div class="pagination">${page}</div>
</body>
</html>
