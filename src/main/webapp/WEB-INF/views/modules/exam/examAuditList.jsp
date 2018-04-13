<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>考试审核管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
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
                if (element.is(":checkbox")||element.is(":radio")){
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
          });

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
                    $.jBox.confirm("是否批量审核通过？","系统提示",function(v,h,f){
                        if (v == 'ok') {
                            var html = "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' /></div>";
                            var submit = function (v, h, f) {
                                if (f.auditRemark == '') {
                                    $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                                    return false;
                                }
                                $("#batchPass").val("1"); // 先默认通过，后续再改
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
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#cpForm").submit();
            return false;
        }



        function checkOrder(soid,level){
            alert(soid);
            $.jBox.confirm("审核通过？","系统提示",function(v,h,f){
                if (v == 'ok') {
                    var html = "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' /></div>";
                    var submit = function (v, h, f) {
                        if (f.auditRemark == '') {
                            $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                            return false;
                        }

                        $("#auditRemark").val(f.auditRemark);
                        if(level.equals("1")){
                        window.location.href="${ctx}/plan/updSoPlanById?auditRemark="+$("#auditRemark").val()+"&soidList="+soid;
                        }
                        if(level.equals("2")){
                            window.location.href="${ctx}/plan/updSoPlanSecondById?auditRemark="+$("#auditRemark").val()+"&soidList="+soid;
                        }
                        if(level.equals("3")){
                            window.location.href="${ctx}/plan/updSoPlanThirdById?auditRemark="+$("#auditRemark").val()+"&soidList="+soid;
                        }
                        $.jBox.tip("审核成功!");

                        return true;
                    };

                    $.jBox(html, { title: "审核", submit: submit });
                }
            });
        }

        function passFirst(id,obj,type){
            $("#soId").val(obj);
            $("#pass").val("1");
            $("#examType").val(type);
            $("#examId").val(id);
            var html = "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' value='审核通过'/></div>";
            var submit = function (v, h, f) {

                if (f.auditRemark == '') {
                    $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                    return false;
                }
                $("#auditForm").attr("action","${ctx}/audit/examFirstAudit/");
                $("#auditInfo").val(f.auditRemark);
                $("#rsrvStr1").val(f.rsrvStr1);
                loading('正在提交，请稍等...');
                $("#auditForm").submit();
                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        }
        function rejectFirst(id,obj,type){
            $("#soId").val(obj);
            $("#pass").val("0");
            $("#examType").val(type);
            $("#examId").val(id);
            var html = "<div style='padding:10px;'>不通过原因：<input type='text' id='auditRemark' name='auditRemark' /></div>";
            var submit = function (v, h, f) {
                if (f.auditRemark == '') {
                    $.jBox.tip("请输入不通过原因", 'error', { focusId: "auditRemark" });
                    return false;
                }

                $("#auditForm").attr("action","${ctx}/audit/examFirstAudit/");
                $("#auditInfo").val(f.auditRemark);
                loading('正在提交，请稍等...');
                $("#auditForm").submit();

                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        }


        function passSecond(id,obj,type){
            $("#soId").val(obj);
            $("#pass").val("1");
            $("#examType").val(type);
            $("#examId").val(id);
            var html = "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' value='审核通过'/></div>";
            var submit = function (v, h, f) {

                if (f.auditRemark == '') {
                    $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                    return false;
                }
                $("#auditForm").attr("action","${ctx}/audit/examSecondAudit/");
                $("#auditInfo").val(f.auditRemark);
                $("#rsrvStr1").val(f.rsrvStr1);
                loading('正在提交，请稍等...');
                $("#auditForm").submit();
                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        }

        function rejectSecond(id,obj,type){
            $("#soId").val(obj);
            $("#pass").val("0");
            $("#examType").val(type);
            $("#examId").val(id);
            var html = "<div style='padding:10px;'>不通过原因：<input type='text' id='auditRemark' name='auditRemark' /></div>";
            var submit = function (v, h, f) {
                if (f.auditRemark == '') {
                    $.jBox.tip("请输入不通过原因", 'error', { focusId: "auditRemark" });
                    return false;
                }

                $("#auditForm").attr("action","${ctx}/audit/examSecondAudit/");
                $("#auditInfo").val(f.auditRemark);
                loading('正在提交，请稍等...');
                $("#auditForm").submit();

                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        }


        function passThird(id,obj,type){
            $("#soId").val(obj);
            $("#pass").val("1");
            $("#examType").val(type);
            $("#examId").val(id);
            var html = "<div style='padding:10px;'>审核意见：<input type='text' id='auditRemark' name='auditRemark' value='审核通过'/></div>";
            var submit = function (v, h, f) {

                if (f.auditRemark == '') {
                    $.jBox.tip("请输入审核意见", 'error', { focusId: "auditRemark" });
                    return false;
                }
                $("#auditForm").attr("action","${ctx}/audit/examThirdAudit/");
                $("#auditInfo").val(f.auditRemark);
                $("#rsrvStr1").val(f.rsrvStr1);
                loading('正在提交，请稍等...');
                $("#auditForm").submit();
                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        }


        function rejectThird(id,obj,type){
            $("#soId").val(obj);
            $("#pass").val("0");
            $("#examType").val(type);
            $("#examId").val(id);
            var html = "<div style='padding:10px;'>不通过原因：<input type='text' id='auditRemark' name='auditRemark' /></div>";
            var submit = function (v, h, f) {
                if (f.auditRemark == '') {
                    $.jBox.tip("请输入不通过原因", 'error', { focusId: "auditRemark" });
                    return false;
                }

                $("#auditForm").attr("action","${ctx}/audit/examThirdAudit/");
                $("#auditInfo").val(f.auditRemark);
                loading('正在提交，请稍等...');
                $("#auditForm").submit();

                return true;
            };

            $.jBox(html, { title: "审核", submit: submit });
        }

    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">考试审核列表</a></li>
<%--
    <li class=""><a href="#">已审核</a></li>
--%>
</ul>

<form:form id="inputForm" modelAttribute="examInfo" action="${ctx}/exam/exam/auditExamList">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <form:hidden id="id" path="id"/>
    <form:hidden id="rsrvStr1" path="rsrvStr1"/>
    <label>审核环节：</label>
    <form:select id="auditLevel" path="auditLevel" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('AUDIT_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>&nbsp;
    <label>审核状态：</label>
    <form:select id="auditTag" path="auditTag" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('AUDIT_TAG')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>&nbsp;
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<form:form id="auditForm" modelAttribute="examInfo" action="${ctx}/exam/audit">
    <form:hidden id="examId" path="id"/>
    <form:hidden id="soId" path="soId"/>
    <form:hidden id="pass" path="pass"/>
    <form:hidden id="auditTag" path="auditTag"/>
    <form:hidden id="auditInfo" path="auditInfo"/>
    <form:hidden id="auditLevel" path="auditLevel"/>
    <form:hidden id="rsrvStr1" path="rsrvStr1"/>
    <form:hidden id="examType" path="examType"/>

</form:form>
<div class="btn-group">
    <button class="btn" id="batchAssBtn">批量审核</button>
</div>
<form:form id="batchForm" action="${ctx}/audit/batchExamAudit" method="post" >
    <input type="hidden" id="batchPass" name="batchPass"/>
    <input type="hidden" id="batchAuditInfo" name="batchAuditInfo"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th><input type="checkbox" id="checkall" name="checkall"/>选择</th>
            <th>申报单号</th>
            <th>考试人</th>
            <th>是否补考</th>
            <th>考试开始时间</th>
            <th>考试结束时间</th>
            <th>分数</th>
            <th>是否合格</th>
            <th>审核环节</th>
            <th>审核状态</th>
            <th>审核</th>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="item">
            <tr>
                <td><input type="checkbox"  name="seqs" value="${item.id}"/> </td>
                <td>${item.soId}</td>
                <td>${fns:getUserById(item.userId).name}</td>
                <td>${fns:getDictLabel(item.examType,'EXAM_TYPE',"")}</td>
                <td>${item.startTime}</td>
                <td>${item.endTime}</td>
                <td>${item.cores}</td>
                <td>${fns:getDictLabel(item.auditLevel,'PASS_TAG',"")}</td>
                <td>${fns:getDictLabel(item.auditLevel,'AUDIT_LEVEL',"")}</td>
                <td>${fns:getDictLabel(item.auditTag,'AUDIT_TAG',"")}</td>
                <td>
                    <c:if test="${item.examType eq '0' or item.examType eq '1'}">
                        <c:if test="${item.auditTag eq '0'}">
                            <c:if test="${item.auditLevel eq '0'}">
                                <shiro:hasPermission name="ac:examAudit:first">
                                    <a  id="pass" href="#" onclick="passFirst('${item.id}','${item.soId}','${item.examType}')">通过</a>
                                    <a  id="reject" href="#" onclick="rejectFirst('${item.id}','${item.soId}','${item.examType}')">不通过</a>
                                </shiro:hasPermission>
                            </c:if>
                            <c:if test="${item.auditLevel eq '1'}">
                                <shiro:hasPermission name="ac:examAudit:second">
                                    <a  id="pass" href="#" onclick="passSecond('${item.id}','${item.soId}','${item.examType}')">通过</a>
                                    <a  id="reject" href="#" onclick="rejectSecond('${item.id}','${item.soId}','${item.examType}')">不通过</a>
                                </shiro:hasPermission>
                            </c:if>
                            <c:if test="${item.auditLevel eq '2'}">
                                <shiro:hasPermission name="ac:examAudit:third">
                                    <a  id="pass" href="#" onclick="passThird('${item.id}','${item.soId}','${item.examType}')">通过</a>
                                    <a  id="reject" href="#" onclick="rejectThird('${item.id}','${item.soId}','${item.examType}')">不通过</a>
                                </shiro:hasPermission>
                            </c:if>
                        </c:if>
                     </c:if>

                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
</form:form>
    <div class="pagination">${page}</div>
</body>
</html>
