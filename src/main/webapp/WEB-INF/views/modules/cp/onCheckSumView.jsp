<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>已审核汇总</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
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

            $("#btnExport").click(function(){
                top.$.jBox.confirm("确认要导出已审核数据吗？","系统提示",function(v,h,f){
                    if(v=="ok"){
                        $("#searchForm").attr("action","${ctx}/cp/soCp/onCheckSumView");
                        $("#searchForm").submit();
                    }
                },{buttonsFocus:1});
                top.$('.jbox-body .jbox-icon').css('top','55px');
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
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/cp/soCp/query">已审核汇总</a></li>
</ul>
<form:form id="searchForm" modelAttribute="so" action="${ctx}/cp/soCp/onCheckSumView" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label class="control-label">企业名称:</label>
    <tags:commonselect id="companyId" name="companyId" value="${fns:getUser().userCompany.companyId}" labelName="companyName"
                       labelValue="${fns:getUser().userCompany.companyName}" title="企业" url="${ctx}/comp/company/findByName"/>

    <label class="control-label" for="localId">申报地市 ：</label>
    <form:select id="localId" path="localId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="batchId">批 次 号 ：</label>
    <form:select id="batchId" path="batchId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getBatchListByAppId('CP')}" itemLabel="batchName" itemValue="batchId" htmlEscape="false"/></form:select>

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
    &nbsp;<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
</form:form>
<div>
编号：
</div>

<div>
内蒙古自治区建筑施工企业主要负责人、项目负责人和安全生产管理
人员安全生产考核申请名单首次申请[ √ ]延期申请[  ]
</div>
<div>
<span>申报单位：（盖章）  </span>                              <span style="margin-left: 787px"> 总人数：&nbsp;&nbsp;&nbsp;&nbsp;人    &nbsp;&nbsp;&nbsp;&nbsp;申报日期：</span>
</div>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>序号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>年龄</th>
        <th>职务</th>
        <th>人员类别</th>
        <th>证件类型</th>
        <th>证件号</th>
        <th>有效期限</th>

    </tr>
    </thead>
    <tbody>
<c:forEach items="${page.list}" var="map">
    <tr>
        <td>${map.SERVID}</td>
        <td>${map.NAME}</td>
        <td>${map.SEX}</td>
        <td>${map.BIRTH_DATE}</td>
        <td>${map.TITLE_TYPE}</td>
        <td>${map.PERSON_TYPE}</td>
        <td>${map.ID_TYPE}</td>
        <td>${map.ID_NO}</td>
        <td>${map.exp_date}</td>
    </tr>
</c:forEach>
    </tbody>
</table>
<div><span>填写人： </span><span style="margin-left: 100px">                联系电话：</span></div>
<div>
备注：1、首次申请考核的：“证件类型”填写身份证，“证件号”填写身份证号码；申请延期的，“证件类型”填写安全生产考核合格证书，“证件号”填写证书编号；“有效期限”注明截止日期。
</div>
<div style="margin-left: 38px">
    2、本页不够可另附页。
</div>
<div class="pagination">${page}</div>
</body>
</html>
