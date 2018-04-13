<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="数据获取地址"%>

<div class="input-append">
    <input id="${id}Id" name="${name}" class="required" type="hidden" value="${value}"/>
    <input id="${id}Name" name="${labelName}" readonly="readonly" type="text" value="${labelValue}" maxlength="50"
           class="required input-medium " /><a id="${id}Button" href="javascript:" class="btn">选择</a>
</div>

<script type="text/javascript">
    $("#${id}Button").click(function(){

        var html = '<form id="searchForm"  method="post" class="breadcrumb form-search">' +
                '<label style="font-size: 8px;color: red;">*默认查询为未注册企业，若要选择其他已注册企业，请输入企业名称点击查询，查询出相应的企业后，根据查询出的结果选中确认或者双击确认。</label><br>'+
                '<label>${title}：</label><input id="queryname" name="queryname"  value="未注册" class="input-medium"/><input id="queryid" name="queryid" type="hidden"/>&nbsp;' +
                '<input id="btnQuery" class="btn btn-primary" type="submit" value="查询"/>' +
                '</form>' +
                '<table id="contentTable" class="table table-striped table-bordered ">' +
                '<thead><tr><th>${title}编码</th><th>${title}名称</th></tr></thead>' +
                '<tbody id="resultContent">' +
                '</tbody>' +
                '</table>' +
                '<script type="text/javascript">' +
                'var result = [];' +
                '$("#btnQuery").click(function(){ ' +
                'if($("#queryname").val() == ""){top.$.jBox.tip("请输入${title}。", "error", { focusId: "queryname" });return false;}' +
                    'loading("正在查询，请稍等...");' +
                    '$.getJSON("${url}",{name:encodeURI($("#queryname").val(),"utf-8")},function(data){' +
                        '$.jBox.closeTip();' +
                        '$("#resultContent").children().remove();' +
                        'for (var i=0; i<data.length; i++){' +
                              '$("#resultContent").append("<tr onclick=\'$(this).addClass(&quot;info&quot;).siblings().removeClass(&quot;info&quot;);choice(this);\' ondblclick=\'choiceSubmit(this)\' id=\'row" + i + "\'><td>"+data[i]["${id}"]+"</td><td>" + data[i]["${labelName}"] + "</td></tr>");' +
                        '}' +
                    '});' +
                    'return false;' +
                '});' +

                'function choiceSubmit(obj) {' +
                    'choice(obj);' +
                    '$("#queryid").val(obj.children[0].textContent);' +
                    '$("#queryname").val(obj.children[1].textContent);' +
                    'top.$.jBox.getBox().find("button[value=\'ok\']").trigger("click");' +
                '}' +
                'function choice(obj) {' +
                '$("#queryid").val(obj.children[0].textContent);' +
                '$("#queryname").val(obj.children[1].textContent=="undefined"?"":obj.children[1].textContent);' +
                '}'+
                '<\/script>';
        var submit = function (v, h, f) {
            if (v == "ok") {
                if (f.queryname == '') {
                    top.$.jBox.tip("请输入${title}。", 'error', { focusId: "queryname" }); // 关闭设置 yourname 为焦点
                    return false;
                }
                if(f.queryid==''){
                    top.$.jBox.tip("请先查询企业");
                    return false;
                }
                $("#${id}Id").val(f.queryid);
                $("#${id}Name").val(f.queryname);
                //return true;
            }
        };
        top.$.jBox.open(html, "选择${title}", 450, 450,{buttons:{"确定":"ok", "关闭":true},submit: submit});
        //111

    });
</script>