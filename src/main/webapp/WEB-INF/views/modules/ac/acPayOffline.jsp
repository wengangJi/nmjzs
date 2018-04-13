<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
  <title>培训列表</title>
  <meta name="decorator" content="default"/>
  <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#inputForm").validate({

                submitHandler: function(form){
                    if ($("#ofilePath").attr("src") == "") {
                        $.jBox.error("请上传图片！");
                        return false;
                    }
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
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
  <li class="active"><a href="#">线下支付</a></li>
</ul>
<%--<form:form id="searchForm" modelAttribute="seal" action="${ctx}/plan/lockList" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
&lt;%&ndash;  <div>

    &lt;%&ndash;<label>培训名称：</label><form:input path="planName" htmlEscape="false" maxlength="50" class="input-small"/>&ndash;%&gt;
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
  </div>&ndash;%&gt;
</form:form>--%>

<tags:message content="${message}"/>
<form:form id="inputForm" modelAttribute="soPlan" action="${ctx}/plan/saveOflineInfo" method="post" >
<form:hidden path="soid"/>
    <div class="tab-content">
        <!--首页信息-->
        <div class="tab-pane active" id="cpTitle">
            <br>
            <div class="span10"  style="margin-left: 380px;">
                <p style="text-align: left;margin-bottom: 20px; font-size: 20px;">
                    <strong>账号信息：</strong><br><br>
                    开户银行名称：中国建设银行 呼和浩特东达支行<br><br>
                    户名：内蒙古自治区建筑业协会<br><br>
                    银行账号：<u>15001706693050000187</u><br><br>
                    开户行号：<u>105191084082</u>
                </p>
            </div>
            <br><br>
            <div class="span10"  style="margin-left: 380px;">
                <p style="text-align: left;margin-bottom: 20px; font-size: 16px;">
                    <strong>支付方式：</strong><br><br>
                    1、使用本人网银进行支付，将支付成功页面截图上传。<br><br>
                    2、对公汇款、将回执单备注学员姓名及申报单号(或身份证号)上传。<br><br>
                </p>
            </div>

            <div class="span10" style="margin-left: 300px;">
                <div class="control-group">
                    <div class="controls">
                        <label class="control-label">学员名称：<span style="color: red">*</span></label> <form:input path="oflineUser"  class="required realName input-medium" />
                        <label class="control-label">网银交易流水：</label> <form:input path="oflineNo"  class="input-medium" />注：对公汇款无需填写
                    </div>
                    <div class="controls">
                        <label class="control-label">备     注：<span style="color: red">*</span></label> <form:textarea path="oflineRemarks" placeholder="单位名称" cssStyle="width: 430px;"  class="required input-medium"   rows="3" />
                    </div>
                </div>

                <div class="span10"  >
                    <div  class="control-group" >
                        <div class="controls">
                           <span style="margin-left: 10px;">
                                <img alt="" src="" id="ofilePath"/>
                                <tags:upload id="oflinePath" name="oflinePath" value="${soPlan.oflinePath}"  width="750" height="1024" ></tags:upload>
                           </span>
                        </div>

                    </div>
                </div>

                <ul >
                    <li style="margin-left: 200px;"> <input id="btnSubmit" class="btn btn-primary" type="submit" value="提    交" name="submit"></li>
                </ul>
            </div>



</form:form>
<div class="pagination">${page}</div>




</html>
