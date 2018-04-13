<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">
        $(document).ready(function() {

            $("#checkall").click(
                function(){
                    if(this.checked){
                        $("input[name='seqs']").attr('checked', true)
                    }else{
                        $("input[name='seqs']").attr('checked', false)
                    }
                }
            );

            $("#batchExtendBtn").click(
                    function(){
                        var flag = false;
                        $("input[name='seqs']").each(function(){
                            if(this.checked){
                                flag = true;
                            }
                        });
                        if(!flag){
                            $.jBox.error("请选择记录后操作!");
                            return false;
                        }
                        var html = "<div style='padding:10px;'>生成批次：<input type='text' id='auditRemark' name='auditRemark' /></div>";
                        var submit = function (v, h, f) {
                            if (f.auditRemark == '') {
                                $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                                return false;
                            }

                            $("#auditRemark").val(f.auditRemark);
                            $("#inputForm").submit();
                            $.jBox.tip("审核成功!");

                            return true;
                        };

                        $.jBox(html, { title: "审核", submit: submit });
                    }
            );

            $("#forwardBtn").click(
                    function(){
                        alert("正在开发中，请您耐心等待！");
                    }
            )

            $("#publicBtn").click(
                    function(){
                        alert("正在开发中，请您耐心等待！");
                    }
            )

            $("#blackBtn").click(
                    function(){
                        alert("正在开发中，请您耐心等待！");
                    }
            )
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#cpForm").submit();
            return false;
        }

    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/cp/soCp/servList">证书延期</a></li>
  <%--  <li><a href="${ctx}/cp/soCp/cpCommitForm">申报提交</a></li>--%>
</ul>
<form:form id="cpForm" modelAttribute="personnel" action="${ctx}/cp/soCp/servList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="companyId" name="companyId" type="hidden" value="${company.companyId}"/>


    <label class="control-label" for="personType">人员类型 ：</label>
    <form:select id="personType" path="personType" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
    <label class="control-label">证件号码：</label>
    <form:input path="idNo"  class="input-medium" />
    <label class="control-label">人员姓名：</label>
    <form:input path="name"  class="input-medium" />



    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<%--<div class="btn-group">
    <button class="btn" id="batchExtendBtn">批量延期</button>
</div>--%>
<table id="contentTable" class="table  table-bordered table-condensed table-hover">
    <thead><tr><th>证书编号</th><th>人员姓名</th><th>证件类型</th><th>证件号码</th><th>人员类别</th><th>发证单位</th><th>发证时间</th><th>有效期至</th><th>证书状态</th><th>操作</th></tr></thead>
    <tbody>
    <c:forEach items="${page.list}" var="personnel">
        <tr>
            <td><a href="${ctx}/cp/personnel/findCpServInfoById?servid=${personnel.cert.servid}"/>${personnel.cert.certNo}</td>
            <td>${personnel.name}</td>
            <td>${fns:getDictLabel(personnel.idType, 'ID_TYPE', '')}</td>
            <td>${personnel.idNo}</td>
            <td>${fns:getDictLabel(personnel.personType, 'PERSON_TYPE', '')}</td>
            <td>${personnel.cert.issueBy}</td>
            <td><fmt:formatDate value="${personnel.cert.issueDate}" type="date"/></td>
            <td><fmt:formatDate value="${personnel.cert.expDate}" type="date"/></td>
            <td>${fns:getDictLabel(personnel.cert.sts, 'STS', '')}</td>
            <td><a href="${ctx}/cp/personnel/findCpServInfoById?servid=${personnel.servid}&soType=08">延期</a></td>

        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>

</body>
</html>
