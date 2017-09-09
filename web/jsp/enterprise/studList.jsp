<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jy.model.Manager" %>
<%@ page import="com.jy.model.Student" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>学生信息查看</title>
<link type="text/css" rel="stylesheet" href="/static/css/style.css">
</head>
<%
  List list=(List)request.getAttribute("list");
  int number=Integer.parseInt((String)request.getAttribute("number"));
  int maxPage=Integer.parseInt((String)request.getAttribute("maxPage"));
  int pageNumber=Integer.parseInt((String)request.getAttribute("pageNumber"));
%>
<body>
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
    
      <jsp:include page="../top.jsp" flush="true" />
      <table width="801" height="436" border="1" cellpadding="0" cellspacing="0" style="margin-top: 8px"   class="bg">
        <tr>
          <td>
            <jsp:include page="../left.jsp" flush="true" />
          </td>
          <td height="243" valign="top">
            <table width="575" height="25" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><div align="center">
                  <h2 style="background-color: burlywood">
                    学生信息查询
                  </h2>
                </div>
                </td>
              </tr>
              <tr>
                <td>
                  <form name="form" method="post" action="/studentServlet.do?action=1&ctype=1">
                  <table>
                    <tr height="33.3%"></tr>
                    <tr height="33.3%">
                      <td width="10%"><div align="center"><font color="#d2691e">搜索:</font></div></td>
                      <td width="40%"><input type="text" size="30" name="condition"></td>
                      <td width="20%"><div align="center"><font color="#d2691e">&nbsp;&nbsp;搜索类型：</font></div></td>
                      <td width="20%"><div align="center"><select name="type">
                        <option value="3">求职意向</option>
                        <option value="2">学院</option>
                        <option value="4">专业</option>
                      </select></div></td>
                      <td width="10%"><input type="submit" value="搜索"></td>
                    </tr>
                    <tr height="33.3%"></tr>
                  </table>
                    </form>
                </td>
              </tr>
            </table>
            <br>

            <table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC">
              <tr>
                <td width="12%" height="25"><div align="center">数据编号</div></td>
                <td width="12%"><div align="center">姓名</div></td>
                <td width="12%"><div align="center">学院</div></td>
                <td width="12%"><div align="center">专业</div></td>
                <td width="14%"><div align="center">求职意向</div></td>
                <td width="12%"><div align="center">操作</div></td>
              </tr>
              <%for(int i=0;i<list.size();i++){
                Student student=(Student)list.get(i);

              %>
              <tr bgcolor="#FFFFFF">
                <td height="30"><div align="center"><%=number*6+i+1%></div></td>

                <td><div align="center"><%=student.getStuName()%></div></td>

                <td><div align="center"><%=student.getAcademy()%></div></td>
                <td><div align="center"><%=student.getProfession()%></div></td>
                <td><div align="center"><%=student.getIntention()%></div></td>
                <td><div align="center">
                  <a href="resumeServlet.do?action=0&userId=<%=student.getUserId()%>">简历查看</a>

                </div></td>
                <%}%>  </tr>
            </table>
            <br>
            <table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
              <tr align="center">
                <td width="13%">共为<%=maxPage%>页</td>
                <td width="16%">共有<%=pageNumber%>条记录</td>
                <td width="14%">当前为第<%=number+1%>页</td>
                <td width="19%"><%if((number+1)==1){%>
                  上一页
                  <%}else{%>

                  <a href="/studentServlet.do?action=1&ctype=1&number=<%=number-1%>">
                    上一页</a></td>
                <%}%>
                <td width="18%"><%if(maxPage<=(number+1)){%>
                  下一页
                    <%}else{%>

                  <a href="/studentServlet.do?action=1&ctype=1&number=<%=number+1%>">下一页</a>
                    <%}%>

              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
