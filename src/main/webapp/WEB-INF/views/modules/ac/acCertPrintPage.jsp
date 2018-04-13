<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>证书打印</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <link href="${ctxStatic}/print/print.css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jqprint/jquery.jqprint-0.3.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            $("#print").click(function(){

                //$("div#myPrintArea").printArea();
                //$("div#myPrintArea").printPage();
                $("div#credit").jqprint();

            });
        });

    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#choosePlan" data-toggle="tab">打印</a></li>
</ul>
<div style="width: 98%;height: 750px;margin:-9px 0px 0px 0px ;border-style: ridge;  ">
<div style=' width: 960px;height: 650px;padding:40px 0px 0px 100px; ' id="credit ;" >
<div>


<img src="${ctxStatic}/images/creadit.jpg" style=" width: 960px;height: 650px;">

</div>

    <div>
        <div style="margin:-118px 0px 104px 510px; ">
            <span style="margin:0px 0px 10px 106px; ">&nbsp;&nbsp;&nbsp; ${fns:getYear(newDate)}&nbsp;&nbsp;&nbsp;&nbsp; ${fns:getMonth(newDate)}&nbsp;&nbsp;&nbsp;&nbsp;${fns:getDay(newDate)}</span>
        </div>
<div style='margin:-511px 0px 104px 110px; '>
    <img src="" style="width: 150px;height: 200px">
</div>
    <div style="margin:-57px 0px 104px 180px;">
        ${servAcInfo.name}
    </div>
    <div style="margin:-74px 0px 104px 180px;">
       ${fns:getCompanyById(servAcInfo.companyId).companyName}
    </div>
    <div style="margin:-81px 0px 104px 180px;">
        ${servAcInfo.idNo}
    </div>
    <div style="margin:-89px 0px 104px 180px;">
        ${servAcInfo.certNo}
    </div>

    <div style="margin:-400px 0px 104px 526px;">
      <span>   ${servAcInfo.name}</span><span style="margin:0px 0px 10px 122px; ">&nbsp;&nbsp;&nbsp;${fns:getYear(soPlan.applyDate)}&nbsp;&nbsp;&nbsp;&nbsp;${fns:getMonth(soPlan.applyDate)}&nbsp;&nbsp;&nbsp;&nbsp;${fns:getDay(soPlan.applyDate)}</span>
    </div>

    </div>

</div>
</br>
<div style="text-align: center;">
    <input id="print" type="button" value="打 印" class="btn"/>
    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>

</div>
</body>
</html>