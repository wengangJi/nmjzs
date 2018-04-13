<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>三类人员
    </title>
    <meta name="decorator" content="default"/>
    <style type="text/css">
        ul li{margin-top: 10px;}

    </style>
</head>
<body>

<div id="content" class="row-fluid">

<div id="left">
    <ul class="nav nav-tabs" id="compTab">
        <li class="active"><a href="javascript:void(0);"  data-toggle="tab" style="width: 145px;">列表</a></li>
        <li><a href="javascript:void(0);" data-toggle="tab" style="width: 145px;" id="ck1">申请表首页</a></li>
        <li><a href="javascript:void(0);" data-toggle="tab" style="width: 145px;" id="ck2">填写说明</a></li>
        <li><a href="javascript:void(0);" data-toggle="tab" style="width: 145px;"  id="ck3">基本情况</a></li>
        <%--
            <li><a href="#acMajorPage" data-toggle="tab">二级建造师专业信息</a></li>
        --%>
        <li><a href="javascript:void(0);" data-toggle="tab" style="width: 145px;"  id="ck4">工作简历及业绩</a></li>

    </ul>
</div>
<div id="openClose" class="close">&nbsp;</div>

<div id="eee" style=" background-color: #f9f9f9;float: right; width: 968px;">
    <form:form  id="cpForm"  modelAttribute="personnel"   action="${ctx}/cp/personnel/save" method="post">
        <div id="div1" style="display: none;width: 968px;" >
            <ul style="list-style: none; text-align: center; margin-top:30px; ">
                <li>
                    内蒙古自治区建筑施工企业
                </li>
                <li>
                    主要负责人、项目负责人和专职安全
                </li>
                <li>
                    生产管理人员考核申请表
                </li>
            </ul>



            <ul style="list-style: none; text-align: center; margin-top:30px; ">
                <li>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;企业名称<input name="company_id">
                </li>
                <li>
                    &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;申请人姓名<input name="ppl_person">
                </li>
                <li>
                    &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;身份证件号<input name="appl_id">
                </li>
                <li>
                    申请时间
                    <input id="apple_date" width="30px;" name="beginDate" type="text" readonly="readonly" maxlength="50" class="input-small Wdate"
                           value="${beginDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>

                </li>
                <li>
                    申请类别 <input name="so_type" type="radio" value="0">首次申请<input name="so_type" type="radio" value="1">延期申请
                </li>
            </ul>
            <ul style="list-style: none; text-align: center; margin-top:70px; ">
                <li>

                    内蒙古自治区建设厅编制
                </li>

            </ul>
        </div>
        <div id="div2" style=" background-color: #f9f9f9; display: none;width: 968px;">
            <span style='text-align: center; margin-left: 450px;font-family:"微软雅黑";font-size: 20;'> 填  写  说  明</span>

            <ul style="list-style-type:none">

                <li>
                    1、本申请表所有内容必须由申请人及所在单位如实填写，内容要具体，申请表封面应有申请人签名，所在单位签署意见并加盖公章。
                </li>
                <li>
                    2、封面部分“申请人姓名”一栏由申请人用兰色或黑色钢笔或签字笔签名。申请人如果是首次申请，请在“首次申请”后的方括号内打钩，如果是延期申请，请在“延期申请”后的方括号内打钩。
                </li>
                <li>
                    3、“基本情况”部分，“专业”、“学历”栏中应填写符合考核条件的专业、学历，未获得学位的，不应自行填写学位；“证件类型”首次申请的在身份证前打“√”，申请延期的在“考核合格证书”前打“√”。“执业资格”应由项目负责人填写取得建筑施工企业项目经理资质证书或建造师执业资格证书情况。
                </li>
                <li>
                    4、“工作简历”、“安全生产业绩”应按时间顺序分别填写，“工作简历”一项最多填写五项；“安全生产业绩”栏的“受处罚情况”填写主要为事故处罚情况。
                </li>
                <li>
                    5、“证书使用情况”填写证书被注销、变更和延期等情况。
                </li>
            </ul>
        </div>
        <div id="div3" style="  display: none; width: 968px;">


            <table id="contentTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr align="center"><td colspan="7" style="text-align: center">基 本 情 况</td></tr>
                </thead>
                <tbody>

                <tr>
                    <td>姓名</td><td><input name="name"></td><td>性别</td><td><input name="sex"></td><td>出生日期</td><td>
                    <input id="birth_date" width="30px;" name="beginDate" type="text" readonly="readonly" maxlength="50" class="input-small Wdate"
                           value="${beginDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>

                </td><td rowspan="3"width="60px;">照片</td>

                </tr>
                <tr>
                    <td>证件号</td><td colspan="3"><input name="id_no"></td> <td>证件类别</td><td><input type="radio" name="D_TYPE" value="1">
                    身份证<input type="radio" name="D_TYPE" value="0">考核合格证书</td>
                </tr>
                <tr>
                    <td>人员类别</td><td colspan="5"><input type="radio" name="person_type" value="1">
                    企业主要负责人<input type="radio" name="person_type" value="0">项目负责人<input type="radio" name="person_type" value="2">
                    专职安全生产管理人</td>
                </tr>
                <tr>
                    <td colspan="2">参加考试时间</td><td colspan="3"><input name="EXAM_DATE exan_date"></td> <td>考试成绩</td><td><input name="EXAM_SCORE" style="width: 96px;"></td>
                </tr>
                <tr>
                    <td colspan="2">所在企业名称</td><td colspan="5"><input name=""></td>
                </tr>
                <tr>
                    <td colspan="2">企业联系电话</td><td colspan="3"><input name="TELEPHONE"></td> <td>资质等级</td><td><input name="" style="width: 96px;"></td>
                </tr>
                <tr>
                    <td colspan="2">通讯地址</td><td colspan="3"><input name="ADDRESS"></td> <td>邮政编码</td><td><input name="POST_CODE" style="width: 96px;"></td>
                </tr>
                <tr>
                    <td colspan="2">电子邮箱</td><td colspan="5"><input name="MAIL"></td>
                </tr>
                <tr>
                    <td colspan="2">毕业院校</td><td colspan="5"><input name="GARD_SCHOOL"></td>
                </tr>
                <tr>
                    <td>毕业时间</td><td>
                    <input id="GARD_DATE" width="30px;" name="beginDate" type="text" readonly="readonly" maxlength="50" class="input-small Wdate"
                           value="${beginDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>

                </td>
                    <td >专业</td><td ><input name="MAJOR"></td>
                    <td >职称</td><td  colspan="2" ><input name=TITLE_LEVEL""></td>


                </tr>
                <tr>
                    <td>学    历</td><td><input name="DEGREE"></td>
                    <td >学位</td><td ><input name="EDUCATION" width="400px;"></td>
                    <td >执业资格</td><td  colspan="2" ><input name=""></td>


                </tr>
                <tr>
                    <td>参加工作时间</td><td colspan="2">
                    <input id="WORKING_DATE" width="30px;" name="beginDate" type="text" readonly="readonly" maxlength="50" class="input-small Wdate"
                           value="${beginDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>

                </td>

                    <td  colspan="2">累计从事安全生
                        产管理工作年限
                    </td><td  colspan="2" ><input name=""></td>


                </tr>
                <tr>
                    <td colspan="2">接受安全教育、培训及考核情况</td><td colspan="5"><input name="LEARN_EXPE"></td>
                </tr>
                <tr>
                    <td colspan="2">证书使用情况
                    </td><td colspan="5"><input name="CERT_EXPE"></td>
                </tr>

                </tbody>
                <tfoot>

                <tr>
                    <td colspan="7" style="text-align: center">


                        <input id="btnSubmit" class="btn btn-primary" type="reset" value="重置">
                    </td>
                </tr>
                </tfoot>

            </table>

        </div>
</div>
<div id="div4" style="display: none; width: 968px; float: right">


    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <caption>工 作 简 历</caption>
        <thead >
        <tr style="text-align: center">
            <td>序 号 </td><td>聘用起止时间</td><td>工作单位</td><td>职务</td>
        </tr>
        </thead>
        <tbody>
        <tr><td>1</td><td><input name=""/></td><td><input name=""/></td><td><input name=""/></td></tr>
        <tr><td>2</td><td><input name=""/></td><td><input name=""/></td><td><input name=""/></td></tr>
        <tr><td>3</td><td><input name=""/></td><td><input name=""/></td><td><input name=""/></td></tr>
        <tr><td>4</td><td><input name=""/></td><td><input name=""/></td><td><input name=""/></td></tr>
        <tr><td>5</td><td><input name=""/></td><td><input name=""/></td><td><input name=""/></td></tr>
        <tr><td colspan="4" style="text-align: center">安 全 生 产 业 绩</td></tr>
        <tr>
            <td>受表彰情况</td> <td colspan="3">
            <textarea></textarea>
        </td>

        </tr>
        <tr>
            <td>受处罚情况</td> <td colspan="3">
            <textarea></textarea>
        </td>
        </tr>
        <tr>
            <td>企业审核意见</td> <td colspan="3">
            <textarea>负责人（签字） 单  位（公章） 年  月  日</textarea>
        </td>

        </tr>
        <tr>
            <td>省辖市建设行政主管部门</td> <td colspan="3">
            <textarea style="width: 736px;">负责人（签字） 单  位（公章） 年  月  日</textarea>
        </td>

        </tr>
        <tr>
            <td>建设厅审查意见
            </td> <td colspan="3">
            <textarea> 负责人（签字） 单  位（公章） 年  月  日
            </textarea>
        </td>
        </tr>
        <tr>
            <td>备注
            </td> <td colspan="3">
            <textarea></textarea>
        </td>
        </tr>
        </tbody>
        <tfoot>

        <tr>
            <td colspan="7" style="text-align: center">
                <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存">
                <input id="btnSubmit" class="btn btn-primary" type="reset" value="重置">
            </td>
        </tr>
        </tfoot>

    </table>



</div>
</form:form>
</div>
</div>
<script type="text/javascript">
    var leftWidth = "160"; // 左侧窗口大小
    function wSize(){
        var strs=getWindowSize().toString().split(",");
        $("#cmsMenuFrame, #cmsMainFrame, #openClose").height(strs[0]-5);
        $("#right").width($("body").width()-$("#left").width()-$("#openClose").width()-5);
    }


    $("#ck1").bind("click", function(event) { $("#div1").show(); $("#div2").hide(); $("#div3").hide();$("#div4").hide();});
    $("#ck2").bind("click", function(event) { $("#div2").show(); $("#div1").hide(); $("#div3").hide();$("#div4").hide();});
    $("#ck3").bind("click", function(event) { $("#div3").show(); $("#div1").hide(); $("#div2").hide();$("#div4").hide();});
    $("#ck4").bind("click", function(event) { $("#div4").show(); $("#div2").hide(); $("#div3").hide();$("#div1").hide();});

</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>
