<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>打印页面</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/print/LodopFuncs.js" type="text/javascript"></script>
    <script src="${ctxStatic}/print/webprinter.js" type="text/javascript"></script>
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" codebase="/lodop.cab#version=6.1.4.1" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 ></embed>
    </object>
</head>
<body>

<form id="paperDiv" name="paperDiv">
    <input type="hidden" id="test" name="test" value="2" />
</form>

<div id="divButton_new" style="left: 50px; top: 1000;">
    <input type ="button" class="btn" onclick="javascript:prn1_preview()" value ="打印预览">
    <input type ="button" class="btn" onclick="CheckIsInstall()" value ="查看本机是否安装控件">
    <input type ="button" class="btn" onclick="prn1_print()" value ="直接打印">
    <input type ="button" class="btn" onclick="prn1_printA()" value ="选择打印机">
    <input type ="button" class="btn" onclick="Design1()" value ="打印设计">
    <input type ="button" class="btn" onclick="prn1_manage()" value ="打印设置">
</div>


<script>
    var LODOP; //声明为全局变量

    function prn1_preview() {
        CreatePrintPage();
        LODOP.PREVIEW();
    };
    function prn1_print() {
        CreatePrintPage();
        LODOP.PRINT();
    };
    function prn1_printA() {
        CreatePrintPage();
        LODOP.PRINTA();
    };
    function prn1_manage() {
        CreatePrintPage();
        LODOP.PRINT_SETUP();
    };

    function Design1() {
        CreatePrintPage();
//		LODOP.SET_SHOW_MODE("HIDE_ITEM_LIST",true);//设置对象列表默认处于关闭状态
//		LODOP.SET_SHOW_MODE("TEXT_SHOW_BORDER",1); //设置字符编辑框默认为single
        LODOP.PRINT_DESIGN();
    };
    function CreatePrintPage() {
        LODOP = getLodop(document.getElementById('LODOP'), document.getElementById('LODOP_EM'));
  /*      LODOP.PRINT_INITA(0,0,630,454,'证书打印');
        LODOP.PRINT_INIT("证书打印");
        LODOP.ADD_PRINT_SETUP_BKIMG("E:\\项目学习\\建设厅方案\\证书1.jpg");
        LODOP.SET_SHOW_MODE("BKIMG_WIDTH",642);
        LODOP.SET_SHOW_MODE("BKIMG_HEIGHT",461);
        LODOP.SET_PRINT_STYLE("FontSize",18);
        LODOP.SET_PRINT_STYLE("Bold",1);
        LODOP.ADD_PRINT_TEXT(0,0,0,0,"");
        //LODOP.ADD_PRINT_HTM(18,18,800,1000,"(超文本2的HTML代码内容)");
        LODOP.ADD_PRINT_TEXT(248,106,100,25,"刘庆宇");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(286,106,100,25,"男");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(324,106,100,25,"1983年6月9日");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(360,106,184,25,"152104198306092270");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(73,438,181,58,"亚信科技（南京）有限公司亚信科技（南京）有限公司");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(145,438,173,25,"高级软件工程师");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(184,438,172,25,"高级");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(219,438,170,25,"2112344353245345");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(362,467,42,25,"2014");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(362,526,27,25,"10");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(362,569,29,25,"10");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);

        LODOP.NewPage();
        LODOP.ADD_PRINT_TEXT(123,58,188,20,"2014-06-06");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(158,58,188,20,"2017-06-09");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(123,394,157,20,"2017-09-09");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
        LODOP.ADD_PRINT_TEXT(158,394,157,20,"2018-10-10");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",10);

        LODOP.ADD_PRINT_HTM(0, 0, 800, 1000, document.getElementById("paperDiv").innerHTML);*/


/*        LODOP.PRINT_INIT("证书打印");
        LODOP.PRINT_INITA(0,0,1586,1077,"");
        LODOP.ADD_PRINT_SETUP_BKIMG("E:\\项目学习\\建设厅方案\\安全生产许可\\安全生产许可\\eq_main.jpg");
        LODOP.ADD_PRINT_TEXT(572,558,910,35,"单位名称");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(728,557,910,35,"有限责任公司（经济类型）");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(675,557,910,35,"单位地址");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(623,557,910,35,"主要负责人");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(779,557,910,35,"建筑施工（施工范围）");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(459,618,36,35,"蒙");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(459,823,70,35,"2014");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
        LODOP.ADD_PRINT_TEXT(459,912,315,35,"001234");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(883,1177,324,35,"发证机关");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(830,448,60,35,"2013");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(830,722,60,35,"2014");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(939,1104,60,35,"2015");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(830,551,36,35,"12");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(830,621,36,35,"01");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(830,816,36,35,"11");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(830,889,36,35,"30");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(939,1201,36,35,"01");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);
        LODOP.ADD_PRINT_TEXT(939,1276,36,35,"01");
        LODOP.SET_PRINT_STYLEA(0,"FontSize",18);*/
        //LODOP.ADD_PRINT_HTM(0, 0, 1586, 1077, document.getElementById("paperDiv").innerHTML);


        LODOP.PRINT_INITA(0,0,960,655,"");
        LODOP.ADD_PRINT_SETUP_BKIMG("D:\\myworkspace\\nmjzs\\src\\main\\webapp\\static\\print\\ac\\ac_education.jpg");
        LODOP.ADD_PRINT_TEXT(390,167,260,25,"$serv.idNo");
        LODOP.ADD_PRINT_TEXT(324,167,260,25,"$serv.name");
        LODOP.ADD_PRINT_TEXT(357,167,260,25,"$serv.companyId|COMPANY");
        LODOP.ADD_PRINT_TEXT(422,167,260,25,"$serv.certNo");
        LODOP.ADD_PRINT_TEXT(213,307,200,25,"$serv.name");
        LODOP.SET_PRINT_STYLEA(0,"Alignment",3);
        LODOP.ADD_PRINT_TEXT(213,557,35,25,"2012");
        LODOP.ADD_PRINT_TEXT(213,604,25,25,"12");
        LODOP.ADD_PRINT_TEXT(213,640,25,25,"23");
        LODOP.ADD_PRINT_TEXT(442,506,35,25,"$SYSDATE|YEAR");
        LODOP.ADD_PRINT_TEXT(442,554,25,25,"$SYSDATE|MONTH");
        LODOP.ADD_PRINT_TEXT(442,585,25,25,"$SYSDATE|DAY");
        LODOP.ADD_PRINT_IMAGE(149,151,115,150,"<img src='http://s1.sinaimg.cn/middle/4fe4ba17hb5afe2caa990&690' />");

    };
    function CheckIsInstall() {
        try {
            var LODOP = getLodop(document.getElementById('LODOP'), document
                    .getElementById('LODOP_EM'));
            if ((LODOP != null) && (typeof (LODOP.VERSION) != "undefined"))
                alert("本机已成功安装过Lodop控件!");
        } catch (err) {
            alert("Error:本机未安装!");
        }
    }

    function print(soid,pageNum,w,h) {
        pageNum = pageNum || 1;
        if (LodopTool){
            var printer = new LodopTool("证书打印",'0');
            var param = {};
            printer.preview("/nmjzs/a/print/printHtml?soid=" + soid +"&pageNum=" + pageNum,param,w,h);
        }
    }
</script>
<input type="button" class="btn" onclick="print('471AC012015061400001157','1',960,655);" value="打印证书"/>
</body>
</html>
