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
    <li class="active"><a href="#">二级建造师查询</a></li>
</ul>
<form:form id="cpForm" modelAttribute="servAcInfo" action="${ctx}/ac/servAc/initCompanyServAcInfo" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>


    <label class="control-label" >证件号码 ：</label>
    <form:input path="idNo" htmlEscape="false"  class="input-medium"></form:input>


    <label class="control-label" >证书编号 ：</label>
    <form:input path="certNo" htmlEscape="false"  class="input-medium"></form:input>

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr>
        <th>归属地市</th>
        <th>姓名</th>
        <th>证件号码</th>
        <th>归属公司</th>
        <th>证书编号</th>
        <th>专业类型</th>
        <th>发证时间</th>
        <th>操作</th>
    </tr></thead>
    <tbody>
    <c:forEach items="${page.list}" var="servAcInfo" varStatus="staus">
        <tr>
            <td>${fns:getDictLabel(servAcInfo.localId, 'LOCAL_ID', '')}</td>
            <td>${servAcInfo.name}</td>
            <td>${servAcInfo.idNo}</td>
            <td>${fns:getCompanyById(servAcInfo.companyId).companyName}</td>
            <td>${servAcInfo.certNo}</td>
            <td>${fns:getDictLabel(servAcInfo.majorFirst, 'MAJOR', '')}</td>
            <td><fmt:formatDate value="${servAcInfo.issueDate}" pattern="yyyy-MM-dd"/></td>

                <td>
                    <a href="${ctx}/ac/servAc/queryServAcInfo?userId=${servAcInfo.userId}">详细信息</a>
                </td>

        </tr>
     </c:forEach>
    </tbody>
</table>
    <div class="pagination">${page}</div>
</body>
</html>
