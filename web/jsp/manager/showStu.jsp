<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.jy.model.UserBase" %>
<%@ page import="com.jy.model.Student" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>毕业生的具体信息</title>
<link type="text/css" rel="stylesheet" href="/static/css/style.css">
  <%
    UserBase user=null;
    if(session.getAttribute("currentUser")!=null){
      user=(UserBase)session.getAttribute("currentUser");
    }
    Student student=(Student)request.getAttribute("student");
  %>
</head>

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

          <td height="243"valign="top" align="center">
            <form name="form" method="post" action="/jobServlet.do?action=0" onSubmit="return checkAction(this)">
              <table width="575" height="25" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td><div align="center">
                    <h2 style="background-color: burlywood">
                        毕业生的具体信息
                    </h2>
                  </div>
                  </td>
                </tr>
              </table>
              <table width="355" border="1" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC">

                <tbody>
                <tr>
                  <th width="99" height="30"><span>姓名：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" name="stuName" size="40" value="${student.stuName}" readonly="true"></td>
                </tr>
                <tr>
                  <th width="99" height="30"><span>学号：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" name="stuID" size="40" value="${student.stuID}" readonly="true"></td>
                </tr>
                <tr>
                  <th width="99" height="30"><span>学院：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" name="stuID" size="40" value="${student.academy}" readonly="true"></td>
                </tr>
                <tr>
                  <th width="99" height="30"><span>专业：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" name="stuID" size="40" value="${student.profession}" readonly="true"></td>
                </tr>
                <tr>
                  <th width="99" height="30"><span>性别：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" value="<%=student.getSex()==1?'男':'女'%>" size="40" readonly="true"></td>
                </tr>
                <tr>
                  <th width="99" height="30"><span>身份证：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" name="idCard" size="40" value="${student.idCard}" readonly="true"></td>
                </tr>
                <tr>
                  <th height="30"><span>学历：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="education" size="40" value="${student.education}" readonly="true"></td>
                </tr>
                <tr>
                  <th height="30"><span>毕业去向：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="workWhere" size="40" value="<%=student.getWorkWhere()==null?"未就业":student.getWorkWhere()%>" readonly="true"></td>
                </tr>
                <tr>
                  <th width="99" height="30"><span>求助意向：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" name="stuID" size="40" value="${student.intention}" readonly="true"></td>
                </tr>
                <tr>
                  <th width="99" height="30"><span>职位名称：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" name="stuID" size="40" value="<%=student.getPositionName()==null?"无":student.getPositionName()%>" readonly="true"></td>
                </tr>
                <tr>
                  <th height="30"><span>联系方式：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="phone" size="40" value="${student.phone}" readonly="true"></td>
                </tr>
                </tbody></table>
                  <br>
                  <div align="center">
                  &nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <a href="#" onClick="javasrcipt:history.go(-1)">返回</a>
                    </div>
              </form>
          </td>
        </tr>
      </table>
	  <%--<jsp:include page="down.jsp" flush="true" />--%>
    </td>
  </tr>
</table>

</body>
</html>
