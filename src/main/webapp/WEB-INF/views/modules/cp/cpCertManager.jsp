<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员证书管理</title>
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

            $("#batchAssBtn").click(
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
                        var html = "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' /></div>";
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
    <li class="active"><a href="${ctx}/cp/personnel/findCpManagerCert">证书管理</a></li>

</ul>
<form:form id="cpForm" modelAttribute="servCpEntity" action="${ctx}/cp/personnel/findCpManagerCert" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>


    <label class="control-label" for="localId">申报地市 ：</label>
    <form:select id="localId" path="serv.localId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="batchId">批 次 号 ：</label>
    <form:select id="batchId" path="serv.batchId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getBactchAllByAppId('CP')}" itemLabel="batchName" itemValue="batchId" htmlEscape="false"/></form:select>

    <label class="control-label" for="serv.company.companyName">企业名称 ：</label>
    <form:input id="serv.company.companyName" path="serv.company.companyName" htmlEscape="false" class=" input-medium"/>
   <br>
    <label class="control-label" for="sts">证书状态 ：</label>
    <form:select id="sts" path="cert.sts" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('CERT_MAIN_STS')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="personType">申报类别 ：</label>
    <form:select id="personType" path="personnel.personType" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="personnel.name">人员姓名 ：</label>
    <form:input id="personnel.name" path="personnel.name" htmlEscape="false" class=" input-medium"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<shiro:hasPermission name="cp:assess:batchAudit">
<%--<div class="btn-group">
    <button class="btn" id="batchAssBtn">批量延期</button>
    <button class="btn" id="removeBtn">批量注销</button>
    <button class="btn" id="assignBtn">批量发布</button>
    <button class="btn" id="cancelBtn">批量取消发布</button>

</div>--%>
</shiro:hasPermission>

  <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
<%--
            <th><input type="checkbox" id="checkall" name="checkall"/>选择</th>
--%>
            <th>证书编号</th>
            <th>人员姓名</th>
            <th>证件号码</th>
            <th>人员类别</th>
            <th>所属地市</th>
            <th>企业名称</th>

           <%-- <th>发证单位</th>--%>

            <th>发证日期</th>
            <th>有效期至</th>
            <th>证书状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="servCpEntity">
            <tr>
<%--
                <td><input type="checkbox"  name="seqs" value="${servCpEntity.cert.servid}"/> </td>
--%>
                <td><a href="${ctx}/cp/personnel/findCpServInfoById?servid=${servCpEntity.serv.servid}" /a>${servCpEntity.cert.certNo}</td>
                <td>${servCpEntity.personnel.name}</td>
                <td>${servCpEntity.personnel.idNo}</td>
                <td>${fns:getDictLabel(servCpEntity.personnel.personType, 'PERSON_TYPE', '')}</td>
                <td>${fns:getDictLabel(servCpEntity.serv.localId, 'LOCAL_ID', '')}</td>
                <td>${servCpEntity.serv.company.companyName}</td>

               <%-- <td>${servCpEntity.cert.issueBy}</td>--%>

                <td><fmt:formatDate value="${servCpEntity.cert.issueDate}" type="date"/></td>
                <td><fmt:formatDate value="${servCpEntity.cert.expDate}" type="date"/></td>
                <td>${fns:getDictLabel(servCpEntity.cert.sts, 'STS', '')}</td>
                <td>

                       <%-- <a href="${ctx}/sys/workflow/processMap?processInstanceId=${servCpEntity.serv.servid}" class="fancybox"  data-fancybox-type="iframe">延期</a>
                        <a href="${ctx}/sys/workflow/processMap?processInstanceId=${servCpEntity.serv.servid}" class="fancybox"  data-fancybox-type="iframe">注销</a>
                        <a href="${ctx}/cp/assess/detail?soid=${soAssess.so.soid}&audit=1">发布</a>--%>
                        <a href="${ctx}/cp/assess/detail?soid=${soAssess.so.soid}&audit=1">打证</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>


<div class="pagination">${page}</div>
</body>
</html>
