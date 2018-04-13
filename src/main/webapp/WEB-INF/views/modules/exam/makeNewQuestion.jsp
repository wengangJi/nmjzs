<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>参加考试首页</title>
    <meta name="decorator" content="default"/>
    <script  type="text/javascript" src="${ctxStatic}/jquery/jquery.form-2.67.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
        });
       function submitForm(){
           $("#form1").ajaxSubmit({
               type:"POST",
               dataType:"json",
               success:function (msg) {
                   if(msg.flag==1){alert('试题生成失败')}
                   else{
                       alert('试题生成成功')
                   }

                   window.location.reload();
               }

           });
       }


        function addQuestionCheck(){
            var _len = $("#questionAdd tr").length-1;
            var _size= $("#questionAdd tr").length-1;
            $("#questionAdd").append("<tr  align='center'>"+'<td>'+String.fromCharCode(_len+65)+'</td>'
                    +"<td><input id=\"detail\" name=\"detail["+_size+"]\.questionChoice\" maxlength=\"64\" class=\"required input-medium\" type=\"text\" value=\"\">&nbsp;&nbsp;<a href='javascript:void(0)' onclick='javascript:del(this);'>删除</a></td>"
                    +"</tr>");
        };
        function del(obj) {
            var inRowIndex = obj.parentNode.parentNode.rowIndex;
            //alert(inRowIndex);
            var delRow=obj.parentNode.parentNode.parentNode;
            delRow.deleteRow(inRowIndex-1);
        }
        function  addAnwer(){
            var _size= $("#answerAdd tr").length-1;
            var _len = $("#answerAdd tr").length-1;
            $("#answerAdd").append("<tr  align='center'>"+'<td>'+1+'</td>'
                    +"<td><input id=\"answer\" name=\"answer["+_size+"]\.answer\" maxlength=\"64\" class=\"required input-medium\" type=\"text\" value=\"\">&nbsp;&nbsp;<a href='javascript:void(0)' onclick='javascript:del(this);'>删除</a></td>"
                    +"</tr>");
        };


    </script>
</head>
<body>
<tags:message content="${message}"/>
    <form  action="${ctx}/exam/exam/makeNewQuestion"   modelAttribute="question" id="form1">
      <%--  <form:hidden path="question.Profession" value ="${plan.majorId}"/>
        <form:hidden path="question.type" value ="${plan.planType}"/>--%>
        </br>
        <div class="span10">
                <li style="text-align: center">试题录入</li>
        </div>
        </br></br>
        <table border="0" align="center" width="640px;" id="questionId">
           <tr>
                <td>  <label class="control-label" for="type">专 业 ：</label></td>
                <td> <form:select id="type" path="question.Profession" class="required input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('QC_MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
                </td>
            </tr>
          <%--  <tr>
                <td>  <label class="control-label" for="type">类 别 ：</label></td>
                <td> <form:select id="type" path="question.type" class="required input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PLAN_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
                </td>
            </tr>--%>
            <tr>
                <td><label class="control-label" for="type">题目类别 ：</label></td>

                <td><form:radiobuttons id="type" path="question.QuestionStyle" items="${fns:getDictList('QUESTION_TYPE')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                </td>
            </tr>
             <tr>
                <td> <label class="control-label" >题目标题 ：</label></td>
                <td colspan="6"><form:textarea path="question.question"  rows="2" class="required input-block-level"/></td>

            </tr>
        </table>
        <table class="table table-striped table-bordered " id="questionAdd">
            <tr>
                <td> <label class="control-label" >该题选项 ：</label></td>
                <td> <input id="anQuestion" class="btn btn-primary" type="button" onclick="addQuestionCheck()" value="添加选项"> </td>
            </tr>
          <%--  <div class="span10" style="text-align: center;width: 1000px">

                选择题输入示例	下列哪个不是程序设计语言？ A、vb语言 B、java C、c语言 D、UML            </div>
            </table>--%>
        <table class="table table-striped table-bordered " id="answerAdd">
            <tr>
                <td> <label class="control-label">该题答案 ：</label></td>
                <td>   <input id="dd" class="btn btn-primary" type="button" onclick="addAnwer()" value="添加答案"></td>
            </tr>
            <div class="span10" style="text-align: center;width: 1000px">

                请输入正确答案对应的选项            </div>
        </table>
        <div class="span10" style="text-align: center;width: 1000px">
            <input id="btnSubmit" class="btn btn-primary" type="button" value="生成试题"  onclick="submitForm()">
        </div>
    </form>

</body>
</html>
