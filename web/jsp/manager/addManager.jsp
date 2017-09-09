<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加管理员</title>
<link type="text/css" rel="stylesheet" href="/static/css/style.css">

</head>
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
      window.alert("请输入姓名");
      document.form.userName.focus();
      return false;
    }
    if (document.form.phone.value == "") {
      window.alert("联系方式");
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
  }

</script>
<body>
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
    
      <jsp:include page="../top.jsp" flush="true" />

      <table width="801" height="436" border="1" cellpadding="0" cellspacing="0" style="margin-top: 8px"   class="bg">
        <tr>
          <td valign="top">
            <jsp:include page="../left.jsp" flush="true" />
          </td>

          <td height="243" valign="top">
            <form name="form" method="post" action="/managerServlet.do?action=0" onSubmit="return checkAction()">
                  <table width="575" height="25" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><div align="center">
                        <h2 style="background-color: burlywood">
                          添加管理员
                        </h2>
                      </div>
                      </td>
                    </tr>
                  </table>
                  <table width="350" border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC">
                    <tr>
                      <th width="35%" height="30"><span>姓&nbsp;&nbsp;名：</span></th>
                      <td width="65%" bgcolor="#FFFFFF"><input id="userName" name="userName" type="text" size="27"></td>
                    </tr>
                    <tr>
                      <th height="30"><span>密&nbsp;&nbsp码：</span></th>
                      <td bgcolor="#FFFFFF"><input id="pwd1" name="pwd1" type="password" size="27"></td>
                    </tr>
                    <tr>
                      <th height="30"><span>确认密码：</span></th>
                      <td bgcolor="#FFFFFF"><input id="pwd2" name="pwd2" type="password" size="27"></td>
                    </tr>
                    <tr>
                      <th height="30"><span>联系方式：</span></th>
                      <td bgcolor="#FFFFFF"><input id="phone" name="phone" type="text" size="27"></td>
                    </tr>
                    <tr>
                      <td>
                    </tr>
                  </table>
                  <br>
                  <div align="center">
                  &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"   value="提交" width="51" height="20">
                  &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="重置" onclick="clearPwd()">&nbsp;&nbsp;&nbsp;&nbsp;
                  <a href="#" onClick="javasrcipt:history.go(-1)">返回</a>
                    </div>
              </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</body>
</html>
