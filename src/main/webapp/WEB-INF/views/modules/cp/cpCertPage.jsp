<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员证书分配</title>
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

            $("#batchGene").click(
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
                        $("#inputForm").attr("action","${ctx}/cp/personnel/batchGene");
                        $("#inputForm").submit();
                    }
            );

            $("#batchPublish").click(
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
                        $("#inputForm").attr("action","${ctx}/cp/personnel/batchPublish");
                        $("#inputForm").submit();
                    }
            )

            $("#batchCancelGene").click(
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
                        $("#inputForm").attr("action","${ctx}/cp/personnel/batchCancelGene");
                        $("#inputForm").submit();
                    }
            )

            $("#batchCancel").click(
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
                        $("#inputForm").attr("action","${ctx}/cp/personnel/batchCancel");
                        $("#inputForm").submit();
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
    <li class="active"><a href="${ctx}/cp/personnel/findCpAssignCert">证书分配</a></li>

</ul>
<form:form id="cpForm" modelAttribute="servCpEntity" action="${ctx}/cp/personnel/findCpAssignCert" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label class="control-label" for="localId">申报地市 ：</label>
    <form:select id="localId" path="serv.localId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
    <label class="control-label" for="batchId">批次编号 ：</label>
    <form:select id="batchId" path="serv.batchId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getBactchAllByAppId('CP')}" itemLabel="batchName" itemValue="batchId" htmlEscape="false"/></form:select>

    <label class="control-label" for="startTime">开始时间 ：</label>
    <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
        value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
<%--
    <label class="control-label" for="companyId">选择企业 ：</label>
    <tags:commonselect  id="companyId" name="serv.companyId"  value="serv.companyId" labelName="companyName"  labelValue="" title="企业" url="${ctx}/comp/company/findByName" />--%>
    </br>
   <label class="control-label" for="certSts">证书状态 ：</label>
    <form:select id="certSts" path="cert.certSts" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('CERT_STS')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="personType">申报类别 ：</label>
    <form:select id="personType" path="personnel.personType" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>

    <label class="control-label" for="endTime">结束时间 ：</label>
    <form:input id="endTime" path="endTime" type="text" readonly="readonly" class="input-small Wdate"
        value="${endTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<div class="btn-group">
    <c:if test="${servCpEntity.cert.certSts ne '3'}">
<%--
        <c:if test="${servCpEntity.cert.certSts eq '0'}">
--%>
            <button class="btn" id="batchGene">批量分配</button>
      <%--  </c:if>
        <c:if test="${servCpEntity.cert.certSts eq '1'}">--%>
            <button class="btn" id="batchPublish">批量发布</button>
            <button class="btn" id="batchCancelGene">批量分配取消</button>
<%--
        </c:if>
--%>
    <button class="btn" id="batchCancel">批量作废</button>
    </c:if>
</div>


<form:form id="inputForm" action="${ctx}/cp/personnel/" method="post" >
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th><input type="checkbox" id="checkall" name="checkall"/>选择</th>
            <th>申报人员</th>
            <th>证件类型</th>
            <th>证件号码</th>
            <th>人员类别</th>
            <th>证书编号</th>
            <th>所属地市</th>
            <th>企业名称</th>
            <th>证书状态</th>
            <th>状态时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="servCpEntity">
            <tr>
                <td><input type="checkbox"  name="seqs" value="${servCpEntity.soid}"/> </td>
                <td>${servCpEntity.personnel.name}</td>
                <td>${fns:getDictLabel(servCpEntity.personnel.idType, 'ID_TYPE', '')}</td>
                <td>${servCpEntity.personnel.idNo}</td>
                <td>${fns:getDictLabel(servCpEntity.personnel.personType, 'PERSON_TYPE', '')}</td>
                <td>${servCpEntity.cert.certNo}</td>
                <td>${fns:getDictLabel(servCpEntity.serv.localId, 'LOCAL_ID', '')}</td>
                <td>${servCpEntity.serv.company.companyName}</td>
                <td>${fns:getDictLabel(servCpEntity.cert.certSts, 'CERT_STS', '')}</td>
                <td><fmt:formatDate value="${servCpEntity.cert.certDate}" type="date"/></td>
                <td>
                    <c:if test="${servCpEntity.cert.certSts eq '0'}">
                    <a href="${ctx}/cp/personnel/geneCert?personType=${servCpEntity.personnel.personType}&soid=${servCpEntity.soid}">分配证书</a>
                    </c:if>
                    <c:if test="${servCpEntity.cert.certSts eq '1'}">
                    <a href="${ctx}/cp/personnel/publishCert?soid=${servCpEntity.soid}">发布</a>
                        <a href="${ctx}/cp/personnel/cancelGeneCert?soid=${servCpEntity.soid}">取消分配</a>
                    </c:if>
                    <c:if test="${servCpEntity.cert.certSts eq '2'}">
                        <a href="${ctx}/cp/assess/detail?soid=${servCpEntity.soid}&audit=1">打证</a>
                    </c:if>
                    <c:if test="${servCpEntity.cert.certSts ne '3'}">
                        <a href="${ctx}/cp/personnel/cancelCert?soid=${servCpEntity.soid}">作废</a>
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
