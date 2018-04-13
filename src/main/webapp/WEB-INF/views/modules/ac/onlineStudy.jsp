<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>Flash FLV Player播放列表</title>
    <script type="text/javascript" src="${ctxStatic}/flash/ufo.js"></script>
    <script type="text/javascript">
        function playMovie(file) {
            var FO = {
                movie:"flvplayer.swf",
                width:"320px",
                height:"260px",
                majorversion:"7",
                build:"0",
                flashvars:"file="+file+"&autoStart=true"
            };

            UFO.create(FO, 'player');
        }
    </script>
</head>
<body>
<h2> 课程1 ifox格式-互联网视频格式(搜狐)</h2>

<div id="player">
    <object type="application/x-shockwave-flash" data="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/a2.mp4" width="780" height="420">
        <param name="movie" value="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/01.ifox" />
    </object>
</div>

<h2> 课程2 mp4格式-流媒体格式</h2>

<div id="player2">
    <object type="application/x-shockwave-flash" data="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/2.mp4" width="780" height="420">
        <param name="movie" value="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/2.mp4" />
    </object>
</div>

<h2> 课程3 flv格式-标准格式 </h2>

<div id="player3">
    <object type="application/x-shockwave-flash" data="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/搞笑小孩3.flv" width="780" height="420">
        <param name="movie" value="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/搞笑小孩3.flv" />
    </object>
</div>

<h2> 课程4 wmv格式转为flv格式 </h2>

<div id="player4">
    <object type="application/x-shockwave-flash" data="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/wmv-flv.flv" width="780" height="420">
        <param name="movie" value="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/wmv-flv.flv" />
    </object>
</div>

<h2> 课程5 rm格式转为flv格式 </h2>

<div id="player5">
    <object type="application/x-shockwave-flash" data="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/rm-flv.flv" width="780" height="420">
        <param name="movie" value="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/rm-flv.flv" />
    </object>
</div>

<h2> 课程6 rmvb格式转为flv格式 </h2>
<div id="player6">
    <object type="application/x-shockwave-flash" data="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/rmvb-flv.flv" width="780" height="420">
        <param name="movie" value="${ctxStatic}/flash/flvplayer.swf?file=${ctxStatic}/flash/rmvb-flv.flv" />
    </object>
</div>
</body>
</html>
