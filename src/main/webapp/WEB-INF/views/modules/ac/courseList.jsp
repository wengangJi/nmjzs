<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>课程列表</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/course/list/">课程列表</a></li>
    <shiro:hasPermission name="course:edit">
        <li><a href="${ctx}/course/courseForm?courseId=${course.courseId}">课程${not empty course.courseId?'修改':'添加'}</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="courseCenter" action="${ctx}/course/list/" method="post" >
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
    <form:input id="courseType" path="courseType" type="hidden"/>
    <form:input id="majorId" path="majorId" type="hidden"/>
  <%--  <div>
        <label>年份：</label>
        <form:select path="plan.year" id="yearSel" cssClass="required input-small">
            <form:options items="${fns:getDictList('YEAR')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
        </form:select>&nbsp;
        <label>计划：</label><form:select path="planId" id="planId" cssClass="required"><form:options items="${planList}" itemLabel="planName" itemValue="planId" htmlEscape="false"/></form:select>&nbsp;
        <label>课程名称：</label><form:input path="courseName" htmlEscape="false" maxlength="50" class="input-small"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
    </div>--%>
</form:form>
<tags:message content="${message}"/>
<div id="courses-total-info">
    <div class="row">

        <div class="span1" style="padding-top:8px;padding-bottom: 8px;">课程类型:</div>
        <div class="span11">
            <ul class="nav nav-pills">
                <li id="allCourseType"><a href="#"  onclick="findByCourseType()">全部</a></li>
                <c:forEach items="${fns:getDictList('COURSE_TYPE')}" var="courseType" varStatus="status">
                    <li id="courseType${courseType.value}"><a href="#"  onclick="findByCourseType(${courseType.value})">${courseType.label}</a><%--<c:if test="${not status.last}">|</c:if>--%></li>
                </c:forEach>
            </ul>
        </div>

    </div>
    <div class="row">

        <div class="span1" style="padding-top:8px;padding-bottom: 8px;">所属专业:</div>
        <div class="span11">
            <ul class="nav nav-pills">
                <li id="allMajorType"><a href="#"  onclick="findByMajorType()">全部</a></li>
                <c:forEach items="${fns:getDictList('MAJOR')}" var="node" varStatus="status">
                    <c:if test="${node.value ne '0'}">
                         <li id="majorType${node.value}"><a href="#"  onclick="findByMajorType(${node.value})">${node.label}</a><%--<c:if test="${not status.last}">|</c:if>--%></li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>

    </div>

    <hr class="featurette-divider" style="margin-bottom:0px;margin-top:0px;"/>
</div>
<!-- // end   courses-total-info-->

<!-- // courses-list-->
<div id="courses-list" class="row">

    <c:forEach items="${page.list}" var="node">
        <div class="span4">
            <div class="thumbnail thumbnaiBox">
                <a href="${ctx}/course/detail?courseId=${node.courseId}">
                    <c:choose>
                        <c:when test="${node.imagePath == null}">
                            <img style="width:100%" src="${ctxStatic}/imgages/nopic_course.jpg"/>
                        </c:when>
                        <c:otherwise>
                            <img style="width:100%;height:200px;" src="${node.imagePath}">
                        </c:otherwise>
                    </c:choose>
                </a>

                <div class="caption">
                    <h4><a href="${ctx}/course/detail?courseId=${node.courseId}">${node.courseName}</a></h4>
                    <p>
                        <c:choose>
                            <c:when test="${fn:length(node.rsrvStr1) > 40}">
                                <c:out value="${fn:substring(node.rsrvStr1, 0, 40)}......"/>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${node.rsrvStr1}"/>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p>
                        主讲老师：${node .teacherName} &nbsp;&nbsp;
                        课时情况：${node.courseHours}
                    </p>
                    <p>
                        课程专业：${fns:getDictLabel(node.majorId, 'MAJOR', '')}
                        <span style="float: right;">
                            <shiro:hasPermission name="course:edit">
                                <a href="${ctx}/course/courseForm?courseId=${node.courseId}" class="btn btn-primary">修改</a>
                                <a href="${ctx}/course/delete?courseId=${node.courseId}" class="btn btn-primary" onclick="return confirmx('确认要删除该课程吗？', this.href)">删除</a>
                            </shiro:hasPermission>
                        </span>
                    </p>
                </div>
            </div>
            </br>
        </div>
    </c:forEach>


</div>
<!-- // end  courses-list-->
    <!-- // page-list-->
    <div class="pagination">${page}</div>
    <!-- // end   page-list-->

<script type="text/javascript">

    //页面加载完成干的事
    $(document).ready(function () {

        if($("#courseType") && $("#courseType").val() != ""){
            var cType = "#courseType" + $("#courseType").val();
            $(cType).addClass("active");
        }
        if($("#courseType").val() == ""){
            $("#allCourseType").addClass("active");
        }

        if($("#majorId") && $("#majorId").val() != ""){
            var cType = "#majorType" + $("#majorId").val();
            $(cType).addClass("active");
        }
        if($("#majorId").val() == ""){
            $("#allMajorType").addClass("active");
        }

        $("#yearSel").change(function () {
            var year = $("#yearSel").val();
            $.ajax({
                type: "POST",//提交方式
                url: "${ctx}/plan/getPlanByYear",//获取数据的函数
                data: "year=" + year,//查询条件
                error: function () { alert("服务器异常") },//查询失败
                success: function (data) {//查询成功,data为返回的数据
                    $("#planId option").remove();//先清除数据
                    $("#planId").select2().select2("val", null);
                    data = eval('(' + data + ')');
                    for (i=0; i< data.length; i++) {
                        $("#planId").append("<option value=" + data[i].planId + ">" + data[i].planName + "</option>");//赋值
                    }
                }
            });
        });

    }); // end ---$(document)
    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").attr("action","${ctx}/course/list/");
        $("#searchForm").submit();
        return false;
    }
    function findByCourseType(obj){
        $("#courseType").val(obj);
        $("#searchForm").submit();

    }
    function findByMajorType(obj){
        $("#majorId").val(obj);
        $("#searchForm").submit();

    }

</script>



</body>
</html>
