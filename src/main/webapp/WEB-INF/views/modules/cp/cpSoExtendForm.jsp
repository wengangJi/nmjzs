<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员延续申报</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/jquery-upload/css/blueimp-gallery.min.css">

    <script type="text/javascript">
        $(document).ready(function() {
            $("#name").focus();

            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
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

            $('#rootwizard').bootstrapWizard({
                'tabClass': 'nav nav-tabs',
                onTabShow: function(tab, navigation, index) {
                    var $total = navigation.find('li').length;
                    var $current = index+1;
                    var $percent = ($current/$total) * 100;
                    //$('#rootwizard').find('.bar').css({width:$percent+'%'}); // 进度条

                    // If it's the last tab then hide the last button and show the finish instead
                    if($current >= $total) {
                        $('#rootwizard').find('.pager .next').hide();
                        $('#rootwizard').find('.pager .finish').show();
                        $('#rootwizard').find('.pager .finish').removeClass('disabled');
                    } else {
                        $('#rootwizard').find('.pager .next').show();
                        $('#rootwizard').find('.pager .finish').hide();
                    }

                },
                'onNext': function(tab, navigation, index) {
                    var $valid = $("#inputForm").valid();
                    if(!$valid) {
                        $validator.focusInvalid();
                        return false;
                    }
                },
                'onTabClick': function(tab, navigation, index) {
                    var $valid = $("#inputForm").valid();
                    if(!$valid) {
                        //$validator.focusInvalid();
                        return false;
                    }
                }
            });
            $('#rootwizard .finish').click(function() {
                var $valid = $("#inputForm").valid();
                if(!$valid) {
                    $validator.focusInvalid();
                    return false;
                }
                $("#inputForm").submit();
            });
            $('#rootwizard').find("a[href*='cpBase']").attr("disabled",true);
        });


    </script>
    <style type="text/css">
        #contentTable .control-label {width: 90px;}
    </style>
</head>
<body>
<div id="rootwizard" >
<ul class="nav nav-tabs" id="cpSoInfoPage">
    <li class="active"><a href="#cpTitle" data-toggle="tab">首页申请信息</a></li>
    <li><a href="#cpBase" data-toggle="tab">基本信息</a></li>
    <li><a href="#cpResume" data-toggle="tab">简历信息</a></li>
    <li><a href="#cpAppr" data-toggle="tab">审核信息</a></li>
    <li><a href="#cpUpload" data-toggle="tab">附件上传</a></li>


</ul>
<form:form id="inputForm" modelAttribute="soCpEntity" action="${ctx}/cp/soCp/saveForm" method="post" class="form-horizontal">
<form:hidden path="so.servid" value="${servCpEntity.servid}"/>
<form:hidden path="so.appId" value="${Constants.GLOBAL_CP_APP_ID}" />
<form:hidden path="so.companyId" value="${fns:getUser().userCompany.companyId}"/>
<form:hidden path="soCpBase.companyId" value="${fns:getUser().userCompany.companyId}"/>

<tags:message content="${message}"/>
<div class="tab-content">
<!-- 首页信息-->
<div class="tab-pane active" id="cpTitle">
    <div class="span10"  style="margin-left: 157px;">
        <p style="text-align: center;margin-bottom: 20px; font-size: 18px;">
            内蒙古自治区建筑施工企业<br>
            主要负责人、项目负责人和专职安全<br>
            生产管理人员考核申请表
        </p>
    </div>
        <div class="offset2 span10" style="margin-left: 300px;">
            <div class="control-group">
                <label class="control-label">企业名称:</label>

                <div class="controls">
                        <%-- <tags:commonselect id="companyId" name="companyId" value="${companyId}" labelName="companyName"
                                            labelValue="" title="企业" url="${ctx}/comp/company/findByName"/>--%>
                        <form:input path="so.rsrvStr1"  value="${servCpEntity.serv.company.companyName}" class="input-medium" readonly="true"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">申请人姓名:</label>

                <div class="controls">
                         <form:input path="so.applPerson" value="${servCpEntity.personnel.name}" class="required input-medium" readonly="true" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">身份证件号:</label>

                <div class="controls">
                         <form:input path="so.applIdNo"  value="${servCpEntity.personnel.idNo}" class="required input-medium" readonly="true"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">申请时间:</label>

                    <div class="controls">
                        <input id="applDate" name="so.applDate" type="text" readonly="readonly" maxlength="50" class="required input-medium Wdate" value="${applDate}"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                    </div>

            </div>
             <div class="control-group">
                     <label class="control-label">申报批次:</label>

                 <div class="controls">
                     <form:select id="so.batchId" path="so.batchId" class="required input-medium" ><form:option value=""
                                                                                                          label=""/><form:options
                             items="${fns:getBatchListByCompanyId(fns:getUser().userCompany.companyId)}" itemLabel="batchName"
                             itemValue="batchId" htmlEscape="false"/></form:select><a id="${id}Button" href="${ctx}/sys/sys/geneBacthPickFast?servid=${servCpEntity.servid}&appId=${Constants.GLOBAL_CP_APP_ID}&soType=${Constants.GLOBAL_SO_TYPE_EXTEND}" class="btn"  onclick="return confirmx('您确实要本次业务生成批次么？', this.href)">创建批次</a>
                 </div>
                 </div>
            <div class="control-group">
                <label class="control-label">申报类别:</label>

              <div class="controls">
                       <form:radiobutton path="so.soType" value="01"  readonly="true"/>首次申请<form:radiobutton path="so.soType"    checked="true"
                                                                                                           value="08"    class="required"
                                                                                                           disabled ="false" />延期申请

                </div>
            </div>
        </div>
        <div class="span10" style="margin-left: 165px;">
            <p style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
                内蒙古自治区建设厅编制
            </p>

        </div>

    </div>
<!-- 基本信息-->
<div class="tab-pane" id="cpBase">
     <table id="contentTable12" class="table table-bordered table-condensed table-hover">
                <thead>
                <tr align="center">
                    <td colspan="6" style="text-align: center"><h4>基 本 情 况</h4></td>
                </tr>
                </thead>
                <tr>
                    <td> <label class="control-label">姓名</label></td>
                    <td> <form:input path="soCpBase.name" htmlEscape="false"  class="required input-medium" readonly="true"/> </td>
                    <td> <label class="control-label">性别</label> </td>
                    <td> <form:radiobuttons path="soCpBase.sex" items="${fns:getDictList('SEX')}" itemLabel="label"  itemValue="value" htmlEscape="false" class="required" readonly="true"></form:radiobuttons>
                    <td> <label class="control-label">出生日期</label> </td>
                    <td> <input id="birthDate" name="soCpBase.birthDate" type="text" readonly="readonly"   readonly="true" maxlength="50" class="input-medium Wdate" value="<fmt:formatDate value="${soCache.soCpBase.birthDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> </td>
                    <td rowspan="3"width="60px;">照片</td>
                </tr>

                <tr>
                    <td><label class="control-label">证件号</label></td>
                    <td colspan="3"> <form:input path="soCpBase.idNo"  class="required input-medium" readonly="true"/></td>
                    <td><label class="control-label">证件类别</label></td>
                    <td><form:radiobuttons path="soCpBase.idType" items="${fns:getDictList('ID_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" readonly="true"></form:radiobuttons> </td>
                </tr>
                <tr>
                    <td><label class="control-label">人员类别</label></td>
                    <td colspan="5"> <form:radiobuttons path="soCpBase.personType" items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label"  itemValue="value" htmlEscape="false" class="required" readonly="true"></form:radiobuttons> </td>
                </tr>

                <tr>
                    <td><label class="control-label">参加考试时间</label></td>
                    <td colspan="2"><input id="examDate" name="soCpBase.examDate" type="text" readonly="readonly"   readonly="true"  maxlength="50" class="input-medium Wdate"      value="<fmt:formatDate value="${soCache.soCpBase.examDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>  </td>
                    <td><label class="control-label">考试成绩</label></td>
                    <td colspan="3"><form:input path="soCpBase.examScore"  class="input-medium" readonly="true"/></td>
                </tr>

                <tr>
                    <td ><label class="control-label">所在企业名称</label></td>
                    <td colspan="6"><form:input path="soCpBase.rsrvStr1" value="${servCpEntity.serv.company.companyName}"  class="input-medium" readonly="true"/></td>
                </tr>

                <tr>
                    <td><label class="control-label">企业联系电话</label></td>
                    <td colspan="2"><form:input path="soCpBase.telephone"  class="input-medium" readonly="true"/></td>
                    <td><label class="control-label">资质等级</label></td>
                    <td colspan="3"><form:input path="soCpBase.qualLevel"   class="input-medium" readonly="true"/></td>
                </tr>

                <tr>
                    <td><label class="control-label">通讯地址</label></td>
                    <td colspan="2"><form:input path="soCpBase.address" class="input-medium" readonly="true"/></td>
                    <td><label class="control-label">邮政编码</label></td>
                    <td colspan="3"><form:input path="soCpBase.postCode"  class="input-medium" readonly="true"/></td>
                </tr>

                <tr> <td ><label class="control-label">电子邮箱</label></td>
                    <td colspan="6"><form:input path="soCpBase.mail"  class="input-medium" readonly="true"/></td>
                </tr>

                <tr>
                    <td><label class="control-label">毕业院校</label></td>
                    <td colspan="6"><form:input path="soCpBase.gardSchool"   class="input-medium" readonly="true"/></td>
                </tr>

                <tr>
                    <td><label class="control-label">毕业时间</label></td>
                    <td> <input id="gardDate" name="soCpBase.gardDate" type="text" readonly="readonly" maxlength="50"     readonly="true" class="input-medium Wdate" value="<fmt:formatDate value="${soCache.soCpBase.gardDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>   </td>
                    <td><label class="control-label">专业</label></td>
                    <td> <form:select path="soCpBase.major" class="input-medium"> <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false" readonly="true"/>  </form:select> </td>
                    <td><label class="control-label">职称</label></td>
                    <td colspan="2"> <form:select path="soCpBase.titleLevel" class="input-medium"><form:options items="${fns:getDictList('TITLE_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false" readonly="true"/> </form:select> </td>
                </tr>

                <tr>
                    <td><label class="control-label">学 历</label></td>
                    <td>
                        <form:select path="soCpBase.degree" class="input-medium">
                            <form:options items="${fns:getDictList('DEGREE')}" itemLabel="label" itemValue="value" htmlEscape="false" readonly="true"/>
                        </form:select>
                    </td>
                    <td><label class="control-label">学位</label></td>
                    <td><form:select path="soCpBase.education" class="input-medium">
                        <form:options items="${fns:getDictList('EDUCATION')}" itemLabel="label" itemValue="value" htmlEscape="false" readonly="true"/>
                    </form:select>
                    </td>
                    <td><label class="control-label">执业资格</label></td>
                    <td colspan="2"><form:input path="soCpBase.titleType"  class="input-medium" readonly="true"/></td>
                </tr>

                <tr>
                    <td><label class="control-label">参加工作时间</label></td>
                    <td colspan="2">
                        <input id="workingDate" name="soCpBase.workingDate" type="text" readonly="readonly"   readonly="true"
                               maxlength="50" class="input-medium Wdate"
                               value="<fmt:formatDate value="${soCache.soCpBase.workingDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                            <%--<fmt:formatDate value="${workingDate}" type="date" />--%>


                    </td>
                    <td><label class="control-label">累计安全生产管理工作年限</label></td>
                    <td colspan="3"><form:input path="soCpBase.workExpe"  class="input-medium" readonly="true"/></td>
                </tr>
                <tr>
                    <td><label class="control-label">接受安全教育、培训及考核情况</label></td>
                    <td colspan="6"><form:textarea path="soCpBase.learnExpe" class="input-block-level" rows="4" readonly="true"/></td>
                </tr>
                <tr>
                    <td><label class="control-label">证书使用情况</label> </td>
                    <td colspan="6"><form:textarea path="soCpBase.certExpe" class="input-block-level" rows="4" readonly="true"/></td>
                </tr>
         </table>
    </div>
<!-- 简历信息-->
<div class="tab-pane" id="cpResume">


            <table id="contentTable" class="table table-striped table-bordered table-condensed table-hover">
                <thead>
                <tr align="center"><td colspan="8" style="text-align: center"><h4>工 作 简 历</h4></td></tr>
                </thead>
                <tr style="text-align: center">
                    <td>序 号</td><td>聘用开始时间</td><td>聘用结束时间</td><td>工作单位</td><td>职务</td>
                </tr>
                </thead>

                <c:forEach items="${soCpEntity.soCpResume}" var="soCpResume" varStatus="status">
                    <form:hidden path="soCpResume[${status.index}].seq"/>

                    <tr><td>${status.index}</td>
                        <td><input id="effDate" name="soCpResume[${status.index}].effDate" type="text" maxlength="50" class="input-medium Wdate"        readonly="readonly"
                                   value="<fmt:formatDate value="${soCpEntity.soCpResume[status.index].effDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> </td>
                        <td><input id="expDate" name="soCpResume[${status.index}].expDate" type="text" maxlength="50" class="input-medium Wdate"  readonly="readonly"
                                   value="<fmt:formatDate value="${soCpEntity.soCpResume[status.index].expDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> </td>
                        <td ><form:input path="soCpResume[${status.index}].company"  class="input-medium" readonly="true"/></td>
                        <td ><form:input path="soCpResume[${status.index}].position"  class="input-medium" readonly="true"/></td>
                    </tr>
                </c:forEach>

               <tr><td colspan="5" style="text-align: center"><h4>安 全 生 产 业 绩</h4></td></tr>
                <tr>
                    <td><label class="control-label">受表彰情况</label></td> <td colspan="4">
                    <form:textarea path="soCpPerformance.honorCase" class="input-block-level" rows="4" readonly="true"/></td>
                </tr>
                <tr>
                    <td><label class="control-label">受处罚情况</label></td> <td colspan="4">
                    <form:textarea path="soCpPerformance.penaltyCase" class="input-block-level" rows="4" readonly="true"/></td>
                </tr>
            </table>
</div>
<!-- 审核信息-->
<div class="tab-pane" id="cpAppr">
    <table id="contentApproveTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr align="center"><td colspan="8" style="text-align: center"><h4>审 核 信 息</h4></td></tr>
        </thead>
        <tr>
            <td class="span2"><label class="control-label">企业审核意见</label></td>
            <td><form:textarea path="soCpApprove[0].content"   maxlength="2048" class="required input-block-level" rows="4"/></td>
        </tr>
        <tr>
            <td class="span2"><label class="control-label">省辖市建设行政主管部门</label></td>
            <td><form:textarea path="soCpApprove[0].contentLoc" class=" input-block-level" rows="4" readonly="true"/></td>
        </tr>
        <tr>
            <td class="span2"><label class="control-label">建设厅审查意见</label></td>
            <td><form:textarea path="soCpApprove[0].contentMon" class=" input-block-level" rows="4" readonly="true"/></td>
        </tr>
        <tr>
            <td class="span2"><label class="control-label">备注</label></td>
            <td><form:textarea path="soCpApprove[0].remarks" class=" input-block-level" rows="4" /></td>
        </tr>
    </table>
</div>
<!-- 附件信息-->
<div class="tab-pane" id="cpUpload">
<%--
    <iframe id="cpUploadFrame" name="cpUploadFrame" src="${ctx}/cp/personnel/findCpServAttachmentList?servid=${servCpEntity.servid}" style="overflow:auto"
                scrolling="yes" frameborder="no" width="100%" height="300"></iframe>
    <iframe id="cpUploadFrame2" name="cpUploadFrame2" src="${ctx}/cp/soCp/cpAttachment?appId=CP&soType=08" style="overflow:auto;"
            scrolling="yes" frameborder="no" width="100%" height="300"></iframe>--%>
        <%-- <iframe id="cpUploadFrame1" name="cpUploadFrame1" src="${ctx}/cp/soCp/cpUploadPage?soid=${soCpEntity.soid}&pageModule=cpSoChgForm" style="overflow:visible;"
                      scrolling="yes" frameborder="no" width="100%" height="300"></iframe>--%>
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
        <legend id="hideme" data-toggle="tooltip" data-placement="top" title="" data-original-title="点击隐藏/显示附件信息">点击隐藏/显示附件</legend>
        <div id="fileArea">
            <form id="fileForm">
                <input type="hidden" id="currImgId">
                <table class="table">
                    <tr>
                        <th>缩略图</th>
                        <th>附件名</th>
                        <th>文件大小</th>
                        <th>审核人</th>
                        <th>审核时间</th>
                        <th>是否合格</th>
                    </tr>
                    <c:forEach items="${servCpEntity.servAttachments}" var="file" varStatus="status">
                        <form:hidden path="soAttachments[${status.index}].id"/>
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
                            </td>
                            <td>

                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </form>
        </div>
    </fieldset>

    <iframe id="cpUploadFrame2" name="cpUploadFrame2" src="${ctx}/cp/soCp/cpAttachment?appId=${Constants.GLOBAL_CP_APP_ID}&soType=${Constants.GLOBAL_SO_TYPE_EXTEND}" style="overflow:visible;"
            scrolling="yes" frameborder="no" width="100%" height="300"></iframe>
</div>
</div>
<style>
    #linknav ul{text-align:center;list-style-type:none;}
    #linknav ul li{display:inline;list-style-type:none;}
</style>

<ul class="pager wizard">
    <li class="previous"  ><input type='button' class='btn button-previous' name='previous' value='上一步' /></li>
    <li class="next" ><input type='button' class='btn button-next btn-primary' name='next' value='下一步' /></li>
    <li class="next finish" style="display:none;"><input type='button' class='btn btn-primary' name='next' value='保 存' /></li>
</ul>
</form:form>
</div>
</body>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/load-image.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="${ctxStatic}/jquery-upload/js/canvas-to-blob.min.js"></script>
<!-- blueimp Gallery script -->
<script src="${ctxStatic}/jquery-upload/js/jquery.blueimp-gallery.min.js"></script>
</html>