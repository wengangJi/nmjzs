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
    <input id="${id}Name" name="${labelName}" <%--readonly="readonly"--%> type="text" value="${labelValue}" maxlength="50"
           class="input-medium required" onblur="copyvalue()"/><a id="${id}Button" href="javascript:" class="btn">选择</a>
</div>

<script type="text/javascript">
    function copyvalue(){
        $("#${id}Id").val($("#${id}Name").val());
    }
    $("#${id}Button").click(function(){

        var html = '<form id="searchForm"  method="post" class="breadcrumb form-search">' +
                '<label>${title}证件号：</label><input id="queryidNo" name="queryidNo" class="input-medium"/><input id="queryidNum" name="queryidNum" type="hidden"/><input id="queryName" name="queryName" type="hidden"/><input id="querySex" name="querySex" type="hidden"/><input id="querybirthDate" name="querybirthDate" type="hidden"/><input id="queryidType" name="queryidType" type="hidden"/>&nbsp;' +
                '<input id="btnQuery" class="btn btn-primary" type="submit" value="查询"/>' +
                '</form>' +
                '<table id="contentTable" class="table table-striped table-bordered ">' +
                '<thead><tr><th>姓名</th><th>性别</th><th>出生日期</th><th>证件号码</th><th>证件类型</th></tr></thead>' +
                '<tbody id="resultContent">' +
                '</tbody>' +
                '</table>' +
                '<script type="text/javascript">' +
                'var result = [];' +
                '$("#btnQuery").click(function(){ ' +
                'if($("#queryidNo").val() == ""){top.$.jBox.tip("请输入${title}证件号。", "error", { focusId: "queryidNo" });return false;}' +
                'loading("正在查询，请稍等...");' +
                '$.getJSON("${url}",{name:$("#queryidNo").val()},function(data){' +
                '$.jBox.closeTip();' +
                '$("#resultContent").children().remove();' +
                'for (var i=0; i<data.length; i++){' +
                '$("#resultContent").append("<tr ondblclick=\'choiceSubmit(this)\' id=\'row" + i + "\'><td>"+data[i]["name"]+"</td><td>" + (data[i]["sex"]=="1"?"女":(data[i]["sex"]=="0"?"男":"")) + "</td><td>"+new Date(data[i]["birthDate"]).Format("yyyy-MM-dd")+"</td><td>"+data[i]["idNo"]+"</td><td>"+(data[i]["idType"]=="0"?"身份证":(data[i]["idType"]=="1"?"合格证":""))+"</td></tr>");' +
                '}' +
                '});' +
                'return false;' +
                '});' +
                'function choiceSubmit(obj) {' +
                '$("#queryName").val(obj.children[0].textContent);' +
                '$("#querySex").val(obj.children[1].textContent=="男"?"0":(obj.children[1].textContent=="女"?"1":""));' +
                '$("#querybirthDate").val(obj.children[2].textContent);' +
                '$("#queryidNum").val(obj.children[3].textContent);' +
                '$("#queryidType").val(obj.children[4].textContent=="身份证"?"0":(obj.children[4].textContent=="合格证"?"1":""));' +
                'top.$.jBox.getBox().find("button[value=\'ok\']").trigger("click");' +
                '}' +
                '<\/script>';
        var submit = function (v, h, f) {
            if (v == "ok") {
                if (f.queryidNo == '') {
                    top.$.jBox.tip("请输入${title}证件号。", 'error', { focusId: "queryidNo" }); // 关闭设置 yourname 为焦点
                    return false;
                }
                $("#applPerson").val(f.queryName);
                $("#sex").val(f.querySex);
                //$("#sex1").attr("checked","true");
               // $("input[name='sex'][value='" +f.querySex+"']").attr("checked","true");
                $("#birthDate").val(f.querybirthDate);
                $("#idType").val(f.queryidType);
                //$("#applIdNo").val(f.queryidNo);
                $("#${id}Id").val(f.queryidNo);
                $("#${id}Name").val(f.queryidNo);

                // $("#idType").val(f.queryidType);
                <%--$("#${path}NAME").val(f.queryname);--%>
                <%--$("#${path}SEX").val(f.querysex);--%>
                <%--$("#${id}birthDay").val(f.querybirthDay);--%>
                <%--$("#${id}IdNo").val(f.queryidNo);--%>
                <%--$("#${path}PersonnelType").val(f.querypersonnelType);--%>
                //return true;
            }
        };
        top.$.jBox.open(html, "选择${title}证件号", 450, 450,{buttons:{"确定":"ok", "关闭":true},submit: submit});
        //111

    });
</script>