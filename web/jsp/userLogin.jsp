<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>用户登录</title>
</head>
<link href="/static/css/css.css" rel="stylesheet" type="text/css">
<script language="javascript">

    var code ; //在全局 定义验证码
    window.onload=function createCode(){
        code = "";
        var codeLength = 4;//验证码的长度
        var checkCode = document.getElementById("checkCode");
        var selectChar = new Array(1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','j','k','l','m','n','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');

        for(var i=0;i<codeLength;i++) {
            var charIndex = Math.floor(Math.random()*60);
            code +=selectChar[charIndex];
        }
        if(code.length != codeLength){
            createCode();
        }
        checkCode.value = code;
    }
    function createCode1(){
        code = "";
        var codeLength = 4;//验证码的长度
        var checkCode = document.getElementById("checkCode");
        var selectChar = new Array(1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','j','k','l','m','n','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');

        for(var i=0;i<codeLength;i++) {
            var charIndex = Math.floor(Math.random()*60);
            code +=selectChar[charIndex];
        }
        if(code.length != codeLength){
            createCode();
        }
        checkCode.value = code;
    }


    function validate () {
        var inputCode = document.getElementById("input1").value.toUpperCase();
        var codeToUp=code.toUpperCase();
        if(inputCode.length <=0) {
            alert("请输入验证码！");
            return false;
        }
        else if(inputCode != codeToUp ){
            alert("验证码输入错误！");
            return false;
        }
        else {
            return true;
        }

    }
    function beforeSubmit(form){

        if(form.userName.value==''){
            alert('用户名不能为空！');
            form.userName.focus();
            return false;
        }
        if(form.pwd.value==''){
            alert('用户名不能为空！');
            form.pwd.focus();
            return false;
        }
        if(form.userType.value==0){
            alert('请选择用户类型！');
            form.pwd.focus();
            return false;
        }


        //校验验证码
        var inputCode = form.input1.value.toUpperCase();
        var codeToUp=code.toUpperCase();
        if(inputCode.length <=0) {
            alert("请输入验证码！");
            return false;
        } else if(inputCode != codeToUp ){
            alert("验证码输入错误！");
            document.getElementById("input1").value="";
            return false;
        }
        else {
            return true;
        }
    }

</script>
<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>


            <form name="form" method="post" action="/userBaseServlet.do?action=0" onSubmit="return beforeSubmit(this)">
                <table width="801" height="757" border="0" align="center" cellpadding="0" cellspacing="0" background="/static/images/login.jpg">
                    <tr>
                        <td width="50%">&nbsp;</td>
                        <td width="50%" valign="middle">
                            <h1>
                                请登录！！！
                            </h1>
                            <table width="350" border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#808080">
                                <tr>
                                    <th width="35%" height="35"><span class="word_white">账&nbsp;&nbsp;号：</span></th>
                                    <td width="65%" bgcolor="#FFFFFF"><input id="userName" name="userName" type="text" size="27" style="height: 30px"></td>
                                </tr>
                                <tr>
                                    <th height="35"><span class="word_white">密&nbsp;&nbsp码：</span></th>
                                    <td bgcolor="#FFFFFF"><input id="pwd" name="pwd" type="password" size="27" style="height: 30px"></td>
                                </tr>
                                <tr>
                                    <th height="35"><span class="word_white">验证码：</span></th>
                                    <td bgcolor="#FFFFFF"><input type="text" id="input1" name="input1" size="5" style="height: 30px"/>
                                        <input type="text" id="checkCode"  style="width: 45px;height: 30px;background-color: #666666" onclick="createCode()"/> <a href="#" onclick="createCode1()">看不清楚</a>
                                    </td>
                                </tr>
                                <tr>
                                    <th height="35"><span class="word_white">用户类型：</span></th>
                                    <td bgcolor="#FFFFFF" align="center"><select name="userType">
                                        <option value="0">---请选择用户类型--</option>
                                        <option value="1">------毕业生------</option>
                                        <option value="2">-------企业-------</option>
                                        <option value="3">------管理员------</option>
                                    </select>
                                    </td>
                                </tr>
                            </table>
                            <br>
                            <div align="center">
                            &nbsp;&nbsp;&nbsp;&nbsp;<input type="image"  src="/static/images/1.png" width="51" height="20">

                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/jsp/enterprise/enterpriseRegister.jsp"><font color="#ff7f50">企业注册中心</font></a></div></td>
                            </td>
                    </tr>
                </table>

            </form>
        </td>
    </tr>
</table>





</body>
</html>
