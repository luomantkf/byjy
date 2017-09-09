package com.jy.service;



import com.jy.dao.mapper.ManagerMapper;
import com.jy.dao.mapper.StudentMapper;
import com.jy.dao.mapper.UserBaseMapper;
import com.jy.model.Manager;
import com.jy.model.UserBase;
import com.jy.util.DbUtil;
import com.jy.util.MD5Util;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.util.List;

/**
 *增加用户的处理类
 */
public class UserBaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil=new DbUtil();
    UserBaseMapper mapper=null;
    StudentMapper mapper1=null;
    HttpSession session=null;
    SqlSession sqlSession=null;

    @Override
    public void destroy() {
        super.destroy();
        dbUtil.closeSqlSession(sqlSession);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        session=request.getSession();

        //每次会话都要重新建立以防止mybatis的一级缓存
        try {
                sqlSession = dbUtil.getSqlSession();
        } catch (Exception e) {
            e.printStackTrace();
        }
        mapper = sqlSession.getMapper(UserBaseMapper.class);
        mapper1 = sqlSession.getMapper(StudentMapper.class);

        int action=Integer.parseInt(request.getParameter("action"));
        switch (action){
            case 0: userLogin(request, response);break;//登录验证
            case 1: updatePwd(request, response);break;//用户修改
        }

    }
    private void userLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserBase userBase = new UserBase();
        userBase.setUserName(request.getParameter("userName"));
        userBase.setUserType(Short.parseShort(request.getParameter("userType")));
        try {
            userBase.setPassword(MD5Util.EncoderPwdByMd5(request.getParameter("pwd")));
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/userLogin.jsp\"</script>");
            return;
        }

        try {
            if (mapper.select(userBase) != null) {
                userBase=(UserBase) mapper.select(userBase);
                if(userBase.getUserType()==1){
                    userBase.setUserName(mapper1.selectStuName(userBase.getUserName()));
                }
                session.setAttribute("currentUser", userBase);
                request.getRequestDispatcher("/jsp/mainPage.jsp").forward(request, response);
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"密码有误\");window.location.href=\"/jsp/userLogin.jsp\"</script>");
            return;
        }
        PrintWriter pw = response.getWriter();
        pw.print("<script>alert(\"密码有误\");window.location.href=\"/jsp/userLogin.jsp\"</script>");
        return;
    }
    private void updatePwd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBase userBase = new UserBase();
        userBase.setUserId(Integer.parseInt(request.getParameter("userId")));
        try {
            userBase.setPassword(MD5Util.EncoderPwdByMd5(request.getParameter("pwd1")));
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/userLogin.jsp\"</script>");
            return;
        }
        try {
            if(mapper.updatePwd(userBase)==1){
                sqlSession.commit();
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"更改成功\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                return;
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }
    }
}

