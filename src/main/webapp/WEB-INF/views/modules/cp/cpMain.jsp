<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员申报</title>
    <meta name="decorator" content="default"/>
</head>
<body>
<div id="content" class="row-fluid">
    <div id="left">
        <iframe id="cpMenuFrame" name="cpMenuFrame" src="${ctx}/cp/soCp/tree?appId=CP" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%"></iframe>
    </div>
    <div id="openClose" class="close">&nbsp;</div>
    <div id="right">
        <iframe id="cpMainFrame" name="cpMainFrame" src="${ctx}/cp/soCp/none?appId=CP" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%"></iframe>
    </div>

</div>
<script type="text/javascript">
    var leftWidth = "160"; // 左侧窗口大小
    function wSize(){
        var strs=getWindowSize().toString().split(",");
        $("#cpMenuFrame, #cpMainFrame, #openClose").height(strs[0]-5);
        $("#right").width($("body").width()-$("#left").width()-$("#openClose").width()-5);
    }
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>