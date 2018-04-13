<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>系统批次</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

            $("#param").focus();
            $("#searchForm").validate({
                submitHandler: function(form){
                    loading('正在查询，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });


        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/sys/sys/batchList/">批次列表</a></li>
    <li><a href="${ctx}/sys/sys/batchList/">批次修改</a></li>
</ul>
<form:form id="searchForm" modelAttribute="sysBatch" action="${ctx}/sys/sys/batchList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>批次类型 ：</label><form:select id="batchType" path="batchType" class="input-medium"><form:options items="${fns:getDictList('BATCH_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
    <label>所属模块 ：</label><form:select id="appId" path="appId" class="input-medium"><form:options items="${fns:getDictList('APP_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr><th>批次号</th><th>批次名称</th><th>批次所属模块</th><th>批次年份</th><th>批次月份</th><th>批次序号</th><th>批次所属企业</th><th>批次创建人</th><th>批次创建时间</th><th>批次状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${page.list}" var="batchList"   >

        <tr>
            <td>${batchList.batchId}</td>
            <td>${batchList.batchName}</td>
            <td>${fns:getDictLabel(batchList.appId, 'APP_ID', '')}</td>
            <td>${fns:getDictLabel(batchList.batchYear, 'BATCH_YEAR', '')}</td>
            <td>${fns:getDictLabel(batchList.batchMonth, 'BATCH_MONTH', '')}</td>
            <td>${fns:getDictLabel(batchList.batchSeq, 'BATCH_SEQ', '')}</td>
            <td>${batchList.companyId}</td>
            <td>${batchList.createBy}</td>
            <td><fmt:formatDate value="${batchList.createDate}" type="date"/></td>
            <td>${fns:getDictLabel(batchList.sts, 'STS', '')}</td>
            <td>
                <c:if test="${batchList.sts!='2'}">
                    <a href="${ctx}/sys/sys/batchUpdateStatus?appId=${batchList.appId}&batchId=${batchList.batchId}&batchType=${batchList.batchType}&status=8&companyId=${batchList.companyId}" onclick="return confirmx('您确认修改该批次(${batchList.batchId})吗?',this.href)">修改</a>
                </c:if>
                <a href="${ctx}/sys/sys/batchUpdateStatus?batchId=${batchList.batchId}&status=2" onclick="return confirmx('您确认锁定该批次(${batchList.batchId})吗?',this.href)">锁定</a>
                <a href="${ctx}/sys/sys/batchUpdateStatus?batchId=${batchList.batchId}&status=3" onclick="return confirmx('您确认解锁该批次(${batchList.batchId})吗?',this.href)">解锁</a>
                <a href="${ctx}/sys/sys/batchUpdateStatus?batchId=${batchList.batchId}&status=4" onclick="return confirmx('您确认作废该批次(${batchList.batchId})吗?',this.href)">作废</a>
            </td>

        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
