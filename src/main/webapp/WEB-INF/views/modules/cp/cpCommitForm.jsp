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



            $("#batchCommitBtn").click(
                    function batchCommit() {
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
                        top.$.jBox.confirm("确认批量提交申报？","系统提示",function(){
                           $("#inputForm").submit();
                        });
                    }
            );

            $("#batchRemoveBtn").click(
                    function batchRemove() {
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
                        top.$.jBox.confirm("确认批量删除申报？","系统提示",function(){
                            $("#inputForm").attr("action","${ctx}/cp/soCp/removeSoBatchByPrimaryKey");
                            $("#inputForm").submit();
                        });
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
    <li><a href="${ctx}/cp/soCp/query">申报列表</a></li>
    <li class="active"><a href="${ctx}/cp/soCp/cpCommitForm">申报提交</a></li>
</ul>
<form:form id="cpForm" modelAttribute="soCpEntity" action="${ctx}/cp/soCp/queryCommitList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label class="control-label" for="so.batchId">批 次 号 ：</label>
    <form:select id="so.batchId" path="so.batchId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getBatchListByAppId('CP')}" itemLabel="batchName" itemValue="batchId" htmlEscape="false"/></form:select>
  <%-- <label class="control-label" for="so.soType">申报类别 ：</label>
    <form:select id="so.soType" path="so.soType" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('SO_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
   --%>&nbsp;<input id="findSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<h6 style="color: red">以下是您待提交申报信息，待提交申报未上报至审核单位，若要上报请确认后点击提交按钮进行上报，按批次申报的情况选择后通过批量提交按钮统一提交上报。</h6></br>

    <div class="btn-group">
        <button class="btn" id="batchCommitBtn">批量提交</button>
        <button class="btn" id="batchRemoveBtn">批量删除</button>
    </div>

<form:form id="inputForm" action="${ctx}/cp/soCp/batchStartProcess" method="post" >
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th><input type="checkbox" id="checkall" name="checkall"/>选择</th>
            <th>申报单号</th>
            <th>地市</th>
            <th>业务类型</th>
            <th>申报人</th>
            <th>证件号码</th>
            <th>人员类别</th>
            <th>申报时间</th>
            <th>审核状态</th>
            <th>申报状态</th>
            <th>操作</th>
        </tr>
        </thead>


        <c:forEach items="${page.list}" var="soCpEntity">
            <tr>
                <td><input type="checkbox"  name="seqs" value="${soCpEntity.so.soid}"/> </td>
                <td><a href="${ctx}/cp/soCp/soCpInfo?soid=${soCpEntity.so.soid}&soType=${soCpEntity.so.soType}">${soCpEntity.so.soid}</a></td>
                <td>${fns:getDictLabel(soCpEntity.so.localId, 'LOCAL_ID', '')}</td>
                <td>${fns:getDictLabel(soCpEntity.so.soType, 'SO_TYPE', '')}</td>
                <td>${soCpEntity.soCpBase.name}</td>
                <td>${soCpEntity.soCpBase.idNo}</td>
                <td>${fns:getDictLabel(soCpEntity.soCpBase.personType, 'PERSON_TYPE', '')}</td>
                <td><fmt:formatDate value="${soCpEntity.so.applDate}" type="date"/></td>
                <td>${soCpEntity.so.processSts}</td>
                <td>${fns:getDictLabel(soCpEntity.so.sts, 'sts', '')}</td>
                <td>
                    <c:if test="${soCpEntity.so.sts eq '9'}">
                        <a href="${ctx}/cp/soCp/startProcess?soid=${soCpEntity.so.soid}">提交</a>
                        <c:if test="${soCpEntity.so.soType ne '04'}">
                           <a href="${ctx}/cp/soCp/soCpChgForm?soid=${soCpEntity.so.soid}">修改</a>
                        </c:if>
                    <a href="${ctx}/cp/soCp/removeSoByPrimaryKey?soid=${soCpEntity.so.soid}"onclick="return confirmx('确认要删除该申报吗？', this.href)">删除</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>

    </table>
</form:form>
<div class="pagination">${page}</div>
</body>
</html>
