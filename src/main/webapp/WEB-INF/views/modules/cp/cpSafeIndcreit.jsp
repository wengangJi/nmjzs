<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>全生产许可证申请表</title>
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
                   /* var $valid = $("#inputForm").valid();
                    if(!$valid) {
                        $validator.focusInvalid();
                        return false;
                    }*/
                },
                'onTabClick': function(tab, navigation, index) {
                   /* var $valid = $("#inputForm").valid();
                    if(!$valid) {
                        $validator.focusInvalid();
                        return false;
                    }*/
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
           var _len = $("#contentResumeTable tr").length-2;
           var _size= $("#contentResumeTable tr").length-2;
           $("#contentResumeTable").append("<tr  align='center'>" +'<td>'+_len+'</td>'
                    +"<input id=\"seq\" name=\"soCpResume["+_size+"]\.seq\" class=\"input-medium\" type=\"hidden\" value=\""+_len+"\">"
                   +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                   +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                    +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                   +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                   +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                   +" <td><input id=\"effDate\" name=\"soCpResume["+_size+"]\.effDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${effDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                   +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                   +" <td><input id=\"effDate\" name=\"soCpResume["+_size+"]\.effDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${effDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                    +"</tr>");
        };
        function del(obj) {
           var inRowIndex = obj.parentNode.parentNode.rowIndex;
            //alert(inRowIndex);
            var delRow=obj.parentNode.parentNode.parentNode;
           delRow.deleteRow(inRowIndex-1);
        }

        function addInfo(){
            var _len = $("#contentInfoTable tr").length-10;
            var _size= $("#contentInfoTable tr").length-10;
            $("#contentInfoTable").append("<tr  align='center'>" +'<td>'+_len+'</td>'
                    +"<input id=\"seq\" name=\"soCpResume["+_size+"]\.seq\" class=\"input-medium\" type=\"hidden\" value=\""+_len+"\">"
                                    +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                    +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                    +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                    +" <td><input id=\"effDate\" name=\"soCpResume["+_size+"]\.effDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${effDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                    +"<td><input id=\"company\" name=\"soCpResume["+_size+"]\.company\" maxlength=\"12\" class=\"required input-medium\" type=\"text\" value=\"\"></td>"
                    +" <td><input id=\"effDate\" name=\"soCpResume["+_size+"]\.effDate\" type=\"text\" readonly=\"readonly\" maxlength=\"50\" class=\"required input-medium Wdate\" value=\"${effDate}\" onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});\"/></td> "
                    +"</tr>");
        };
        function delInfo(obj) {
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
        #contentBaseTable.control-label {width: 102px;}
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
        <li class="active"><a href="#cpTitle" data-toggle="tab">首页</a></li>
        <li><a href="#showInfo" data-toggle="tab">填  表  说  明</a></li>
        <li ><a href="#daibiao" data-toggle="tab">企业法定代表人声明</a></li>
        <li><a href="#cpUpload" data-toggle="tab">企业主要负责人简况</a></li>
        <li ><a href="#cpResume" data-toggle="tab">项目负责人简况</a></li>
        <li ><a href="#cpBase" data-toggle="tab">专职安全生产管理人员简况</a></li>
        <li ><a href="#cpAppr" data-toggle="tab">安全生产许可证审批情况</a></li>
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
            <div class="control-group" style="float: left">
                <label class="control-label">申请编号:</label>
                <div class="controls">
                    <form:input id="applIdNo" path="so.applIdNo"  onblur="evalSameValue();" class="required card input-medium" />
                </div>
            </div>
            <div class="control-group" >
                <label class="control-label">受理编号:</label>
                <div class="controls">
                    <form:input id="applIdNo" path="so.applIdNo"  onblur="evalSameValue();" class="required card input-medium" />
                </div>
            </div>
            <div class="control-group" style="float: left">
                <label class="control-label">申请时间:</label>
                <div class="controls">
                    <form:input id="applIdNo" path="so.applIdNo"  onblur="evalSameValue();" class="required card input-medium" />
                </div>
            </div>
            <div class="control-group" >
                <label class="control-label"> 受理时间:</label>
                <div class="controls">
                    <form:input id="applIdNo" path="so.applIdNo"  onblur="evalSameValue();" class="required card input-medium" />
                </div>
            </div>
            <p style="text-align: center;margin-bottom: 20px; font-size: 18px;">
                建筑施工企业安全生产许可证申请表
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
                <label class="control-label">申报日期:</label>
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
    <!-- 填  表  说  明-->
    <div class="tab-pane  " id="showInfo">
        <div style="  display:block width: 968px;" >
            <h4 style="text-align: center">    填  表  说  明</h4>
            <p>
                一、本表用于建筑施工企业首次申请或者申请延期安全生产许可证。
            </p>
            <p>
                二、本表应使用黑色钢笔或签字笔填写，或使用计算机打印，字迹要工整，不得涂改。
            </p><p>
            三、申请编号、申请时间、受理编号、受理时间由发证机关填写，本表第一至第五部分由企业填写。表中“证书有效期”一栏，请填写证书有效期的截止时间。企业应如实逐项填写，不得有空项。如遇没有的项目请填写“无”。
        </p><p>  四、本表一律用中文填写，数字均使用阿拉伯数字。
        </p><p> 五、本表在填写时如需加页，一律使用A4型纸。
        </p><p>  六、本表所需附件材料请按第七项所列目录顺序用A4型纸单独装订成册；企业在申请时，需要交验附件材料中涉及的所有证件、凭证原件。
        </p><p>   七、本表可在建筑安全生产监督管理信息系统(www.jzaq.net)下载后用A4型纸打印。</p>

        </div>
    </div>
    <!-- >企业法定代表人声明-->
    <div class="tab-pane " id="daibiao">
        <table id="daibiaotable" class="table table-striped table-bordered table-condensed">
            <thead>
            <tr align="center"><td colspan="8" style="text-align: center"><h4>企业法定代表人声明</h4></td></tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="8" >
                    <textarea name="soCpApprove[0].content" id="soCpApprove[0].content" maxlength="2048" class="required input-block-level" rows="4" >
                        本人        （法定代表人）                    （身份证号码）郑重声明，本企业填报的《建筑施工企业安全生产许可证申请表》及附件材料的全部内容是真实的，无任何隐瞒和欺骗行为。本企业此次申请建筑施工企业安全生产许可证，如有隐瞒情况和提供虚假材料以及其他违法行为，本企业和本人愿意接受建设主管部门及其他有关部门依据有关法律法规给予的处罚。

                        企业法人代表：
                        (签名)            （企业公章）

                        年   月   日

                    </textarea>

                </td>
            </tr>
            <tr><td colspan="8" style="text-align: center" >

                一、企业基本情况

            </td></tr>
            <tr>
                <td  colspan="2"> <label class="control-label">企业名称</label></td>
                <td  colspan="6"> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>


            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">注册地址及邮箱</label></td>
                <td  colspan="6"> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>


            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">营业执照注册号</label></td>
                <td  colspan="6"> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>


            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">经济类型</label></td>
                <td  colspan="2"> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>

                <td  colspan="2"> <label class="control-label">首次批准资质时间
                </label></td>
                <td  colspan="2"> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>

            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">联系电话</label></td>
                <td  colspan="2"> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>

                <td  colspan="2"> <label class="control-label">传真电话</label></td>
                <td  colspan="2"> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>

            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">电子邮箱</label></td>
                <td  colspan="2"> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>

                <td  colspan="2"> <label class="control-label">职工年平均人数</label></td>
                <td  colspan="2">
                    <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>

            </tr>
            <tr>
                <td  rowspan="3"  colspan="2"> <label class="control-label">资质类别及等级</label></td>
                <td   colspan="2"> <label class="control-label">主项资质</label></td>
                <td   colspan="4">
                    <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td   colspan="2"> <label class="control-label">增项资质</label></td>
                <td   colspan="4">
                    <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td   colspan="2"> <label class="control-label">资质证书编号</label></td>
                <td   colspan="4">
                    <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <!-- 企业主要负责人简况-->
    <div class="tab-pane" id="cpUpload">
    <div id="div" style="  display:block width: 968px;" >
        <table id="contentInfoTable" class="table table-striped table-bordered table-condensed">
            <thead>
            <tr align="center">
                <td colspan="7" style="text-align: center"><h4>法定代表人</h4></td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td  colspan="2"> <label class="control-label">姓名</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">性别</label> </td>
                <td><form:radiobuttons id="sex" path="soCpBase.sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                </td>
                <td rowspan="4"width="150px;">照片</td>
            </tr>

            <tr>
                <td  colspan="2"><label class="control-label">证件号</label></td>
                <td colspan="4">
                    <form:input id="idNo" path="soCpBase.idNo"  class="required input-medium"/>
                        <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">职务</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">职称</label> </td>
                <td><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">最高学历</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">专业</label> </td>
                <td><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">固定电话</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">移动电话</label></td>
                <td colspan="1"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">安全生产考核合格发证单位</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">发证时间</label></td>
                <td colspan="1">
                    <input id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" class="input-small Wdate" type="text" value="">                       </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">证书编号</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">证书有效期</label></td>
                <td colspan="1">
                    <input id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" class="input-small Wdate" type="text" value="">
                </td>
            </tr>
            <tr align="center">
                <td colspan="7" style="text-align: center"><h4>经  理</h4></td>
            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">姓名</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">性别</label> </td>
                <td><form:radiobuttons id="sex" path="soCpBase.sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                </td>
                <td rowspan="4"width="150px;">照片</td>
            </tr>

            <tr>
                <td  colspan="2"><label class="control-label">证件号</label></td>
                <td colspan="4">
                    <form:input id="idNo" path="soCpBase.idNo"  class="required input-medium"/>
                        <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">职务</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">职称</label> </td>
                <td><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">最高学历</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">专业</label> </td>
                <td><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">固定电话</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">移动电话</label></td>
                <td colspan="1"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">安全生产考核合格发证单位</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">发证时间</label></td>
                <td colspan="1">
                    <input id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" class="input-small Wdate" type="text" value="">                       </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">证书编号</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">证书有效期</label></td>
                <td colspan="1">
                    <input id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" class="input-small Wdate" type="text" value="">
                </td>
            </tr>
            <tr align="center">
                <td colspan="7" style="text-align: center"><h4>分管安全生产经理</h4></td>
            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">姓名</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">性别</label> </td>
                <td><form:radiobuttons id="sex" path="soCpBase.sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                </td>
                <td rowspan="4"width="150px;">照片</td>
            </tr>

            <tr>
                <td  colspan="2"><label class="control-label">证件号</label></td>
                <td colspan="4">
                    <form:input id="idNo" path="soCpBase.idNo"  class="required input-medium"/>
                        <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">职务</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">职称</label> </td>
                <td><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"> <label class="control-label">最高学历</label></td>
                <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                <td  colspan="2"> <label class="control-label">专业</label> </td>
                <td><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">固定电话</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">移动电话</label></td>
                <td colspan="1"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">安全生产考核合格发证单位</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">发证时间</label></td>
                <td colspan="1">
                    <input id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" class="input-small Wdate" type="text" value="">                       </td>
            </tr>
            <tr>
                <td  colspan="2"><label class="control-label">证书编号</label></td>
                <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                </td>
                <td  colspan="2"><label class="control-label">证书有效期</label></td>
                <td colspan="1">
                    <input id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" class="input-small Wdate" type="text" value="">
                </td>
            </tr>
            </tbody>
        </table>

    </div>
        <!-- 项目负责人简况-->
        <div class="tab-pane active" id="cpResume">
            <table id="contentResumeTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr align="center"><td colspan="8" style="text-align: center"><h4>项目负责人简况</h4></td></tr>
                </thead>
                <tr style="text-align: center">
                    <td rowspan="2">序 号</td><td rowspan="2">姓  名</td><td rowspan="2">注册建造师级别</td><td rowspan="2">注册建造师专业</td><td rowspan="2">注册建造师注册号</td><td colspan="4">安全生产考核合格情况</td>
                </tr>
                <tr style="text-align: center" >
                    <td>发证单位</td> <td>发证时 间</td> <td>证书编号</td> <td>证书有效期</td>
                </tr>
            </table>
            <table id="addResumeTable" class="table table-striped table-bordered table-condensed">
                <tr>
                    <td colspan="5" style="text-align:right"> <a href="javascript:" onclick="addResume();" class="btn  btn-primary">添加负责人简况</a></td>
                </tr>
            </table>
        </div>
      <!-- 专职安全生产管理人员简况-->
        <div class="tab-pane  " id="cpBase">
            <div id="div" style="  display:block width: 968px;" >
                <table id="contentInfoTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr align="center">
                        <td colspan="7" style="text-align: center"><h4>安全管理机构负责人</h4></td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td  colspan="2"> <label class="control-label">姓名</label></td>
                        <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                        <td  colspan="2"> <label class="control-label">性别</label> </td>
                        <td><form:radiobuttons id="sex" path="soCpBase.sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                               itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
</td>
                        <td rowspan="4"width="150px;">照片</td>
                    </tr>

                    <tr>
                        <td  colspan="2"><label class="control-label">证件号</label></td>
                        <td colspan="4">
                            <form:input id="idNo" path="soCpBase.idNo"  class="required input-medium"/>
                                <%--<tags:idselect id="idNo" name="idNo" value="${soCpBase.idNo}" labelName="" labelValue="${soCpBase.idNo}" title="查询人员" url="${ctx}/cp/personnel/findListByIdNo"/>--%></td>

                    </tr>
                    <tr>
                        <td  colspan="2"> <label class="control-label">职务</label></td>
                        <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                        <td  colspan="2"> <label class="control-label">职称</label> </td>
                        <td><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                        </td>
                    </tr>
                    <tr>
                        <td  colspan="2"> <label class="control-label">最高学历</label></td>
                        <td> <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/> </td>
                        <td  colspan="2"> <label class="control-label">专业</label> </td>
                        <td><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                        </td>
                    </tr>
                    <tr>
                        <td  colspan="2"><label class="control-label">固定电话</label></td>
                        <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                        </td>
                        <td  colspan="2"><label class="control-label">移动电话</label></td>
                        <td colspan="1"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                        </td>
                    </tr>
                    <tr>
                        <td  colspan="2"><label class="control-label">安全生产考核合格发证单位</label></td>
                        <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                        </td>
                        <td  colspan="2"><label class="control-label">发证时间</label></td>
                        <td colspan="1">
                            <input id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" class="input-small Wdate" type="text" value="">                       </td>
                    </tr>
                    <tr>
                        <td  colspan="2"><label class="control-label">证书编号</label></td>
                        <td colspan="2"><form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                        </td>
                        <td  colspan="2"><label class="control-label">证书有效期</label></td>
                        <td colspan="1">
                            <input id="startTime" name="startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" class="input-small Wdate" type="text" value="">                    </tr>
                    <tr align="center">
                        <td colspan="7" style="text-align: center"><h4>专职安全生产管理人员</h4></td>
                    </tr>
                    <tr style="text-align: center">
                        <td rowspan="2">序 号</td><td rowspan="2">姓  名</td><td rowspan="2">专 业</td><td colspan="4">安全生产考核合格情况</td>
                    </tr>
                    <tr style="text-align: center" >
                        <td>发证单位</td> <td>发证时 间</td> <td>证书编号</td> <td>证书有效期</td>
                    </tr>
                    </tbody>
                </table>
                <table id="addResumeTable" class="table table-striped table-bordered table-condensed">
                    <tr>
                        <td colspan="5" style="text-align:right"> <a href="javascript:" onclick="addInfo();" class="btn  btn-primary">添加信息</a></td>
                    </tr>
                </table>
           </div>
        </div>

      <!-- 安全生产许可证审批情况-->
        <div class="tab-pane " id="cpAppr">
            <table id="contentApproveTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr align="center"><td colspan="8" style="text-align: center"><h4>安全生产许可证审批情况</h4></td></tr>
                </thead>
                <tr>
                    <td class="span2"><label class="control-label">盟市建设行政主管部门初审意见</label></td>
                    <td><form:textarea path="soCpApprove[0].content" maxlength="2048" class="required input-block-level" rows="4"/></td>
                </tr>
                <tr>
                    <td class="span2"><label class="control-label">自治区建设行政主管部门审批意见</label></td>
                    <td><form:textarea path="soCpApprove[0].contentLoc" class=" input-block-level" rows="4" readonly="true"/></td>
                </tr>
                </table>
            <table class="table table-striped table-bordered table-condensed">
                <thead>
                <tr align="center"><td colspan="8" style="text-align: center"><h4>安全生产许可证正本、副本载明内容</h4></td></tr>
                </thead>
                <tr>
                    <td ><label class="control-label">单位名称</label></td>
                    <td colspan="7">
                        <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                    </td>
                </tr>
                <tr>
                    <td ><label class="control-label">单位地址</label></td>
                    <td colspan="7">
                        <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                    </td>
                </tr>
                <tr>
                    <td ><label class="control-label">经济类型</label></td>
                    <td>
                        <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                    </td>

                    <td ><label class="control-label">主要负责人</label></td>
                    <td>
                        <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                    </td>
                </tr>
                <tr>
                    <td class="span2"><label class="control-label">发证日期</label></td>
                    <td>
                        <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                    </td>
                    <td class="span2"><label class="control-label">证书编号</label></td>
                    <td>
                        <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                    </td>
                </tr>

                <tr>
                    <td class="span2"><label class="control-label">证书有效期</label></td>
                    <td colspan="7">
                        <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                    </td>
                </tr>
                <tr>
                    <td class="span2"><label class="control-label">许可范围</label></td>
                    <td colspan="7">
                        <form:input id="name" path="soCpBase.name" htmlEscape="false"  class="required input-medium"/>
                    </td>
                </tr>
            </table>
        </div>

            <!-- 法人代表声明-->

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