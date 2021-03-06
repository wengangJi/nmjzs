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
                        if($("#isLocalAudit").val()=="1"){
                            $.jBox.confirm("批量审核存在未审核附件，是否对附件默认审核通过？","系统提示",function(v,h,f){
                                if (v == 'ok') {
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
                            });

                        }
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
    <li class="active"><a href="#">未支付记录</a></li>
</ul>
<form:form id="cpForm" modelAttribute="soPlan" action="${ctx}/alipay/alipay/getNoIpsorderList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>


    <label class="control-label" for="localId">申报地市 ：</label>
    <form:select id="localId" path="localId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>



    <label class="control-label" for="startTime">交易时间(始) ：</label>
    <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
        value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    <label class="control-label">申报单号 ：</label>
    <form:input path="soid" htmlEscape="false"  class="input-medium"></form:input>
    </br>
    <label class="control-label" for="planId">申报项目 ：</label>
    <form:select id="planId" path="planId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getAllPlanByYear('2014')}" itemLabel="planName" itemValue="planId" htmlEscape="false"/></form:select>


    <label class="control-label" for="endTime">交易时间(至) ：</label>
    <form:input id="endTime" path="endTime" type="text" readonly="readonly" class="input-small Wdate"
        value="${endTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr>
        <th>交易流水</th>
        <th>申报流水</th>
        <th>申报项目</th>
        <th>支付人</th>
        <th>交易时间</th>
        <th>交易金额</th>
        <th>交易状态</th>
        <th>操作</th>
    </tr></thead>
    <tbody>
    <c:forEach items="${page.list}" var="element" varStatus="staus">
        <tr>
            <td>${element.alipayId}</td>
            <td><a href="${ctx}/plan/findSoAllInfo?soid=${element.soid}">${element.soid}</a></td>
            <td>${fns:getPlanById(element.planId).planName}</td>
            <td>${fns:getUserById(element.userId).name}</td>
            <td><fmt:formatDate value="${element.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${element.fee}(元)</td>
            <td style="color: red;">${fns:getDictLabel(element.feeState, 'FEE_STATE', '')}</td>
            <c:if test="${element.feeState eq '1'}">
                <td>
                        <%-- <a href="${ctx}/exam/exam/examQuestionList?planId=${soPlan.planId}&soid=${soPlan.soid}"> <i class="icon-white icon-play-circle"></i></a>--%>
                </td>
            </c:if>
            <c:if test="${element.feeState eq '0'}">
                <td>
                    <a href="${ctx}/alipay/alipay/alipayReSubmit?alipayId=${element.alipayId}&soid=${element.soid}&fee=0.1" target="_blank">重新支付</a>
                </td>
            </c:if>
        </tr>
     </c:forEach>
    </tbody>
</table>
    <div class="pagination">${page}</div>
</body>
</html>
