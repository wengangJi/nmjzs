<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>三类人员考核详细</title>
	<meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <!-- blueimp Gallery styles -->
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/blueimp-gallery.min.css">
	<script type="text/javascript">
		$(document).ready(function() {
            showBackAct();
            showseal();
			$("#name").focus();
			$("#inputForm").validate({

				submitHandler: function(form){
                    var error = false;
                    if($("input[name='so.pass']:checked").val()=="1"){
                        $("input[name^='soAttachments']:checked").each(function(index,domEle){
                            if(this.value == '0'){
                                error = true;
                            }
                        });
                    }
                    if(error){
                        $.jBox.error("有不合格的附件，不允许选择通过！");
                        return false;
                    }else{
                        loading('正在提交，请稍等...');
                        form.submit();
                    }
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

            $("input[name^=soAttachments]").click(function(){
                $.post("${ctx}/file/auditImg",{id:$("#currImgId").val(),imgpass:$(this).attr("value")},function(data){
                    //alert($("this").attr("checked"));
                    //$("this").attr("checked",true);
                    //$("input[name=imgpass][value=data]").attr("checked",true);
                })
            });

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

        function showseal(para1){
            if(para1 != null){
                switch (para1.value){
                    case "0":
                        $("#sealImg").hide();
                        break;
                    case "1":
                        $("#sealImg").show();
                        break;
                    default :
                        $("#sealImg").hide();
                        break;
                }
            } else {
                $("#sealImg").hide();
            }
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cp/assess/tasks">待办任务</a></li>
<%--		<li><a href="${ctx}/cp/assess/alllist">所有任务</a></li>--%>
		<li class="active"><a href="${ctx}/cp/assess/detail?id=${soAssess.so.soid}">审核查看</a></li>
	</ul>
<%--	<form class="form-horizontal">
		<div class="control-group">
			<label class="control-label">请假类型：</label>
			<div class="controls">
				${leave.leaveTypeDictLabel }
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始时间：</label>
			<div class="controls">
				${leave.startTime}
		</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间：</label>
			<div class="controls">
				${leave.endTime}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">请假原因：</label>
			<div class="controls">
				${leave.reason}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">当前状态：</label>
			<div class="controls">
				${leave.processStatus}
			</div>
		</div>
	</form>--%>
<%--	<c:if  test="${not empty workflowEntity.historicTaskInstances}">
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead><tr>
				<th>环节名称</th>
				<th>审批人</th>
                <th>是否与原件一致</th>
                <th>审批意见</th>
				<th>审批时间</th>
			</tr></thead>
			<tbody>
				<c:forEach items="${workflowEntity.historicTaskInstances}" var="historicTaskInstance">
					<c:if test="${not empty  historicTaskInstance.endTime}">
						<tr>
							<td>${historicTaskInstance.name}</td>
							<td>${fns:getUserById(historicTaskInstance.assignee).name}</td>
							<td>${workflowEntity.commentMap[historicTaskInstance.id]}</td>
                            <td><fmt:formatDate value="${historicTaskInstance.endTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</c:if>--%>
    <tags:message content="${message}"/>
    <c:if  test="${not empty soAssess.soCpApproves}">
        <table id="contentTable" class="table table-striped table-bordered table-condensed">
            <thead><tr>
                <th>环节名称</th>
                <th>审批人</th>
<%--
                <th>是否与原件一致</th>
--%>
                <th>审批意见</th>
                <th>审批时间</th>
            </tr></thead>
            <tbody>
            <c:forEach items="${soAssess.soCpApproves}" var="approve">
                <tr>
                    <td>${approve.taskName}</td>
                    <td>${fns:getUserById(approve.apprUserId).name}</td>
<%--
                    <td>${fns:getDictLabel(approve.consistentOriginal, "CONSISTENT_ORIGINAL", "")}</td>
--%>
                    <td>${approve.content}</td>
                    <td><fmt:formatDate value="${approve.apprDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <!-- The blueimp Gallery widget -->
    <div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls">
        <div class="slides"></div>
        <h3 class="title"></h3>
        <a class="prev">‹</a>
        <a class="next">›</a>
        <a class="close">×</a>
        <a class="play-pause"></a>
        <ol class="indicator"></ol>
    </div>
    <fieldset>
        <legend id="hideme" data-toggle="tooltip" data-placement="top" title="" data-original-title="点击隐藏/显示附件信息">附件信息</legend>
        <div id="fileArea">
<%--            <div style="float: right">
            <button type="button" class="btn btn-success" id="listBtn">
                <i class="icon-th-list icon-white"></i>
                <span>列表展示</span>
            </button>
            <button type="button" class="btn btn-success" id="largeBtn">
                <i class="icon-th-large icon-white"></i>
                <span>缩略图展示</span>
            </button>
            </div>--%>
            <div class="btn-group" style="float: right">
                <button class="btn btn-primary" id="listBtn"><i class="icon-th-list icon-white"></i>&nbsp;列表展示</button>
                <button class="btn btn-primary" id="largeBtn"><i class="icon-th-large icon-white"></i>&nbsp;缩略图展示</button>
            </div>
            <form:form id="fileForm" modelAttribute="soAssess">
            <input type="hidden" id="currImgId">
            <table class="table">
                <tr>
                    <th id="thHead">缩略图</th>
                    <th>文件名(点击文件名下载)</th>
                    <th>文件大小</th>
                    <th>审核人</th>
                    <th>审核时间</th>
                    <th>是否合格</th>
                </tr>
<%--                <c:forEach items="${files}" var="file">
                    <tr>
                        <td><span class="preview"><a href="${file.url}" title="${file.name}" download="${file.name}" data-gallery><img
                                src="${file.thumbnailUrl}"></a></span></td>
                        <td><a href="${file.url}" title="${file.name}"
                               download="${file.name}" ${empty file.thumbnailUrl?'data-gallery':''}>${file.name}</a></td>
                        <td>${fns:formatFileSize(file.size)}</td>
                        <td>${fns:getUserById(file.passUserId).name}</td>
                        <td><fmt:formatDate value="${file.passDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                        <c:choose>
                            <c:when test="${soAssess.so.processSts eq '盟市初审'}">
                                <form:radiobuttons onchange="setImpId(${file.id})" name="soAttachment.pass" path="soAttachment.pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                                   itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${file.sts eq '0'}">
                                        未审核
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${file.pass eq '0'}">
                                                <strong style="color:red ">不合格</strong>
                                            </c:when>
                                            <c:otherwise>
                                                合格
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        </td>
                    </tr>
                </c:forEach>--%>
                <c:forEach items="${soAssess.soAttachments}" var="file" varStatus="status">
                    <tr>
                        <td id="thContent${status.index}"><span class="preview"><a href="${file.url}" title="${file.name}" download="${file.name}" data-gallery><img
                                src="${file.thumbnailUrl}"></a></span></td>
                        <td><a href="${file.url}" title="${file.name}"
                               download="${file.name}" ${empty file.thumbnailUrl?'data-gallery':''}>${file.name}</a></td>
                        <td>${fns:formatFileSize(file.size)}</td>
                        <td>${fns:getUserById(file.passUserId).name}</td>
                        <td><fmt:formatDate value="${file.passDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${soAssess.so.processSts eq '盟市初审'}">
                                    <form:radiobuttons onchange="setImpId(${file.id})" name="pass" path="soAttachments[${status.index}].pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${file.sts eq '0'}">
                                            未审核
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${file.pass eq '0'}">
                                                    <strong style="color:red ">不合格</strong>
                                                </c:when>
                                                <c:otherwise>
                                                    合格
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            </form:form>
        </div>
    </fieldset>
    <c:if test="${soAssess.so.processSts eq '盟市初审'}">
        <form:form id="inputForm" modelAttribute="soAssess" action="${ctx}/cp/assess/localAudit" method="post" class="form-horizontal">
            <form:hidden path="soid"/>
           <%-- <div class="control-group">
                <label class="control-label">是否与原件一致：</label>
                <div class="controls">
                    <form:radiobuttons path="so.consistentOriginal" items="${fns:getDictList('CONSISTENT_ORIGINAL')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>--%>
            <div class="control-group">
                <label class="control-label">是否通过：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="so.pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">是否签章：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showseal(this)" id="seal" name="seal" path="so.seal" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div id="sealImg">
                <img src="${ctx}/file/seal/${fns:getUser().company.id}/cpAssLocalSeal">
            </div>
            <div class="control-group" id="backBlock">
                <label class="control-label">回退到：</label>
                <div class="controls">
                    <form:select path="so.backActivity">
                        <form:options items="${fns:getDictList('BACK_ACTIVITY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">审核意见：</label>
                <div class="controls">
                    <form:textarea id="auditRemarks" path="so.auditRemarks"     class="required" rows="5" maxlength="200"/>
                </div>
            </div>
            <div class="form-actions">
                <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </c:if>
    <c:if test="${soAssess.so.processSts eq '盟市分管局长审核'}">
        <form:form id="inputForm" modelAttribute="soAssess" action="${ctx}/cp/assess/localLeaderAudit" method="post" class="form-horizontal">
            <form:hidden path="soid"/>
           <%-- <div class="control-group">
                <label class="control-label">是否与原件一致：</label>
                <div class="controls">
                    <form:radiobuttons path="so.consistentOriginal" items="${fns:getDictList('CONSISTENT_ORIGINAL')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>--%>
            <div class="control-group">
                <label class="control-label">是否通过：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="so.pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">是否签章：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showseal(this)" id="seal" name="seal" path="so.seal" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div id="sealImg">
                <img src="${ctx}/file/seal/${fns:getUser().company.id}/cpAssLocalSeal">
            </div>
            <div class="control-group" id="backBlock">
                <label class="control-label">回退到：</label>
                <div class="controls">
                    <form:select path="so.backActivity">
                        <form:options items="${fns:getDictList('BACK_ACTIVITY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">审核意见：</label>
                <div class="controls">
                    <form:textarea id="auditRemarks"  path="so.auditRemarks" class="required" rows="5" maxlength="200"/>
                </div>
            </div>
            <div class="form-actions">
                <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </c:if>
    <c:if test="${soAssess.so.processSts eq '盟市主管科长审核'}">
        <form:form id="inputForm" modelAttribute="soAssess" action="${ctx}/cp/assess/localMainLeaderAudit" method="post" class="form-horizontal">
            <form:hidden path="soid"/>
           <%-- <div class="control-group">
                <label class="control-label">是否与原件一致：</label>
                <div class="controls">
                    <form:radiobuttons path="so.consistentOriginal" items="${fns:getDictList('CONSISTENT_ORIGINAL')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>--%>
            <div class="control-group">
                <label class="control-label">是否通过：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="so.pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">是否签章：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showseal(this)" id="seal" name="seal" path="so.seal" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div id="sealImg">
                <img src="${ctx}/file/seal/${fns:getUser().company.id}/cpAssLocalSeal">
            </div>
            <div class="control-group" id="backBlock">
                <label class="control-label">回退到：</label>
                <div class="controls">
                    <form:select path="so.backActivity">
                        <form:options items="${fns:getDictList('BACK_ACTIVITY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">审核意见：</label>
                <div class="controls">
                    <form:textarea id="auditRemarks"  path="so.auditRemarks" class="required" rows="5" maxlength="200"/>
                </div>
            </div>
            <div class="form-actions">
                <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </c:if>
    <c:if test="${soAssess.so.processSts eq '建设厅主管领导审核'}">
        <form:form id="inputForm" modelAttribute="soAssess" action="${ctx}/cp/assess/constructionCpLeaderAudit" method="post" class="form-horizontal">
            <form:hidden path="soid"/>
           <%-- <div class="control-group">
                <label class="control-label">是否与原件一致：</label>
                <div class="controls">
                    <form:radiobuttons path="so.consistentOriginal" items="${fns:getDictList('CONSISTENT_ORIGINAL')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>--%>
            <div class="control-group">
                <label class="control-label">是否通过：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="so.pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">是否签章：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showseal(this)" id="seal" name="seal" path="so.seal" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div id="sealImg">
                <img src="${ctx}/file/seal/${fns:getUser().company.id}/cpAssLocalSeal">
            </div>
            <div class="control-group" id="backBlock">
                <label class="control-label">回退到：</label>
                <div class="controls">
                    <form:select path="so.backActivity">
                        <form:options items="${fns:getDictList('BACK_ACTIVITY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">审核意见：</label>
                <div class="controls">
                    <form:textarea id="auditRemarks"  path="so.auditRemarks" class="required" rows="5" maxlength="200"/>
                </div>
            </div>
            <div class="form-actions">
                <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </c:if>
    <c:if test="${soAssess.so.processSts eq '建设厅分管领导审核'}">
        <form:form id="inputForm" modelAttribute="soAssess" action="${ctx}/cp/assess/constructionAllLeaderAudit" method="post" class="form-horizontal">
            <form:hidden path="soid"/>
           <%-- <div class="control-group">
                <label class="control-label">是否与原件一致：</label>
                <div class="controls">
                    <form:radiobuttons path="so.consistentOriginal" items="${fns:getDictList('CONSISTENT_ORIGINAL')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>--%>
            <div class="control-group">
                <label class="control-label">是否通过：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="so.pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">是否签章：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showseal(this)" id="seal" name="seal" path="so.seal" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div id="sealImg">
                <img src="${ctx}/file/seal/${fns:getUser().company.id}/cpAssLocalSeal">
            </div>
            <div class="control-group" id="backBlock">
                <label class="control-label">回退到：</label>
                <div class="controls">
                    <form:select path="so.backActivity">
                        <form:options items="${fns:getDictList('BACK_ACTIVITY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">审核意见：</label>
                <div class="controls">
                    <form:textarea id="auditRemarks"  path="so.auditRemarks" class="required" rows="5" maxlength="200"/>
                </div>
            </div>
            <div class="form-actions">
                <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </c:if>
    <c:if test="${soAssess.so.processSts eq '厅长审核'}">
        <form:form id="inputForm" modelAttribute="soAssess" action="${ctx}/cp/assess/directorAudit" method="post" class="form-horizontal">
            <form:hidden path="soid"/>
            <%--<div class="control-group">
                <label class="control-label">是否与原件一致：</label>
                <div class="controls">
                    <form:radiobuttons path="so.consistentOriginal" items="${fns:getDictList('CONSISTENT_ORIGINAL')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>--%>
            <div class="control-group">
                <label class="control-label">是否通过：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showBackAct(this)" id="pass" name="pass" path="so.pass" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">是否签章：</label>
                <div class="controls">
                    <form:radiobuttons onchange="showseal(this)" id="seal" name="seal" path="so.seal" items="${fns:getDictList('PASS')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" cssClass="required"></form:radiobuttons>
                </div>
            </div>
            <div id="sealImg">
                <img src="${ctx}/file/seal/${fns:getUser().company.id}/cpAssLocalSeal">
            </div>
            <div class="control-group" id="backBlock">
                <label class="control-label">回退到：</label>
                <div class="controls">
                    <form:select path="so.backActivity">
                        <form:options items="${fns:getDictList('BACK_ACTIVITY')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">审核意见：</label>
                <div class="controls">
                    <form:textarea id="auditRemarks"  path="so.auditRemarks" class="required" rows="5" maxlength="200"/>
                </div>
            </div>
            <div class="form-actions">
                <input class="btn btn-primary" type="button" value="确 定"  onclick="auditPass();"/>&nbsp;
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </c:if>
    <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
    <script src="${ctxStatic}/jquery-upload/js/load-image.min.js"></script>
    <!-- The Canvas to Blob plugin is included for image resizing functionality -->
    <script src="${ctxStatic}/jquery-upload/js/canvas-to-blob.min.js"></script>
    <!-- blueimp Gallery script -->
    <script src="${ctxStatic}/jquery-upload/js/jquery.blueimp-gallery.min.js"></script>
</body>
</html>
