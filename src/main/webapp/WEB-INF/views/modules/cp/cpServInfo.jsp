<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员申报详细信息</title>
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
</head>
<body>
<ul class="nav nav-tabs" id="cpSoInfoPage">
    <li class="active"><a href="#cpTitle" data-toggle="tab">首页申请信息</a></li>
    <li><a href="#cpBase" data-toggle="tab">基本信息</a></li>
    <li><a href="#cpResume" data-toggle="tab">简历信息</a></li>
    <li><a href="#cpUpload" data-toggle="tab">附件信息</a></li>


</ul>
<form:form id="inputForm" modelAttribute="servCpEntity" action="${ctx}/cp/soCp/saveExtend" method="post" class="form-horizontal">

<tags:message content="${message}"/>
<div class="tab-content">
<div class="tab-pane active" id="cpTitle">
    <div class="span10">
        <p style="text-align: center;margin-bottom: 20px; font-size: 18px;">
            内蒙古自治区建筑施工企业<br>
            主要负责人、项目负责人和专职安全<br>
            生产管理人员考核申请表
        </p>
    </div>
    <div class="offset2 span10">
        <div class="control-group">
            <label class="control-label">企业名称:</label>

            <div class="controls">
                           ${servCpEntity.serv.company.companyName}
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">申请人姓名:</label>

            <div class="controls">
                    ${servCpEntity.personnel.name}
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">身份证件号:</label>

            <div class="controls">
                    ${servCpEntity.personnel.idNo}
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">申请时间:</label>

            &nbsp;&nbsp;&nbsp;<fmt:formatDate value="${servCpEntity.serv.applDate}" type="date" />

        </div>
        <div class="control-group">
            <label class="control-label">申报批次:</label>

            <div class="controls">
                    ${fns:getBatchInfoByBatchId(servCpEntity.serv.batchId).batchName}
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">申报类别:</label>
             <div class="controls">
                     ${fns:getDictLabel(Constants.GLOBAL_SO_TYPE_SO, 'SO_TYPE', '')}
             </div>
        </div>
    </div>
    <div class="span10">
        <p style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
            内蒙古自治区建设厅编制
        </p>
        <div style="text-align: center;">
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
    </div>
 </div>

    <!-- 基本信息-->
    <div class="tab-pane" id="cpBase">
        <table id="contentTable" class="table table-bordered table-condensed table-striped table-hover" >
            <thead>
            <tr align="center">
                <td colspan="6" style="text-align: center"><h3>基 本 情 况</h3></td>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><label class="control-label">姓名</label></td>
                <td>${servCpEntity.personnel.name} </td>
                <td><label class="control-label">性别</label></td>
                <td>${fns:getDictLabel(servCpEntity.personnel.sex, 'SEX', '')}</td>
                <td><label class="control-label">出生日期</label> </td>
                <td><fmt:formatDate value="${servCpEntity.personnel.birthDate}" type="date"/> </td>
                <td rowspan="3"width="60px;">照片</td>
            </tr>

            <tr>
                <td><label class="control-label">证件号</label></td>
                <td colspan="3"> ${servCpEntity.personnel.idNo}
                <td><label class="control-label">证件类别</label></td>
                <td>${fns:getDictLabel(servCpEntity.personnel.idType, 'ID_TYPE', '')} </td>
            </tr>
            <tr>
                <td><label class="control-label">人员类别</label></td>
                <td colspan="5"> ${fns:getDictLabel(servCpEntity.personnel.personType, 'PERSON_TYPE', '')} </td>
            </tr>

            <tr>
                <td><label class="control-label">参加考试时间</label></td>
                <td colspan="2"><fmt:formatDate value="${servCpEntity.personnel.examDate}" type="date"/> </td>
                <td><label class="control-label">考试成绩</label></td>
                <td colspan="3">${servCpEntity.personnel.examScore}</td>
            </tr>

            <tr>
                <td ><label class="control-label">所在企业名称</label></td>
                <td colspan="6">${servCpEntity.serv.company.companyName}</td>
            </tr>

            <tr>
                <td><label class="control-label">企业联系电话</label></td>
                <td colspan="2">${servCpEntity.personnel.telephone}</td>
                <td><label class="control-label">资质等级</label></td>
                <td colspan="3">${servCpEntity.serv.company.qualLevel}</td>
            </tr>

            <tr>
                <td><label class="control-label">通讯地址</label></td>
                <td colspan="2">${servCpEntity.personnel.address}</td>
                <td><label class="control-label">邮政编码</label></td>
                <td colspan="3">${servCpEntity.personnel.postCode}</td>
            </tr>

            <tr> <td ><label class="control-label">电子邮箱</label></td>
                 <td colspan="6">${servCpEntity.personnel.mail}</td>
            </tr>

            <tr>
                <td><label class="control-label">毕业院校</label></td>
                <td colspan="6">${servCpEntity.personnel.gardSchool}</td>
            </tr>

            <tr>
                <td><label class="control-label">毕业时间</label></td>
                <td>  <fmt:formatDate value="${servCpEntity.personnel.gardDate}" type="date" /></td>
                <td><label class="control-label">专业</label></td>
                <td> ${fns:getDictLabel(servCpEntity.personnel.major, 'MAJOR', '')} </td>
                <td><label class="control-label">职称</label></td>
                <td colspan="2">  ${fns:getDictLabel(servCpEntity.personnel.titleLevel, 'TITLE_LEVEL', '')} </td>
            </tr>

            <tr>
                <td><label class="control-label">学 历</label></td>
                <td> ${fns:getDictLabel(servCpEntity.personnel.degree, 'DEGREE', '')} </td>
                <td><label class="control-label">学位</label></td>
                <td> ${fns:getDictLabel(servCpEntity.personnel.education, 'EDUCATION', '')} </td>
                <td><label class="control-label">执业资格</label></td>
                <td colspan="2">${servCpEntity.personnel.titleType}</td>
            </tr>

            <tr>
                <td><label class="control-label">参加工作时间</label></td>
                <td colspan="2">   <fmt:formatDate value="${servCpEntity.personnel.workingDate}" type="date" /> </td>
                <td><label class="control-label">累计安全生产管理工作年限</label></td>
                <td colspan="3">${servCpEntity.personnel.workExpe}</td>
            </tr>
            <tr>
                <td><label class="control-label">接受安全教育、培训及考核情况</label></td>
                <td colspan="6">${servCpEntity.personnel.learnExpe}<br/><br/></br></br></td>
            </tr>
            <tr>
                <td><label class="control-label">证书使用情况</label> </td>
                <td colspan="6">${servCpEntity.personnel.certExpe}<br/><br/></br></br></td>
            </tr>

            </tbody>

        </table>
    </div>

    <!-- 简历信息-->
    <div class="tab-pane" id="cpResume">
            <table id="contentTable21" class="table table-bordered table-condensed table-hover">
                <thead>
                <tr align="center"><td colspan="8" style="text-align: center"><h3>工 作 简 历</h3></td></tr>
                </thead>
                <tr style="text-align: center">
                    <td>序 号</td><td>聘用开始时间</td><td>聘用结束时间</td><td>工作单位</td><td>职务</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${servCpEntity.servCpResumes}" var="servCpResume">
                <tr>
                    <td>${servCpResume.seq}</td>
                    <td><fmt:formatDate value="${servCpResume.effDate}" pattern="yyyy-MM-dd"/> </td>
                    <td> <fmt:formatDate value="${servCpResume.expDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${servCpResume.company}</td>
                    <td>${servCpResume.position}</td>
                </tr>
                </c:forEach>
                <tr> <td colspan="5" style="text-align: center"><h3>安 全 生 产 业 绩</h3></td></tr>
                <tr> <td><label class="control-label">受表彰情况</label></td> <td colspan="4">${servCpEntity.servCpPerformance.honorCase} <br/><br/></br></br> <br/><br/></br></br> </td></tr>
                <tr> <td><label class="control-label">受处罚情况</label></td> <td colspan="4">${servCpEntity.servCpPerformance.penaltyCase} <br/><br/></br></br><br/><br/></br></br> </td> </tr>
            </table>
    </div>

    <!-- 附件信息-->
    <div class="tab-pane" id="cpUpload">
      <div>
        <iframe id="cpUploadFrame" name="cpUploadFrame" src="${ctx}/cp/personnel/findCpServAttachmentList?servid=${servCpEntity.servid}" style="overflow:visible;"
                scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
            </div>
        <div>
    </div>


</div>
</form:form>
</body>
</html>