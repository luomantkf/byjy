<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jy.model.Enterprise" %>
<%@ page import="com.jy.model.JobVo" %>
<%@ page import="com.jy.util.DateUtil" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看招聘情况</title>
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
            <form name="form" method="post" action="/jobServlet.do?action=1&type=2">
            <table width="575" height="25" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="2"><div align="center">
                  <h2 style="background-color: burlywood">
                  查看招聘情况
                  </h2>
                </div>
                </td>
              </tr>
                <tr>

                <td width="20%"><div align="center"><font color="#d2691e" size="4">职位搜索:</font></div></td>
                <td width="80%" align="left"><div><input type="text" size="30" name="condition">&nbsp;&nbsp;&nbsp;<input type="submit" value="搜索"></div></td>
              </tr>
            </table>
              </form>
            <br>

            <table width="90%"  align="center" border="1" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC">
              <tr>
                <td width="13%" height="25"><div align="center">数据编号</div></td>
                <td width="14%"><div align="center">职位名</div></td>
                <td width="19%"><div align="center">截止日期</div></td>
                <td width="17%"><div align="center">审核状态</div></td>
                <td width="17%"><div align="center">投简历人</div></td>
                <td width="24%"><div align="center">操作</div></td>
              </tr>
              <%for(int i=0;i<list.size();i++){
                JobVo jobVo=(JobVo)list.get(i);

              %>
              <tr bgcolor="#FFFFFF">
                <td height="30"><div align="center"><%=number*6+i+1%></div></td>
                <td><div align="center"><%=jobVo.getJobName()%></div></td>
                <td><div align="center"><%=DateUtil.formatDate(DateUtil.formatString(jobVo.getJobEndTime(), "yyyy-MM-dd"), "yyyy-MM-dd")%></div></td>

                <td><div align="center"><%=jobVo.getStatus()==1?"已通过":"未审核"%></div></td>
                <td><div align="center"><a href="/applyResumeServlet.do?action=1&jobId=<%=jobVo.getJobId()%>">查看</a></div></td>
                <td><div align="center"><a href="/jobServlet.do?action=2&jobId=<%=jobVo.getJobId()%>&type=2">明细</a>|<a href="/jobServlet.do?action=6&jobId=<%=jobVo.getJobId()%>">删除</a></div></td>

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

                  <a href="/jobServlet.do?action=1&number=<%=number-1%>">
                    上一页</a></td>
                <%}%>
                <td width="18%"><%if(maxPage<=(number+1)){%>
                  下一页
                    <%}else{%>

                  <a href="/jobServlet.do?action=1&number=<%=number+1%>">下一页</a>
                    <%}%>


                <td width="20%"> &nbsp;&nbsp;&nbsp;
                 </td>

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
