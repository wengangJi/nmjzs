<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/common/typica-login.css">
	<style type="text/css">
		.control-group{border-bottom:0px;}
        #softkey {
            margin-top: 10px;
        }
	</style>
    <script src="${ctxStatic}/common/backstretch.min.js"></script>
</head>
<body>
<embed id="s_simnew31"  type="application/npsyunew3-plugin" hidden="true"> </embed><!--创建firefox,chrome等插件-->
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
         <%-- <a class="brand" href="${ctx}"><img src="${ctxStatic}/images/logo1.png" alt="CIMS Admin" style="height:40px;"></a>--%>
        </div>
      </div>
    </div>

<tags:message content="${message}"/>

<%String errorLock = (String) request.getAttribute("isValidateLockLogin");%>
<div id="messageBox" class="alert alert-error <%=errorLock==null?"hide":""%>"><button data-dismiss="alert" class="close">×</button>
    <label id="loginError2" class="error"><%=errorLock%></label>
</div>

    <div class="container">

        <div  style="text-align: center;font-size: 30px;margin-top: 40px;">
            <div class="control-group">
                <a href="http://60.31.29.42:8001/nmjzs/a/login" target="_blank">学员入口1:</a>&nbsp;&nbsp;&nbsp;&nbsp;<c:if test="${color1 eq 'red'}"><span style="background-color: red;">爆满</c:if><c:if test="${color1 eq 'yellow'}"><span style="background-color: yellow;">拥挤</c:if><c:if test="${color1 eq 'blue'}"><span style="background-color: blue;">畅通</c:if></span>
            </div>
            </br>
            <div class="control-group">
                <a href="http://60.31.29.42:8002/nmjzs/a/login" target="_blank">学员入口2:</a>&nbsp;&nbsp;&nbsp;&nbsp;<c:if test="${color2 eq 'red'}"><span style="background-color: red;">爆满</c:if><c:if test="${color2 eq 'yellow'}"><span style="background-color: yellow;">拥挤</c:if><c:if test="${color2 eq 'blue'}"><span style="background-color: blue;">畅通</c:if></span>
            </div>
            </br>
            <div class="control-group">
                <a href="http://60.31.29.42:8003/nmjzs/a/login" target="_blank">学员入口3:</a>&nbsp;&nbsp;&nbsp;&nbsp;<c:if test="${color3 eq 'red'}"><span style="background-color: red;">爆满</c:if><c:if test="${color3 eq 'yellow'}"><span style="background-color: yellow;">拥挤</c:if><c:if test="${color3 eq 'blue'}"><span style="background-color: blue;">畅通</c:if></span>
            </div>
            </br>
         <%--   <div class="control-group">
                <a href="http://60.31.29.42:8004/nmjzs/a/login" target="_blank">管理入口4:</a>&nbsp;&nbsp;&nbsp;&nbsp;<c:if test="${color4 eq 'red'}"><span style="background-color: red;">爆满</c:if><c:if test="${color4 eq 'yellow'}"><span style="background-color: yellow;">拥挤</c:if><c:if test="${color4 eq 'blue'}"><span style="background-color: blue;">畅通</c:if></span>
            </div>
--%>
        </div>
    </div>



</div>



  </body>
</html>