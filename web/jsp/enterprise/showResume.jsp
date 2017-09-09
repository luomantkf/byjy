<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.jy.model.Resume" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>  简历查看</title>
<link type="text/css" rel="stylesheet" href="/static/css/style.css">
<%
    Resume resume=(Resume)request.getAttribute("resume");
%>
</head>
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
    
      <jsp:include page="../top.jsp" flush="true" />
      <table border="1" cellpadding="1" cellspacing="1" style="margin-top: 8px"   class="bg">
        <tr>
          <td valign="top">
            <jsp:include page="../left.jsp" flush="true" />
          </td>
          <td  valign="top">
            <table width="575" height="25" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><div align="center">
                  <h2 style="background-color: burlywood">
                    简历查看
                  </h2>
                </div>
                </td>
              </tr>
            </table>
            <table border="1"  align="center" width="575" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bgcolor="#dcdcdc">
              <input type="hidden" name="stuUid" value="${resume.stuUid}">
              <input type="hidden" name="resumeId" value="${resume.resumeId}">

              <tr>
                <td width="70%" colspan="3">
                  <table border="0">
                    <tr>
                      <th height="25" width="85">学号：</th>
                      <td  width="200" bgcolor="#FFFFFF"><input type="text" name="stuID" value="${resume.stuID}" readonly="true"></td>
                    </tr>
                    <tr>
                      <th width="85">姓名：</th>
                      <td  width="200" bgcolor="#FFFFFF"><input type="text" name="stuName" value="${resume.stuName}" readonly="true"></td>
                    </tr>
                    <tr>
                      <th height="25">年龄：</th>
                      <td bgcolor="#FFFFFF"><input type="text" name="age" value="${resume.age}" readonly="true"></td>

                    </tr>
                    <tr>
                      <th>性别：</th>
                      <td bgcolor="#FFFFFF"><input type="text" value="<%=resume.getSex()==1?"男":"女"%>" readonly="true"></td>
                    </tr>
                    <tr>
                      <th>毕业学校：</th>
                      <td bgcolor="#FFFFFF"><input type="text" name="university" value="${resume.university}" readonly="true"></td>
                    </tr>
                    <tr>
                      <th height="25">学院：</th>
                      <td bgcolor="#FFFFFF"><input type="text" name="academy" value="${resume.academy}" readonly="true"></td>
                    </tr>
                    <tr>
                      <th height="25">专业：</th>
                      <td bgcolor="#FFFFFF"><input type="text" name="profession" value="${resume.profession}" readonly="true"></td>
                    </tr>
                  </table>
                </td>
                <td width="30%" align="center">
                  <div>
                    <img src="${resume.picture}" height="200" width="175">
                  </div>
                </td>
              </tr>
              <tr>
                <th height="25">文化程度：</th>
                <td bgcolor="#FFFFFF"><input type="text" name="education" value="${resume.education}" readonly="true"></td>
                <th>求职意向：</th>
                <td bgcolor="#FFFFFF"><input type="text" name="intention" value="${resume.intention}" readonly="true"></td>
              </tr>
              <tr>
                <th>现所在地：</th>
                <td bgcolor="#FFFFFF"><input type="text" name="address" value="${resume.address}" readonly="true"></td>
                <th height="25">联系电话：</th>
                <td bgcolor="#FFFFFF"><input type="text" name="phone" value="${resume.phone}" readonly="true"></td>
              </tr>
              <tr>
                <th height="107">语言能力：</th>
                <td colspan="3" bgcolor="#FFFFFF"><textarea name="tongue" cols="65" rows="5" readonly="true">${resume.tongue}</textarea></td>
              </tr>
              <tr>
                <th height="107">技能特长：</th>
                <td colspan="3" bgcolor="#FFFFFF"><textarea name="skill" cols="65" rows="5" readonly="true">${resume.skill}</textarea></td>
              </tr>

              <tr>
                <th height="107">自我介绍：</th>
                <td colspan="3" bgcolor="#FFFFFF"><textarea name="introduce" cols="65" rows="5" readonly="true">${resume.introduce}</textarea></td>
              </tr>
              <tr>
                <th height="107">工作经历：</th>
                <td colspan="3" bgcolor="#FFFFFF"><textarea name="workExperience" cols="65" rows="5" readonly="true" readonly="true">${resume.workExperience}</textarea></td>
              </tr>
              <tr>
                <th height="107">校园经历：</th>
                <td colspan="3" bgcolor="#FFFFFF"><textarea name="schoolExperience" cols="65" rows="5" readonly="true">${resume.schoolExperience}</textarea></td>
              </tr>
              <tr>
                <th height="107">简历文件查看：</th>
                <td colspan="3" bgcolor="#FFFFFF"><a style="font-size:12px; color:#0066cc;" href="${resume.resumeFile}" title="简历文件查看">简历文件查看</a></p><p><br/></p></td>
              </tr>
            </table>
        <br>
        <div align="center">
          &nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <a href="#" onClick="javasrcipt:history.go(-1)">返回</a>
        </div>
	 </table>
   </td>
    </tr>
    </td>
  </tr>
</table>


</body>
</html>
