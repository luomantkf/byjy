<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.jy.model.UserBase" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>完善企业信息</title>
<link type="text/css" rel="stylesheet" href="/static/css/style.css">
  <%
    UserBase user=null;
    if(session.getAttribute("currentUser")!=null){
      user=(UserBase)session.getAttribute("currentUser");
    }
  %>
</head>
<script language="javascript">

  function checkAction(form) {
    if(form.enterpriseName.value==""||form.address.value==""||form.phone.value==""||form.contactMan.value==""||form.email.value==""||form.website.value==""||form.evidence.value==""){
      window.alert("请完善信息");
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

          <td height="243" valign="top" align="center">
            <form name="form" method="post" action="/enterpriseServlet.do?action=1" enctype="multipart/form-data" onSubmit="return checkAction(this)">
              <table width="575" height="25" border="0" cellpadding="0" cellspacing="0" >
                <tr>
                  <td><div align="center">
                    <h2 style="background-color: burlywood">
                      完善企业信息
                    </h2>
                  </div></td>
                </tr>
              </table>
              <table width="355" border="1" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC" align="center">

                <tbody><tr>
                  <input type="hidden" name="userId" value="<%=user.getUserId()%>">
                  <th width="99" height="30"><span>企业代理用户：</span></th>
                  <td width="250" bgcolor="#FFFFFF"><input type="text" name="userName" size="40" value="<%=user.getUserName()%>" readonly="true"></td>
                </tr>
                <tr>
                  <th height="30"><span>企业名称：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="enterpriseName" size="40" value="${enterprise.enterpriseName}"></td>
                </tr>
                <tr>
                  <th height="30"><span>企业地址：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="address" size="40" value="${enterprise.address}"></td>
                </tr>
                <tr>
                  <th height="30"><span>联系电话：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="phone" size="40" value="${enterprise.phone}"></td>
                </tr>
                <tr>
                  <th height="30"><span class="word_white">联系人：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="contactMan" size="40" value="${enterprise.contactMan}" ></td>
                </tr>
                <tr>
                  <th height="30"><span class="word_white">邮箱：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="email" size="40" value="${enterprise.email}" ></td>
                </tr>
                <tr>
                  <th height="30"><span class="word_white">网站：</span></th>
                  <td bgcolor="#FFFFFF"><input type="text" name="website" size="40" value="${enterprise.website}" ></td>
                </tr>
                <tr>
                  <th height="30"><span class="word_white">相关证据：</span></th>
                  <td bgcolor="#FFFFFF"><input type="file" style="width: 150px" name="evidence">&nbsp;<font color="#ff7f50">word形式上传</font></td>
                </tr>

                </tbody></table>
                  <br>
                  <div align="center">
                  &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"   value="提交审核" width="51" height="20">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
