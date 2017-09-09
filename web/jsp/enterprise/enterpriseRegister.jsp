<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>欢迎企业注册！</title>
</head>
<link href="/static/css/css.css" rel="stylesheet" type="text/css">
<script language="javascript">
    function clearPwd() {
        var pwd1=document.getElementById("pwd1").value;
        var pwd2=document.getElementById("pwd2").value;
        if (pwd1.length>0||pwd2.length>0)
        {
            document.getElementById("pwd1").value="";
            document.getElementById("pwd2").value="";
        }
    }
    function checkAction() {
        if (document.form.userName.value == "") {
            window.alert("请输入账号");
            document.form.userName.focus();
            return false;
        }
        if (document.form.pwd1.value == "") {
            window.alert("请输入密码");
            document.form.pwd1.focus();
            return false;
        }
        if (document.form.pwd2.value == "") {
            window.alert("请输入密码");
            document.form.pwd2.focus();
            return false;
        }
        if(document.form.pwd1.value!=document.form.pwd2.value) {

            alert('你两次输入的密码不一致，请重新输入！');
            document.getElementById("pwd1").value="";
            document.getElementById("pwd2").value="";
            return false;
        }
        if (document.form.userType.value == "") {
            window.alert("请选择用户类型");
            document.form.userType.focus();
            return false;
        }
    }

</script>
<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <form name="form" method="post" action="/enterpriseServlet.do?action=0" onSubmit="return checkAction()">
                <table width="801" height="757" border="0" align="center" cellpadding="0" cellspacing="0" background="/static/images/login.jpg">
                    <tr>
                        <td width="50%">&nbsp;</td>
                        <td width="50%" valign="middle">
                            <h1>
                                欢迎企业注册！
                            </h1>
                            <table width="350" border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#808080">
                                <tr>
                                    <th width="35%" height="30"><span class="word_white">账&nbsp;&nbsp;号：</span></th>
                                    <td width="65%" bgcolor="#FFFFFF"><input id="userName" name="userName" type="text" size="27"></td>
                                </tr>
                                <tr>
                                    <th height="30"><span class="word_white">密&nbsp;&nbsp码：</span></th>
                                    <td bgcolor="#FFFFFF"><input id="pwd1" name="pwd1" type="password" size="27"></td>
                                </tr>
                                <tr>
                                    <th height="30"><span class="word_white">确认密码：</span></th>
                                    <td bgcolor="#FFFFFF"><input id="pwd2" name="pwd2" type="password" size="27"></td>
                                </tr>
                                <tr>
                                    <td>
                                </tr>
                            </table>
                            <br>
                            &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"   value="提交" width="51" height="20">
                            &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="重置" onclick="clearPwd()">&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="#" onClick="javasrcipt:history.go(-1)">返回</a></td>
                    </tr>
                </table>

            </form>
        </td>
    </tr>
</table>





</body>
</html>
