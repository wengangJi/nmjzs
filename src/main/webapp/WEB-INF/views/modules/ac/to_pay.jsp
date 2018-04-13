<%@ page contentType="text/html;charset=utf-8" language="java" %>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>

<%!


	private String getContent(Map params, String privateKey) {
		List keys = new ArrayList(params.keySet());
		Collections.sort(keys);
		String prestr = "";
		for (int i = 0; i < keys.size(); i++) {
			String key = (String) keys.get(i);
			String value = (String) params.get(key);
			if (i == keys.size() - 1) {
				prestr = prestr + key + "=" + value;
			} else {
				prestr = prestr + key + "=" + value + "&";
			}
		}
		return prestr + privateKey;
	}
%>
<%
String urlParam = (String)request.getAttribute("sHtmlText");

%>
<html>
<head>
</head>
<body>
<%
    out.print(urlParam);
%>


</body>
</html>
<script>
</script>