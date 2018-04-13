(function () {
    var param = null;
    var printNum = 1;
    var heightNum = $("#heightNum").val() || 1000;
    var LODOP = null;
    var current = 0;
    var curPercent = 0;
    var printType;
    var printData;
    var host_url = "http://60.31.29.42:8001";
    (function () {
        var obj = $('#printData').html();
        printType = $("#printType").val();
        printData = jQuery.parseJSON(obj);
        printType =  2;
        printNum =  1;
        document.title = "证书打印";
        var htmlStr = '<table border="1" width="100%"><tr><td bgcolor="#FF6600"></td>';
        var btnArr = ["high:Btn:适高", "normal:Btn:正常", "wide:Btn:适宽", "big:Btn:变大", "small:Btn:变小", "first:Btn:首页", "prev:Btn:上一页", "next:Btn:下一页", "last:Btn:尾页", "percent:Sel:百分比", "set:Btn:打印设置", "printAt:Btn:直接打印", "page:Sel:页码", "preview:Btn:预览", "printSet:Btn:选择打印机", "close:Btn:关闭"];
        for (var i = 0; i < btnArr.length; i++) {
            var vvArray = btnArr[i].split(":");
            if (vvArray[1] == "Btn") {
                htmlStr += '<td width="3%" ><img  id="' + vvArray[0] + 'Btn" alt="' + vvArray[2] + '" src="/nmjzs/static/print/images/' + vvArray[0] + '.gif" border="0" /></td>';
            }
            else if (vvArray[1] == "Sel") {
                htmlStr += '<td width="3%" ><select size="1" id="' + vvArray[0] + 'Sel"></select></td>';
            }
        }
        htmlStr += '<td bgcolor="#FF6600"></td></tr><tr><td width="100%" colspan="' + (btnArr.length + 2) + '"> <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=100% height=' + heightNum + '><embed id="LODOP_EM" TYPE="application/x-print-lodop" width=100% height=' + heightNum + ' ></embed></object></td></tr></table>';
        $("#showDiv").append(htmlStr);
        var opArr = ["0:30%", "1:50%", "2:60%", "3:70%", "4:80%", "5:85%", "6:90%", "7:95%", "8:100%", "9:125%", "10:150%", "11:200%", "12:按整宽", "13:按整高", "14:按整页", "15:整宽不变形", "16:整高不变形", "17:其它比例"];
        //var inputSelect = $("#percentSel");
        var inputSelect=document.getElementById('percentSel');
        for (var i = 0; i < opArr.length; i++) {
            var vvArray = opArr[i].split(":");
            var opp = new Option(vvArray[1], vvArray[0]);
            inputSelect.add(opp);
        }
        for (var i = 0; i < btnArr.length; i++) {
            var vvArray = btnArr[i].split(":");
            if (vvArray[1] == "Btn") {
                $("#" + vvArray[0] + "Btn").bind("click", printFunc( vvArray[0]));
            }
            else if (vvArray[1] == "Sel") {
                $("#" + vvArray[0] + "Sel").bind("change", printFunc( vvArray[0]));
            }
        };
        inputSelect.value = "8";
        $(this).doTimeout('typing', 10, function() {
            LODOP = getLodop(document.getElementById('LODOP'), document.getElementById('LODOP_EM'));
            initPage();
        });
    })();
    function initPage() {
        if (CreatePrintPage(null)) {
            OpenPreview();
            LODOP.DO_ACTION("PREVIEW_PERCENT", 8);
            LODOP.DO_ACTION("PREVIEW_ZOOM_NORMAL", 0);
            disableBtn("normal", true);
            disableAllBtn(["first", "prev"], true);
            var strResult = LODOP.GET_VALUE("PREVIEW_PAGE_COUNT", 1);//获得页数
            printNum = strResult;//赋值
            if (printNum <= 1) {
                disableAllBtn(["next", "last"], true);
            }
            else {
                disableAllBtn(["next", "last"], false);
            }
            current = 1;
            curPercent = 0;
            if (printNum > 0) {
                var inputSelect = document.getElementById("pageSel");
                inputSelect.options.length = 0;
                for (var i = 0; i < printNum; i++) {
                    var opp = new Option((i + 1) + "页", i + 1);
                    inputSelect.add(opp);
                }
                document.getElementById("pageSel").value = 1;
            }
        }
    }

    function CreatePrintPage(cur)   //组装数据
    {
        var printStr = "";
        var printMultiPrintTag = $("#print_multi_page").val() || "0";
        if (printMultiPrintTag == "0") {
            // 单页方式
            for (var i = 0; i < printData.length; i++)
            {
                var printNode = printData[i];
                var paraType = printNode.paraType;
                var paraName = printNode.paraName;
                var paraNum = printNode.paraNum;
                var itm = "LODOP." + paraType + "(";
                if (parseInt(paraNum) > 0)
                {
                    for (var j = 1; j <= parseInt(paraNum); j++)
                    {
                        if (paraType == "ADD_PRINT_SETUP_BKIMG") {
                            itm += ("\'<img border=\"0\" src=\"" + printNode["paraCode" + j] + "\">\'");
                        } else if(paraType == "ADD_PRINT_IMAGE") {
                            if (j==5) {
                                //itm += ("\'<img border=\"0\" src=\"" + printNode["paraCode" + j] + "\">\'");
                                itm += ("\'" + "URL:" + host_url + printNode["paraCode" + j] + "\'");
                            } else {
                                itm += ("\'" + printNode["paraCode" + j] + "\'");
                            }
                        }
                        else {
                            itm += ("\'" + printNode["paraCode" + j] + "\'");
                        }
                        if (j < parseInt(paraNum))
                        {
                            itm += ",";
                        }
                    }
                }
                itm += ");";
                printStr += itm + " ";
            }
        } else {
            // 多页方式
            var pageCnt = printData[printData.length-1].pageNum;
            for (var i = 0; i < pageCnt; i++) {
                for (var k = 0; k < printData.length; k++) {
                    var printNode = printData[k];
                    var paraType = printNode.paraType;
                    var pageNum = printNode.pageNum;
                    var paraName = printNode.paraName;
                    var paraNum = printNode.paraNum;
                    if (cur != null) {
                        if(pageNum == cur) {
                            var itm = "LODOP." + paraType + "(";
                            if (parseInt(paraNum) > 0)
                            {
                                for (var j = 1; j <= parseInt(paraNum); j++)
                                {
                                    if (paraType == "ADD_PRINT_SETUP_BKIMG") {
                                        itm += ("\'<img border=\"0\" src=\"" + printNode["paraCode" + j] + "\">\'");
                                    } else if(paraType == "ADD_PRINT_IMAGE") {
                                        if (j==5) {
                                            //itm += ("\'<img border=\"0\" src=\"" + printNode["paraCode" + j] + "\">\'");
                                            itm += ("\'" + "URL:"+ host_url + printNode["paraCode" + j] + "\'");
                                        } else {
                                            itm += ("\'" + printNode["paraCode" + j] + "\'");
                                        }
                                    }
                                    else {
                                        itm += ("\'" + printNode["paraCode" + j] + "\'");
                                    }
                                    if (j < parseInt(paraNum))
                                    {
                                        itm += ",";
                                    }
                                }
                            }
                            itm += ");";
                            printStr += itm + " ";
                        }
                    } else {
                        if (i+1 == pageNum) {
                            var itm = "LODOP." + paraType + "(";
                            if (parseInt(paraNum) > 0)
                            {
                                for (var j = 1; j <= parseInt(paraNum); j++)
                                {
                                    if (paraType == "ADD_PRINT_SETUP_BKIMG") {
                                        itm += ("\'<img border=\"0\" src=\"" + printNode["paraCode" + j] + "\">\'");
                                    }else if(paraType == "ADD_PRINT_IMAGE") {
                                        if (j==5) {
                                            //itm += ("\'<img border=\"0\" src=\"" + printNode["paraCode" + j] + "\">\'");
                                            itm += ("\'" + "URL:" + host_url + printNode["paraCode" + j] + "\'");
                                        } else {
                                            itm += ("\'" + printNode["paraCode" + j] + "\'");
                                        }
                                    }
                                    else {
                                        itm += ("\'" + printNode["paraCode" + j] + "\'");
                                    }
                                    if (j < parseInt(paraNum))
                                    {
                                        itm += ",";
                                    }
                                }
                            }
                            itm += ");";
                            printStr += itm + " ";
                        }
                    }
                }
                if (i + 1 != pageCnt) {
                    printStr += "LODOP.NewPage();"; //换页
                }
            }
        }
        eval(printStr);
        setTimeout(function() {}, 5);
        return true;
    };
    function disableBtn(id, flag) {
        if (flag) {
            $("#" + id + "Btn").attr("src","/nmjzs/static/print/images/" + id + "-disabled.gif");
            $("#" + id + "Btn").attr("disabled",true);
        }
        else {
            $("#" + id + "Btn").attr("src", "/nmjzs/static/print/images/" + id + ".gif");
            $("#" + id + "Btn").attr("disabled",false);
        }
    };
    function disableAllBtn(id, flag) {
        if (id == null && id.length == 0) return;
        for (var i = 0; i < id.length; i++) {
            disableBtn(id[i], flag);
        }
    };
    function OpenPreview() {
        //LODOP.SET_PRINT_PAGESIZE(1,4196,2850,"CreateCustomPage");
        LODOP.SET_PRINT_MODE("PRINT_PAGE_PERCENT", "Full-Page"); //按整页缩放
        LODOP.SET_SHOW_MODE("HIDE_PAPER_BOARD", true); //隐藏走纸板
        LODOP.SET_PREVIEW_WINDOW(0, 3, 0, 0, 0, ""); //隐藏工具条，设置适高显示
        LODOP.SET_SHOW_MODE("PREVIEW_IN_BROWSE", true); //预览界面内嵌到页面内
        LODOP.PREVIEW();
    };
    function getCountFind(str, find) //统计str中find出现次数
    {
        var reg = new RegExp(find, "g");//建立了一个正则表达式
        var count = str.match(reg); //match则匹配返回的字符串,这是很正规的做法
        return count ? count.length : 0;
    }

    function printFunc(obj) {
        var id = obj;
        if (id == "close")   //关闭
        {
            return function(){window.close();};
        }
        if (id == "high")   //适高
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_ZOOM_HIGHT", 0);
                disableBtn(id, true);
                disableAllBtn(["normal", "wide"], false);
                curPercent = -2;
            }

        }
        else if (id == "normal")   //正常
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_ZOOM_NORMAL", 0);
                disableBtn(id, true);
                disableAllBtn(["high", "wide"], false);
                curPercent = 0;
            }

        }
        else if (id == "wide")   //适宽
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_ZOOM_WIDTH", 0);
                disableBtn(id, true);
                disableAllBtn(["high", "normal"], false);
                curPercent = 1;
            }

        }
        else if (id == "small")   //变小
        {
            return function(){
                if (curPercent > -3) {
                    curPercent--;
                    LODOP.DO_ACTION("PREVIEW_ZOOM_OUT", 0);
                    if (curPercent == -2) {
                        disableBtn("high", true);
                        disableAllBtn(["normal", "wide"], false);
                    }
                    else if (curPercent == 0) {
                        disableBtn("normal", true);
                        disableAllBtn(["high", "wide"], false);
                    }
                    else if (curPercent == 1) {
                        disableBtn("wide", true);
                        disableAllBtn(["normal", "high"], false);
                    }
                    else {
                        disableAllBtn(["high", "normal", "wide"], false);
                    }
                }
            }

        }
        else if (id == "big")   //变大
        {
            return function(){
                if (curPercent < 5) {
                    LODOP.DO_ACTION("PREVIEW_ZOOM_IN", 0);
                    curPercent++;
                    if (curPercent == -2) {
                        disableBtn("high", true);
                        disableAllBtn(["normal", "wide"], false);
                    }
                    else if (curPercent == 0) {
                        disableBtn("normal", true);
                        disableAllBtn(["high", "wide"], false);
                    }
                    else if (curPercent == 1) {
                        disableBtn("wide", true);
                        disableAllBtn(["normal", "high"], false);
                    }
                    else {
                        disableAllBtn(["high", "normal", "wide"], false);
                    }
                }
            }

        }
        else if (id == "percent")   //百分比
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_ZOOM_NORMAL", 0);
                LODOP.DO_ACTION("PREVIEW_PERCENT", document.getElementById(id + "Sel").value);
                current = 1;
                disableAllBtn(["first", "prev"], true);
                if (printNum > 1) {
                    disableAllBtn(["next", "last"], false);
                }
                document.getElementById("pageSel").value = current;
            }

        }
        else if (id == "first")   //首页
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_GOFIRST", 0);
                current = 1;
                disableAllBtn(["first", "prev"], true);
                if (printNum > 1) {
                    disableAllBtn(["next", "last"], false);
                }
                document.getElementById("pageSel").value = current;
            }

        }
        else if (id == "prev")   //前一页
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_GOPRIOR", 0);
                current--;
                if (current == 1) {
                    disableAllBtn(["first", "prev"], true);
                }
                if (printNum > 1) {
                    disableAllBtn(["next", "last"], false);
                }
                document.getElementById("pageSel").value = current;
            }

        }
        else if (id == "next")   //下一页
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_GONEXT", 0);
                current++;
                if (current == printNum) {
                    disableAllBtn(["next", "last"], true);
                }
                if (printNum > 1) {
                    disableAllBtn(["first", "prev"], false);
                }
                document.getElementById("pageSel").value = current;
            }

        }
        else if (id == "last")   //最后一页
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_GOLAST", 0);
                current = printNum;
                disableAllBtn(["next", "last"], true);
                if (printNum > 1) {
                    disableAllBtn(["first", "prev"], false);
                }
                document.getElementById("pageSel").value = current;
            }

        }
        else if (id == "page")   //跳转
        {
            return function(){
                LODOP.DO_ACTION("PREVIEW_GOTO", document.getElementById(id + "Sel").value);
                current = document.getElementById(id + "Sel").value;
                disableAllBtn(["first", "prev", "next", "last"], false);
                if (current == 1) {
                    disableAllBtn(["first", "prev"], true);
                }
                else if (current == printNum) {
                    disableAllBtn(["next", "last"], true);
                }
            }

        }
        else if (id == "set")   //设置
        {
            return function(){
                if (CreatePrintPage(current)) {
                    LODOP.PRINT_SETUP();
                }
            }

        }
        else if (id == "preview")   //打印预览
        {
            return function(){
                if (CreatePrintPage()) {
                    LODOP.PREVIEW();
                }
            }

        }
        else if (id == "printAt")   //直接打印
        {
            return function(){
                if (CreatePrintPage()) {
                    document.getElementById('print_status').value =  LODOP.PRINT();
                    if ($("#print_status").val() == "true") {
                        $.post("/nmjzs/a/print/finish?soid=" + $("#soid").val(), function(data) {
                            if (data == "sucess") {
                                // 更新证书状态成功
                            }
                        });
                    }
                }
            }
        }
        else if (id == "printSet")   //打印机设置
        {
            return function(){
                if (CreatePrintPage()) {
                    document.getElementById('print_status').value = LODOP.PRINTA();
                    if ($("#print_status").val() == "true") {
                        $.post("/nmjzs/a/print/finish?soid=" + $("#soid").val(), function(data) {
                            if (data == "sucess") {
                                // 更新证书状态成功
                            }
                        });
                    }
                }
            }
        }
    }
})();