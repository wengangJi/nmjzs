<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<meta name="decorator" content="default"/>
    <link href="${ctxStatic}/css/cu_red.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript"> 
		$(document).ready(function() {
			$("#menu a.menu").click(function(){
				$("#menu li.menu").removeClass("active");
				$(this).parent().addClass("active");
				if(!$("#openClose").hasClass("close")){
					$("#openClose").click();
				}
			});
		});
	</script>
</head>
<body>
	<div id="main">
        <div style="Z-INDEX: 200; POSITION: relative" id="header" class="top">

            		<div id="in-nav">

            		</div>
            		<div id="top-nav" class="top-nav navbar navbar-fixed-top" style="height: 30px;">
            	      <div class="navbar-inner" style="height: 30px;">
            	         <div class="nav-collapse">
            	           <ul class="nav pull-right">
                               <shiro:hasPermission name="cms:site:select">
                                   <li class="dropdown">
                                       <a class="dropdown-toggle" data-toggle="dropdown" href="#">${fnc:getSite(fnc:getCurrentSiteId()).name}<b class="caret"></b></a>
                                       <ul class="dropdown-menu">
                                           <c:forEach items="${fnc:getSiteList()}" var="site"><li><a href="${ctx}/cms/site/select?id=${site.id}&flag=1">${site.name}</a></li></c:forEach>
                                       </ul>
                                   </li>
                               </shiro:hasPermission>
            				 <li><a href="${pageContext.request.contextPath}${fns:getFrontPath()}/index-${fnc:getCurrentSiteId()}.html" target="_blank" title="访问网站主页"><i class="icon-home"></i></a></li>
            			  	 <li class="dropdown">
            				    <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息">您好, <shiro:principal property="name"/></a>
            				    <ul class="dropdown-menu">
            				      <li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
            				      <li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
            				    </ul>
            			  	 </li>
            			  	 <li><a href="${ctx}/logout" title="退出登录">退出</a></li>
            	           </ul>
            	         </div><!--/.nav-collapse -->
            	      </div>
            	    </div>
            <div class="topLogo">
                <div class="topLogoL">${fns:getConfig('productName')}</div>
                <div class="topLogoR">
                    <div class="topInput"><input style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; PADDING-BOTTOM: 0px; LINE-HEIGHT: 25px; MARGIN: 0px; PADDING-LEFT: 0px; WIDTH: 150px; PADDING-RIGHT: 0px; FLOAT: left; HEIGHT: 25px; COLOR: #666; FONT-SIZE: 12px; BORDER-TOP: 0px; BORDER-RIGHT: 0px; PADDING-TOP: 0px" id="seachKey" class="" value="文件搜索" type="text">
                        <div style="Z-INDEX: 1000; DISPLAY: none" id="searchColleageBox" class="searchBox"></div>
                    </div>
                    <div class="searchBut"><a href="javascript:search('common', '/search')"><img alt="搜索 " align="absMiddle" src="${ctxStatic}/img/bt_global_search.gif" width="70" height="30"></a></div>
                </div>
            </div>
            <div class="topMenu">

          <div class="navbar ">
          <div class="navbar-inner">
             <div class="nav-collapse">
               <ul id="menu" class="nav">
                 <c:set var="firstMenu" value="true"/>
                 <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
                    <c:if test="${menu.parent.id eq '1' && menu.isShow eq '1'}">
                        <li class="menu ${firstMenu ? ' active' : ''}"><a class="menu" href="${ctx}/sys/menu/tree?parentId=${menu.id}" target="menuFrame" >${menu.name}</a></li>
                        <c:if test="${firstMenu}">
                            <c:set var="firstMenuId" value="${menu.id}"/>
                        </c:if>
                        <c:set var="firstMenu" value="false"/>
                    </c:if>
                 </c:forEach>
               </ul>
             </div><!--/.nav-collapse -->
          </div>
          </div>
            <div class="topLine"></div>
        </div>
    </div>
	    <div class="container-fluid">
			<div id="content" class="row-fluid">
				<div id="left">
					<iframe id="menuFrame" name="menuFrame" src="${ctx}/sys/menu/tree?parentId=${firstMenuId}&childId=${secondMenuId}" style="overflow:visible;"
						scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
				</div>
				<div id="openClose" class="close">&nbsp;</div>
				<div id="right">
					<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;"
						scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
				</div>
			</div>
		    <div id="footer" class="row-fluid">
	            Copyright &copy; 2014-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')}&nbsp;&nbsp;&nbsp;&nbsp;联系电话：0471-6925612
			</div>
		</div>
	</div>
	<script type="text/javascript"> 
		var leftWidth = "160"; // 左侧窗口大小
		function wSize(){
			var minHeight = 500, minWidth = 980;
			var strs=getWindowSize().toString().split(",");
			$("#menuFrame, #mainFrame, #openClose").height((strs[0]<minHeight?minHeight:strs[0])-$("#header").height()-$("#footer").height()-46);
			$("#openClose").height($("#openClose").height()-5);
			if(strs[1]<minWidth){
				$("#main").css("width",minWidth-10);
				$("html,body").css({"overflow":"auto","overflow-x":"auto","overflow-y":"auto"});
			}else{
				$("#main").css("width","auto");
				$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
			}
			$("#right").width($("#content").width()-$("#left").width()-$("#openClose").width()-5);
		}
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>