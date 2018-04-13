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
                var finishTime;
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
                        courseVideoURL: "${ctx}/video/video/" + lessonId,
                        captureEvent: ["videoPlayStarted", "videoPaused", "videoPlayComplete"],
                        captureDuration: 900,
                        bufferTime: 5,
                        uploadURL: "${ctx}/video/videoImageUpload?soid=" + soid + "&courseId=" + courseId + "&lessonId=" + lessonId,
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

            function

                    cfPlayerStatus(status){

                /*
                 status是一个对象，代表播放器运行状态，
                 status.type是状态类型，type目前有这些取值：

                 得到视频信息			gotVideoInfo
                 　　　有属性			status.videoDuration(视频总时长，秒为单位)

                 播放开始				videoPlayStarted
                 播放完毕				videoPlayComplete
                 加载完毕				loadComplete
                 视频暂停				videoPaused
                 视频暂停				videoResumed
                 恢复播放				RESUMED
                 有可用摄像头			cameraExist
                 没摄像头或不可用		noCamera
                 播放开始时拍照		    firstCapture
                 摄像头拒绝使用         refuseUseCamera
                 自动抓拍				autoCapture
                 默认拒绝使用摄像头	    refuseUseCamera
                 手动拒绝使用摄像头	    refuseUseCameraManually
                 默认允许使用摄像头	    allowUseCamera
                 手动允许使用摄像头	    allowUseCameraManually

                 每个状态都有currentVideoTime属性，是当前视频播放的时间点，秒为单位
                 status.currentVideoTime

                 */

                if(status.type=="noCamera"){
                    $.jBox.tip('没有可用的摄像头，请确保有可用的摄像头进行学习。');
                    return ;
                }

                if(status.type=="refuseUseCameraManually" ){
                    $jBox.tip('您的摄像头没有启用，无法进行视频图片抓取。');
                    cameraFlag =false;
                    return ;
                }
                if( status. type== "videoPaused" && cameraFlag==true){
                    $.jBox.tip('您已暂停视频播放，同时已暂停图片抓取功能，重新播放恢复抓取。');
                    return ;
                }
                if(status.type =="videoResumed" && cameraFlag ==true){
                    $.jBox.tip('您已恢复视频播放，同时图片抓取功能已恢复。');
                    return ;
                }


                if(status.type== "videoPlayStarted" && cameraFlag ==true){
                     startTime = new Date().Format("yyyy-MM-dd hh:mm:ss") ;
                    $.ajax({
                        type: "post",
                        url: "${ctx}/video/removeHourSvc",
                        data: {"soid":soid,"courseId":courseId,"lessonId":lessonId},
                        dataType: "json",
                        success: function (msg) {
                            if (msg.flag == 0) {
                                $.jBox.tip('清除无效视频数据成功！');

                            }
                        }
                    });
                }
                if(status.type=="gotVideoInfo"){
                    videoTime=status.videoDuration;
                }
                if(status.type=="reportCurrentTime"){
                    if((parseInt(videoTime)-parseInt(status.currentVideoTime))== 10) {
                        $.jBox.tip('本次课程距离结束时间还剩10秒钟,10秒后自动进入学时确认页面。');
                    }
                }


                if(status.type=="videoPlayComplete" && cameraFlag == true ){
                    finishTime = new Date().Format("yyyy-MM-dd hh:mm:ss") ;
                    /*  confirmx('课件已经播放完成。播放时长'+status.currentVideoTime+'(秒)。点击【确定】后转入学时确认页面，学时确认可对本次学习提交审核和作废。若点击取消，本次学习不计入学时。',*/
                     window.location.href ="${ctx} /video/syncVideoSvc?soid="+ soid+ "&courseId=" + courseId + "&lessonId=" + lessonId + "&startTime=" + startTime + "&finishTime="
                             +finishTime +"&videoTime="+videoTime+"&playedTime="+ status.currentVideoTime+"&imgNum="+ status.sendCount;

                }
                if(status.type == "gotVideoInfo"){
                    console.log(status.type +" 总时长 "+ status.videoDuration);
                }else{
                    console.log(status.type, status.currentVideoTime);
                }
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