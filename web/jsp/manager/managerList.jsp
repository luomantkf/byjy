<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jy.model.Manager" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理员管理</title>
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
      <table width="801" height="436" border="1" cellpadding="0" cellspacing="0" style="margin-top: 8px"    class="bg">
        <tr>
          <td>
            <jsp:include page="../left.jsp" flush="true" />
          </td>
          <td height="243" valign="top">
            <table width="575" height="25" border="0" cellpadding="0" cellspacing="0" >
              <tr>
                <td><div align="center">
                  <h2 style="background-color: burlywood">
                    管理员管理
                  </h2>
                </div></td>
              </tr>
            </table>
            <br>

            <table width="90%"  border="1" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC" align="center">
              <tr>
                <td width="14%" height="25"><div align="center">数据编号</div></td>
                <td width="19%"><div align="center">姓名</div></td>
                <td width="14%"><div align="center">联系方式</div></td>
                <td width="14%"><div align="center">创建时间</div></td>
                <td width="25%"><div align="center">操作</div></td>
              </tr>
              <%for(int i=0;i<list.size();i++){
                Manager user=(Manager)list.get(i);

              %>
              <tr bgcolor="#FFFFFF">
                <td height="30"><div align="center"><%=number*6+i+1%></div></td>
                <td><div align="center"><%=user.getUserName()%></div></td>

                <td><div align="center"><%=user.getPhone()%></div></td>

                <td><div align="center"><%=user.getCreateTime()%></div></td>
                <td><div align="center">

                  <a href="/managerServlet.do?action=3&userId=<%=user.getUserId()%>&managerId=<%=user.getDetail()%>">删除</a>

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

                  <a href="/managerServlet.do?action=1&number=<%=number-1%>">
                    上一页</a></td>
                <%}%>
                <td width="18%"><%if(maxPage<=(number+1)){%>
                  下一页
                    <%}else{%>

                  <a href="/managerServlet.do?action=1&number=<%=number+1%>">下一页</a>
                    <%}%>


                <td width="20%">
                  <div align="right">&nbsp;<a href="/jsp/manager/addManager.jsp">添加管理员</a>&nbsp;</div></td>

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
