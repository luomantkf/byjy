<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.List"%>
<%@ page import="com.jy.model.JobVo" %>
<%@ page import="com.jy.util.DateUtil" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>招聘信息查看</title>
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
                   招聘信息查看
                  </h2>
                </div>
                </td>
              </tr>
            </table>
            <table width="500"  border="1" cellpadding="0" cellspacing="0" align="center">
            <tr>
              <td width="50%" height="40" bgcolor="#cd853f">
                <div align="center">即将截止的招聘</div>
              </td>
              <td width="50%" height="40" bgcolor="#cd853f">
               <div align="center"> 最新招聘</div>
              </td>
            </tr>
              <tr>
                <td width="50%">
                  <table width="250" border="0" align="center">
                        <marquee direction="up" height="114" onmouseout="this.start()"
                                 onmouseover="this.stop()" scrollAmount="1" scrollDelay="1">
                          <%
                            List<JobVo> jobVos1=(List<JobVo>)request.getAttribute("list2");
                            for(int i=0;i<jobVos1.size();i++){
                              JobVo job=jobVos1.get(i);
                          %>
                          <font color="#ff7f50">企业：<a href="/enterpriseServlet.do?action=3&enterpriseId=<%=job.getEnterpriseId()%>&type=1" style="text-decoration: underline"><%=job.getEnterpriseName()%></a> |职位:<a href="/jobServlet.do?action=2&jobId=<%=job.getJobId()%>&type=3"><%=job.getJobName()%></a> |截止日期：<%=DateUtil.formatDate(DateUtil.formatString(job.getJobEndTime(), "yyyy-MM-dd"), "yyyy-MM-dd")%></font> <br><br><br>
                          <%}%>
                        </marquee>

                      </td>
                    </tr>
                  </table>
                </td>
                <td width="50%">
                  <table width="250" border="0" align="center">
                    <tr>
                      <td width="171" height="143">
                        <marquee direction="up" height="114" onmouseout="this.start()"
                                 onmouseover="this.stop()" scrollAmount="1" scrollDelay="1">
                          <%
                            List<JobVo> jobVos=(List<JobVo>)request.getAttribute("list1");
                            for(int i=0;i<jobVos.size();i++){
                              JobVo job=jobVos.get(i);
                          %>
                         <font color="#ff7f50">企业：<a href="/enterpriseServlet.do?action=3&enterpriseId=<%=job.getEnterpriseId()%>&type=1" style="text-decoration: underline"><%=job.getEnterpriseName()%></a> |职位:<a href="/jobServlet.do?action=2&jobId=<%=job.getJobId()%>&type=3"><%=job.getJobName()%></a> |人数：<%=job.getJobAmount()%></font> <br><br><br>
                          <%}%>
                        </marquee>

                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

              </table>
            <br>
            <form name="form" method="post" action="/jobServlet.do?action=5">
            <table width="500" height="25" align="center" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="10%"><font color="#d2691e">搜索:</font></td>
                <td width="40%"><input type="text" size="30" name="condition"></td>
                <td width="20%"><font color="#d2691e">搜索类型：</font></td>
                <td width="20%"><select name="ctype">
                  <option value="1">企业名</option>
                  <option value="2">职位名</option>
                </select></td>
                <td width="10%"><input type="submit" value="搜索"></td>
              </tr>
            </table>
            </form>
            <table width="90%" align="center" border="1" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC">
              <tr>
                <td width="15%" height="25"><div align="center">数据编号</div></td>
                <td width="12%"><div align="center">发布企业</div></td>
                <td width="11%"><div align="center">职位名</div></td>
                <td width="16%"><div align="center">截止日期</div></td>
                <td width="18%"><div align="center">联系电话</div></td>
                <td width="13%"><div align="center">状态</div></td>
                <td width="15%"><div align="center">操作</div></td>
              </tr>
              <%for(int i=0;i<list.size();i++){
                JobVo jobVo=(JobVo)list.get(i);

              %>
              <tr bgcolor="#FFFFFF">
                <td height="30"><div align="center"><%=number*6+i+1%></div></td>
                <td><div align="center"><a href="/enterpriseServlet.do?action=3&enterpriseId=<%=jobVo.getEnterpriseId()%>&type=1" style="text-decoration: underline"><%=jobVo.getEnterpriseName()%></a></div></td>
                <td><div align="center"><%=jobVo.getJobName()%></div></td>
                <td><div align="center"><%=DateUtil.formatDate(DateUtil.formatString(jobVo.getJobEndTime(), "yyyy-MM-dd"), "yyyy-MM-dd")%></div></td>
                <td><div align="center"><%=jobVo.getPhone()%></div></td>
                <td><div align="center"><%if(jobVo.getType()==0){%>未投简历<%}else if(jobVo.getType()==1){%>已投简历<%}else if(jobVo.getType()==2){%>简历通过<%}else if(jobVo.getType()==3){%>不匹配<%}%></div></td>
                <td><div align="center"><a href="/jobServlet.do?action=2&jobId=<%=jobVo.getJobId()%>&type=3">明细</a><%if(jobVo.getType()==0){%>|<a href="/applyResumeServlet.do?action=0&jobId=<%=jobVo.getJobId()%>">投简历</a><%}%>
                </div>
                </td>
                <%}%>
              </tr>
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
  </tr>
</table>
</body>
</html>
