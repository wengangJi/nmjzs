<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>模板配置初始化</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
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
            $("#searchForm").attr("action","${ctx}/print/list/");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li  class="active"><a href="${ctx}/print/list">模板列表</a></li>
    <li><a href="${ctx}/print/init/">模板新增</a></li>
    <li><a href="${ctx}/print/form">模板元素增加</a></li>
</ul>
<form:form id="searchForm" modelAttribute="printTemplate" action="${ctx}/print/query/" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <div>
        <label>证书类型：</label>
        <form:select path="certType" >
            <form:options items="${fns:getDictList('APP_ID')}" itemLabel="label" itemValue="value" htmlEscape="false" />
        </form:select>
        <label>申请类型：</label>
        <form:select path="soType" >
            <form:options items="${fns:getDictList('SO_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false" />
        </form:select>
        <label>打印页：</label>
        <form:input  path="pageNum" class="required input-medium" />
        &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
    </div>
</div>
</form:form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed" style="table-layout: fixed;WORD-BREAK: break-all; WORD-WRAP: break-word">
    <thead><tr><th width="55px;">证书类型</th><th  width="55px;">申请类型</th><th width="40px;">打印页</th><th width="55px;">索引顺序</th><th>元素类型</th><th width="55px;">参数个数</th><th width="55px;">元素名</th><th>PARA_CODE1</th><th width="68px;">PARA_CODE2</th><th width="68px;">PARA_CODE3</th><th width="68px;">PARA_CODE4</th><th>PARA_CODE5</th><th width="68px;">操作</th></tr></thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td>${fns:getDictLabel(item.certType,"APP_ID" ,"" )}</td>
            <td>${fns:getDictLabel(item.soType,"SO_TYPE" ,"" )}</td>
            <td>${item.pageNum}</td>
            <td>${item.indexItem}</td>
            <td>${item.paraType}</td>
            <td>${item.paraNum}</td>
            <td>${item.paraName}</td>
            <td>${item.paraCode1}</td>
            <td>${item.paraCode2}</td>
            <td>${item.paraCode3}</td>
            <td>${item.paraCode4}</td>
            <td>${item.paraCode5}</td>
            <td>
                <a href="${ctx}/print/form?id=${item.id}">修改</a>
                <a href="${ctx}/print/delete?id=${item.id}" onclick="return confirmx('确认要删除该元素吗？', this.href)">删除</a>
                <a href="${ctx}/print/addElem?certType=${item.certType}&soType=${item.soType}&pageNum=${item.pageNum}&indexItem=${item.indexItem + 1}">添加元素</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
