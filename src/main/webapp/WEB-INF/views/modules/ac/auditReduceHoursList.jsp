<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>学时减免审核</title>
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
                        $.jBox.confirm("是否进行批量审核？","系统提示",function(v,h,f){
                            if (v == 'ok') {
                                var html = "<div style='padding:10px;'>是否通过：<input type='radio' name='pass' value='1' />是&nbsp;<input type='radio' name='pass' value='0' />否</div>";
                                html = html + "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' /></div>";
                                var submit = function (v, h, f) {
                                    if (f.auditRemark == '') {
                                        $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                                        return false;
                                    }
                                    var flag = false;
                                    var pass = "";
                                    $("input[name='pass']").each(function(){
                                        if(this.checked){
                                            flag = true;
                                            pass = $(this).val();
                                        }
                                    });
                                    if(!flag){
                                        $.jBox.error("请选择是否通过!");
                                        return false;
                                    }
                                    $("#batchPass").val(pass); // 先默认通过，后续再改
                                    $("#batchAuditInfo").val(f.auditRemark);
                                    loading('正在提交，请稍等...');
                                    $("#batchForm").submit();
                                    return true;
                                };

                                $.jBox(html, { title: "审核", submit: submit });
                            }
                        });
                    }
            );
        });
        function pass(obj){
            $("#id").val(obj);
            $("#auditTag").val("1");
            $.jBox.confirm("确定审核通过吗？","系统提示",function(v,h,f){
                if (v == 'ok') {
                    loading('正在提交，请稍等...');
                    $("#inputForm").submit();
                }
            });
        }
        function reject(obj){
            $("#id").val(obj);
            $("#auditTag").val("2");
            var html = "<div style='padding:10px;'>不通过原因：<input type='text' id='auditRemark' name='auditRemark' /></div>";
            var submit = function (v, h, f) {
                if (f.auditRemark == '') {
                    $.jBox.tip("请输入不通过原因", 'error', { focusId: "auditRemark" });
                    return false;
                }

                $("#rsrvStr1").val(f.auditRemark);
                loading('正在提交，请稍等...');
                $("#inputForm").submit();

                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        };
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#inputForm").submit();
            return false;
        }
    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/hours/auditReduceList/">审核列表</a></li>
</ul>
<form:form id="inputForm" modelAttribute="soHours" action="${ctx}/hours/auditReduceList">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <form:hidden id="id" path="id"/>
    <form:hidden id="rsrvStr1" path="rsrvStr1"/>
    <label>审核环节：</label>
    <form:select id="auditLevel" path="auditLevel" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('AUDIT_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>&nbsp;
    <label>审核状态：</label>
    <form:select id="auditTag" path="auditTag" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('AUDIT_TAG')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>&nbsp;
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
</form:form>
<div class="btn-group">
    <button class="btn" id="batchAssBtn">批量审核</button>
    <%--<button class="btn" id="forwardBtn">转发</button>
    <button class="btn" id="publicBtn">公示</button>
    <button class="btn" id="blackBtn">黑名单</button>--%>
</div>
<form:form id="batchForm" action="${ctx}/audit/batchReduceAudit" method="post" modelAttribute="soHours" >
<input type="hidden" id="batchPass" name="batchPass"/>
<input type="hidden" id="batchAuditInfo" name="batchAuditInfo"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th><input type="checkbox" id="checkall" name="checkall"/>选择</th>
        <th>申报单号</th>
        <th>申报项目</th>
        <th>申请人姓名</th>
        <th>继续教育证书编号</th>
        <th>执业单位</th>
        <th>冲抵学时数</th>
        <th>冲抵学时理由</th>
        <th>审核环节</th>
        <th>审核状态</th>
        <c:if test="${soHours.auditTag eq '0'}">
        <th>操作</th>
        </c:if>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td><input type="checkbox"  name="seqs" value="${item.id}"/> </td>
            <td>${item.soid}</td>
            <td>${fns:getPlanById(item.planId).planName}</td>
            <td>${fns:getUserById(item.userId).name}</td>
            <td>${item.certNo}</td>
            <td>${item.companyName}</td>
            <td>${item.hours}</td>
            <td>${item.reduceReason}</td>
            <td>减免${fns:getDictLabel(item.auditLevel,'AUDIT_LEVEL',"")}</td>
            <td>${fns:getDictLabel(item.auditTag,'AUDIT_TAG',"")}</td>
            <c:if test="${soHours.auditTag eq '0'}">
            <td>
<%--                <c:if test="${item.auditTag eq '0'}">
                    <a class="btn btn-primary" id="pass" href="#" onclick="pass(${item.id})">通过</a>
                    <a class="btn" id="reject" href="#" onclick="reject(${item.id})">不通过</a>
                </c:if>--%>
                <c:if test="${item.auditTag eq '0'}">
                    <c:if test="${item.auditLevel eq '0'}">
                        <shiro:hasPermission name="ac:reducehour:first">
                            <a id="pass" href="${ctx}/hours/auditReduceDetail?id=${item.id}">审核</a>
                        </shiro:hasPermission>
                    </c:if>
                    <c:if test="${item.auditLevel eq '1'}">
                        <shiro:hasPermission name="ac:reducehour:second">
                            <a id="pass" href="${ctx}/hours/auditReduceDetail?id=${item.id}">审核</a>
                        </shiro:hasPermission>
                    </c:if>
                    <c:if test="${item.auditLevel eq '2'}">
                        <shiro:hasPermission name="ac:reducehour:third">
                            <a id="pass" href="${ctx}/hours/auditReduceDetail?id=${item.id}">审核</a>
                        </shiro:hasPermission>
                    </c:if>
                </c:if>

            </td>
            </c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
</form:form>
<div class="pagination">${page}</div>
</body>
</html>