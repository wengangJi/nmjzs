<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>三类人员申报</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            var $validator = $("#inputForm").validate({

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
            $('#rootwizard').bootstrapWizard({
                'nextSelector': '.button-next',
                'previousSelector': '.button-previous',
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
                        $validator.focusInvalid();
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
		});

        function addResume(){
           var _len = $("#contentResumeTable tr").length-1;
           var _size= $("#contentResumeTable tr").length-2;
           $("#contentResumeTable").append("<tr  align='center'>" +'<td>'+_len+'</td>'
                    +"<input id=\"seq\" name=\"soCpResume["+_size+"]\.seq\" class=\"input-medium\" type=\"hidden\" value=\""+_len+"\">"
                    +" <td><input id=\"effDate\" name=\"soCpResume["+_size+"]\.effDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${effDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                    +" <td><input id=\"expDate\" name=\"soCpResume["+_size+"]\.expDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${expDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                    +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"64\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                    +"<td><input id=\"position\" name=\"soCpResume["+_size+"]\.position\" maxlength=\"64\" class=\"required input-medium\" type=\"text\" value=\"\">&nbsp;&nbsp;<a href='javascript:void(0)' onclick='javascript:del(this);'>删除</a></td>"
                    +"</tr>");
        };
        function del(obj) {
           var inRowIndex = obj.parentNode.parentNode.rowIndex;
            //alert(inRowIndex);
            var delRow=obj.parentNode.parentNode.parentNode;
           delRow.deleteRow(inRowIndex-1);
        }
        function evalSameValue(){
            if(!$("#applPerson").val().empty) {
                $("#name").val($("#applPerson").val());
             }
            if(!$("#applIdNo").val().empty) {
                $("#idNo").val($("#applIdNo").val());
            }
        }
    </script>
    <style type="text/css">
        #contentTable .control-label {width: 90px;}
        #myPrintArea table td {
        .mine
        font-size: 12px;
            font-family: '仿宋';

            font-size: 13px;
            font-family: '宋体';
            padding: 4px; margin-top: 4px;;
        .r20
        }
    </style>

</head>
<body>
<div id="rootwizard" >
    <ul class="nav nav-tabs" id="cpSoForm">
        <li class="active"><a href="#cpTitle" data-toggle="tab">首页申请信息</a></li>
        <li><a href="#cpBase" data-toggle="tab">基本信息</a></li>
        <li><a href="#cpResume" data-toggle="tab">简历信息</a></li>
        <li><a href="#cpAppr" data-toggle="tab">审核信息</a></li>
        <li><a href="#cpUpload" data-toggle="tab">附件信息</a></li>
    </ul>
    <form:form id="inputForm" modelAttribute="soCpEntity" action="${ctx}/cp/soCp/saveForm" method="post" class="form-horizontal">
    <tags:message content="${message}"/>
    <form:hidden path="so.companyId" value="${fns:getUser().userCompany.companyId}"/>
    <form:hidden path="so.appId" value="${Constants.GLOBAL_CP_APP_ID}" />
    <!-- 进度条
    <div id="bar" class="progress progress-striped active">
        <div class="bar"></div>
    </div>
    -->
    <div class="tab-content">
      <!--首页信息-->
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
                        <form:input path="so.rsrvStr1"  value="${fns:getUser().userCompany.companyName}" class="input-medium" disabled ="true"/>
                </div>
            </div>
        <div class="control-group">
                <label class="control-label">申报批次:</label>
                <div class="controls">
                    <form:select id="batchId" path="so.batchId" class="required input-medium" ><form:option value="" label=""/><form:options    items="${fns:getBatchListByCompanyId(fns:getUser().userCompany.companyId)}" itemLabel="batchName"
                            itemValue="batchId" htmlEscape="false"/></form:select>
                    <a id="${id}Button" href="${ctx}/sys/sys/geneBacthPickFast?appId=${Constants.GLOBAL_CP_APP_ID}&soType=${Constants.GLOBAL_SO_TYPE_SO}" class="btn"  onclick="return confirmx('您确实要本次业务生成批次么？', this.href)">创建批次</a>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">申请人姓名:</label>
                <div class="controls">
                    <form:input id="applPerson" path="so.applPerson" onblur="evalSameValue();" class="required realName input-medium" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">身份证件号:</label>
                <div class="controls">
                    <form:input id="applIdNo" path="so.applIdNo"  onblur="evalSameValue();" class="required card input-medium" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">申请时间:</label>
            <div class="controls">
                    <input id="so.applDate" name="so.applDate" type="text" readonly="readonly" maxlength="50" value="" pattern="yyyy-MM-dd"
                           class="required input-medium Wdate" value="${applDate}"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">申报类别:</label>
                <div class="controls">
                    <form:radiobutton path="so.soType" value="01" checked="true" class="required"/>首次申请<form:radiobutton path="so.soType" value="08" disabled="true"/>延期申请
                </div>
            </div>
        </div>
        <div class="span10"  style="margin-left: 165px;">
            <p style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
                内蒙古自治区建设厅编制
            </p>
        </div>
       </div>
      <!-- 基本信息-->
        <div class="tab-pane" id="cpBase">
            <div id="div" style="  display:block width: 968px;" >
                <table id="contentBaseTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr align="center">
                        <td colspan="6" style="text-align: center"><h4>基 本 情 况</h4></td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td> <label class="control-label">姓名</label></td>
                        <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                        <td> <label class="control-label">性别</label> </td>
                        <td><form:radiobuttons id="sex" path="soCpBase.sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                        <td> <label class="control-label">出生日期</label> </td>
                        <td>
                            <input id="birthDate" name="soCpBase.birthDate" type="text" readonly="readonly" maxlength="50"
                                   class="required input-medium Wdate"
                                   value="<fmt:formatDate value="${soCpBase.birthDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </td>
                        <td rowspan="3"width="60px;">照片</td>
                    </tr>

                    <tr>
                        <td><label class="control-label">证件号</label></td>
                        <td colspan="3">
                            <form:input id="idNo" path="soCpBase.idNo"  class="required input-medium"/>
                                <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>
                        <td><label class="control-label">证件类别</label></td>
                        <td><form:radiobuttons id="idType" path="soCpBase.idType" items="${fns:getDictList('ID_TYPE')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>

                        </td>
                    </tr>
                    <tr>
                        <td><label class="control-label">人员类别</label></td>
                        <td colspan="5">
                            <form:radiobuttons path="soCpBase.personType" items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                        </td>
                    </tr>

                    <tr>
                        <td><label class="control-label">参加考试时间</label></td>
                        <td colspan="2"><input id="examDate" name="soCpBase.examDate" type="text" readonly="readonly"
                                               maxlength="50" class="input-medium Wdate"
                                               value="${examDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></td>
                        <td><label class="control-label">考试成绩</label></td>
                        <td colspan="3"><form:input path="soCpBase.examScore"  class="digits input-medium"/></td>
                    </tr>

                    <tr>
                        <td ><label class="control-label">所在企业名称</label></td>
                        <td colspan="6"> <tags:commonselect id="companyId" name="soCpBase.companyId" value="${fns:getUser().userCompany.companyId}" labelName="companyName" labelValue="${fns:getUser().userCompany.companyName}" title="查询企业" url="${ctx}/comp/company/findByName"/></td>
                    </tr>

                    <tr>
                        <td><label class="control-label">企业联系电话</label></td>
                        <td colspan="2"><form:input path="soCpBase.telephone"  value="${fns:getUser().userCompany.contactPhone}" class="simplePhone input-medium"/></td>
                        <td><label class="control-label">资质等级</label></td>
                        <td colspan="3"><form:input path="soCpBase.qualLevel" maxlength="256"  value="${fns:getUser().userCompany.qualLevel}"   class="input-medium"/></td>
                    </tr>

                    <tr>
                        <td><label class="control-label">通讯地址</label></td>
                        <td colspan="2"><form:input path="soCpBase.address" maxlength="2048" value="${fns:getUser().userCompany.address}" class="input-medium"/></td>
                        <td><label class="control-label">邮政编码</label></td>
                        <td colspan="3"><form:input path="soCpBase.postCode" value="${fns:getUser().userCompany.postCode}" class="zipCode input-medium"/></td>
                    </tr>

                    <tr> <td ><label class="control-label">电子邮箱</label></td>
                        <td colspan="6"><form:input path="soCpBase.mail" maxlength="64" value="${fns:getUser().userCompany.email}" class="email input-medium"/></td>
                    </tr>

                    <tr>
                        <td><label class="control-label">毕业院校</label></td>
                        <td colspan="6"><form:input path="soCpBase.gardSchool" maxlength="64" class="input-medium"/></td>
                    </tr>

                    <tr>
                        <td><label class="control-label">毕业时间</label></td>
                        <td>
                            <input id="gardDate" name="soCpBase.gardDate" type="text" readonly="readonly" maxlength="50"
                                   class="input-medium Wdate"
                                   value="${gardDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> </td>
                        <td><label class="control-label">专业</label></td>
                        <td>
                            <form:select path="soCpBase.major" class="input-medium">
                                <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                            </form:select>
                        </td>
                        <td><label class="control-label">职称</label></td>
                        <td colspan="2">
                            <form:select path="soCpBase.titleLevel" class="input-medium">
                                <form:options items="${fns:getDictList('TITLE_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                            </form:select>
                        </td>
                    </tr>

                    <tr>
                        <td><label class="control-label">学 历</label></td>
                        <td>
                            <form:select path="soCpBase.degree" class="input-medium">
                                <form:options items="${fns:getDictList('DEGREE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                            </form:select>
                        </td>
                        <td><label class="control-label">学位</label></td>
                        <td><form:select path="soCpBase.education" class="input-medium">
                            <form:options items="${fns:getDictList('EDUCATION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                        </td>
                        <td><label class="control-label">执业资格</label></td>
                        <td colspan="2"><form:input path="soCpBase.titleType"  maxlength="128" class="input-medium"/></td>
                    </tr>

                    <tr>
                        <td><label class="control-label">参加工作时间</label></td>
                        <td colspan="2">
                            <input id="workingDate" name="soCpBase.workingDate" type="text" readonly="readonly"
                                   maxlength="50" class="input-medium Wdate"
                                   value="${workingDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>

                        </td>
                        <td><label class="control-label">累计安全生产管理工作年限</label></td>
                        <td colspan="3"><form:input path="soCpBase.workExpe"  class="number input-medium"/></td>
                    </tr>
                    <tr>
                        <td><label class="control-label">接受安全教育、培训及考核情况</label></td>
                        <td colspan="6"><form:textarea path="soCpBase.learnExpe" class="input-block-level" rows="4"/></td>
                    </tr>
                    <tr>
                        <td><label class="control-label">证书使用情况</label> </td>
                        <td colspan="6"><form:textarea path="soCpBase.certExpe" class="input-block-level" rows="4"/></td>
                    </tr>

                    </tbody>
                </table>
           </div>
        </div>
      <!-- 简历信息-->
        <div class="tab-pane" id="cpResume">
            <table id="contentResumeTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr align="center"><td colspan="8" style="text-align: center"><h4>工 作 简 历</h4></td></tr>
                </thead>
                <tr style="text-align: center">
                    <td>序 号</td><td>聘用开始时间</td><td>聘用结束时间</td><td>工作单位</td><td>职务</td>
                </tr>
            </table>
            <table id="addResumeTable" class="table table-striped table-bordered table-condensed">
                 <tr>
                    <td colspan="5" style="text-align:right"> <a href="javascript:" onclick="addResume();" class="btn  btn-primary">添加工作简历</a></td>
                </tr>
            </table>
            <table id="contentPerformanceTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr align="center"><td colspan="8" style="text-align: center"><h4>安 全 生 产 业 绩</h4></td></tr>
                </thead>
                <tr>
                    <td class="span2"><label class="control-label">受表彰情况</label></td>
                    <td><form:textarea path="soCpPerformance.honorCase" maxlength="5124" class="required  input-block-level" rows="4"/></td>
                </tr>
                <tr>
                    <td class="span2"><label class="control-label">受处罚情况</label></td>
                    <td><form:textarea path="soCpPerformance.penaltyCase"  maxlength="5124"  class=" input-block-level" rows="4" /></td>
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
                    <td><form:textarea path="soCpApprove[0].content" maxlength="2048" class="required input-block-level" rows="4"/></td>
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
          <iframe id="cpUploadFrame" name="cpUploadFrame" src="${ctx}/cp/soCp/cpAttachment?appId=${Constants.GLOBAL_CP_APP_ID}&soType=${Constants.GLOBAL_SO_TYPE_SO}" style="overflow:visible;"
                  scrolling="yes" frameborder="no" width="100%" height="500"></iframe>
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
</html>