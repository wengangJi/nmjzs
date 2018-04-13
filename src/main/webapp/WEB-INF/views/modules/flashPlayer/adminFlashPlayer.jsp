<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
    String courseId = request.getParameter("courseId");
    String lessonId = request.getParameter("lessonId");
    String soid = request.getParameter("soid");
    String lessonName = request.getParameter("lessonName");
    if(lessonName!=null && !"".equals(lessonName)){
        lessonName = new String(lessonName.getBytes("ISO-8859-1"), "UTF-8");
    }
    String lessonInfo = request.getParameter("lessonInfo");
    if(lessonInfo!=null && !"".equals(lessonInfo)){
        lessonInfo = new String(lessonInfo.getBytes("ISO-8859-1"), "UTF-8");
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
	<head>
		<title></title>
        <meta name="decorator" content="default"/>
        <%@include file="/WEB-INF/views/include/dialog.jsp" %>
        <script src="${ctxStatic}/flashPlayer/swfobject.js" type="text/javascript"></script>
        <script type="text/javascript">
          //  $(document).ready(function() {
                var soid = "<%=soid%>";
                var courseId = "<%=courseId%>";
                var lessonId = "<%=lessonId%>";
                var videoTime;
                var startTime;
                var finshTime;
                var cameraFlag = true;

                var flashvars = {
                    soid: "<%=soid%>",
                    courseId: "<%=courseId%>",
                    lessonId: "<%=lessonId%>"
                };
                var params = {bgcolor: "#CCCCCC", allowfullscreen: true, wmode: "transparent"};
                var attributes = {};
                swfobject.embedSWF("${ctxStatic}/flashPlayer/CaptureFacePlayer.swf", "CaptureFacePlayer", "640", "360", " 9.0.124", false, flashvars, params, attributes);
                function getPlayerInitData(soid, courseId, lessonId) {
                    return {
                        //courseVideoURL:"a2.mp4",
                        courseVideoURL: "${ctx}/video/adminVideo/" + lessonId,
                        captureEvent: ["videoPlayStarted", "videoPaused", "videoPlayComplete"],
                        captureDuration: 10000,
                        bufferTime: 5,
                        isSendPhotoToServer: 1,
                        delayHideControlBar: 5,
                        defaultVol:0.75
                    };
                }

                /*
             courseVideoURL		是指这个课程的视频文件地址，绝对地址和相对地址都可以
             captureEvent		是指触发拍照的播放器事件，目前只支持这三种事件
             captureDuration		触发拍照的时间事件，自动拍照时间间隔，以秒为单位。15就代表15秒，而300就代表5分钟
             注意，在视频暂停时，计时器也暂停，不会在视频暂停期间中不停地拍照的。
             uploadURL			上传图片的servlet服务地址，若与swf不在同一域名下，需要在服务的根目录放置策略文件
             bufferTime			缓冲时间，秒为单位
             isSendPhotoToServer	是否把图片发送到服务器，1为发送，0为不发送，不请求
             */

            function  cfPlayerStatus(status){

            }
//});

        </script>
        <style>
            body,html {width:100%; height:100%; margin: 0px; padding:0px; overflow:hidden }
            body { margin: 0px; overflow:hidden }
        </style>
	</head>
	<body>

    <div class="container">
        <h3><%=lessonName%></h3>
        <div id="CaptureFacePlayer">

        </div>
        <p>内容介绍：<%=lessonInfo%></p>
    </div>
  </br></br></br></br></br></br>
    <div style="margin-left: 450px;">
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>


    </body>



</html>