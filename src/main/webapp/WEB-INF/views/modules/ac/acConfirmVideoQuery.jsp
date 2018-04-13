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
    <li class="active"><a href="#">所有申请</a></li>
</ul>

    <table id="contentTable" class="table  table-bordered table-condensed table-hover">
    <thead>
    <tr>
    <th>申报单号</th>
    <th>申报地市</th>
    <th>申报人</th>
    <th>申报专业</th>
    <th>申报项目</th>
    <th>申报时间</th>
    <th>项目学时</th>
    <th>项目费用</th>
    <th>缴费情况</th>
    <th>学时情况</th>
    <th>考试情况</th>
    <th>证书情况</th>
    <th>是否减免</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${page.list}" var="soPlan">

        <tr>

            <td><a href="${ctx}/plan/findSoAllInfo?soid=${soPlan.soid}">${soPlan.soid}</a></td>
            <td>${fns:getDictLabel(soPlan.localId, 'LOCAL_ID', '')}</td>
            <td>${fns:getUserById(soPlan.userId).name}</td>
            <td>${fns:getDictLabel(fns:getPlanById(soPlan.planId).majorId, 'MAJOR', '')}</td>
            <td>${fns:getPlanById(soPlan.planId).planName}</td>
            <td><fmt:formatDate value="${soPlan.applyDate}" pattern="yyyy-MM-dd"/></td>
            <td>${fns:getPlanById(soPlan.planId).planHours}</td>
            <td style="color: red;font-size: 16px;">${soPlan.fee}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.feeState, 'FEE_STATE', '')}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.hourState, 'HOUR_STATE', '')}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.examState, 'EXAM_STATE', '')}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.certState, 'CERT_STATE', '')}</td>
            <td style="color: red;">${fns:getDictLabel(soPlan.reduceFlag, 'REDUCE_FLAG', '')}</td>
        </tr>
    </c:forEach>
    </tbody>
    </table>
    <div class="pagination">${page}</div>
</body>
</html>
