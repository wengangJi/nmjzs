<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<%@ attribute name="height" type="java.lang.String" required="true" description="图片高度"%>
<%@ attribute name="width" type="java.lang.String" required="true" description="图片宽度"%>

<script type="text/javascript">include('jcrop_css','${ctxStatic}/jquery-jcrop/css/',['jquery.Jcrop.min.css']);</script>
<script type="text/javascript">include('jcrop_lib','${ctxStatic}/jquery-jcrop/js/',['jquery.Jcrop.min.js']);</script>

<img  src="${not empty value?value:''}" id="ofilePath"/></br>
<input id="${id}" name="${name}" type="hidden" value="${value}" /><a id="${id}Button" href="javascript:" class="btn btn-success">上传附件</a>
<script type="text/javascript">
    $("#${id}Button").click(function(){
        top.$.jBox.open("iframe:${ctx}/file/uploadPhoto?width="+"${width}"+"&height=" + "${height}", "上传图片", 800, $(top.document).height()-180, {
            buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                    var filename = h.find("iframe")[0].contentWindow.$("#filename").val();
                    if (filename == "") {
                        top.$.jBox.error("请先选择图片，做相应调整后，点击保存图片按钮！");
                        return false;
                    }
                    var url = "${ctx}/file/headPhoto/" + filename + "/final" + "?" + Math.random();
                    $("#ofilePath").attr("src",url);
                    $("#${id}").val(url);
                }else if (v=="clear"){
                    $("#ofilePath").attr("src","");
                    $("#${id}").val("");
                }
            }, loaded:function(h){
                $(".jbox-content", top.document).css("overflow-y","hidden");
            }
        });
    });
</script>