package com.jy.service;


import com.jy.dao.mapper.ApplyResumeMapper;
import com.jy.model.ApplyResume;
import com.jy.model.UserBase;
import com.jy.util.DbUtil;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *增加用户的处理类
 */
public class ApplyResumeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil = new DbUtil();
    ApplyResumeMapper mapper = null;
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
        mapper = sqlSession.getMapper(ApplyResumeMapper.class);

        int action = Integer.parseInt(request.getParameter("action"));
        switch (action) {
            case 0:
                addApplyResume(request, response);
                break;
            case 1:
                listApplyResume(request, response);
                break;
            case 2:
                changStatus(request, response);
                break;
        }
    }

    private void addApplyResume(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBase user = null;
        if (session.getAttribute("currentUser") != null) {
            user = (UserBase) session.getAttribute("currentUser");
        }
        ApplyResume applyResume = new ApplyResume();

        applyResume.setJobId(Integer.parseInt(request.getParameter("jobId")));
        applyResume.setUserId(user.getUserId());

        try {
            if (mapper.insertApplyResume(applyResume) == 1) {
                sqlSession.commit();
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"投简历成功\");window.location.href=\"/resumeServlet.do?action=2\"</script>");
                return;
            } else {
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/resumeServlet.do?action=2\"</script>");
                return;
            }
        } catch (Exception e) {

            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/resumeServlet.do?action=2\"</script>");
            return;
        }

    }

    private void listApplyResume(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer start = 0;
        Integer pageNum = 6;
        Integer pageNumber = null;
        Integer type = 0;

        if (request.getParameter("number") != null) {
            start = Integer.parseInt(request.getParameter("number")) * pageNum;
        }

        ApplyResume applyResume = new ApplyResume();
        applyResume.setStart(start);
        applyResume.setPageNum(pageNum);
        applyResume.setJobId(Integer.parseInt(request.getParameter("jobId")));


        List list = null;
        try {
            list = mapper.pageList(applyResume);
            pageNumber = mapper.pageRows(applyResume);
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
            request.getRequestDispatcher("/jsp/stu/studList.jsp").forward(request, response);
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }
    }

    private void changStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer applyResumeId = Integer.parseInt(request.getParameter("applyResumeId"));
        Integer status = Integer.parseInt(request.getParameter("status"));
        Integer jobId = Integer.parseInt(request.getParameter("jobId"));
        try {
            if (mapper.changStatus(applyResumeId,status) == 1) {
                sqlSession.commit();
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"操作成功\");window.location.href=\"/applyResumeServlet.do?action=1&jobId=" + jobId + "\"</script>");
                return;
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/applyResumeServlet.do?action=1&jobId=" + jobId + "\"</script>");
            return;
        }

    }

}





