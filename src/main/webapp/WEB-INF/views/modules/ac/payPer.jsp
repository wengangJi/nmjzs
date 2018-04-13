<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>付费课程</title>

</head>
<body>


<%--<form:form id="inputForm"  action="${ctx}/sys/sys/alipySubmit" method="post" class="form-horizontal">
   <label>支付金额</label> <form:input path="fee" id="fee"></form:input>
    <input id="btnSubmit" class="btn btn-primary" type="submit" value="支 付"/>

</form:form>--%>
合作身份者ID:2088901872679630
</br>   </br>
安全检验码:v7ywwztkjnjbqy47s7ael92rxa489hvb
</br>   </br>
签约支付宝账号或卖家收款支付宝帐户:bank@365cp.com
<br>       </br>
防钓鱼功能开关，'0'表示该功能关闭，'1'表示该功能开启。默认为关闭 :0
<br>      </br>
页面编码 :UTF-8
<br>    </br>
加密方式:MD5
<br>     </br>
访问模式:http
<br>   </br>
收款方名称:cai365
<br>     </br>
支付接口:https://mapi.alipay.com/gateway.do
<br>      </br>


<a href="${ctx}/sys/sys/alipySubmit" class='btn btn-primary'   target="_blank" type='button'>支付宝测试</a>
</body>
</html>
