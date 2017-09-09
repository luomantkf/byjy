<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.jy.model.UserBase" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>首页</title>
<link type="text/css" rel="stylesheet" href="/static/css/style.css">
<%
  UserBase user=null;
  if(session.getAttribute("currentUser")!=null){
   user=(UserBase)session.getAttribute("currentUser");
  }%>
</head>
<body>
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
      <jsp:include page="top.jsp" flush="true" />   

<table width="801" height="436" class="bg" border="1" cellpadding="0" cellspacing="0" style="margin-top: 1px"  >
  <tr>
    <td valign="top">
      <jsp:include page="left.jsp" flush="true" />
    </td>
    <td>
      <table width="500" height="436" border="0" cellpadding="0" cellspacing="0"  style="margin-top: 8px">
        <tr>
          <td height="243"><table width="547" align="center">
            <%if(user.getUserType()==1){%>
            <tr align="center">
                <td width="261" height="100"><a href="/resumeServlet.do?action=0"><img src="/static/images/8.jpg" width="175" height="33" border="0"></a></td>
                <td width="274"><a href="/resumeServlet.do?action=2"><img src="/static/images/9.jpg" width="175" height="33" border="0"></a></td>
          </tr>
            <tr align="center">
              <td width="261" height="100"><a href="/resumeServlet.do?action=2&type=1"><img src="/static/images/11.jpg" width="175" height="33" border="0"></a></td>
              <td width="274"> &nbsp;</td>
            </tr>
            <%}%>
            <%if(user.getUserType()==2){%>
            <tr align="center">
              <td width="261" height="100"><a href="/enterpriseServlet.do?action=6"><img src="/static/images/1.jpg" width="175" height="33" border="0"></a></td>
              <td width="274"><a href="/enterpriseServlet.do?action=5&type=1"><img src="/static/images/2.jpg" width="175" height="33" border="0"></a></td>
            </tr>
            <tr align="center">
              <td width="261" height="100"><a href="/jobServlet.do?action=1&type=2"><img src="/static/images/3.jpg" width="175" height="33" border="0"></a></td>
              <td width="274"><a href="/studentServlet.do?action=1&condition=4040404&ctype=1"><img src="/static/images/10.jpg" width="175" height="33" border="0"></a></td>
            </tr>
            <%}%>
            <%if(user.getUserType()==3){%>
            <tr align="center">
              <td width="261" height="100"><a href="/managerServlet.do?action=1"><img src="/static/images/4.jpg" width="175" height="33" border="0"></a></td>
              <td width="274"><a href="/studentServlet.do?action=1&condition=4040404"><img src="/static/images/5.jpg" width="175" height="33" border="0"></a></td>
            </tr>
            <tr align="center">
              <td width="261" height="100"><a href="/enterpriseServlet.do?action=2"><img src="/static/images/6.jpg" width="175" height="33" border="0"></a></td>
              <td width="274" height="100"><a href="/jobServlet.do?action=1&type=1"><img src="/static/images/7.jpg" width="175" height="33" border="0"></a></td>
            </tr>
            <%}%>
          </table></td>
        </tr>
      </table>
      </td>
    </td>
  </tr>
  </td>
</table>
</table>

</body>
</html>
