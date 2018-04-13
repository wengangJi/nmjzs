<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>学时审核</title>
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
    <li class="active"><a href="#">审核列表</a></li>
</ul>
<form:form id="inputForm" modelAttribute="soHours" action="${ctx}/hours/auditHoursList" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <form:hidden id="id" path="id"/>
    <form:hidden id="rsrvStr1" path="rsrvStr1"/>


    <label class="control-label" for="qryStr1">人员姓名 ：</label>
    <form:input id ="qryStr1" path="qryStr1" htmlEscape="false"  class="input-medium"></form:input>
    <label>审核环节：</label>
    <form:select id="auditLevel" path="auditLevel" class="input-medium" disabled="true"><form:options items="${fns:getDictList('AUDIT_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>&nbsp;
    <form:hidden id="auditLevel" path="auditLevel"/>

    <label class="control-label" for="qryStr1">申报单号 ：</label>
    <form:input id ="qryStr5" path="qryStr5" htmlEscape="false"  class="input-medium"></form:input>

    </br>

    <label class="control-label" for="qryStr2">证件号码 ：</label>
    <form:input id="qryStr2" path="qryStr2" htmlEscape="false"  class="input-medium"></form:input>
    <label>审核状态：</label>
    <form:select id="auditTag" path="auditTag" class="input-medium" disabled="true"><form:options items="${fns:getDictList('AUDIT_TAG')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>&nbsp;
    <form:hidden id="auditTag" path="auditTag"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<div class="btn-group">
    <button class="btn" id="batchAssBtn">批量审核</button>
    <%--<button class="btn" id="forwardBtn">转发</button>
    <button class="btn" id="publicBtn">公示</button>
    <button class="btn" id="blackBtn">黑名单</button>--%>
</div>
<form:form id="batchForm" action="${ctx}/audit/batchHoursAudit" method="post" modelAttribute="soHours" >
    <input type="hidden" id="batchPass" name="batchPass"/>
    <input type="hidden" id="batchAuditInfo" name="batchAuditInfo"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th><input type="checkbox" id="checkall" name="checkall"/>选择</th>
            <th>申报单号</th>
            <th>申报项目</th>
                <%--
                            <th>课程</th>
                --%>
            <th>课件</th>
            <th>申报人</th>
            <th>学时数</th>
            <th>审核环节</th>
            <th>审核状态</th>
            <th>学习时间</th>
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
                    <%--
                                    <td>${fns:getCourseName(item.courseId)}</td>
                    --%>
                <td>${fns:getLessonName(item.lessonId)}</td>
                <td>${fns:getUserById(item.userId).name}</td>
                <td>${item.hours}</td>
                <td>学时${fns:getDictLabel(item.auditLevel,'AUDIT_LEVEL',"")}</td>
                <td>${fns:getDictLabel(item.auditTag,'AUDIT_TAG',"")}</td>
                <td><fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <c:if test="${soHours.auditTag eq '0'}">
                    <td>
                        <c:if test="${item.auditTag eq '0'}">
                            <c:if test="${item.auditLevel eq '0'}">
                                <shiro:hasPermission name="ac:lessonhour:first">
                                    <a id="pass" href="${ctx}/hours/auditHoursDetail?id=${item.id}">审核</a>
                                </shiro:hasPermission>
                            </c:if>
                            <c:if test="${item.auditLevel eq '1'}">
                                <shiro:hasPermission name="ac:lessonhour:second">
                                    <a id="pass" href="${ctx}/hours/auditHoursDetail?id=${item.id}">审核</a>
                                </shiro:hasPermission>
                            </c:if>
                            <c:if test="${item.auditLevel eq '2'}">
                                <shiro:hasPermission name="ac:lessonhour:third">
                                    <a id="pass" href="${ctx}/hours/auditHoursDetail?id=${item.id}">审核</a>
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