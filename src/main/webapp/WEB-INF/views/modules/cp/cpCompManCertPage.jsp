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
    <li class="active"><a href="${ctx}/cp/personnel/findCpManCertByCompanyId">已办证书</a></li>

</ul>
<form:form id="cpForm" modelAttribute="servCpEntity" action="${ctx}/cp/personnel/findCpManCertByCompanyId" method="post">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>


    <table id="contentTable" class="table  table-bordered table-condensed table-hover">
        <thead>
        <tr>
            <th>证书编号</th>
            <th>人员姓名</th>
            <th>证件号码</th>
            <th>人员类别</th>
            <th>所属地市</th>
            <th>企业名称</th>
<%--
            <th>发证单位</th>
--%>
            <th>发证日期</th>
            <th>有效期至</th>
            <th>证书状态</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="servCpEntity">
            <tr>
                <td><a href="${ctx}/cp/personnel/findCpServInfoById?servid=${servCpEntity.serv.servid}" /a>${servCpEntity.cert.certNo}</td>
                <td>${servCpEntity.personnel.name}</td>
                <td>${servCpEntity.personnel.idNo}</td>
                <td>${fns:getDictLabel(servCpEntity.personnel.personType, 'PERSON_TYPE', '')}</td>
                <td>${fns:getDictLabel(servCpEntity.serv.localId, 'LOCAL_ID', '')}</td>
                <td>${servCpEntity.serv.company.companyName}</td>
<%--
                <td>${servCpEntity.cert.issueBy}</td>
--%>
                <td><fmt:formatDate value="${servCpEntity.cert.issueDate}" type="date"/></td>
                <td><fmt:formatDate value="${servCpEntity.cert.expDate}" type="date"/></td>
                <td>${fns:getDictLabel(servCpEntity.cert.sts, 'STS', '')}</td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
</form:form>
<div class="pagination">${page}</div>
</body>
</html>
