<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2014/12/5
  Time: 23:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>打印页面</title>
    <link href="${ctxStatic}/print/PrintHtml.css" rel="stylesheet" type="text/css" />
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/print/jquery.timeout.js" type="text/javascript"></script>
    <script src="${ctxStatic}/print/LodopFuncs.js" type="text/javascript"></script>
</head>
<body>
<div id="showDiv"></div>
<input type="hidden" id="printType" name="printType" value="${printType}" />
<input type="hidden" id="print_status" name="print_status" />
<input type="hidden" id="heightNum" name="heightNum" value="${heightNum}"/>
<input type="hidden" id="print_multi_page" name="print_multi_page" value="${print_multi_page}"/>
<input type="hidden" id="soid" name="soid" value="${soid}"/>
<div id="printData" style="visibility: hidden">${printData}</div>
<script src="${ctxStatic}/print/webprinter.js" type="text/javascript"></script>
<script src="${ctxStatic}/print/PrintHtml.js" type="text/javascript"></script>
</body>
</html>
