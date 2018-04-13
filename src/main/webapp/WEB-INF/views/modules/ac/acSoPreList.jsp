<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>学时审核</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <!-- blueimp Gallery styles -->
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/blueimp-gallery.min.css">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#searchForm").validate({
                submitHandler: function (form) {
                    loading('正在查询，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });


        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">待审支付</a></li>
</ul>

<form:form id="searchForm" modelAttribute="soPlan" action="${ctx}/plan/findOflinePre" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label class="control-label" for="oflineUser">学员名称 ：</label>
    <form:input id="oflineUser" path="oflineUser" htmlEscape="false" class=" input-medium"/>

    <label class="control-label" for="oflineSts">审核情况 ：</label>
    <form:select id="oflineSts" path="oflineSts" class="input-medium"><form:options items="${fns:getDictList('OFLINE_STS')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>



    <label class="control-label" for="oflineNo">网银交易流水 ：</label>
    <form:input id="oflineNo" path="oflineNo" htmlEscape="false" class=" input-medium"/>
   &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<tags:message content="${message}"/>
<!-- The blueimp Gallery widget -->
<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>
<fieldset>
    <table id="contentTable" class="table  table-bordered table-condensed table-hover">
        <thead>
        <tr>
            <th>申报单号</th>
            <th>申报专业</th>
            <th>申报时间</th>
            <th>项目学时</th>
            <th>项目费用</th>
            <th>学员名称</th>
            <th>证件号码</th>
            <th>网银交易流水</th>
            <th>备注</th>
            <th>附件</th>
            <th>缴费情况</th>
            <th>审核情况</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
<c:forEach items="${page.list}" var="soPlan">

<tr>

    <td><a href="${ctx}/plan/findSoAllInfo?soid=${soPlan.soid}">${soPlan.soid}</a></td>
    <td>${fns:getDictLabel(fns:getPlanById(soPlan.planId).majorId, 'MAJOR', '')}</td>
    <td><fmt:formatDate value="${soPlan.applyDate}" pattern="yyyy-MM-dd"/></td>
    <td>${fns:getPlanById(soPlan.planId).planHours}</td>
    <td style="color: red;font-size: 16px;">${soPlan.fee}</td>
    <td>${soPlan.oflineUser}</td>
    <td>${soPlan.rsrvStr2}</td>
    <td>${soPlan.oflineNo}</td>
    <td>${soPlan.oflineRemarks}</td>
    <td>
             <span class="preview">
                <div style="float: left;margin-left: 10px;">
                   <%-- <a href="${soPlan.oflinePath}" title="" download="${soPlan.oflinePath}" data-gallery>
                        <img style="height: 80px;width: 120px;" src="${soPlan.oflinePath}">
                    </a>--%>
                       <a href="${soPlan.oflinePath}" title=""  data-gallery>
                           查看附件
                       </a>
                </div>
            </span>
    </td>
    <td style="color: red;">${fns:getDictLabel(soPlan.feeState, 'FEE_STATE', '')}</td>
    <td style="color: red;">${fns:getDictLabel(soPlan.oflineSts, 'OFLINE_STS', '')}</td>
    <td>
    <c:if test="${soPlan.oflineSts eq '0'}">
            <a href="${ctx}/plan/passSoPlanPre?soid=${soPlan.soid}" onclick="loading('正在查询，请稍等...');">通过</a>
            <a href="${ctx}/plan/noPassSoPlanPre?soid=${soPlan.soid}" onclick="loading('正在查询，请稍等...');">不通过</a>
    </c:if>
    </td>


</tr>
</c:forEach>
        </table>
</fieldset>

<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/load-image.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/canvas-to-blob.min.js"></script>
<!-- blueimp Gallery script -->
<script src="${ctxStatic}/jquery-upload/js/jquery.blueimp-gallery.min.js"></script>
<div class="pagination">${page}</div>

</body>

</html>
