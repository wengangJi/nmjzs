<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>申请培训</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">

        function setMinHouts(obj,fee,planId) {
            $("#minHours").val(obj);
            $("#fee").val(fee);
            $("#planId").val(planId);
        }

        function dealHours(obj,hours){
            if(obj.checked){
                $("#totalHours").val(parseInt($("#totalHours").val()) + hours);
            }else{
                $("#totalHours").val(parseInt($("#totalHours").val()) - hours);
            }
        }



    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#courseArea" data-toggle="tab">课程列表</a></li>


</ul>




 <div class="tab-content">
<%--
    <div style="float: right">最少学时：<input type="text" id="minHours" disabled value="0" style="width: 30px"/> &nbsp;已选择学时： <input id="totalHours" type="text" disabled value="0" style="width: 30px"></div>
--%>
<!-- 课程信息-->
    <div class="tab-pane active" id="courseArea">

           <table id="lessonTable" class="table table-striped table-bordered table-condensed">
            <thead><tr><th>课程名称</th><th>课程类型</th><th>讲师</th><th>学时</th><%--<th>状态</th>--%><th>操作</th></tr></thead><tbody>

            <c:forEach items="${courses}" var="course">
                <tr>
                    <td><a href="${ctx}/course/detail?courseId=${course.courseId}"<%-- target="_blank"--%>>${course.courseName}</a></td>
                   <td>${fns:getDictLabel(course.courseType, 'COURSE_TYPE', '')}</td>
                    <td>${course.teacherName}</td>
                    <td>${course.courseHours}</td>
<%--
                    <td>${fns:getDictLabel(course.sts, 'COURSE_STS', '')}</td>
--%>
                    <td> <a href="${ctx}/course/detail?courseId=${course.courseId}" <%--target="_blank"--%>>课程介绍</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>


    </div>


</div>
</body>
</html>