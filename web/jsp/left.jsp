<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%--<%@ page import="java.util.TreeMap" %>
<%@ taglib prefix="s2" uri="/struts-tags" %>
<%
  TreeMap searchType=new TreeMap();
  searchType.put("like","模糊搜索");
  searchType.put("all","全字匹配");
  request.setAttribute("searchType",searchType);
%>--%>

<html>
<head>
  <title>侧栏</title>
</head>
<body>

        <table  border="0" width="225" height="100%" cellspacing="0" cellpadding="0">
            <tr height="30"><td style="text-indent:5" valign="top"><font color="#004790"><b>■日历</b></font></td></tr>
            <tr height="1"><td></td></tr>
            <tr height="215" valign="top">
                <td background="/static/images/leftD.jpg">
                    <jsp:include page="calendar.jsp"/></td>
            </tr>
            <tr height="1"><td></td></tr>
            <tr><td></td></tr>
        </table>
</body>
</html>