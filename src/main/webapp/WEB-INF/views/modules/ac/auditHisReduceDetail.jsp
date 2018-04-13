<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>减免学时审核</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#auditRemarks").val("");
            showBackAct();
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
            $("#hideme").click(function(){
                $("#fileArea").toggle(500);
            });
            $("#hideme").tooltip();

            $("#listBtn").click(function(){
                $("#thHead").hide();
                $("td[id^=thContent]").hide();
            });
            $("#largeBtn").click(function(){
                $("#thHead").show();
                $("td[id^=thContent]").show();
            });
        });
        function auditPass() {
            /*			top.$.jBox.confirm("确认提交数据？","系统提示",function(v,h,f){
             if (v == 'ok') {
             $("#inputForm").submit();
             }
             });*/
            $("#inputForm").submit();
        }
        function showBackAct(para){
            if(para != null){
                switch (para.value){
                    case "0":
                        $("#backBlock").show();
                        $("#auditRemarks").val("不通过原因：");
                        break;
                    case "1":
                        $("#backBlock").hide();
                        $("#auditRemarks").val("审核通过。");
                        break;
                    default :
                        $("#backBlock").hide();
                        break;
                }
            } else {
                $("#backBlock").hide();
            }
        }
        function setImpId(obj){
            $("#currImgId").val(obj);
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">审核查看</a></li>
</ul>
<tags:message content="${message}"/>
    <fieldset>
        <legend>建造师信息</legend>
        <table id="servAcInfo" class="table table-bordered table-condensed  table-hover">
            <tbody>
            <tr>
                <td><label class="control-label">姓名</label></td>
                <td>${servAcInfo.name} </td>
                <td><label class="control-label">性别</label></td>
                <td>${fns:getDictLabel(servAcInfo.sex, 'SEX', '')}</td>
                <td><label class="control-label">出生日期</label> </td>
                <td><fmt:formatDate value="${servAcInfo.birthDate}" type="date"/> </td>
                <td rowspan="5"width="120px;"><img src="${servAcInfo.patchId}"/></td>
            </tr>

            <tr>
                <td><label class="control-label">证件号</label></td>
                <td colspan="3"> ${servAcInfo.idNo}
                <td><label class="control-label">证件类别</label></td>
                <td>${fns:getDictLabel(servAcInfo.idType, 'ID_TYPE', '')} </td>
            </tr>

            <tr>
                <td ><label class="control-label">所属企业</label></td>
                <td colspan="3">${fns:getCompanyById(servAcInfo.companyId).companyName}</td>
                <td ><label class="control-label">所属地市</label></td>
                <td>${fns:getDictLabel(servAcInfo.localId, 'LOCAL_ID', '')} </td>
            </tr>

            <tr>
                <td><label class="control-label">第一专业</label></td>
                <td> ${fns:getDictLabel(servAcInfo.majorFirst, 'MAJOR', '')} </td>
                <td><label class="control-label">第二专业</label></td>
                <td> ${fns:getDictLabel(servAcInfo.majorSecond, 'MAJOR', '')}  </td>
                <td><label class="control-label">第三专业</label></td>
                <td colspan="1"> ${fns:getDictLabel(servAcInfo.majorThird, 'MAJOR', '')} </td>

            </tr>


            </tbody>
        </table>
        <legend>减免申请信息</legend>
        <table id="basicInfo" class="table table-bordered table-condensed  table-hover">
            <tbody>
            <tr>
                <td><label class="control-label">申报单号</label></td>
                <td>${soHours.soid}</td>
                <td><label class="control-label">培训项目</label></td>
                <td>${fns:getPlanById(soHours.planId).planName}</td>
            </tr>
            <tr>
                <td><label class="control-label">申请人姓名</label></td>
                <td>${fns:getUserById(soHours.userId).name}</td>
                <td><label class="control-label">继续教育证书编号</label></td>
                <td>${soHours.certNo}</td>
            </tr>

            <tr>
                <td><label class="control-label">执业单位</label></td>
                <td colspan="3">${soHours.companyName}</td>
            </tr>
            <tr>
                <td><label class="control-label">申请冲抵的学时数</label></td>
                <td colspan="3">${soHours.hours}</td>
            </tr>

            <tr>
                <td><label class="control-label">冲抵学时的理由</label></td>
                <td colspan="3">${soHours.reduceReason}</td>
            </tr>
            <tr>
                <td><label class="control-label">具体情况说明</label></td>
                <td colspan="3">${soHours.remark}</td>
            </tr>
            </tbody>
        </table>
        <legend id="hideme" data-toggle="tooltip" data-placement="top" title="" data-original-title="点击隐藏/显示附件信息">附件信息</legend>
        <div id="fileArea">
            <%--        <div class="btn-group" style="float: right">
                        <button class="btn btn-primary" id="listBtn"><i class="icon-th-list icon-white"></i>&nbsp;列表展示</button>
                        <button class="btn btn-primary" id="largeBtn"><i class="icon-th-large icon-white"></i>&nbsp;缩略图展示</button>
                    </div>--%>
            <table class="table">
                <tr>
                    <%--                <th id="thHead">缩略图</th>--%>
                    <th>文件名(点击文件名下载)</th>
                    <th>文件大小</th>
                </tr>
                <c:forEach items="${files}" var="file" varStatus="status">
                    <tr>
                            <%--                    <td id="thContent${status.index}"><span class="preview"><a href="${file.url}" title="${file.name}" download="${file.name}" data-gallery><img
                                                        src="${file.thumbnailUrl}"></a></span></td>--%>
                        <td><a href="${file.url}" title="${file.name}"
                               download="${file.name}" ${empty file.thumbnailUrl?'data-gallery':''}>${file.name}</a></td>
                        <td>${fns:formatFileSize(file.size)}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <legend>审核信息</legend>
        <table id="contentTable" class="table table-striped table-bordered table-condensed">
            <thead><tr>
                <th>环节名称</th>
                <th>审批人</th>
                <th>审批意见</th>
                <th>审批时间</th>
            </tr></thead>
            <tbody>
            <c:forEach items="${soAudits}" var="approve">
                <tr>
                    <td>减免${fns:getDictLabel(approve.auditLevel-1,"AUDIT_LEVEL","")}</td>
                    <td>${fns:getUserById(approve.auditBy).name}</td>
                    <td>${approve.auditInfo}</td>
                    <td><fmt:formatDate value="${approve.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </fieldset>

</body>
</html>
