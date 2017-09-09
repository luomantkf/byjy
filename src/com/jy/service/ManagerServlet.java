package com.jy.service;



import com.jy.dao.mapper.BaseMapper;
import com.jy.dao.mapper.ManagerMapper;
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
public class ManagerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil=new DbUtil();
    ManagerMapper mapper=null;
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
        mapper = sqlSession.getMapper(ManagerMapper.class);

        int action=Integer.parseInt(request.getParameter("action"));
        switch (action){
            case 0: addManager(request, response);break;//添加管理员
            case 1: listManager(request, response);break;//分页显示
            case 2:break;
            case 3:deleteManager(request,response);break;//删除管理员
        }

    }
    private void addManager(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Manager manager=new Manager();
        manager.setUserName(request.getParameter("userName"));
        try {
            manager.setPassword(MD5Util.EncoderPwdByMd5(request.getParameter("pwd1")));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        manager.setPhone(request.getParameter("phone"));
        manager.setUserType(Short.parseShort("3"));
        try {
            if(mapper.insertManager(manager)==1){
                sqlSession.commit();
            }
            if(mapper.insert(manager)==1){
                sqlSession.commit();
                dbUtil.closeSqlSession(sqlSession);
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"添加成功\");window.location.href=\"/managerServlet.do?action=1\"</script>");
                return;
            }else{
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/managerServlet.do?action=1\"</script>");
                return;
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/managerServlet.do?action=1\"</script>");
            return;
        }

    }
    private void listManager(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Integer start=0;
        Integer pageNum=6;

        if(request.getParameter("number")!=null){
            start=Integer.parseInt(request.getParameter("number"))*pageNum;
        }


        Manager manager=new Manager();
        manager.setUserId(20);
        manager.setUserType(Short.parseShort("3"));
        manager.setStart(start);
        manager.setPageNum(pageNum);

        Integer pageNumber=mapper.pageRows(manager);
        List list = null;
        list = mapper.pageList(manager);
        sqlSession.commit();
        int maxPage =pageNumber; // 计算有多少页数
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
        request.setAttribute("pageNumber",String.valueOf(pageNumber));
        request.setAttribute("list", list);
        request.getRequestDispatcher("/jsp/manager/managerList.jsp").forward(request,response);
    }
    private void deleteManager(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId=Integer.parseInt(request.getParameter("userId"));
        Integer managerId=Integer.parseInt(request.getParameter("managerId"));

        try {
            if(mapper.deleteManager(managerId)==1&&mapper.delete(userId)==1){
                sqlSession.commit();
                dbUtil.closeSqlSession(sqlSession);
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"删除成功\");window.location.href=\"/managerServlet.do?action=1\"</script>");
                return;
            }
        } catch (IOException e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/managerServlet.do?action=1\"</script>");
            return;
        }
    }
}

