<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>企业资质</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#eqForm").submit();
            return false;
        }
    </script>
    <link href="${ctxStatic}/print/print.css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jqprint/jquery.jqprint-0.3.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            $("input#biuuu_button").click(function(){

                //$("div#myPrintArea").printArea();
                //$("div#myPrintArea").printPage();
                $("div#myPrintArea").jqprint();

            });
        });

    </script>
    <style type="text/css">
        #myPrintArea table td {
        .mine
        font-size: 12px;
            font-family: '仿宋';

            font-size: 13px;
            font-family: '宋体';
            padding: 4px; margin-top: 4px;;
        .r20
        }
    </style>
</head>
<body>
<tags:message content="${message}"/>
<%--
<form:form id="eqForm" modelAttribute="soCpResumeList" action="${ctx}/cp/soCp/cpResumePage" method="post" >
--%>
    <%--<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>--%>
<div id="myPrintArea">
    <table id="contentTable" class="table table-bordered table-condensed table-hover">
        <thead>
        <tr align="center"><td colspan="8" style="text-align: center"><h3>工 作 简 历</h3></td></tr>
        </thead>
        <tr style="text-align: center">
            <td>序 号</td><td>聘用开始时间</td><td>聘用结束时间</td><td>工作单位</td><td>职务</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${soCpResumeList}" var="soCpResume">
        <tr>
           <td>${soCpResume.seq}</td>
           <td><%--<input id="effDate" name="effDate" type="text" readonly="readonly"   disabled="true"
                        maxlength="50" class="input-medium Wdate"
                        value="<fmt:formatDate value="${soCpResume.effDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>--%>
               <fmt:formatDate value="${soCpResume.effDate}" pattern="yyyy-MM-dd"/>
           </td>
           <td><%--<input id="expDate" name="expDate" type="text" readonly="readonly"   disabled="true"
                      maxlength="50" class="input-medium Wdate"
                      value="<fmt:formatDate value="${soCpResume.expDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>--%>
               <fmt:formatDate value="${soCpResume.expDate}" pattern="yyyy-MM-dd"/></td>
           <td><%--<form:input path=""   value="${soCpResume.company}" class="input-medium" disabled="true"/>--%>${soCpResume.company}</td>
           <td><%--<form:input path=""   value="${soCpResume.position}" class="input-medium" disabled="true"/>--%>${soCpResume.position}</td>
        </tr>
        </c:forEach>
<%--
        </form:form>
--%>


<%--
        <form:form id="eqForm3" modelAttribute="soCpPerformance" action="${ctx}/cp/soCp/cpPerformancePage" method="post" class="breadcrumb form-search">
--%>

<%--
        <c:forEach items="${soCpPerformanceList}" var="soCpPerformance">
--%>
        <tr><td colspan="5" style="text-align: center"><h3>安 全 生 产 业 绩</h3></td></tr>
        <tr>
            <td><label class="control-label">受表彰情况</label></td> <td colspan="4">
          <%-- <form:textarea path="honorCase"   class="input-block-level" rows="4" disabled="true"/>--%>
          ${soCpPerformance.honorCase} <br/><br/></br></br> <br/><br/></br></br>
        </td>
        </tr>
        <tr>
            <td><label class="control-label">受处罚情况</label></td> <td colspan="4">
         <%-- <form:textarea path="honorCase"   class="input-block-level" rows="4" disabled="true"/>--%>
          ${soCpPerformance.penaltyCase} <br/><br/></br></br><br/><br/></br></br>

        </td>
        </tr>
<%--
        </c:forEach>
--%>
<%--
        </form:form>
--%>
    </table>

</div>
</tbody>
<div style="text-align: center;">
    <input id="biuuu_button" type="button" value="打 印" class="btn"/>
    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>
</body>
</html>
