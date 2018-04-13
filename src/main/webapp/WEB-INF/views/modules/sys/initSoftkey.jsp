<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>加密狗设置</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <style type="text/css">
        #head {
            margin-top: 20px;
            margin-bottom: 50px;
            text-align: center;
            font-family: '微软雅黑';
            font-size: 30px;
        }
    </style>
</head>
<body bgcolor="#ffffff">
<embed id="s_simnew31" type="application/npsyunew3-plugin" hidden="true"></embed>
<!--创建firefox,chrome等插件-->
<SCRIPT LANGUAGE=javascript>

    var digitArray = new Array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');

    function toHex(n) {

        var result = ''
        var start = true;

        for (var i = 32; i > 0;) {
            i -= 4;
            var digit = ( n >> i ) & 0xf;

            if (!start || digit != 0) {
                start = false;
                result += digitArray[digit];
            }
        }

        return ( result == '' ? '0' : result );
    }

    function login_onclick() {
        var DevicePath, ret, n, mylen;
        try {
            //建立操作我们的锁的控件对象，用于操作我们的锁
            var s_simnew31;
            //创建插件或控件
            if (navigator.userAgent.indexOf("MSIE") > 0 && !navigator.userAgent.indexOf("opera") > -1) {
                s_simnew31 = new ActiveXObject("Syunew3A.s_simnew3");
            }
            else {
                s_simnew31 = document.getElementById('s_simnew31');
            }

            //查找是否存在锁,这里使用了FindPort函数
            DevicePath = s_simnew31.FindPort(0);
            if (s_simnew31.LastError != 0) {
                $.jBox.error("未发现加密锁，请插入加密锁。");
                window.location.href = "err.html";
                return;
            }

            //'读取锁的ID
            frmlogin.KeyID.value = toHex(s_simnew31.GetID_1(DevicePath)) + toHex(s_simnew31.GetID_2(DevicePath));
            if (s_simnew31.LastError != 0) {
                $.jBox.error("Err to GetID,ErrCode is:" + s_simnew31.LastError.toString());
                return;
            }

            //获取设置在锁中的用户名
            //先从地址0读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
            ret = s_simnew31.YReadEx(0, 1, "ffffffff", "ffffffff", DevicePath);
            mylen = s_simnew31.GetBuf(0);
            //再从地址1读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
            frmlogin.UserName.value = s_simnew31.YReadString(1, mylen, "ffffffff", "ffffffff", DevicePath);
            if (s_simnew31.LastError != 0) {
                $.jBox.error("获取用户名错误,错误码是:" + s_simnew31.LastError.toString());
                return;
            }

            //获到设置在锁中的用户密码,
            //先从地址20读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
            ret = s_simnew31.YReadEx(20, 1, "ffffffff", "ffffffff", DevicePath);
            mylen = s_simnew31.GetBuf(0);
            //再从地址21读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
            frmlogin.Password.value = s_simnew31.YReadString(21, mylen, "ffffffff", "ffffffff", DevicePath);
            if (s_simnew31.LastError != 0) {
                $.jBox.error("获取用户密码错误,错误码是:" + s_simnew31.LastError.toString());
                return;
            }

        }
        catch (e) {
            $.jBox.error(e.name + ": " + e.message + "。可能是没有安装相应的控件或插件");
        }
    }

    function button1_onclick() {
        try {
            var DevicePath, mylen, ret;
            //建立操作我们的锁的控件对象，用于操作我们的锁
            var s_simnew31;
            //创建插件或控件
            if (navigator.userAgent.indexOf("MSIE") > 0 && !navigator.userAgent.indexOf("opera") > -1) {
                s_simnew31 = new ActiveXObject("Syunew3A.s_simnew3");
            }
            else {
                s_simnew31 = document.getElementById("s_simnew31");
            }
            //查找是否存在锁,这里使用了FindPort函数
            DevicePath = s_simnew31.FindPort(0);
            if (s_simnew31.LastError != 0) {
                $.jBox.error("未发现加密锁，请插入加密锁");
            }
            else {
                if (frmlogin.UserName.value == "" || frmlogin.Password.value == "") {
                    $.jBox.error("请输入用户名密码后再进行操作。");
                    return 0;
                }
                //写入用户名到地址1，使用默认的写密码"FFFFFFFF","FFFFFFFF"
                mylen = s_simnew31.YWriteString(frmlogin.UserName.value, 1, "ffffffff", "ffffffff", DevicePath);
                if (s_simnew31.LastError != 0) {
                    $.jBox.error("写入用户名失败。错误码是：" + s_simnew31.LastError.toString());
                    return 0;
                }
                s_simnew31.SetBuf(mylen, 0);
                //写入用户名的字符串长度到地址0，使用默认的写密码"FFFFFFFF","FFFFFFFF"
                ret = s_simnew31.YWriteEx(0, 1, "ffffffff", "ffffffff", DevicePath);
                if (ret != 0) {
                    $.jBox.error("写入用户名长度失败。错误码是：" + s_simnew31.LastError.toString());
                    return 0;
                }

                //写入用户密码到地址21，使用默认的写密码"FFFFFFFF","FFFFFFFF"
                mylen = s_simnew31.YWriteString(frmlogin.Password.value, 21, "ffffffff", "ffffffff", DevicePath);
                if (s_simnew31.LastError != 0) {
                    $.jBox.error("写入用户密码失败。错误码是：" + s_simnew31.LastError.toString());
                    return 0;
                }
                s_simnew31.SetBuf(mylen, 0);
                //写入用户名密码的字符串长度到地址20，使用默认的写密码"FFFFFFFF","FFFFFFFF"
                ret = s_simnew31.YWriteEx(20, 1, "ffffffff", "ffffffff", DevicePath);
                if (ret != 0) {
                    $.jBox.error("写入用户密码长度失败。错误码是：" + s_simnew31.LastError.toString());
                    return 0;
                }
                $.jBox.success("写入成功");
            }
        }
        catch (e) {
            $.jBox.error(e.name + ": " + e.message);
            return false;
        }
    }

    function button2_onclick() {
        try {
            var DevicePath, mylen, ret;
            //建立操作我们的锁的控件对象，用于操作我们的锁
            var s_simnew31;
            //创建插件或控件
            if (navigator.userAgent.indexOf("MSIE") > 0 && !navigator.userAgent.indexOf("opera") > -1) {
                s_simnew31 = new ActiveXObject("Syunew3A.s_simnew3");
            }
            else {
                s_simnew31 = document.getElementById("s_simnew31");
            }
            DevicePath = s_simnew31.FindPort(0);
            if (s_simnew31.LastError != 0) {
                $.jBox.error("未发现加密锁，请插入加密锁");
                return false;
            }
            else {
                ret = s_simnew31.SetWritePassword(frmlogin.w_hkey.value, frmlogin.w_lkey.value, frmlogin.new_w_hkey.value, frmlogin.new_w_lkey.value, DevicePath);
                if (ret != 0) {
                    $.jBox.error("设置写密码错误");
                    return 0;
                }
                $.jBox.success("设置写密码成功");
            }
        }
        catch (e) {
            $.jBox.error(e.name + ": " + e.message);
            return false;
        }
    }

    function button3_onclick() {
        try {
            var DevicePath, mylen, ret;
            //建立操作我们的锁的控件对象，用于操作我们的锁
            var s_simnew31;
            //创建插件或控件
            if (navigator.userAgent.indexOf("MSIE") > 0 && !navigator.userAgent.indexOf("opera") > -1) {
                s_simnew31 = new ActiveXObject("Syunew3A.s_simnew3");
            }
            else {
                s_simnew31 = document.getElementById("s_simnew31");
            }
            DevicePath = s_simnew31.FindPort(0);
            if (s_simnew31.LastError != 0) {
                $.jBox.error("未发现加密锁，请插入加密锁");
                return false;
            }
            else {
                ret = s_simnew31.SetReadPassword(frmlogin.w_hkey_2.value, frmlogin.w_lkey_2.value, frmlogin.r_hkey.value, frmlogin.r_lkey.value, DevicePath);
                if (ret != 0) {
                    $.jBox.error("设置读密码错误");
                    return false;
                }
                $.jBox.success("设置读密码成功");
            }
        }
        catch (err) {
            txt = "错误,原因是" + err.description + "\n\n";
            txt += "请检查是否安装驱动程序";
            $.jBox.error(txt);
            return false;
        }
    }


</SCRIPT>

<div class="container">
    <div id="head">
        内蒙古自治区二级建造师网络继续教育平台
    </div>

    <form name="frmlogin" method="post" action="initSoftkey.jsp" class="form-horizontal">
        <fieldset>
            <legend>加密狗初始化设置</legend>
            <div class="control-group">
                <label class="control-label">请输入登录名:</label>

                <div class="controls">
                    <input name="UserName" type="text" id="UserName" class="required userName"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">请输入登录密码:</label>

                <div class="controls">
                    <input name="Password" type="password" id="Password" class="required"/>
                </div>
            </div>
            <input name="KeyID" type="text" id="KeyID" style="VISIBILITY: hidden">

            <div class="form-actions">
                <input type="button" name="button1" value="写入用户名及密码" onClick="button1_onclick()"
                       class="btn btn-primary"/> <input id="btnCancel" class="btn" type="button" value="返 回"
                                                        onclick="history.go(-1)"/>
            </div>
            <div style="display: none;">
                <legend>设置写密码：</legend>

                <p>原写密码：
                    <input name="w_hkey" type="text" id="w_hkey" value="ffffffff">
                    --
                    <input name="w_lkey" type="text" id="w_lkey" value="ffffffff">
                </p>

                <p>新写密码：
                    <input name="new_w_hkey" type="text" id="new_w_hkey" value="ffffffff">
                    --
                    <input name="new_w_lkey" type="text" id="new_w_lkey" value="ffffffff">
                </p>

                <p>
                    <input type="button" name="button2" value="设置" onClick="button2_onclick()" class="btn btn-primary"/>
                </p>

                <legend>设置读密码：</legend>
                <p>写密码：
                    <input name="w_hkey_2" type="text" id="w_hkey_2" value="ffffffff">
                    --
                    <input name="w_lkey_2" type="text" id="w_lkey_2" value="ffffffff">
                </p>

                <p>新的读密码：
                    <input name="r_hkey" type="text" id="r_hkey" value="ffffffff">
                    --
                    <input name="r_lkey" type="text" id="r_lkey" value="ffffffff">
                </p>

                <p>
                    <input type="button" name="button3" value="设置" onClick="button3_onclick()" class="btn btn-primary"/>
                </p>

                <p>注意设置读密码是用“写”密码设置</p>
            </div>
        </fieldset>
    </form>
</div>
</body>
</html>

