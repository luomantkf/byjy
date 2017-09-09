package com.jy.service;



import com.jy.dao.mapper.EnterpriseMapper;
import com.jy.dao.mapper.UserBaseMapper;
import com.jy.model.Enterprise;
import com.jy.model.UserBase;
import com.jy.util.DbUtil;
import com.jy.util.MD5Util;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.ibatis.session.SqlSession;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *增加用户的处理类
 */
public class EnterpriseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil = new DbUtil();
    EnterpriseMapper mapper = null;
    UserBaseMapper mapper1=null;
    HttpSession session = null;
    SqlSession sqlSession = null;

    @Override
    public void destroy() {
        super.destroy();
        dbUtil.closeSqlSession(sqlSession);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        session = request.getSession();

        //每次会话都要重新建立以防止mybatis的一级缓存
        try {
            sqlSession = dbUtil.getSqlSession();
        } catch (Exception e) {
            e.printStackTrace();
        }
        mapper = sqlSession.getMapper(EnterpriseMapper.class);
        mapper1 = sqlSession.getMapper(UserBaseMapper.class);

        int action = Integer.parseInt(request.getParameter("action"));
        switch (action) {
            case 0:
                enterpriseRegsiter(request, response);//企业注册
                break;
            case 1:
                addEnterprise(request, response);//完善企业信息
                break;
            case 2:
               listEnterprise(request, response);//管理企业信息
                break;
            case 3:
                showEnterprise(request, response);//详细企业信息
                break;

            case 4:changStatus(request,response);break;//审核

            case 5:checkStatus(request, response);break;//审核是否通过审核

            case 6:editEnterprise(request,response);break;//完善信息时判断是否有过记录
        }
    }

    private void enterpriseRegsiter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Enterprise enterprise = new Enterprise();
        enterprise.setUserName(request.getParameter("userName"));
        try {
            enterprise.setPassword(MD5Util.EncoderPwdByMd5(request.getParameter("pwd1")));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        enterprise.setUserType(Short.parseShort("2"));
        try {
            if (mapper.insert(enterprise) == 1) {
                session.setAttribute("currentUser", enterprise);
                sqlSession.commit();
                dbUtil.closeSqlSession(sqlSession);
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"注册成功\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                return;
            } else {
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/jsp/enterprise/enterpriseRegister.jsp\"</script>");
                return;
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/enterprise/enterpriseRegister.jsp\"</script>");
            return;
        }

    }

    private void addEnterprise(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
           {
               Enterprise enterprise=new Enterprise();
               String uploadPath = request.getSession().getServletContext().getRealPath("/") + "/static/word/";
               // 配置上传参数
               DiskFileItemFactory factory = new DiskFileItemFactory();
               // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
               factory.setSizeThreshold(1024 * 1024 * 10);
               // 设置临时存储目录
               factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

               ServletFileUpload upload = new ServletFileUpload(factory);

               // 设置最大文件上传值
               upload.setFileSizeMax(1024 * 1024 * 40);

               // 设置最大请求值 (包含文件和表单数据)
               upload.setSizeMax(1024 * 1024 * 3);

               // 如果目录不存在则创建
               File uploadDir = new File(uploadPath);
               if (!uploadDir.exists()) {
                   uploadDir.mkdir();
               }
               try {
                   List<FileItem> formItems = upload.parseRequest(request);

                   if (formItems != null && formItems.size() > 0) {
                       // 迭代表单数据
                       for (FileItem item : formItems) {
                           //处理在表单的数据
                           if (item.isFormField()) {
                               String name = item.getFieldName(); //获取form表单中name的id
                               if ("userId".equals(name)) {
                                   enterprise.setUserId(Integer.parseInt(item.getString("utf-8")));
                               }
                               if ("enterpriseName".equals(name)) {
                                   enterprise.setEnterpriseName(item.getString("utf-8"));
                               } else if ("address".equals(name)) {
                                   enterprise.setAddress(item.getString("utf-8"));
                               } else if ("phone".equals(name)) {
                                   enterprise.setPhone(item.getString("utf-8"));
                               } else if ("contactMan".equals(name)) {
                                   enterprise.setContactMan(item.getString("utf-8"));
                               } else if ("email".equals(name)) {
                                   enterprise.setEmail(item.getString("utf-8"));
                               } else if ("website".equals(name)) {
                                   enterprise.setWebsite(item.getString("utf-8"));
                               }
                           }
                           // 处理不在表单中的字段
                           else {
                               String fileName = new File(item.getName()).getName();
                               String endName = fileName.substring(fileName.indexOf("."));   //后缀名
                               String filePath = (new Date()).getTime() + endName;
                               File storeFile = new File(uploadPath +filePath);
                               // 保存文件到硬盘
                               item.write(storeFile);
                               enterprise.setEvidence("/static/word/" + filePath);
                            }
                       }
                   }
               } catch (Exception ex) {
                   System.out.println(ex);
                   PrintWriter pw = response.getWriter();
                   pw.print("<script>alert(\"error\");window.location.href=\"/jsp/enterprise/addEnterprise.jsp\"</script>");
                   return;
               }
               try {
                   if(mapper.insertEnterprise(enterprise)==1){
                       UserBase user=(UserBase)session.getAttribute("currentUser");
                       user.setDetail(enterprise.getDetail());
                       session.setAttribute("currentUser",user);
                       sqlSession.commit();
                       if(mapper.updateBaseDetail(enterprise)==1){
                           sqlSession.commit();
                           PrintWriter pw = response.getWriter();
                           pw.print("<script>alert(\"提交成功\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                           return;
                       }
                   }else{
                       PrintWriter pw = response.getWriter();
                       pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                       return;
                   }

               } catch (Exception e) {
                   PrintWriter pw = response.getWriter();
                   pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                   return;
               }

           }
    private void checkStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            UserBase userBase=(UserBase)session.getAttribute("currentUser");

        try {
            if(mapper.getStatus(userBase)!=-1){
                Short status=mapper.getStatus(userBase);
                if(status==0){
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"请等待后台审核后执行该操作!!!\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                    return;
                }else{
                    if(request.getParameter("type").equals("1")){//通过type不同跳转不同的页面
                        response.sendRedirect("/jsp/enterprise/addJob.jsp");
                    }
                    else{
                        PrintWriter pw = response.getWriter();
                        pw.print("<script>window.location.href=\"/jobServlet.do?action=1&type=2\"</script>");
                        return;
                    }
                }
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"请完善企业信息!!!\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
    }
    }

    private void listEnterprise(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Integer start = 0;
        Integer pageNum = 6;
        Integer pageNumber = null;


        if (request.getParameter("number") != null) {
            start = Integer.parseInt(request.getParameter("number")) * pageNum;
        }


        Enterprise Enterprise = new Enterprise();
        Enterprise.setUserId(20);
        Enterprise.setDetail(1);
        Enterprise.setUserType(Short.parseShort("1"));
        Enterprise.setStart(start);
        Enterprise.setPageNum(pageNum);


        List list = null;
        list = mapper.pageList(Enterprise);
        pageNumber = mapper.pageRows(Enterprise);
        sqlSession.commit();
        int maxPage = pageNumber; // 计算有多少页数
        String number = request.getParameter("number");
        if (maxPage % pageNum == 0) {
            maxPage = maxPage / pageNum;
        } else {
            maxPage = maxPage / pageNum + 1;
        }
        if (number == null) {
            number = "0";
        }
        request.setAttribute("number", String.valueOf(number));
        request.setAttribute("maxPage", String.valueOf(maxPage));
        request.setAttribute("pageNumber", String.valueOf(pageNumber));
        request.setAttribute("list", list);
        request.getRequestDispatcher("/jsp/manager/enterpriseList.jsp").forward(request, response);
    }


    private void showEnterprise(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer enterpriseId=Integer.parseInt(request.getParameter("enterpriseId"));
        if(request.getParameter("type")!=null){
            request.setAttribute("type",request.getParameter("type")!=null);
        }

        Enterprise enterprise=null;
        try {
            enterprise=mapper.selectById(enterpriseId);
            if(enterprise!=null){
                request.setAttribute("enterprise",enterprise);
                request.getRequestDispatcher("/jsp/manager/showEnterprise.jsp").forward(request,response);
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/manager/enterpriseList.jsp\"</script>");
            return;
        }

    }

    private void editEnterprise(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBase userBase=(UserBase)session.getAttribute("currentUser");

        Enterprise enterprise=null;
        Integer detail=0;

        try {
            detail=mapper1.selectDetail(userBase);
            if(detail!=0){
                try {
                    enterprise=mapper.selectById(detail);
                    if(enterprise!=null){
                        request.setAttribute("enterprise",enterprise);
                        request.getRequestDispatcher("/jsp/enterprise/addEnterprise.jsp").forward(request,response);
                    }
                } catch (Exception e) {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                    return;
                }
            }else {
                response.sendRedirect("/jsp/enterprise/addEnterprise.jsp");
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }

    }
    private void changStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer enterpriseId=Integer.parseInt(request.getParameter("enterpriseId"));
        try {
            if(mapper.changStatus(enterpriseId)==1){
                sqlSession.commit();
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"操作成功\");window.location.href=\"/enterpriseServlet.do?action=2\"</script>");
                return;
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }

    }

}






