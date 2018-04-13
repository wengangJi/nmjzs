<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>减免学时申请</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
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
                'tabClass': 'nav nav-tabs',
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
                    var $valid = $("#inputForm").valid();
                    if(!$valid) {
                        $validator.focusInvalid();
                        return false;
                    }
                },
                'onTabClick': function(tab, navigation, index) {
                    var $valid = $("#inputForm").valid();
                    if(!$valid) {
                        $validator.focusInvalid();
                        return false;
                    }
                }
            });
            $('#rootwizard .finish').click(function() {
                var $valid = $("#inputForm").valid();
                if(!$valid) {
                    $validator.focusInvalid();
                    return false;
                }
                $("#inputForm").submit();
            });
        });
    </script>
</head>
<body>
<tags:message content="${message}"/>
<div id="rootwizard" >
    <ul class="nav nav-tabs">
        <li class="active"><a href="#basicInfo" data-toggle="tab">基本信息</a></li>
        <li><a href="#cpUpload" data-toggle="tab">附件信息</a></li>
    </ul>
    <form:form id="inputForm" modelAttribute="soHours" action="${ctx}/hours/reduceModify" method="post" class="form-horizontal">
        <div class="tab-content">
            <div class="tab-pane active" id="basicInfo">
                <table id="contentTable" class="table table-bordered table-condensed  table-hover">
                    <form:hidden path="planId" value ="${soHours.planId}"/>
                    <thead>
                    <tr align="center">
                        <td colspan="6" style="text-align: center"><h3>继续教育冲抵学时申请</h3></td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><label class="control-label">申报单号</label></td>
                        <td><form:input id="soid" path="soid" htmlEscape="false" class=" input-medium"  readonly="true"/></td>
                        <td><label class="control-label">培训项目</label></td>
                        <td><form:input id="planId" path="rsrvStr3" value="${fns:getPlanById(soHours.planId).planName}" htmlEscape="false" class="input-block-level" readonly="true"/></td>
                    </tr>
                    <tr>
                        <td><label class="control-label">申请人姓名</label></td>
                        <td><form:input id="userName" path="userName" htmlEscape="false" class="required input-medium" disabled="true" value="${fns:getUser().name}"/></td>
                        <td><label class="control-label">继续教育证书编号</label></td>
                        <td><form:input id="certNo" path="certNo" htmlEscape="false" class="required input-medium"/></td>
                    </tr>

                    <tr>
                        <td><label class="control-label">执业单位</label></td>
                        <td colspan="3"><form:input path="companyName" class="required input-block-level"/></td>
                    </tr>
                    <tr>
                        <td><label class="control-label">申请冲抵的学时数</label></td>
                        <td colspan="3"><form:input path="hours" class="digits required input-block-level"/></td>
                    </tr>

                    <tr>
                        <td><label class="control-label">冲抵学时的理由</label></td>
                        <td colspan="3"><form:input path="reduceReason" class="required input-block-level"/></td>
                    </tr>
                    <tr>
                        <td><label class="control-label">具体情况说明</label></td>
                        <td colspan="3"><form:textarea rows="3" path="remark" class="input-block-level"/></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- 附件信息-->
            <div class="tab-pane" id="cpUpload">
                <iframe id="cpUploadFrame" name="cpUploadFrame" src="${ctx}/hours/acReduceAttachment?soid=${soHours.soid}&appId=${Constants.GLOBAL_AC_APP_ID}&soType=${Constants.SO_TYPE_REDUCE_HOURS}" style="overflow:visible;"
                        scrolling="yes" frameborder="no" width="100%" height="500"></iframe>
            </div>

            <ul class="pager wizard">
                <li class="previous"  ><input type='button' class='btn button-previous' name='previous' value='上一步' /></li>
                <li class="next" ><input type='button' class='btn button-next btn-primary' name='next' value='下一步' /></li>
                <li class="next finish" style="display:none;"><input type='button' class='btn btn-primary' name='next' value='保 存' /></li>
            </ul>
        </div>
    </form:form>
</div>
</body>
</html>