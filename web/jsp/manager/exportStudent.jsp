<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>导入毕业生信息</title>
<link type="text/css" rel="stylesheet" href="/static/css/style.css">

</head>
<body>
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
    
      <jsp:include page="../top.jsp" flush="true" />
      <table width="801" height="436" border="1" cellpadding="0" cellspacing="0" style="margin-top: 8px"    class="bg">
        <tr>
          <td valign="top">
            <jsp:include page="../left.jsp" flush="true" />
          </td>

          <td height="243" valign="top">
            <table width="575" height="25" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><div align="center">
                  <h2 style="background-color: burlywood">
                   导入毕业生信息
                  </h2>
                </div>
                </td>
              </tr>
            </table>
                  <table width="450" border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#808080">
                    <tr>
                      <td width="35%" height="30"align="center"><span>导入模板下载：</span></td>
                      <td width="65%" bgcolor="#FFFFFF" align="center"><div align="center"><img style="vertical-align: middle; margin-right: 2px;" src="/static/images/icon_xls.gif"/>
                        <a style="font-size:12px; color:#0066cc;" href="/static/excel/000000.xlsx" title="毕业生信息导入模板.xls">毕业生信息导入模板.xlsx</a></p><p><br/></p></div></td>
                    </tr>
                    <tr>
                      <td width="35%" height="30" align="center" ><span class="word_white">上传文件：</span></td>
                      <td width="65%" bgcolor="#FFFFFF"><form action='/studentServlet.do?action=0   ' enctype="multipart/form-data" method="post" id="fileForm" name="fileForm">
                        <table>
                          <tr>
                            <td><input type="file" name="ExcelData"></td>
                            <td><input type="submit" value="上传"></td>
                          </tr>
                        </table>

                      </form></td>
                    </tr>
                  </table>
                  <br>

          </td>
        </tr>
      </table>
	  <%--<jsp:include page="down.jsp" flush="true" />--%>
    </td>
  </tr>
</table>

</body>
</html>
