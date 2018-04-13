var LodopTool = function (printWindowName, printMode) {
    var printWindowName = printWindowName;
    var printMode = printMode;
    var init = function () {
        // this.printWindowName = printWindowName || top.printframe;
        //(document.getElementsByTagName('body')[0]).prepend('<object id="LODOP" classid="CLSID:2105C259-1E0C-4534-8141-A753534CB4CA"	CODEBASE="lodop.cab#version=6.1.4.1" style="display:none;"></object>');
    }
    init();
}

//预览
LodopTool.prototype.preview=function(pageName,pdatas,w,h) {
    w = w||1000;
    h = h||1000;
    if(window.ActiveXObject){ //IE
        window.showModalDialog(pageName, pdatas, 'dialogWidth: '+w+'px; dialogHeight: '+h+'px; resizable: no; help: no; status: no; scroll: yes;');
    }else{  //非IE
        window.open(pageName, '_blank', 'dialogWidth: '+w+'px; dialogHeight: '+h+'px; resizable: no; help: no; status: no; scroll: yes;');
    }
}