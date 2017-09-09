package com.jy.service;


import com.jy.dao.mapper.ApplyResumeMapper;
import com.jy.dao.mapper.JobMapper;
import com.jy.model.*;
import com.jy.util.DateUtil;
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
import java.util.Date;
import java.util.List;

/**
 *增加用户的处理类
 */
public class JobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil = new DbUtil();
    JobMapper mapper = null;
    ApplyResumeMapper mapper1=null;
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
        mapper = sqlSession.getMapper(JobMapper.class);
        mapper1 = sqlSession.getMapper(ApplyResumeMapper.class);

        int action = Integer.parseInt(request.getParameter("action"));
        switch (action) {
            case 0:
                addJob(request,response);break;
            case 1:
                listJob(request, response);break;
            case 2:
                showJob(request, response);break;
            case 3:
                changStatus(request,response);break;
            case 4:
                editJob(request, response);break;
            case 5:selectByCondition(request,response);break;
            case 6:deleteJob(request,response);break;
        }
    }
    private void addJob(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
           {
               Job job=new Job();
               job.setEnterpriseId(Integer.parseInt(request.getParameter("enterpriseId")));
               job.setJobName(request.getParameter("jobName"));
               job.setJobNeed(request.getParameter("jobNeed"));
               job.setJobAddress(request.getParameter("jobAddress"));
               job.setJobAmount(request.getParameter("jobAmount"));
               job.setJobSalary(request.getParameter("jobSalary"));
               job.setJobEndTime(request.getParameter("jobEndTime"));
               job.setRemark(request.getParameter("remark"));


               try {
                   if(mapper.insertJob(job)==1){
                       sqlSession.commit();
                       PrintWriter pw = response.getWriter();
                       pw.print("<script>alert(\"添加成功\");window.location.href=\"/jsp/enterprise/addJob.jsp\"</script>");
                       return;
                   }else{
                       PrintWriter pw = response.getWriter();
                       pw.print("<script>alert(\"error\");window.location.href=\"/jsp/enterprise/addJob.jsp\"</script>");
                       return;
                   }
               } catch (Exception e) {
                   PrintWriter pw = response.getWriter();
                   pw.print("<script>alert(\"error\");window.location.href=\"/jsp/enterprise/addJob.jsp\"</script>");
                   return;
               }

           }
    private void editJob(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        Job job=new Job();
        job.setJobId(Integer.parseInt(request.getParameter("jobId")));
        job.setEnterpriseId(Integer.parseInt(request.getParameter("enterpriseId")));
        job.setJobName(request.getParameter("jobName"));
        job.setJobNeed(request.getParameter("jobNeed"));
        job.setJobAddress(request.getParameter("jobAddress"));
        job.setJobAmount(request.getParameter("jobAmount"));
        job.setJobSalary(request.getParameter("jobSalary"));
        job.setJobEndTime(request.getParameter("jobEndTime"));
        job.setRemark(request.getParameter("remark"));


        try {
            if(mapper.update(job)==1){
                sqlSession.commit();
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"更改成功\");window.location.href=\"/jobServlet.do?action=1&type=2\"</script>");
                return;
            }else{
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/jobServlet.do?action=1&type=2\"</script>");
                return;
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jobServlet.do?action=1&type=2\"</script>");
            return;
        }

    }

    private void listJob(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer start = 0;
        Integer pageNum = 6;
        Integer pageNumber = null;
        Integer type=0;

        if (request.getParameter("number") != null) {
            start = Integer.parseInt(request.getParameter("number")) * pageNum;
        }
        if (request.getParameter("type") != null) {
            type = Integer.parseInt(request.getParameter("type"));
        }

        Job job = new Job();
        job.setStart(start);
        job.setPageNum(pageNum);

        //根据职位查询
        if(request.getParameter("condition")!=null){
            job.setCondition("and jobName like \"%" +request.getParameter("condition") + "%\"");
        }
        if(type==2){
        UserBase userBase=(UserBase)session.getAttribute("currentUser");
        if(userBase!=null){
          job.setUserId(userBase.getUserId());
        }
        }
        List list = null;
        try {
            list = mapper.pageList(job);
            pageNumber =list.size();
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
            if(type==1){//type为1时显示为管理员查看的招聘职位
                request.getRequestDispatcher("/jsp/manager/jobList.jsp").forward(request, response);
            }else{//type为2时显示为企业查看的招聘职位
                request.getRequestDispatcher("/jsp/enterprise/jobList.jsp").forward(request, response);
            }

        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }

    }
    private void showJob(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer jobId=Integer.parseInt(request.getParameter("jobId"));

        JobVo jobVo=null;
        try {
            if(jobId!=null){
                jobVo=mapper.selectById(jobId);
                jobVo.setJobEndTime(DateUtil.formatDate(DateUtil.formatString(jobVo.getJobEndTime(), "yyyy-MM-dd"), "yyyy-MM-dd"));
            }

            if(jobVo!=null){
                request.setAttribute("jobVo",jobVo);
                if(request.getParameter("type").equals("1")){//type=1管理员查看不可更改，企业查看可更改
                    request.getRequestDispatcher("/jsp/manager/showJob.jsp").forward(request,response);
                }
                else if(request.getParameter("type").equals("2")) {
                    request.getRequestDispatcher("/jsp/enterprise/editJob.jsp").forward(request, response);
                }
                else if(request.getParameter("type").equals("3")) {//毕业生查看招聘信息
                    request.getRequestDispatcher("/jsp/stu/showJob.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/manager/jobList.jsp\"</script>");
            return;
        }

    }
    private void changStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer jobId=Integer.parseInt(request.getParameter("jobId"));
        try {
            if(mapper.changStatus(jobId)==1){
                sqlSession.commit();
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"操作成功\");window.location.href=\"/jobServlet.do?action=1&type=1\"</script>");
                return;
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }

    }

    private void selectByCondition(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //查询出最新的招聘
        Job job=new Job();
        job.setStart(0);
        job.setPageNum(4);
        List<JobVo> list1=null;
        try {
            list1=mapper.selectNewJob(job);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //查询出即将截止的招聘

        Job job2=new Job();
        job2.setStart(0);
        job2.setPageNum(4);
        List<JobVo> list2=null;
        try {
            list2=mapper.selectJobEndTime(job2);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Integer start = 0;
        Integer pageNum = 6;
        Integer pageNumber = null;

        String condition=request.getParameter("condition");
        Integer type=Integer.parseInt(request.getParameter("ctype"));


        if (request.getParameter("number") != null) {
            start = Integer.parseInt(request.getParameter("number")) * pageNum;
        }


        JobVo jobVo = new JobVo();
        jobVo.setStart(start);
        jobVo.setPageNum(pageNum);
        jobVo.setStatus(Short.parseShort("1"));//查找已经通过审核的职位
        if(type==1){
            jobVo.setEnterpriseName(condition);
        }else{
            jobVo.setJobName(condition);
        }
        //判断是否投过简历
        UserBase user=null;
        if(session.getAttribute("currentUser")!=null){
            user=(UserBase)session.getAttribute("currentUser");
        }
        List list = null;
        try {
            if(type==1) {
                list = mapper.selectByEnterpriseName(jobVo);
            }else {
                list = mapper.selectByJobName(jobVo);
            }
            for(int i=0;i<list.size();i++){
                ApplyResume applyResume=new ApplyResume();
                applyResume.setJobId(((JobVo)list.get(i)).getJobId());
                applyResume.setUserId(user.getUserId());
                Short status=mapper1.selectStatus(applyResume);
                if(status==null){
                    ((JobVo) list.get(i)).setType(0);//未投简历
                }else if(status==0){
                    ((JobVo) list.get(i)).setType(1);//已投简历
                }else if(status==1){
                    ((JobVo) list.get(i)).setType(2);//简历通过
                }
            }
            pageNumber =list.size();
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
            request.setAttribute("list1", list1);
            request.setAttribute("list2", list2);
                request.getRequestDispatcher("/jsp/stu/jobList.jsp").forward(request, response);
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }

    }
    private void deleteJob(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer jobId=Integer.parseInt(request.getParameter("jobId"));

        try {
            if(mapper.delete(jobId)==1){
                sqlSession.commit();
                dbUtil.closeSqlSession(sqlSession);
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"删除成功\");window.location.href=\"/jobServlet.do?action=1&type=2\"</script>");
                return;
            }
        } catch (IOException e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jobServlet.do?action=1&type=2\"</script>");
            return;
        }
    }
}






