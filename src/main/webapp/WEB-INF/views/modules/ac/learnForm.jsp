<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>在线学习</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script src="${ctxStatic}/jquery-cookie/jquery.cookie.js" type="text/javascript"></script>
    <script type="text/javascript">

        function setMinHouts(obj,fee,planId) {
            $("#minHours").val(obj);
            $("#fee").val(fee);
            $("#planId").val(planId);
        }

        function dealHours(obj,hours){
            if(obj.checked){
                $("#totalHours").val(parseInt($("#totalHours").val()) + hours);
            }else{
                $("#totalHours").val(parseInt($("#totalHours").val()) - hours);
            }
        }

        $(document).ready(function() {
            var $validator = $("#inputForm").validate({

                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            $('#rootwizard').bootstrapWizard({
                'nextSelector': '.button-next',
                'previousSelector': '.button-previous',
                'tabClass': 'nav nav-pills',
                onTabShow: function(tab, navigation, index) {
                    var $total = navigation.find('li').length;
                    var $current = index+1;
                    var $percent = ($current/$total) * 100;
                    //$('#rootwizard').find('.bar').css({width:$percent+'%'}); // 进度条

                    // If it's the last tab then hide the last button and show the finish instead
                    if($current >= $total) {
                        $('#rootwizard').find('.pager .next').hide();
                        $('#rootwizard').find('.pager .finish').show();
                        $('#rootwizard').find('.pager .finish').removeClass('disabled');
                    } else {
                        $('#rootwizard').find('.pager .next').show();
                        $('#rootwizard').find('.pager .finish').hide();
                    }

                },
                'onNext': function(tab, navigation, index) {
                    if(index == "1") {
                        var flag = false;
                        $("input[name='planRadio']").each(function(){
                            if(this.checked){
                                flag = true;
                            }
                        });

                        $.get("${ctx}/plan/getCourses?planId=" + $("#planId").val(), function(data){
                            var js = '<script type="text/javascript">'
                                    + '$("#checkall").click('
                                    + '        function(){'
                                    + '                $("input[name=\'seqs\']").click();'
                                    + '});'
                                    + '$("#checkall").click();'
                                    + '<\/script>';
                            var html = js + "<table id='lessonTable' class='table table-striped table-bordered table-condensed'>"
                                       +"<thead><tr><th><input type='checkbox' id='checkall' name='checkall' />选择</th><th>课程名称</th><th>课程类型</th><th>讲师</th><th>学时</th></tr></thead><tbody>"
                            for(i=0; i< data.length; i++) {
                                html = html
                                        + "<tr><td><input type='checkbox'  name='seqs' value='"+data[i].id+"'  onclick='return dealHours(this," + data[i].courseHours + ");'/></td>"
                                        + "<td><a href='${ctx}/course/detail?courseId=" + data[i].courseId + "'' >" + data[i].courseName + "</a></td>"
                                        + "<td>" + data[i].rsrvStr1 + "</td>"
                                        + "<td>" + data[i].teacherName + "</td>"
                                        + "<td>" + data[i].courseHours + "</td></tr>";
                            }
                            html = html + "</tbody></table>";
                            $("#courseArea").html(html);
                           // $.jBox("get:${ctx}/course/detail?courseId=100");
                        });
                    } else if (index == "2") {
                        var flag = false;
                        $("input[name='seqs']").each(function(){
                            if(this.checked){
                                flag = true;
                            }
                        });
                        if(!flag){
                            $.jBox.error("请先进行在线学习，完成确认学时!");
                            return false;
                        }

/*                        if(parseInt($("#totalHours").val()) < parseInt($("#minHours").val())){
                            $.jBox.error("选择的学时不够!");
                            return false;
                        }*/
                    } else if (index == "3") {
                        var ids = new Array();
                        $("input[name='seqs']").each(function(){
                            if(this.checked){
                                ids.push(this.value);
                            }
                        });

                        $.get("${ctx}/plan/getPlan?planId=" + $("#planId").val(), function(data){
                            var html = "<p>您订购的培训计划：</p><table id='lessonTable' class='table table-striped table-bordered table-condensed'>"
                                    +"<thead><tr><th>计划名称</th><th>计划类型</th><th>专业</th><th>学时</th><th>价格</th></tr></thead><tbody>"
                                html = html
                                        + "<tr><td>" +data.planName + "</td>"
                                        + "<td>" + data.rsrvStr1 + "</td>"
                                        + "<td>" + data.rsrvStr2 + "</td>"
                                        + "<td>" + data.planHours + "</td>"
                                        + "<td>" + data.charge + "</td></tr>";
                            html = html + "</tbody></table>";
                            $("#confirmPlan").html(html);
                        });

                        $.get("${ctx}/plan/getCoursesByIds?courseIds=" + ids, function(data){
                            var html = "<p>您选择的课程：</p><table id='lessonTable' class='table table-striped table-bordered table-condensed'>"
                                    +"<thead><tr><th>课程名称</th><th>课程类型</th><th>讲师</th><th>学时</th></tr></thead><tbody>"
                            for(i=0; i< data.length; i++) {
                                html = html
                                        + "<tr><td>" +data[i].courseName + "</td>"
                                        + "<td>" + data[i].rsrvStr1 + "</td>"
                                        + "<td>" + data[i].teacherName + "</td>"
                                        + "<td>" + data[i].courseHours + "</td></tr>";
                            }
                            html = html + "</tbody></table>";
                            $("#confirmCourse").html(html);
                        });
                    }
                    var $valid = $("#inputForm").valid();
                    if(!$valid) {
                        $validator.focusInvalid();
                        return false;
                    }
                },
                'onPrevious':function(tab, navigation, index) {
                    if(index == "0") {
                        $("#totalHours").val(0);
                    }
                },
                'onTabClick': function(tab, navigation, index) {
                    return false;
                }
            });
            $('#rootwizard .finish').click(function() {
                var $valid = $("#inputForm").valid();
                if(!$valid) {
                    $validator.focusInvalid();
                    return false;
                }
                $.jBox.confirm("确认提交订单？","系统提示",function(v,h,f){
                    if (v == 'ok') {
                        $("#inputForm").submit();
                    }
                });
            });
        });

    </script>

</head>
<body>
<div id="rootwizard">
<ul class="nav nav-tabs">
<%--
    <li class="active"><a href="#choosePlan" data-toggle="tab">学习须知</a></li>
--%>
    <li><a href="#chooseLesson" data-toggle="tab">在线学习</a></li>
</ul>
<tags:message content="${message}"/>
<!-- 进度条
<div id="bar" class="progress progress-striped active">
    <div class="bar"></div>
</div>
-->

    <div class="tab-content">
<input type="hidden" id="planId" />
<!--选择计划-->
<%--<div class="tab-pane active" id="choosePlan">
    1.专业选择: </br>
    选修课学习所选择的专业为所得证书的主项专业（增项专业不可选），对于有增项专业的也只需选择主项专业学习60学时即可。 </br>
    2.课程选择:  </br>
    首先按照专业要求选择课程，必须达到要求的总学时数。 </br>
    3.确认选课: </br>
    选择课程后，对所选的课程进行确认，确认无误后，点击确认选课按钮，即确定了要进行学习的课程。特别提醒：所选课程一经确认，将无法修改，请谨慎操作。 </br>
    4.学习内容:</br>
    进行课程内容的学习，每个章节都有规定计划的学习时间，学习完成且达到规定时间后点击完成提交按钮，即可完成本章节的内容学习。所有章节都完成后即完成了本课程内容的学习。</br>
    学习过程中，需要安装摄像头，每个章节都会进行自动摄像,为保护个人隐私，请务必着正装学习。请学员注意：系统没有接收到摄像的，本章节学习无效，摄像比对个人信息照片，非本人学习，本章学习无效，不允许替学。 </br>
    课程学习完成后方可进行试卷考核，考试题目是随机抽取的，答对60%以上的视为该门课程学习合格。每门课程合格之后即取得相应的学时。  </br>
</div>--%>
<!-- 选择课程-->
<div class="tab-pane" id="chooseLesson">
    <div id="courseArea1">
        请选择培训项目进入学习:

        <table id="lessonTable" class="table  table-bordered table-condensed table-hover">
            <thead><tr><th>序号</th><th>申报单号</th><th>专业</th><th>培训项目</th><th>申请时间</th><th>要求学时</th><th>已学学时</th><th>缴费情况</th><th>学时情况</th><th>在线学习</th></tr></thead><tbody>

        <c:forEach items="${soPlans}" var="soPlan" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>${soPlan.soid}</td>
                <td>${fns:getDictLabel(fns:getPlanById(soPlan.planId).majorId, 'MAJOR', '')}</td>
                <td>${fns:getPlanById(soPlan.planId).planName}</td>
                <td><fmt:formatDate value="${soPlan.applyDate}" type="date" /></td>
                <td>${fns:getPlanById(soPlan.planId).planHours}(学时)</td>
                <td>${soPlan.rsrvStr3}(学时)</td>
                <td style="color: red;">${fns:getDictLabel(soPlan.feeState, 'FEE_STATE', '')}</td>
                <td style="color: red;">${fns:getDictLabel(soPlan.hourState, 'HOUR_STATE', '')}</td>
                <td>
                    <c:if test="${soPlan.feeState eq '1'}">
                        <a href="${ctx}/plan/findSoNoCourseBySoid?soid=${soPlan.soid}&planId=${soPlan.planId}">进入学习</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        </table>

    </div>
</div>


<!-- 支付-->
<div class="tab-pane" id="submit">
    <div id="confirmPlan"></div>
    <div id="confirmCourse"></div>
<%--    <a href="${ctx}/sys/sys/alipySubmit" target="_blank">支付</a>--%>
</div>
</div>
<style>
    #linknav ul{text-align:center;list-style-type:none;}
    #linknav ul li{display:inline;list-style-type:none;}

</style>

<%--<ul class="pager wizard">
    <li class="previous"  ><input type='button' class='btn button-previous' name='previous' value='上一步' /></li>
    <li class="next" ><input type='button' class='btn button-next btn-primary' name='next' value='下一步' /></li>
    <li class="next finish" style="display:none;"><input type='button' class='btn btn-primary' name='next' value='提 交' /></li>
</ul>--%>
</div>
</body>
</html>