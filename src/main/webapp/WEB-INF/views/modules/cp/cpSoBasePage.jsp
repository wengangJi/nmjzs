<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>企业资质</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#eqForm").submit();
            return false;
        }
    </script>

    <link href="${ctxStatic}/print/print.css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jqprint/jquery.jqprint-0.3.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            $("input#biuuu_button").click(function(){

                //$("div#myPrintArea").printArea();
                //$("div#myPrintArea").printPage();
                $("div#myPrintArea").jqprint();

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
<tags:message content="${message}"/>
   <%-- <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>--%>
<form:form id="inputForm" modelAttribute="soCpBase" action="${ctx}/cp/soCp/cacheBase" method="post" class="form-horizontal">

<div id="myPrintArea"  style="display:block width: 968px;">
    <table id="contentTable" class="table table-bordered table-condensed table-striped table-hover" >
        <thead>
        <tr align="center">
            <td colspan="6" style="text-align: center"><h3>基 本 情 况</h3></td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><label class="control-label">姓名</label></td>
            <td> <%--<form:input path="name" htmlEscape="false"  class="required input-medium" disabled="true"/>--%>${soCpBase.name} </td>
            <td><label class="control-label">性别</label></td>
            <td><%--<form:radiobuttons path="sex" items="${fns:getDictList('SEX')}" itemLabel="label"
                                   itemValue="value" htmlEscape="false" class="required" disabled="true"></form:radiobuttons>--%>${fns:getDictLabel(soCpBase.sex, 'SEX', '')}</td>
            <td><label class="control-label">出生日期</label> </td>
              <td>
                  <%--<input id="birthDate" name="birthDate" type="text" readonly="readonly"   disabled="true"
                         maxlength="50" class="input-medium Wdate"
                         value="<fmt:formatDate value="${soCpBase.birthDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>--%>
            <fmt:formatDate value="${soCpBase.birthDate}" type="date"/>

            </td>

           <%-- <td> <fmt:formatDate value="${soCpBase.birthDate}" type="date"  /> </td>--%>

            <td rowspan="3"width="60px;">照片</td>
        </tr>

        <tr>
            <td><label class="control-label">证件号</label></td>
            <td colspan="3"><%--<tags:commonselect id="idNo" name="idNo" value="${idNo}" labelName="idNo" labelValue="" title="查询人员" url="${ctx}/comp/company/findByName"/>--%>
               <%-- <form:input path="idNo"  class="required input-medium" disabled="true"/></td>--%>   ${soCpBase.idNo}
            <td><label class="control-label">证件类别</label></td>
            <td><%--<form:radiobuttons path="idType" items="${fns:getDictList('ID_TYPE')}" itemLabel="label"
                                   itemValue="value" htmlEscape="false" class="required" disabled="true"></form:radiobuttons>--%>
                    ${fns:getDictLabel(soCpBase.idType, 'ID_TYPE', '')}
            </td>
        </tr>
        <tr>
            <td><label class="control-label">人员类别</label></td>
            <td colspan="5">
                <%--<form:radiobuttons path="personType" items="${fns:getDictList('PERSON_TYPE')}" itemLabel="label"
                                   itemValue="value" htmlEscape="false" class="required" disabled="true"></form:radiobuttons>--%>
                        ${fns:getDictLabel(soCpBase.personType, 'PERSON_TYPE', '')}
            </td>
        </tr>

        <tr>
            <td><label class="control-label">参加考试时间</label></td>
            <td colspan="2"><%--<input id="examDate" name="examDate" type="text" readonly="readonly"   disabled="true"
                                           maxlength="50" class="input-medium Wdate"
                                           value="<fmt:formatDate value="${soCpBase.examDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>--%>
                <fmt:formatDate value="${soCpBase.examDate}" type="date"/>

            </td>
            <td><label class="control-label">考试成绩</label></td>
            <td colspan="3"><%--<form:input path="examScore"  class="input-medium" disabled="true"/>--%>${soCpBase.examScore}</td>
        </tr>

        <tr>
            <td ><label class="control-label">所在企业名称</label></td>
            <td colspan="6">${fns:getCompanyById(soCpBase.companyId).companyName}<%--<form:input path="companyId"  class="input-medium" disabled="true"/>--%></td>
        </tr>

        <tr>
            <td><label class="control-label">企业联系电话</label></td>
            <td colspan="2"><%--<form:input path="telephone"  class="input-medium" disabled="true"/>--%>${soCpBase.telephone}</td>
            <td><label class="control-label">资质等级</label></td>
            <td colspan="3"><%--<form:input path="qualLevel"   class="input-medium" disabled="true"/>--%>${soCpBase.qualLevel}</td>
        </tr>

        <tr>
            <td><label class="control-label">通讯地址</label></td>
            <td colspan="2"><%--<form:input path="address" class="input-medium" disabled="true"/>--%>${soCpBase.address}</td>
            <td><label class="control-label">邮政编码</label></td>
            <td colspan="3"><%--<form:input path="postCode"  class="input-medium" disabled="true"/>--%>${soCpBase.postCode}</td>
        </tr>

        <tr> <td ><label class="control-label">电子邮箱</label></td>
            <td colspan="6"><%--<form:input path="mail"  class="input-medium" disabled="true"/>--%>${soCpBase.mail}</td>
        </tr>

        <tr>
            <td><label class="control-label">毕业院校</label></td>
            <td colspan="6"><%--<form:input path="gardSchool"   class="input-medium" disabled="true"/>--%>${soCpBase.gardSchool}</td>
        </tr>

        <tr>
            <td><label class="control-label">毕业时间</label></td>
            <td>
               <%-- <input id="gardDate" name="gardDate" type="text" readonly="readonly" maxlength="50"     disabled="true"
                        class="input-medium Wdate"
                        value="<fmt:formatDate value="${soCpBase.gardDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>--%>
               <fmt:formatDate value="${soCpBase.gardDate}" type="date" />
            </td>
            <td><label class="control-label">专业</label></td>
            <td>
                <%--<form:select path="major" class="input-medium">
                    <form:options items="${fns:getDictList('MAJOR')}" itemLabel="label" itemValue="value" htmlEscape="false" disabled="true"/>
                </form:select>--%>
                        ${fns:getDictLabel(soCpBase.major, 'MAJOR', '')}

            </td>
            <td><label class="control-label">职称</label></td>
            <td colspan="2">
                <%--<form:select path="titleLevel" class="input-medium">
                    <form:options items="${fns:getDictList('TITLE_LEVEL')}" itemLabel="label" itemValue="value" htmlEscape="false" disabled="true"/>
                </form:select>--%>
                        ${fns:getDictLabel(soCpBase.titleLevel, 'TITLE_LEVEL', '')}
            </td>
        </tr>

        <tr>
            <td><label class="control-label">学 历</label></td>
            <td>
                <%--<form:select path="degree" class="input-medium">
                    <form:options items="${fns:getDictList('DEGREE')}" itemLabel="label" itemValue="value" htmlEscape="false" disabled="true"/>
                </form:select>--%>
                        ${fns:getDictLabel(soCpBase.degree, 'DEGREE', '')}
            </td>
            <td><label class="control-label">学位</label></td>
            <td><%--<form:select path="education" class="input-medium">
                <form:options items="${fns:getDictList('EDUCATION')}" itemLabel="label" itemValue="value" htmlEscape="false" disabled="true"/>
            </form:select>--%>
                    ${fns:getDictLabel(soCpBase.education, 'EDUCATION', '')}
            </td>
            <td><label class="control-label">执业资格</label></td>
            <td colspan="2"><%--<form:input path="titleType"  class="input-medium" disabled="true"/>--%>${soCpBase.titleType}</td>
        </tr>

        <tr>
            <td><label class="control-label">参加工作时间</label></td>
            <td colspan="2">
                <%-- <input id="workingDate" name="workingDate" type="text" readonly="readonly"   disabled="true"
                        maxlength="50" class="input-medium Wdate"
                        value="<fmt:formatDate value="${soCpBase.workingDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>--%>
                <fmt:formatDate value="${soCpBase.workingDate}" type="date" />


            </td>
            <td><label class="control-label">累计安全生产管理工作年限</label></td>
            <td colspan="3"><%--<form:input path="workExpe"  class="input-medium" disabled="true"/>--%>${soCpBase.workExpe}</td>
        </tr>
        <tr>
            <td><label class="control-label">接受安全教育、培训及考核情况</label></td>
            <td colspan="6"><%--<form:textarea path="learnExpe" class="input-block-level" rows="4" disabled="true"/>--%>${soCpBase.learnExpe}<br/><br/></br></br></td>
        </tr>
        <tr>
            <td><label class="control-label">证书使用情况</label> </td>
            <td colspan="6"><%--<form:textarea path="certExpe" class="input-block-level" rows="4" disabled="true"/>--%>${soCpBase.certExpe}<br/><br/></br></br></td>
        </tr>

        </tbody>

    </table>
   </div>
   </form:form>
    <div style="text-align: center;">
        <input id="biuuu_button" type="button" value="打 印" class="btn"/>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</body>
</html>
