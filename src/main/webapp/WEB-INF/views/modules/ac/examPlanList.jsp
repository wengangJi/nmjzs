<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>申请培训</title>
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
            $("#invoice").click(
                    function(){
                        if(this.checked){
                            $("#invoiceArea").show();
                        }else{
                            $("#invoiceArea").hide();
                        }
                    }
            );
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
                        if(!flag){
                            $.jBox.error("请选择一个培训项目!");
                            return false;
                        }
                        $.get("${ctx}/plan/getCourses?planId=" + $("#planId").val(), function(data){
                            var js = '<script type="text/javascript">'
                                    + '$("#checkall").click('
                                    + '        function(){'
                                    + '                $("input[name=\'seqs\']").click();'
                                    + '});'
                                    + '$("#checkall").click();'
                                    + '<\/script>';
                            var html = "<table id='lessonTable' class='table table-striped table-bordered table-condensed'>"
                                       +"<thead><tr><!--<th><input type='checkbox' id='checkall' name='checkall' />选择</th>--><th>课程名称</th><th>课程类型</th><th>讲师</th><th>学时</th></tr></thead><tbody>"
                            for(i=0; i< data.length; i++) {
                                html = html + "<tr>"
                                        //+ "<td><input type='checkbox'  name='seqs' value='"+data[i].courseId+"'  onclick='return dealHours(this," + data[i].courseHours + ");'/></td>"
                                        + "<td><a href='${ctx}/course/detail?courseId=" + data[i].courseId + "''>" + data[i].courseName + "</a></td>"
                                        + "<td>" + data[i].rsrvStr1 + "</td>"
                                        + "<td>" + data[i].teacherName + "</td>"
                                        + "<td>" + data[i].courseHours + "</td></tr>";
                            }
                            html = html + "</tbody></table>";
                            $("#courseArea").html(html);
                           // $.jBox("get:${ctx}/course/detail?courseId=100");
                        });
                    } else if (index == "2") {
                        var ids = new Array();
                        $("input[name='seqs']").each(function(){
                            if(this.checked){
                                ids.push(this.value);
                            }
                        });

                        $.get("${ctx}/plan/getPlan?planId=" + $("#planId").val(), function(data){
                            var html = "<p>您订购的培训项目：</p><table id='lessonTable' class='table table-striped table-bordered table-condensed'>"
                                    +"<thead><tr><th>项目名称</th><th>项目类型</th><th>专业</th><th>学时</th><th>价格</th></tr></thead><tbody>"
                                html = html
                                        + "<tr><td>" +data.planName + "</td>"
                                        + "<td>" + data.rsrvStr1 + "</td>"
                                        + "<td>" + data.rsrvStr2 + "</td>"
                                        + "<td>" + data.planHours + "</td>"
                                        + "<td>" + data.charge + "</td></tr>";
                            html = html + "</tbody></table>";
                            $("#confirmPlan").html(html);
                        });

                        $.get("${ctx}/plan/getCourses?planId=" + $("#planId").val(), function(data){
                            var html = "<p>专业课程：</p><table id='lessonTable' class='table table-striped table-bordered table-condensed'>"
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
    <li class="active"><a href="#choosePlan" data-toggle="tab">选择项目</a></li>
</ul>
<tags:message content="${message}"/>
    <form:form id="inputForm" modelAttribute="soPlanEntity" action="${ctx}/plan/save" method="post" class="form-horizontal">
    <div class="tab-content">
     <input type="hidden" id="planId" />
<!--选择计划-->
    <div class="tab-pane active" id="choosePlan">
    <table id="planTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>项目年度</th>
            <th>项目地市</th>
            <th>项目名称</th>
            <th>项目类型</th>
            <th>专业</th>
            <th>学时</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${plans}" var="plan">
            <tr>
                <td>${plan.year}(年度)</td>
                <td>${fns:getDictLabel(plan.localId, 'LOCAL_ID', '')}</td>
                <td>${plan.planName}</td>
                <td>${fns:getDictLabel(plan.planType, 'PLAN_TYPE', '')}</td>
                <td>${fns:getDictLabel(plan.majorId, 'MAJOR', '')}</td>
                <td>${plan.planHours}(学时)</td>
                <td>
                    <a href="${ctx}/exam/exam/makeNewQuestionPre?planId=${plan.planId}">
                        <i class="icon-white icon-play-circle"></i> 录入试题
                    </a>

                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</form:form>

</body>
</html>