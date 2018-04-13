<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>

<head>
    <title>${course.courseName}</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">
        function checkExistsPlayVideo(lessonId,soid,courseId,lessonName,lessonInfo) {
            $.ajax({
                type: "post",
                url: "${ctx}/course/checkExistsPlayVideo",
                data: {"courseId": courseId, "soid":soid},
                dataType: "json",
                success: function (msg) {
                    if (msg.flag == true) {
                        $.jBox.tip("存在正在学习记录，在未学完前不允许再次学习，请一小时候后再进行学习。继续教育禁止同时开启多个窗口同时学习。");
                       //$("#beginBt").attr({"disabled": "disabled"});
                        return false;
                    }else{
                        window.location.href = "${ctx}/video/init?lessonId="+lessonId+"&soid="+soid+"&courseId="+courseId+"&lessonName="+lessonName+"&lessonInfo="+lessonName;
                    }

                }
            });




        }

    </script>
</head>

<body>
<div class="jumbotron" id="intro">
    <div class="container">

        <!-- Main component for a primary marketing message or call to action -->
        <div class="">
            <div class="row" style="margin-bottom:20px">
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
    <!-- /container -->
</div>


<div class="row">
    <div class="span12" style="width: 100%">
        <ul class="nav nav-tabs" id="myTab">
            <li class="active"><a href="#course_lesson">课程目录</a></li>
            <li><a href="#course_introduction">课程介绍</a></li>
            <li><a href="#course_teacher">讲师介绍</a></li>
        </ul>

        <div class="tab-content" style="min-height: 300px;padding-top:20px">
            <div class="tab-pane active" id="course_lesson">
                <table class="table table-striped">
                    <tbody>
                    <tr>
                        <td width="20%" style="color: darkred">课件名称</td>
                        <td width="30%">课件信息</td>
                        <td>课件学时</td>
                        <td>已学学时</td>
                        <td>已播放时长</td>
                        <td>审核状态</td>
                        <td width="15%">操作 </td>
                    </tr>
                    <c:forEach items="${lessons}" var="item" varStatus="status">
                       <tr>
                            <td width="20%" style="color: darkred">${item.lessonName}</td>
                            <td width="30%">${item.lessonInfo}</td>
                            <td>${item.playTime}学时</td>
                            <td style="color: red;">
                                ${item.hours}学时
                            </td>
                           <td style="color: red;">
                                 ${item.playedTime}秒
                           </td>
                            <td style="color: red;"><strong>${fns:getDictLabel(item.auditTag, 'AUDIT_TAG', '')}</strong></td>

                            <td width="15%">
                                <c:if test="${soPlan.feeState eq '1'}">
                                    <c:if test="${item.auditTag eq '0' or item.auditTag eq '1'}">
                                        <a href="${ctx}/video/init?lessonId=${item.lessonId}&soid=${soPlan.soid}&courseId=${course.courseId}&lessonName=${item.lessonName}&lessonInfo=${item.lessonInfo}" class="btn btn-success  btn-xs">
                                            <i class="icon-white icon-play-circle"></i>重播
                                        </a>
                                     </c:if>
                                    <c:if test="${item.auditTag eq ''or item.auditTag == null or item.auditTag eq '2'}">
                                       <%-- <a href="${ctx}/video/init?lessonId=${item.lessonId}&soid=${soPlan.soid}&courseId=${course.courseId}&lessonName=${item.lessonName}&lessonInfo=${item.lessonInfo}" class="btn btn-success  btn-xs">
                                            <i class="icon-white icon-play-circle"></i>播放
                                        </a>--%>
                                        <a id="beginBt" href="javascript:void(0)" class="btn btn-success  btn-xs" onclick="checkExistsPlayVideo('${item.lessonId}','${soPlan.soid}','${course.courseId}','${item.lessonName}','${item.lessonInfo}')">
                                            <i class="icon-white icon-play-circle"></i>  播放
                                        </a>
                                    </c:if>
                                </c:if>
                            </td>
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
<div style="text-align: center;">
    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>

<script type="text/javascript">
    //页面加载完成干的事
    $(document).ready(function () {
        $('#myTab a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
    });
</script>
</body>
</html>
