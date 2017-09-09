<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.jy.model.UserBase" %>
<%--<jsp:directive.page import="com.wy.form.ManagerForm"/>--%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
</head>
<script>
function quit() {
window.location.href="/jsp/loginOut.jsp";
}

</script>
<%

    UserBase user=null;
    String userType="";
    if(session.getAttribute("currentUser")==null){
        out.print("<script language=javascript>alert('请登录！');window.location.href='/jsp/userLogin.jsp';</script>");
    }else {
        user = (UserBase) session.getAttribute("currentUser");
        switch (user.getUserType()){
            case 1:userType="毕业生";break;
            case 2:userType="企业";break;
            case 3:userType="管理员";break;
        }
    }
%>
<body>
      <table width="100" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/static/images/top2.jpg" width="801" height="107"></td>
        </tr>
      </table>  
<table width="801" height="34" border="0" cellpadding="0" cellspacing="0" background="/static/images/top3.jpg">
        <tr>
          <td width="532" align="left" valign="top">
		  <table width="224" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
              <td width="206" height="30" valign="bottom" align="left"><font color="#00008b" size="1px">&nbsp;&nbsp;&nbsp;&nbsp;欢迎<%=userType%>&nbsp;:&nbsp;<%=user.getUserName()%></font></td>
              <td width="10">&nbsp;</td>
            </tr>
          </table>         
	      </td>
            <td width="88"><a href="/jsp/editUser.jsp"  ><img src="/static/images/top-11.jpg" name="Image1" width="85" height="34" border="0" id="Image1"></a></td>
            <td width="88"><a href="/jsp/mainPage.jsp"  ><img src="/static/images/top-22.jpg" name="Image2" width="85" height="34" border="0" id="Image2"></a></td>
            <td width="93"><a href="/jsp/loginOut.jsp" ><img src="/static/images/top-33.jpg" name="Image3" width="85" height="34" border="0" id="Image3"></a></td>
        </tr>
      </table>
	  </body>
</html>
