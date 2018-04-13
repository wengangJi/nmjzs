<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2014/10/14
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>学时维护</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">

        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#cpForm").submit();
            return false;
        }
        function showOrHide(trline){

            var id="#tr_"+trline;
            var ido="#"+trline+"_only";
            var idm="#"+trline+"_moremore";
            $(id).show();
            $(ido).show();
            $(idm).hide();
        }

        function HideSamll(trline){

            var id="#tr_"+trline;
            var ido="#"+trline+"_only";
            var idm="#"+trline+"_moremore";
            $(id).hide();
            $(ido).hide();
            $(idm).show();
        }

    </script>
</head>
<body>
<tags:message content="${message}"/>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">学时维护</a></li>
</ul>
<%--<form:form id="soHours" modelAttribute="soPlan" action="" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>


    <label class="control-label">申报单号 ：</label>
    <form:input path="soid" htmlEscape="false"  class="input-medium"></form:input>


    <label class="control-label" for="planId">申报项目 ：</label>
    <form:select id="planId" path="planId" class="input-medium"><form:option value="" label=""/><form:options items="${fns:getAllPlanByYear('2014')}" itemLabel="planName" itemValue="planId" htmlEscape="false"/></form:select>

    <label class="control-label">申报人 ：</label>
    <form:input path="soid" htmlEscape="false"  class="input-medium"></form:input>


    <label class="control-label" for="startTime">申报时间 ：</label>
    <form:input id="startTime" path="startTime" type="text" readonly="readonly" class="input-small Wdate"
                value="${startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>--%>

<table id="lessonTable" class="table  table-bordered table-condensed table-hover">
    <thead><tr><th>课程名称</th><th>课程类型</th><th>课程讲师</th><th>要求学时</th><%--<th>状态</th>--%><th>课程专业</th></tr></thead><tbody>

<c:forEach items="${courses}" var="course" varStatus="status">

    <tr bgcolor="#f5f5f5">
        <td><a href="${ctx}/course/detail?courseId=${course.courseId}">${course.courseName}</a></td>
        <td>${fns:getDictLabel(course.courseType, 'COURSE_TYPE', '')}</td>
        <td>${course.teacherName}</td>
        <td>${course.courseHours}</td>
        <td>${fns:getDictLabel(course.majorId, 'MAJOR', '')}
            <span>
                 <c:if test="${status.index==0}">
            <a onclick="showOrHide('${status.index}')" href="javascript:void(0)" id="${status.index}_moremore"  style="display: none">|展开</a>
            <a onclick="HideSamll('${status.index}')" href="javascript:void(0)" id="${status.index}_only">|收起</a>
    </c:if>
    <c:if test="${status.index>=1}">
            <a onclick="showOrHide('${status.index}')" href="javascript:void(0)" id="${status.index}_moremore">|展开</a>
            <a onclick="HideSamll('${status.index}')" href="javascript:void(0)" style="display: none" id="${status.index}_only">|收起</a>
    </c:if>
        </td>
        </span>
    </tr>
    <c:if test="${status.index>=1}">
        <tr style="display: none" id="tr_${status.index}">
    </c:if>
    <c:if test="${status.index==0}">
        <tr  id="tr_${status.index}">
    </c:if>
    <td colspan="5">
        <table id="lessonTable1" class="table  table-bordered table-condensed table-hover">
            <tr><td>播放课件</td><td>课件学时</td><td>已学学时</td><td>已播放时长</td><td>审核状态</td><td>操作</td></tr>
            <c:forEach items="${course.lessons}" var="lesson" varStatus="status">

                <tr>
                <td>${lesson.lessonName}</td>
                <td>${lesson.playTime} (学时)</td>
                <td><c:if test="${lesson.hours eq '' or lesson.hours eq null }">0  (学时)</c:if>
                    <c:if test="${lesson.hours ne '' and lesson.hours ne null }">${lesson.hours}  (学时)</c:if>
                </td>
                <td><c:if test="${lesson.playedTime eq '' or lesson.playedTime eq null }">0  (秒)</c:if>
                    <c:if test="${lesson.playedTime ne '' and lesson.playedTime ne null }">${lesson.playedTime}  (秒)</c:if>
                </td>
                <td><c:if test="${lesson.auditTag eq '' or lesson.auditTag eq null }">未学</c:if>
                    <c:if test="${lesson.auditTag ne '' and lesson.auditTag ne null }"> ${fns:getDictLabel(lesson.auditTag, 'AUDIT_TAG', '')}</c:if>
                </td>
                <td> <a href="${ctx}/oper/operAttachment?soid=${course.tmpSoid}&appId=${lesson.courseId}&soType=${lesson.lessonId}&duration=${lesson.watchTimes}">上传</a>
                    <a href="${ctx}/oper/operVideoSvc?soid=${course.tmpSoid}&courseId=${lesson.courseId}&lessonId=${lesson.lessonId}&duration=${lesson.watchTimes}" onclick="return confirmx('生成学时前请确认图片已经全部上传？', this.href)">生成学时</a>
                </td>
                <c:if test="${status.index>=1}">
                    </tr>
                </c:if>
            </c:forEach>

        </table>
    </td>
    </tr>

</c:forEach>
</tbody>
</table>

<%--
111111
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr>
        <th>课程</th>
        <th>课程名</th>
        <th>学时</th>
    </tr></thead>
    <tbody>
    <c:forEach items="${page.list}" var="element" varStatus="staus">
        <tr>
            <td>1</td><td>1</td><td>1</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
        </tr>
        <c:if test="${status.index==0}">
        <div id="more">
        ----------------------------------------------------------------------->><a onclick="showOrHide()" href="javascript:void(0)">more</a>
        </div>
        </c:if>
        <c:if test="${status.index==1}">
        <div id="moreInfo">
        </c:if>
        <tr>
            <td>1</td><td>1</td><td>1</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
            <td>课件1</td><td colspan="2">课件基本信息</td>
        </tr>
            <c:if test="${status.index==1}">
                </div>
                </c:if>

    </c:forEach>
    <div id="only" style="display: none">
        ----------------------------------------------------------------------->><a onclick="HideSamll()" href="javascript:void(0)">small</a>
    </div>
    </tbody>
</table>
<div class="pagination">${page}</div>--%>

<div style="text-align: center;">
    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>
</body>
</html>

