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

        $(document).ready(function() {


            $("#hideme").click(function(){
                $("#fileArea").toggle(500);
            });
            $("#hideme").tooltip();


        });

    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#courseArea" data-toggle="tab">已学课程</a></li>
</ul>
<div id="courses-list" class="row">

            <c:forEach items="${soCourses}" var="node">
                <div class="span4">
                    <div class="thumbnail thumbnaiBox">
                        <a href="${ctx}/course/detail?courseId=${node.course.courseId}">
                            <c:choose>
                                <c:when test="${node.course.image == null}">
                                    <img style="width:100%" src="${ctxStatic}/imgages/nopic_course.jpg"/>
                                </c:when>
                                <c:otherwise>
                                    <img style="width:100%;height:140px;" src="${ctx}/file/pic/${node.course.id}"/>
                                </c:otherwise>
                            </c:choose>
                        </a>

                        <div class="caption">
                            <h4><a href="${ctx}/course/detail?courseId=${node.course.courseId}">${node.course.courseName}</a></h4>
                            <p>
                                <c:choose>
                                    <c:when test="${fn:length(node.course.rsrvStr1) > 40}">
                                        <c:out value="${fn:substring(node.course.rsrvStr1, 0, 40)}......"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="${node.course.rsrvStr1}"/>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <p>
                                主讲老师：${node.course.teacherName} &nbsp;&nbsp;
                                课时情况：${node.course.courseHours}(小时)
                            </p>
                            <p>
                                课程专业：${fns:getDictLabel(node.course.majorId, 'MAJOR', '')}  &nbsp;&nbsp;

                                    <i class="icon-white icon-play-circle"></i> 已完成

                            </p>




                                <%--                    <p>
                                                        <a role="button" class="btn btn-primary" href="#">立刻播放</a>
                                                        <a role="button" class="btn btn-default" href="#">分享好友</a>
                                                    </p>--%>
                        </div>
                    </div>
                </div>
            </c:forEach>

</div>
</body>
</html>