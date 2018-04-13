<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>二级建造师信息录入</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script src="${ctxStatic}/jquery-cookie/jquery.cookie.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#inputForm").validate({

                submitHandler: function(form){
                    if ($("#headImg").attr("src") == "") {
                        $.jBox.error("请上传照片！");
                        return false;
                    }
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
        });
    </script>
    <style type="text/css">
        #contentTable .control-label {width: 90px;}
    </style>
    <link href="${ctxStatic}/print/print.css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jqprint/jquery.jqprint-0.3.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            $("input#biuuu_button").click(function(){

                //$("div#myPrintArea").printArea();
                //$("div#myPrintArea").printPage();
                $("div#cpTitle").jqprint();

            });
        });

    </script>
    <style type="text/css">
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
<ul class="nav nav-tabs" id="cpSoInfoPage">
    <li class="active"><a href="#cpTitle" data-toggle="tab">基本信息</a></li>
</ul>
<tags:message content="${message}"/>
<form:form id="inputForm" modelAttribute="servAcInfo" action="${ctx}/ac/servAc/saveAcForm" method="post" class="form-horizontal">

<div class="tab-content">
    <div class="tab-pane active" id="cpTitle">
        <table id="contentTable" class="table table-bordered table-condensed  table-hover" >
            <thead>
            <tr align="center">
                <td colspan="7" style="text-align: center"><h3>二级建造师信息录入</h3></td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><label class="control-label">姓名</label></td>
                <td> <form:input id="name" path="name" htmlEscape="false"   class="required input-medium"/></td>
                <td><label class="control-label">性别</label></td>
                <td><form:radiobuttons id="sex" path="sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" class="required"></form:radiobuttons></td>
                <td><label class="control-label">出生日期</label> </td>
                <td> <input id="birthDate" name="birthDate" type="text" readonly="readonly" maxlength="50"
                            class="input-medium Wdate"
                             onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                </td>
                <td rowspan="3" style="text-align: center;width: 120px">
                    <img alt="" src="" id="headImg"/>
                    <tags:headPhoto id="patchId" name="patchId" value="${servAcInfo.patchId}"  width="150" height="200" ></tags:headPhoto>
                </td>
            </tr>

            <tr>
                <td><label class="control-label">证件类别</label></td>
                <td><form:radiobuttons id="idType" path="idType" items="${fns:getDictList('ID_TYPE')}" itemLabel="label"
                                       itemValue="value" htmlEscape="false" class="required"></form:radiobuttons> </td>
                <td><label class="control-label">证件号</label></td>
                <td colspan="1"> <form:input path="idNo"  class="required input-medium"/></td>
                <td><label class="control-label">联系电话</label></td>
                <td colspan="1"> <form:input path="contactPhone" placeholder="请填写正确的手机号" class="required input-medium"/></td>

            </tr>
          <%--  <tr>
                <td><label class="control-label">在职状态</label></td>
                <td colspan="5">  <form:radiobuttons path="empFlag" items="${fns:getDictList('EMP_FLAG')}" itemLabel="label"
                                                     itemValue="value" htmlEscape="false" class="required"></form:radiobuttons>
                </td>
            </tr>--%>

            <tr>
                <td ><label class="control-label">所属企业</label></td>
                <td colspan="3">

                   <tags:commonselect  id="companyId" name="companyId"  value="" labelName="companyName"  labelValue="" title="企业" url="${ctx}/comp/company/findByName" />

                </td>
                <td ><label class="control-label">所属地市</label></td>
                <td><form:select id="localId" path="localId" class="required input-medium"><form:option value="" label=""/><form:options items="${fns:getDictList('LOCAL_ID')}" itemLabel="label" itemValue="value" htmlEscape="false"/></form:select>
                </td>
            </tr>
<%--
            <tr>
                <td><label class="control-label">联系人</label></td>
                <td><form:input path="contactPerson"   class="required input-medium"/></td>
                <td><label class="control-label">联系电话</label></td>
                <td><form:input path="contactPhone"   class="required input-medium"/></td>
                <td ><label class="control-label">电子邮箱</label></td>
                <td colspan="2"><form:input path="mail"   class="input-medium"/></td>
            </tr>
            <tr>
                <td ><label class="control-label">联系地址</label></td>
                <td colspan="3"><form:input path="contactAddr"   class="required input-medium"/></td>
                <td><label class="control-label">邮政编码</label></td>
                <td colspan="2"><form:input path="postCode"   class="required input-medium"/></td>
            </tr>


            <tr>
                <td><label class="control-label">毕业院校</label></td>
                <td><form:input path="gardSchool"  class="required input-medium"/></td>
                <td><label class="control-label">毕业时间</label></td>
                <td><input id="gardDate" name="gardDate" type="text"  maxlength="50"
                           class="required input-medium Wdate"
                            onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> </td>
                <td><label class="control-label">所学专业</label></td>
                <td colspan="2"> <form:select path="gardMajor" class="required input-medium"> <form:option value="" label=""/>
                    <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select></td>
            </tr>
            <tr>
                <td><label class="control-label">学 历</label></td>
                <td>  <form:select path="degree" class="required input-medium">
                    <form:options items="${fns:getDictList('DEGREE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select></td>
                <td><label class="control-label">学位</label></td>
                <td> <form:select path="education" class="required input-medium">
                    <form:options items="${fns:getDictList('EDUCATION')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>  </td>
                <td><label class="control-label">参加工作时间</label></td>
                <td colspan="2">  <input id="workingDate" name="workingDate" type="text"
                                         maxlength="50" class="input-medium Wdate"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>  </td>

            </tr>--%>
         <%--   <tr>
                <td><label class="control-label">资格证编号</label></td>
                <td colspan="3"> <form:input path="certNo"   class=" input-medium"/> </td>
                <td><label class="control-label">签发日期</label></td>
                <td colspan="2"> <input id="issueDate" name="issueDate" type="text" readonly="readonly"
                                        maxlength="50" class=" input-medium Wdate"
                                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>  </td>
            </tr>

            <tr>
                <td><label class="control-label">注册证书编号</label></td>
                <td colspan="3"><form:input path="regiNo"   class=" input-medium"/>  </td>
                <td><label class="control-label">签发日期</label></td>
                <td colspan="2"><input id="regiDate" name="regiDate" type="text"
                                       maxlength="50" class=" input-medium Wdate"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></td>
            </tr>

            <tr>
                <td><label class="control-label">继续教育证书编号</label></td>
                <td colspan="3"><form:input path="educNo"   class=" input-medium"/> </td>
                <td><label class="control-label">签发日期</label></td>
                <td colspan="2"><input id="educDate" name="educDate" type="text" readonly="readonly"
                                       maxlength="50" class=" input-medium Wdate"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>  </td>
            </tr>--%>

            <tr>
                <td><label class="control-label">第一专业</label></td>
                <td> <form:select path="majorFirst" class="required input-medium">
                    <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select> </td>
                <td><label class="control-label">第二专业</label></td>
                <td> <form:select path="majorSecond" class="input-medium">  <form:option value="" label=""/>
                    <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>  </td>
                <td><label class="control-label">第三专业</label></td>
                <td colspan="2"><form:select path="majorThird" class="input-medium"><form:option value="" label=""/>
                    <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>  </td>

            </tr>
            <tr>
                <td><label class="control-label">注册编号</label> </td>
                <td colspan="6"> <form:input id="name" path="regiNo" htmlEscape="false"   class="required input-medium"/> <span style="color: red">注：注册编号格式如“蒙21506101XXXX”，请正确填写您的注册编号。</span></td>
            </tr>
            <tr>
                <td><label class="control-label">备注</label> </td>
                <td colspan="6"><form:textarea path="remarks" class="input-block-level" rows="4"/></td>
            </tr>
            </tbody>

            <tfoot>
            <tr>
                <td colspan="7" style="text-align: center">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" name="submit">
                    <input id="btnCancel" class="btn btn-primary" type="reset" value="重置">
                </td>
            </tr>
            </tfoot>
        </table>

    </div>



  <%--  <!-- 附件信息-->
    <div class="tab-pane" id="cpUpload">
        <iframe id="cpUploadFrame" name="cpUploadFrame" src="${ctx}/cp/soCp/cpUploadPage?soid=${so.soid}" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
    </div>--%>

    </form:form>
</div>


</body>
</html>