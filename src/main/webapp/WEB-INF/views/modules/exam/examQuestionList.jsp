<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>参加考试首页</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>

    <script type="text/javascript">
        var maxtime;
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                var len = $("input:checkbox:checked").length;
                len = len + $("input:radio:checked").length;
                $.ajax({

                    type: "post",
                    url: "${ctx}/exam/exam/checkIsSubmit",
                    data: {"soid": $("#soid").val()},
                    dataType: "json",
                    success: function (msg) {
                        if (msg.flag == 1) {
                            $.jBox.tip('考卷已经提交，不可重复提交！');

                        }
                        if (msg.flag == 0) {

                           // alert(len);

                            if (len < 50) {
                                /*  var falg= confirmx('您本次考试还有未完成试题，您确定提交吗？');
                                 alert(falg);*/

                                //未点击开始考试，不允许提交试卷
                                if($("#beginBt").attr("disabled") != "disabled"){
                                    $.jBox.tip('未开始答题，不能提交试卷！');
                                    return ;
                                }
                                confirmxAlipay('您本次考试还有未完成试题，您确定提交吗？', submitQueByUser);


                            }else{
                                confirmxAlipay('您确定提交吗？', submitQueByUser);
                            }

                        }
                    }

                });


                //   submitQue();

            });

            maxtime = 60*60;

            eleDisable();
        });

        // 不可选
        function eleDisable() {

            $("input[type='radio']").attr("readonly", true);//将radio元素设置为readonly
            $("input[type='checkbox']").attr("readonly", true);//将checkbox元素设置为readonly

        }
        function eleEnable() {
            $("input[type='radio']").attr("disabled", false);//将radio元素设置为readonly
            $("input[type='checkbox']").attr("disabled", false);//将checkbox元素设置为readonly

        }
        function submitQueByUser() {
            var f = 0;


            var tet = $("#examForm").serialize();
            $.ajax({
                type: "post",
                url: "${ctx}/exam/exam/makeResultToExamInfoDeatail",
                data: {"param": tet, "examInfoId": $("#examInfoId").val(),"listId":$('#listId').val(), "planId": $('#planId').val(), "soid": $("#soid").val()},
                dataType: "json",
                success: function (msg) {
                    if (msg.flag == 1) {
                        $.jBox.tip("试卷提交失败,请重新考试.")
                    }
                    if (msg.flag == 2) {
                        $.jBox.tip("试卷提交成功,作答试题数量为0.");
                    }
                    else {
                        $.jBox.tip("您已进行在线考试!")
                    }
                    //这里是否要提交展示 试卷页面
                   //window.location.href = "${ctx}/exam/exam/getQuestionListByType?examInfoId=" + $("#examInfoId").val() + "&flag=1";
                    window.location.href = "${ctx}/exam/exam/getUserSoExamInfo";

                }

            });
        }
        function submitQueByTime() {
            var tet = $("#examForm").serialize();
            $.ajax({
                type: "post",
                url: "${ctx}/exam/exam/makeResultToExamInfoDeatail",
                data: {"param": tet, "examInfoId": $("#examInfoId").val(),"listId":$('#listId').val(), "planId": $('#planId').val(), "soid": $("#soid").val()},
                dataType: "json",
                success: function (msg) {
                    if (msg.flag == 1) {
                        $.jBox.tip("试卷提交失败,请重新考试.");
                    }
                    if (msg.flag == 2) {
                        $.jBox.tip("试卷提交成功,作答试题数量为0.");
                        confirmx('考试时间已到，已经自动交卷。点击【确定】可查看试卷。', "${ctx}/exam/exam/getQuestionListByType?examInfoId=" + $("#examInfoId").val() + "&flag=1");

                    }
                    else {
                       // $.jBox.tip("您已进行在线考试，成绩待审核后公布!");
                        confirmx('考试时间已到，已经自动交卷。点击【确定】可查看试卷。', "${ctx}/exam/exam/getQuestionListByType?examInfoId=" + $("#examInfoId").val() + "&flag=1");
                    }

                    //这里是否要提交展示 试卷页面
                    //  window.location.href="${ctx}/exam/exam/getQuestionListByType?examInfoId="+$("#examInfoId").val()+"&flag=1";
                }

            });
        }

        function showOrhide(qid){
         var ttId='#count-row-'+qid;
          /*  var val=$('input:radio[name="'+qid+'"]:checked').val();
           var tet= $(ttId).html();
            if(val!=null){
                $(ttId).show();
            }
            else{
                $(ttId).hide();
            }*/
            $("input[name='"+qid+"']").each(function(){
                if($(this).attr("checked")){
                    $(ttId).show();
                return false;

                }
                else{

                    $(ttId).hide();
                }
            });



        }

        function CountDown() {
            if (maxtime >= 0) {
                minutes = Math.floor(maxtime / 60);
                seconds = Math.floor(maxtime % 60);
                msg = minutes + "分" + seconds + "秒";
                document.all["timer"].innerHTML = msg;
               if(maxtime == 3*60)  $.jBox.tip('温馨提示：您的考试时间还有3分钟!');
                --maxtime;
                if (maxtime == 0) {
                    submitQueByTime();
                }
            }
            else {
                clearInterval(timer);
                var n = document.getElementById("hidden").value;
            }
        }
        function timer(obj) {

            if ($("#beginBt").attr("disabled") == "disabled") {
                $.jBox.tip("考试已经开始，不能重复参加本次考试");
            }
            else {
                $("#questionTable").show();
                setInterval("CountDown()", 1000);
                $("#beginBt").attr({"disabled": "disabled"});
                eleEnable();
                // 生成考试信息
                $.ajax({
                    type: "post",
                    url: "${ctx}/exam/exam/addDataInfoExamInfo",
                    data: {"planId": $('#planId').val(), "soid": $("#soid").val(), "examInfoId": $("#examInfoId").val()},
                    dataType: "json",
                    success: function (msg) {
                    }

                });

                $("#nowTime").html(currentTime());
            }


            //  $("#beginBt").live("click",function(){alert('您已经进行了考试，请勿点击')});
            // ${ctx}/exam/exam/examQuestionList?planId=${soPlan.planId}&soid=${soPlan.soid}"
        }
        ;
        function currentTime() {
            var d = new Date(), str = '';
            str += d.getFullYear() + '年';
            str += d.getMonth() + 1 + '月';
            str += d.getDate() + '日';
            str += d.getHours() + '时';
            str += d.getMinutes() + '分';
            str += d.getSeconds() + '秒';
            return str;
        }
    </script>
</head>
<body>
<tags:message content="${message}"/>
<input style="display: none" value="${examInfo.planId}" id="planId">
<input style="display: none" value="${examInfo.soId}" id="soid">
<input style="display: none" value="${listId}" id="listId">

<form name="examForm" id="examForm" action="" modelAttribute="question">
    <div class="tab-pane" id="cpResume">

        <div class="span12">
            <p style="text-align: center; font-size: 20px;">
                </br>内蒙古自治区二级建造师继续教育考试系统</br></br>
            </p>

            <p>尊敬的用户：<u>${examInfo.userName}</u>&nbsp;您好。您选择了：<u>${fns:getPlanById(examInfo.planId).planName}</u>&nbsp;培训项目并已完成了全部学时：<u>${fns:getPlanById(examInfo.planId).planHours}</u>&nbsp;学时的学习，请您进行在线考试。
            </p>

            <p>考试满分为<u> 100分 </u>，试题总量为<u> 50题 </u> ，分为单选题、多选题、判断题三种试题类型。单选每题<u> 2分 </u>多选每题<u> 2分 </u>判断每题<u> 2分 </u>，合格分数为<u>
                60分 </u>，考试时间为<u> ${examInfo.requireTime} </u>分钟，请谨慎答题，交卷后不可修改，祝您取得优异的成绩。 </p>

            <p><a id="beginBt" href="javascript:void(0)" class="btn btn-success  btn-xs" onclick="timer(this)">
                <i class="icon-white icon-play-circle"></i> 开始答题
            </a></p>
        </div>
        <table class="table  table-bordered table-condensed table-hover">
            <tr align="center">
                <td><label class="control-label">答题开始时间:</label><span id="nowTime"></span></td>
                <td><label class="control-label">剩余时间:</label><span id="timer" style="color:red"></span></td>
                <input id="oldTimer" value="${examInfo.requireTime}" style="display: none"/>
                <input style="display: none" id="examInfoId" value="${examInfo.id}"/>

            </tr>
        </table>
        <table class="table  table-bordered table-condensed table-hover" id="questionTable" style="display: none">
            <c:forEach items="${QuestionList}" var="question" varStatus="status">
                <tr>
                    <td><label class="control-label">题目${status.index+1} <c:if test="${question.profession==0}">(公共课试题)</c:if>
                        <c:if test="${question.profession!=0}">(专业课试题)</c:if>:&nbsp;&nbsp;${question.question}
                        <c:if test="${question.questionStyle==0}">(单选题)</c:if>
                        <c:if test="${question.questionStyle==1}">(多选题)</c:if>
                        <c:if test="${question.questionStyle==2}">(判断题)</c:if>

                        <div id="count-row-${question.id}" style="display: none; color: red">已选</div>
                        <c:forEach var="detail" items="${question.detail}" varStatus="status1">
                            <br>
                            <c:if test="${question.questionStyle==0||question.questionStyle==2}"><input type="radio"
                                                                                                        name="${question.id}"
                                                                                                        value="${status1.index+1}"
                                                                                                        disabled="true" onclick="showOrhide('${question.id}')"/></c:if>
                            <c:if test="${question.questionStyle==1}"><input type="checkbox" name="${question.id}"
                                                                             value="${status1.index+1}"
                                                                             disabled="true" onclick="showOrhide('${question.id}')"/></c:if>
                            ${detail.index}&nbsp;${detail.questionChoice}
                            <br>
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
        </table>
        <div class="span10" style="text-align: center;width: 1000px">
            <input id="btnSubmit" class="btn btn-primary" type="button" value="交卷" name="submit">
            <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">

        </div>
    </div>
</form>

</body>
</html>
