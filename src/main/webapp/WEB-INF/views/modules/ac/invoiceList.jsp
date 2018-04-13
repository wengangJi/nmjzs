<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发票审核</title>
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

            $("#btnExport").click(function(){
                top.$.jBox.confirm("确认要导出发票数据吗？","系统提示",function(v,h,f){
                    if(v=="ok"){
                        $("#inputForm").attr("action","${ctx}/invoice/export");
                        $("#inputForm").submit();
                    }
                },{buttonsFocus:1});
                top.$('.jbox-body .jbox-icon').css('top','55px');
            });

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
                        // 如果是盟市审核环节，批量提示对附件是否默认通过
                        $.jBox.confirm("是否批量审核通过？","系统提示",function(v,h,f){
                            if (v == 'ok') {
                                var html = "<div style='padding:10px;'>物流单号：<input type='text' id='rsrvStr1' name='rsrvStr1' /></div>"
                                        + "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' value='审核通过'/></div>";
                                var submit = function (v, h, f) {

                                    if (f.rsrvStr1 == '') {
                                        $.jBox.tip("请输入物流单号", 'error', { focusId: "rsrvStr1" });
                                        return false;
                                    }

                                    if (f.auditRemark == '') {
                                        $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                                        return false;
                                    }

                                    $("#auditRemark").val(f.auditRemark);
                                    $("#expressCode").val(f.rsrvStr1);
                                    loading('正在提交，请稍等...');
                                    $("#batchForm").submit();
                                    $.jBox.tip("审核成功!");

                                    return true;
                                };

                                $.jBox(html, { title: "审核", submit: submit });
                            }
                        });
                    }
            );
        });
        function pass(obj){
            $("#soid").val(obj);
            $("#auditTag").val("1");
/*            $.jBox.confirm("确定审核通过吗？","系统提示",function(v,h,f){
                if (v == 'ok') {
                    $("#inputForm").action = "${ctx}/invoice/audit";
                    loading('正在提交，请稍等...');
                    $("#auditForm").submit();
                }
            });*/
            var html = "<div style='padding:10px;'>物流单号：<input type='text' id='rsrvStr1' name='rsrvStr1' /></div>"
                    + "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' value='审核通过'/></div>";
            var submit = function (v, h, f) {
                if (f.rsrvStr1 == '') {
                    $.jBox.tip("请输入物流单号", 'error', { focusId: "rsrvStr1" });
                    return false;
                }
                if (f.auditRemark == '') {
                    $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                    return false;
                }

                $("#inputForm").action = "${ctx}/invoice/audit";
                $("#auditInfo").val(f.auditRemark);
                $("#rsrvStr1").val(f.rsrvStr1);
                loading('正在提交，请稍等...');
                $("#auditForm").submit();

                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        }
        function reject(obj){
            $("#soid").val(obj);
            $("#auditTag").val("2");
            var html = "<div style='padding:10px;'>不通过原因：<input type='text' id='auditRemark' name='auditRemark' /></div>";
            var submit = function (v, h, f) {
                if (f.auditRemark == '') {
                    $.jBox.tip("请输入不通过原因", 'error', { focusId: "auditRemark" });
                    return false;
                }

                $("#inputForm").action = "${ctx}/invoice/audit";
                $("#auditInfo").val(f.auditRemark);
                loading('正在提交，请稍等...');
                $("#auditForm").submit();

                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        }



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
    <li class="active"><a href="${ctx}/invoice/list/">审核列表</a></li>
</ul>
<%--<div class="btn-group">
    <button class="btn" id="batchAssBtn">批量审核</button>
</div>--%>
<form:form id="inputForm" modelAttribute="soInvoice" action="${ctx}/invoice/list" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>




    <label class="control-label" for="title">身份证号 ：</label>
    <form:input id ="rsrvStr3" path="rsrvStr3" htmlEscape="false"  class="input-medium"></form:input>

    <label class="control-label" for="title">发票抬头 ：</label>
    <form:input id ="title" path="title" htmlEscape="false"  class="input-medium"></form:input>

        <label class="control-label" for="startTime">开始时间 ：</label>
        <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
                    value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;


        <label class="control-label" for="endTime">结束时间 ：</label>
        <form:input id="endTime" path="endTime" type="text" readonly="readonly" class="input-small Wdate"
                    value="${endTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
        &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
    &nbsp;<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
</form:form>
<form:form id="auditForm" modelAttribute="soInvoice" action="${ctx}/invoice/audit">
    <form:hidden id="soid" path="soid"/>
    <form:hidden id="auditTag" path="auditTag"/>
    <form:hidden id="auditInfo" path="auditInfo"/>
    <form:hidden id="rsrvStr1" path="rsrvStr1"/>
</form:form>
<form:form id="batchForm" action="${ctx}/invoice/batchInvoiceAudit" method="post" >
<input type="hidden" id="auditRemark" name="auditRemark"/>
<input type="hidden" id="expressCode" name="expressCode"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr><th><input type="checkbox" id="checkall" name="checkall"/>选择</th><th>申报单号</th><th>姓名</th><th>身份证号</th><th>支付类型</th><th>发票抬头</th><th>发票金额</th><th>申请时间</th><th>邮寄地址</th><th>邮编</th><th>联系人</th><th>联系电话</th><th>物流单号</th><th>操作</th></thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td><input type="checkbox"  name="seqs" value="${item.soid}"/> </td>
            <td>${item.soid}</td>
            <td>${fns:getUserById(item.userId).name}</td>
            <td>${fns:getUserById(item.userId).loginName}</td>
            <td><c:if test="${item.companyName ne null and item.companyName ne ''}">线下支付</c:if><c:if test="${item.companyName eq null or item.companyName eq ''}">在线支付</c:if></td>
            <td>${item.title}</td>
            <td><fmt:formatNumber value="${item.fee}" type="currency"/></td>
            <td><fmt:formatDate value="${item.applyDate}" pattern="yyyy-MM-dd"/></td>
            <td style="width: 200px;">${item.postAddress}</td>
            <td>${item.postCode}</td>
            <td>${item.contactName}</td>
            <td>${item.contactPhone}</td>
            <td>${item.rsrvStr1}</td>
            <td>
                <shiro:hasPermission name="ac:invoice:audit">
                <c:if test="${item.auditTag eq '0'}">
                    <a  id="pass" href="#" onclick="pass('${item.soid}')">通过</a>
                    <a  id="reject" href="#" onclick="reject('${item.soid}')">不通过</a>

                </c:if>
                </shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</form:form>
<div class="pagination">${page}</div>

</body>
</html>