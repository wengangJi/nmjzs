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
                            $.jBox.error("请选择课程!");
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
    <li class="active"><a href="#choosePlan" data-toggle="tab">培训项目</a></li>

</ul>
<tags:message content="${message}"/>

<div class="tab-pane active" id="choosePlan">
    <table id="planTable" class="table table-hover table-bordered table-condensed">
        <thead>
        <tr>
            <th>序号</th>
            <th>项目名称</th>
            <th>项目年度</th>
            <th>项目类型</th>
            <th>专业</th>
            <th>学时</th>
            <th>价格</th>
            <th>所属地市</th>
            <th>项目状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${plans}" var="plan" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>${plan.planName}</td>
                <td>${plan.year}(年度)</td>
                <td>${fns:getDictLabel(plan.planType, 'PLAN_TYPE', '')}</td>
                <td>${fns:getDictLabel(plan.majorId, 'MAJOR', '')}</td>
                <td>${plan.planHours}(学时)</td>
                <td>${plan.charge}(元)</td>
                <td>${fns:getDictLabel(plan.localId, 'LOCAL_ID', '')}</td>
                <td>${fns:getDictLabel(plan.sts, 'AUDIT_STS', '')}</td>
                <td>
                    <a href="${ctx}/plan/auditPlan?planId=${plan.planId}">发布</a>
                    <a href="${ctx}/plan/removePlan?planId=${plan.planId}">作废</a>
                </td>
           </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</div>
</body>
</html>