<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>二级建造师信息</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
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
<%--<ul class="nav nav-tabs">
    <li><a href="${ctx}/cp/personnel/soCpInfo">申报详细信息</a></li>
</ul><br/>--%>
<ul class="nav nav-tabs" id="cpSoInfoPage">
    <li class="active"><a href="#cpTitle" data-toggle="tab">基本信息</a></li>



</ul>
<form:form id="inputForm" modelAttribute="servAcInfo" action="${ctx}/ac/servAc/servAcInfo" method="post" class="form-horizontal">
<tags:message content="${message}"/>

   <h5 style="color: red;"> ${servAcInfo.rsrvStr2}</h5> </br>
<div class="tab-content">
    <div class="tab-pane active" id="cpTitle">

        <table id="contentTable" class="table table-bordered table-condensed  table-hover" >
            <thead>
            <tr align="center">
                <td colspan="7" style="text-align: center"><h3>二级建造师基本信息</h3></td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><label class="control-label">姓名</label></td>
                <td>${servAcInfo.name} </td>
                <td><label class="control-label">性别</label></td>
                <td>${fns:getDictLabel(servAcInfo.sex, 'SEX', '')}</td>
                <td><label class="control-label">出生日期</label> </td>
                <td><fmt:formatDate value="${servAcInfo.birthDate}" type="date"/> </td>
                <td rowspan="4"width="120px;"><img src="${servAcInfo.patchId}"/></td>
            </tr>

            <tr>

                <td><label class="control-label">证件类别</label></td>
                <td>${fns:getDictLabel(servAcInfo.idType, 'ID_TYPE', '')} </td>
                <td><label class="control-label">证件号</label></td>
                <td colspan="1"> ${servAcInfo.idNo}</td>
                <td><label class="control-label">联系电话</label></td>
                <td colspan="1"> ${servAcInfo.contactPhone}</td>
            </tr>


          <%--  <tr>
                <td><label class="control-label">在职状态</label></td>
                <td colspan="5"> ${fns:getDictLabel(servAcInfo.empFlag, 'EMP_FLAG', '')}
                </td>
            </tr>--%>

            <tr>
                <td ><label class="control-label">所属企业</label></td>
                <td colspan="3">${fns:getCompanyById(servAcInfo.companyId).companyName}</td>
                <td ><label class="control-label">所属地市</label></td>
                <td>${fns:getDictLabel(servAcInfo.localId, 'LOCAL_ID', '')} </td>
            </tr>

          <%--  <tr>
                <td><label class="control-label">联系人</label></td>
                <td>${servAcInfo.contactPerson}</td>
                <td><label class="control-label">联系电话</label></td>
                <td>${servAcInfo.contactPhone}</td>
                <td ><label class="control-label">电子邮箱</label></td>
                <td colspan="2">${servAcInfo.mail}</td>
            </tr>
            <tr>
                <td ><label class="control-label">联系地址</label></td>
                <td colspan="3">${servAcInfo.contactAddr}</td>
                <td><label class="control-label">邮政编码</label></td>
                <td colspan="2">${servAcInfo.postCode}</td>
            </tr>


            <tr>
                <td><label class="control-label">毕业院校</label></td>
                <td>${servAcInfo.gardSchool}</td>
                <td><label class="control-label">毕业时间</label></td>
                <td> <fmt:formatDate value="${servAcInfo.gardDate}" type="date" /> </td>
                <td><label class="control-label">所学专业</label></td>
                <td colspan="2">${fns:getDictLabel(servAcInfo.gardMajor, 'MAJOR', '')} </td>
            </tr>
            <tr>
                <td><label class="control-label">学 历</label></td>
                <td> ${fns:getDictLabel(servAcInfo.degree, 'DEGREE', '')} </td>
                <td><label class="control-label">学位</label></td>
                <td> ${fns:getDictLabel(servAcInfo.education, 'EDUCATION', '')}  </td>
                <td><label class="control-label">参加工作时间</label></td>
                <td colspan="2"><fmt:formatDate value="${servAcInfo.workingDate}" type="date" /> </td>

            </tr>
--%>

       <%--     <tr>
                <td><label class="control-label">资格证编号</label></td>
                <td colspan="3"> ${servAcInfo.certNo} </td>
                <td><label class="control-label">签发日期</label></td>
                <td colspan="2"> <fmt:formatDate value="${servAcInfo.issueDate}" type="date" />  </td>
            </tr>

            <tr>
                <td><label class="control-label">注册证书编号</label></td>
                <td colspan="3"> ${servAcInfo.regiNo} </td>
                <td><label class="control-label">签发日期</label></td>
                <td colspan="2"> <fmt:formatDate value="${servAcInfo.regiDate}" type="date" /> </td>
            </tr>

            <tr>
                <td><label class="control-label">继续教育证书编号</label></td>
                <td colspan="3"> ${servAcInfo.educNo} </td>
                <td><label class="control-label">签发日期</label></td>
                <td colspan="2"><fmt:formatDate value="${servAcInfo.educDate}" type="date" />  </td>
            </tr>--%>

            <tr>
                <td><label class="control-label">第一专业</label></td>
                <td> ${fns:getDictLabel(servAcInfo.majorFirst, 'MAJOR', '')} </td>
                <td><label class="control-label">第二专业</label></td>
                <td> ${fns:getDictLabel(servAcInfo.majorSecond, 'MAJOR', '')}  </td>
                <td><label class="control-label">第三专业</label></td>
                <td colspan="2"> ${fns:getDictLabel(servAcInfo.majorThird, 'MAJOR', '')} </td>

            </tr>

            <tr>
                <td><label class="control-label">注册编号</label></td>
                <td colspan="6">${servAcInfo.regiNo} </td>

            </tr>
            <tr>
                <td><label class="control-label">备注</label> </td>
                <td colspan="6">${servAcInfo.remarks}<br/><br/></br></br></td>
            </tr>

            </tbody>

        </table>

    </div>



<%--    <!-- 附件信息-->
    <div class="tab-pane" id="cpUpload">
        <iframe id="cpUploadFrame" name="cpUploadFrame" src="${ctx}/cp/soCp/cpUploadPage?soid=${so.soid}" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
    </div>--%>

    </form:form>
</div>


</body>
</html>