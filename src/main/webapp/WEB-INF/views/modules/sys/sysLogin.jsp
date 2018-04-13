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
	<script type="text/javascript">
        window.onload= function(){
            var DevicePath,mylen,ret;
            var s_simnew31;
            //创建插件或控件
            if(navigator.userAgent.indexOf("MSIE")>0 && !navigator.userAgent.indexOf("opera") > -1)
            {
                s_simnew31=new ActiveXObject("Syunew3A.s_simnew3");
            }
            else
            {
                s_simnew31= document.getElementById('s_simnew31');
            }
            DevicePath = s_simnew31.FindPort(0);//'来查找加密锁，0是指查找默认端口的锁
            if( s_simnew31.LastError== 0 )
            {
                loginForm.KeyID.value=toHex(s_simnew31.GetID_1(DevicePath))+toHex(s_simnew31.GetID_2(DevicePath));
                if( s_simnew31.LastError!= 0 )
                {
                    $.jBox.error( "获取用户名错误,错误码是"+s_simnew31.LastError.toString());
                    return false;
                }

                //获取设置在锁中的用户名
                //先从地址0读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
                ret=s_simnew31.YReadEx(0,1,"ffffffff","ffffffff",DevicePath);
                mylen =s_simnew31.GetBuf(0);
                //再从地址1读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
                loginForm.username.value=s_simnew31.YReadString(1,mylen, "ffffffff", "ffffffff", DevicePath);

                if( s_simnew31.LastError!= 0 )
                {
                    $.jBox.error(  "Err to GetUserName,ErrCode is:"+s_simnew31.LastError.toString());
                    return false;
                }

                //获到设置在锁中的用户密码,
                //先从地址20读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
                ret=s_simnew31.YReadEx(20,1,"ffffffff","ffffffff",DevicePath);
                mylen =s_simnew31.GetBuf(0);
                //再从地址21读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
                loginForm.password.value=s_simnew31.YReadString(21,mylen,"ffffffff", "ffffffff", DevicePath);
                /*                    if (loginForm.password.value != s_simnew31.YReadString(21,mylen,"ffffffff", "ffffffff", DevicePath)) {
                 $.jBox.error("输入的密码与加密狗不匹配！");
                 return false;
                 }*/
                if( s_simnew31.LastError!= 0 )
                {
                    $.jBox.error( "获取用户密码错误,错误码是:"+s_simnew31.LastError.toString());
                    return false;
                }

            }
        } ;
		$(document).ready(function() {
			/*$.backstretch([
 		      "${ctxStatic}/images/dalou.jpg",
 		      "${ctxStatic}/images/caoyuan1.jpg",
 		      "${ctxStatic}/images/33.jpg"
 		  	], {duration: 5000, fade: 2000});*/
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写身份证号."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架中，则跳转刷新上级页面
		if(self.frameElement && self.frameElement.tagName=="IFRAME"){
			parent.location.reload();
		}

        var digitArray = new Array('0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f');

        function toHex( n ) {

            var result = ''
            var start = true;

            for ( var i=32; i>0; ) {
                i -= 4;
                var digit = ( n >> i ) & 0xf;

                if (!start || digit != 0) {
                    start = false;
                    result += digitArray[digit];
                }
            }

            return ( result == '' ? '0' : result );
        }
        function login_onclick()
        {
            var str = "${Constants.AUDIT_USER_LIST}" || "";
            var auditUsers = str.split(",");
            if ($("#username").val() != "" && $.inArray($("#username").val(),auditUsers) == -1) {
                return true;
            }
            try
            {
                var DevicePath,mylen,ret;
                var s_simnew31;
                //创建插件或控件
                if(navigator.userAgent.indexOf("MSIE")>0 && !navigator.userAgent.indexOf("opera") > -1)
                {
                    s_simnew31=new ActiveXObject("Syunew3A.s_simnew3");
                }
                else
                {
                    s_simnew31= document.getElementById('s_simnew31');
                }
                DevicePath = s_simnew31.FindPort(0);//'来查找加密锁，0是指查找默认端口的锁
                if( s_simnew31.LastError!= 0 )
                {
                    $.jBox.error( "未发现加密锁，请插入加密锁");
                    return false;
                }
                else
                {
                    //'读取锁的ID
                    loginForm.KeyID.value=toHex(s_simnew31.GetID_1(DevicePath))+toHex(s_simnew31.GetID_2(DevicePath));
                    if( s_simnew31.LastError!= 0 )
                    {
                        $.jBox.error( "获取用户名错误,错误码是"+s_simnew31.LastError.toString());
                        return false;
                    }

                    //获取设置在锁中的用户名
                    //先从地址0读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
                    ret=s_simnew31.YReadEx(0,1,"ffffffff","ffffffff",DevicePath);
                    mylen =s_simnew31.GetBuf(0);
                    //再从地址1读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
                    loginForm.username.value=s_simnew31.YReadString(1,mylen, "ffffffff", "ffffffff", DevicePath);
/*                    if (loginForm.username.value != s_simnew31.YReadString(1,mylen, "ffffffff", "ffffffff", DevicePath)) {
                        $.jBox.error("输入的登录名与加密狗不匹配！");
                        return false;
                    }*/
                    if( s_simnew31.LastError!= 0 )
                    {
                        $.jBox.error(  "Err to GetUserName,ErrCode is:"+s_simnew31.LastError.toString());
                        return false;
                    }

                    //获到设置在锁中的用户密码,
                    //先从地址20读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
                    ret=s_simnew31.YReadEx(20,1,"ffffffff","ffffffff",DevicePath);
                    mylen =s_simnew31.GetBuf(0);
                    //再从地址21读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
                    loginForm.password.value=s_simnew31.YReadString(21,mylen,"ffffffff", "ffffffff", DevicePath);
/*                    if (loginForm.password.value != s_simnew31.YReadString(21,mylen,"ffffffff", "ffffffff", DevicePath)) {
                        $.jBox.error("输入的密码与加密狗不匹配！");
                        return false;
                    }*/
                    if( s_simnew31.LastError!= 0 )
                    {
                        $.jBox.error( "获取用户密码错误,错误码是:"+s_simnew31.LastError.toString());
                        return false;
                    }

                    loginForm.submit ();
                }
            }

            catch(e)
            {
                $.jBox.error(e.name + ": " + e.message+"。可能是没有安装相应的控件或插件");
                return false;
            }

        }
	</script>
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

    <div class="container">
        <tags:message content="${message}"/>
		<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
		<%String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);%>
		<div id="messageBox" class="alert alert-error <%=error==null?"hide":""%>"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error"><%=error==null?"":"com.thinkgem.jeesite.modules.sys.security.CaptchaException".equals(error)?"验证码错误, 请重试.":"用户或密码错误, 请重试." %></label>
		</div>

        <%String errorLock = (String) request.getAttribute("isValidateLockLogin");%>
        <div id="messageBox" class="alert alert-error <%=errorLock==null?"hide":""%>"><button data-dismiss="alert" class="close">×</button>
            <label id="loginError2" class="error"><%=errorLock%></label>
        </div>
        <div id="login-wraper">
            <form id="loginForm"  class="form login-form" action="${ctx}/login" method="post">
                <legend><span style="color:#808080">系统登陆</span></legend>
                <div class="body">
					<div class="control-group">
						<div class="controls">
							<input type="text" id="username" name="username" class="required" value="${username}" placeholder="身份证号">
						</div>
					</div>
					
					<div class="control-group">
						<div class="controls">
							<input type="password" id="password" name="password" class="required" placeholder="密码"/>
						</div>
					</div>
                        <%--<input type="hidden" id="username" name="username" class="required" value="${username}" placeholder="登录名">
                        <input type="hidden" id="password" name="password" class="required" placeholder="密码"/>--%>
                    <input name="KeyID" type="hidden" id="KeyID">
					<c:if test="${isValidateCodeLogin}"><div class="validateCode">
						<label for="password">密　码：</label>
						<tags:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
					</div></c:if>
                </div>
                <div class="footer">
<%--                    <label class="checkbox inline">
                        <input type="checkbox" id="rememberMe" name="rememberMe"> <span style="color:#08c;">记住我</span>
                    </label>--%>
                    <input class="btn btn-primary" type="submit" value="登 录"  onclick="return login_onclick();"/>
                    <a href="${ctx}/signup" class="btn btn-primary">注册</a>
                </div>
                <div id="softkey">
                    <a href="${ctx}/softkey/driver">下载加密狗驱动</a> &nbsp;
                    <a href="${ctx}/softkey/setting">设置加密狗</a>
                </div>
            </form>
        </div>
    </div>
    <footer class="white navbar-fixed-bottom">
		 Copyright &copy; 2014-${fns:getConfig('copyrightYear')}内蒙古自治区建筑业协会     联系电话：0471-6925612    交流QQ群：192254282  132727445
       <%-- Copyright &copy; 2014-${fns:getConfig('copyrightYear')} <a href="${pageContext.request.contextPath}${fns:getFrontPath()}">${fns:getConfig('productName')}</a>--%>
    </footer>
  </body>
</html>