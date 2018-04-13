<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>${course.courseName}</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>

</head>

<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">课程详细</a></li>
</ul>

<div class="jumbotron" id="intro">

    <!-- Main component for a primary marketing message or call to action -->
    <div class="">
        <div class="row" style="margin-bottom:20px">
            <tags:message content="${message}"/>

            <div class="span5">
                <img src="${course.imagePath}" alt=""
                     style="float:right;width:400px;height:300px"/>
                <span class="playbt"></span>
            </div>
            <div class="span7">
                <p>
                <h3><strong>${course.courseName}</strong></h3></p>
                <%--				 <p>学习金币：0 </p>
                                 <p>
                                   <a href="${ctx}/course/playCourse/${course.id}.do" class="btn btn-success">
                                     <span class="glyphicon glyphicon-film">&nbsp;立刻观看</span></a>
                                  </p>--%>
                <hr class="featurette-divider"/>
                <p>主讲老师：${course.teacherName}</p>

                <p>课程类别：${fns:getDictLabel(course.majorId, 'MAJOR', '')}</p>

                <p>课时情况：${course.courseHours}</p>
                <%--                 <p>课程价格：${course.teacherName}</p>--%>

                <!-- Baidu Button BEGIN -->
                <%--                    <div id="bdshare" class="bdshare_b" style="line-height: 12px;">
                                        <img src="http://bdimg.share.baidu.com/static/images/type-button-1.jpg?cdnversion=20120831"/>
                                        <a class="shareCount"></a>
                                    </div>
                                    <script type="text/javascript" id="bdshare_js" data="type=button&amp;uid=0"></script>
                                    <script type="text/javascript" id="bdshell_js"></script>
                                    <script type="text/javascript">
                                        document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date() / 3600000);
                                    </script>--%>
                <!-- Baidu Button END -->
            </div>
        </div>
    </div>
</div>


<div class="row">
    <div class="span12">
        <ul class="nav nav-tabs" id="myTab">
            <li class="active"><a href="#course_lesson" data-toggle="tab">课程目录</a></li>
            <li><a href="#course_introduction" data-toggle="tab">课程介绍</a></li>
            <li><a href="#course_teacher" data-toggle="tab">讲师介绍</a></li>
        </ul>

        <div class="tab-content" style="min-height: 300px;padding-top:20px">
            <div class="tab-pane active" id="course_lesson">
            <shiro:hasPermission name="lesson:edit">
                <a href="${ctx}/lesson/lessonForm?courseId=${course.courseId}" class="btn btn-primary">添加课件</a>
                </br>
                </br>
            </shiro:hasPermission>
            <table class="table table-striped" >
                <tbody>
                <c:forEach items="${course.lessons}" var="item" varStatus="status">
                    <tr>
                        <td width="30%" style="color: darkred">${item.lessonName}</td>
                        <td width="30%">${item.lessonInfo}</td>
                        <td>学时：${item.playTime}学时</td>
                        <shiro:hasPermission name="lesson:edit">
                            <td>
                                <a href="${ctx}/video/initAdmin?lessonId=${item.lessonId}&soid=47AC0000000000000000001&courseId=${item.courseId}&lessonName=${item.lessonName}&lessonInfo=${item.lessonInfo}" class="btn btn-success  btn-xs">
                                    <i class="icon-white icon-play-circle"></i>播放
                                </a>
                            </td>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="lesson:edit">
                            <td>
                                <a href="${ctx}/lesson/lessonModifyForm?lessonId=${item.lessonId}" class="btn btn-success  btn-xs">修改</a>
                            </td>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="lesson:edit">
                            <td>
                                <a href="${ctx}/lesson/deleteByLessonId?lessonId=${item.lessonId}" class="btn btn-success  btn-xs" onclick="return confirmx('确认要删除该课件吗？', this.href)">删除</a>
                            </td>
                        </shiro:hasPermission>
                    </tr>


                </c:forEach>
                </tbody>
            </table>

        </div>
        <div class="tab-pane" id="course_introduction">
            <p>${course.courseInfo}</p>
        </div>
        <div class="tab-pane" id="course_teacher">
            <p>${course.teacherInfo}</p>
        </div>
    </div>

    <hr class="featurette-divider"/>

</div>


</div>
<div style="margin-left: 450px;">
    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>

<script type="text/javascript">
    //页面加载完成干的事
    $(document).ready(function () {
    });
</script>
</body>
</html>
