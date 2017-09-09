<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.jy.model.Resume" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title> 个人简历</title>
<link type="text/css" rel="stylesheet" href="/static/css/style.css">

</head>
<script language="javascript">

<%
  Resume resume=(Resume)request.getAttribute("resume");
%>
  function checkAction(form) {
    if(form.stuID.value==""||form.address.value==""||form.stuName.value==""||form.age.value==""||form.sex.value==""||form.birthday.value==""||form.idCard.value==""||form.phone.value==""||form.university.value==""||form.profession.value==""||form.education.value==""||form.intention.value==""||form.picture.value==""){
      window.alert("请完善信息");
      return false;
    }
  }
</script>

<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
      <jsp:include page="../top.jsp" flush="true" />

      <table border="1" cellpadding="1" cellspacing="1" style="margin-top: 8px"    class="bg">
        <tr>
          <td valign="top">
            <jsp:include page="../left.jsp" flush="true" />
          </td>
          <td  valign="top">
            <table width="575" height="25" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><div align="center">
                  <h2 style="background-color: burlywood;height: 25px">
                    个人简历
                  </h2>
                </div>
                </td>
              </tr>
            </table>
            <br>
            <form name="form" method="post" action="/resumeServlet.do?action=1" enctype="multipart/form-data" onSubmit="return checkAction(this)" >
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
                        <td bgcolor="#FFFFFF"><input type="text" name="age" value="${resume.age}"></td>

                      </tr>
                      <tr>
                        <th>性别：</th>
                        <td bgcolor="#FFFFFF"><input type="radio" name="sex" checked  value="1">&nbsp;男&nbsp; &nbsp; &nbsp; <input type="radio" name="sex" value="2">&nbsp;女</td>
                      </tr>
                      <tr>
                        <th>毕业学校：</th>
                        <td bgcolor="#FFFFFF"><input type="text" name="university" value="${resume.university}"></td>
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
                    <%if(resume.getPicture()!=null){%>
                      <div>
                        <img src="${resume.picture}" height="200" width="175">
                      </div>
                    <%}else{%>
                    <input type="file" name="picture" value="请上传头像">
                    <%}%>
                  </td>
                </tr>
                <tr>
                  <th height="25">文化程度：</th>
                  <td bgcolor="#FFFFFF"><input type="text" name="education" value="${resume.education}" readonly="true"></td>
                  <th>求职意向：</th>
                  <td bgcolor="#FFFFFF"><input type="text" name="intention" value="${resume.intention}"></td>
                </tr>
                <tr>
                  <th>现所在地：</th>
                  <td bgcolor="#FFFFFF"><input type="text" name="address" value="${resume.address}"></td>
                  <th height="25">联系电话：</th>
                  <td bgcolor="#FFFFFF"><input type="text" name="phone" value="${resume.phone}"></td>
                </tr>
                <tr>
                  <th height="107">语言能力：</th>
                  <td colspan="3" bgcolor="#FFFFFF"><textarea name="tongue" cols="65" rows="5">${resume.tongue}</textarea></td>
                </tr>
                <tr>
                  <th height="107">技能特长：</th>
                  <td colspan="3" bgcolor="#FFFFFF"><textarea name="skill" cols="65" rows="5">${resume.skill}</textarea></td>
                </tr>

                <tr>
                  <th height="107">自我介绍：</th>
                  <td colspan="3" bgcolor="#FFFFFF"><textarea name="introduce" cols="65" rows="5">${resume.introduce}</textarea></td>
                </tr>
                <tr>
                  <th height="107">工作经历：</th>
                  <td colspan="3" bgcolor="#FFFFFF"><textarea name="workExperience" cols="65" rows="5">${resume.workExperience}</textarea></td>
                </tr>
                <tr>
                  <th height="107">校园经历：</th>
                  <td colspan="3" bgcolor="#FFFFFF"><textarea name="schoolExperience" cols="65" rows="5">${resume.schoolExperience}</textarea></td>
                </tr>
                <tr>
                  <th height="107">简历文件上传：</th>
                  <td colspan="3" bgcolor="#FFFFFF"><%if(resume.getResumeFile()!=null){%><a style="font-size:12px; color:#0066cc;" href="${resume.resumeFile}" title="简历文件查看">简历文件查看</a></p><p><br/></p><%}%><input type="file" name="resumeFile" value="上传相关的简历文件"><font color="#ff7f50">word形式或图片上传</font><%%></td>
                </tr>
              </table>
              <br>
              <div align="center">
                &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"   value="提交" width="51" height="20">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="#" onClick="javasrcipt:history.go(-1)">返回</a>
              </div></form>
          </td>
        </tr>

    </td>
  </tr>
</table>
</td>
  </tr>
</table>
</body>
</html>
