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
                        if($("#servFlag").val()=="1"){
                            $.jBox.error("您尚未完成二级建造师信息，请填录完成后进行培训项目申报!");
                            return false;
                        }
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
                                        + "<td><a href='${ctx}/course/detail?courseId=" + data[i].courseId + "'' target = _blank>" + data[i].courseName + "</a></td>"
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
    <li><a href="#chooseLesson" data-toggle="tab">专业课程</a></li>
    <li><a href="#submit" data-toggle="tab">订单提交</a></li>
</ul>
<tags:message content="${message}"/>
    <form:form id="inputForm" modelAttribute="soPlanEntity" action="${ctx}/plan/save" method="post" class="form-horizontal">

    <div class="tab-content">
      <input type="hidden" id="planId" />
      <input type="hidden" id="servFlag" value="${servFlag}"/>
<!--选择计划-->
<div class="tab-pane active" id="choosePlan">
    <table id="planTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>选择</th>
            <th>项目名称</th>
           <%-- <th>项目年度</th>--%>
            <th>项目类型</th>
            <th>专业</th>
            <th>学时</th>
            <th>价格</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${plans}" var="plan">
            <tr>
                <td><input type="radio"  name="planRadio" value="${plan.planId}" onclick="setMinHouts(${plan.planHours},${plan.charge},${plan.planId});"/></td>
                <td>${plan.planName}</td>
               <%-- <td>${plan.year}(年度)</td>--%>
                <td>${fns:getDictLabel(plan.planType, 'PLAN_TYPE', '')}</td>
                <td>${fns:getDictLabel(plan.majorId, 'MAJOR', '')}</td>
                <td>${plan.planHours}(学时)</td>
                <td>${plan.charge}(元)</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- 选择课程-->
<div class="tab-pane" id="chooseLesson">
<%--
    <div style="float: right">最少学时：<input type="text" id="minHours" disabled value="0" style="width: 30px"/> &nbsp;已选择学时： <input id="totalHours" type="text" disabled value="0" style="width: 30px"></div>
--%>
    <div id="courseArea"></div>
</div>

<!-- 支付-->
<div class="tab-pane" id="submit">
    <div id="confirmPlan"></div>
    <div id="confirmCourse"></div>
    <span class="a-checkbox-label" style="float: left;"><strong>申请发票</strong><input type='checkbox' id='invoice' name='invoice' /></span>
    <!-- 填写发票-->
    <div id="invoiceArea" style="display: none">
        <table id="invoiceTable" class="table table-striped table-bordered table-condensed">
            <thead>
            <tr align="center">
                <td colspan="6" style="text-align: center">填写发票信息</td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="span1"><label class="control-label">发票抬头</label></td>
                <td><form:input path="soInvoice.title" htmlEscape="false"  class="input-block-level required"/></td>
                <td class="span1"><label class="control-label">金额</label></td>
                <td><form:input id="fee" path="soInvoice.fee" htmlEscape="false"  class="input-block-level number" readonly="true"/></td>
            </tr>
            <tr>
                <td><label class="control-label">联系人</label></td>
                <td><form:input path="soInvoice.contactName" htmlEscape="false"  class="input-block-level realName required"/></td>
                <td><label class="control-label">联系电话</label></td>
                <td><form:input path="soInvoice.contactPhone" htmlEscape="false"  class="input-block-level phone required"/></td>
            </tr>
            <tr>
                <td><label class="control-label">邮编</label></td>
                <td><form:input path="soInvoice.postCode" htmlEscape="false"  class="input-block-level zipCode required"/></td>
                <td><label class="control-label">邮寄地址</label> </td>
                <td colspan="5"><form:input path="soInvoice.postAddress" htmlEscape="false"  class="input-block-level required"/></td>
            </tr>

            <tr>
                <td><label class="control-label">电子发票接收邮箱</label></td>
                <td colspan="5">
                    <form:textarea cssStyle="color: red;" path="soInvoice.remark" htmlEscape="false"  value="1" Class="input-block-level"  rows="3"/></td>
                      <%--  <span style="color: red;">根据营业税改征增值税的要求2016年5月1日起申请发票需如实填写以下内容： 单位名称、税号、开户行名称、账号、单位地址、单位电话。
                        如有缺项、漏项或与实施不符，将无法开具培训费发票。</span>

                    </form:textarea>--%>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
<%--    <a href="${ctx}/sys/sys/alipySubmit" target="_blank">支付</a>--%>
</div>
</div>
    </form:form>
<style>
    #linknav ul{text-align:center;list-style-type:none;}
    #linknav ul li{display:inline;list-style-type:none;}

</style>

<ul class="pager wizard">
    <li class="previous"  ><input type='button' class='btn button-previous' name='previous' value='上一步' /></li>
    <li class="next" ><input type='button' class='btn button-next btn-primary' name='next' value='下一步' /></li>
    <li class="next finish" style="display:none;"><input type='button' class='btn btn-primary' name='next' value='提 交'  /></li>
</ul>
</div>
</body>
</html>