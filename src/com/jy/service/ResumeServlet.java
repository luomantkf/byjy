package com.jy.service;


import com.jy.dao.mapper.ApplyResumeMapper;
import com.jy.dao.mapper.JobMapper;
import com.jy.dao.mapper.ResumeMapper;
import com.jy.model.*;
import com.jy.util.DbUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.ibatis.session.SqlSession;

import javax.net.ssl.SNIHostName;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *增加用户的处理类
 */
public class ResumeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil = new DbUtil();
    ResumeMapper mapper = null;
    JobMapper mapper1=null;
    ApplyResumeMapper mapper2=null;
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
        mapper = sqlSession.getMapper(ResumeMapper.class);
        mapper1 = sqlSession.getMapper(JobMapper.class);
        mapper2 = sqlSession.getMapper(ApplyResumeMapper.class);

        int action = Integer.parseInt(request.getParameter("action"));
        switch (action) {
            case 0:showResume(request,response);break;
            case 1:addResume(request,response);break;
            case 2:listJob(request, response);break;
                        }
    }

    private void showResume(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId=null;
        if(request.getParameter("userId")!=null){//这是企业查看信息
            userId=Integer.parseInt(request.getParameter("userId"));
        }else{
            UserBase userBase=(UserBase)session.getAttribute("currentUser");
            userId=userBase.getUserId();
        }

        Resume resume=null;
        try {
            resume=mapper.showResume(userId);
            if(resume!=null){
                request.setAttribute("resume",resume);
                if(request.getParameter("userId")!=null){
                    request.getRequestDispatcher("/jsp/enterprise/showResume.jsp").forward(request,response);
                }else {
                    request.getRequestDispatcher("/jsp/stu/addResume.jsp").forward(request, response);
                }
            }else {//第一次完善简历信息
                resume=mapper.showResume2(userId);
                if(resume!=null) {
                    request.setAttribute("resume", resume);
                    if (request.getParameter("userId") != null) {
                        request.getRequestDispatcher("/jsp/enterprise/showResume.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/jsp/stu/addResume.jsp").forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }
    }

    private void addResume(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Resume resume=new Resume();
        String uploadPath = request.getSession().getServletContext().getRealPath("/") + "/static/";
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
                String name =null;
                // 迭代表单数据
                for (FileItem item : formItems) {
                    name = item.getFieldName(); //获取form表单中name的id
                    //处理在表单的数据
                    if (item.isFormField()) {
                        if ("stuUid".equals(name)) {
                            resume.setStuUid(Integer.parseInt(item.getString("utf-8")));
                        }
                        if ("resumeId".equals(name)) {
                            resume.setResumeId(Integer.parseInt(item.getString("utf-8")));
                        } else if ("stuID".equals(name)) {
                            resume.setStuID(item.getString("utf-8"));
                        } else if ("stuName".equals(name)) {
                            resume.setStuName(item.getString("utf-8"));
                        } else if ("age".equals(name)) {
                           resume.setAge(Integer.parseInt(item.getString("utf-8")));
                        } else if ("university".equals(name)) {
                            resume.setUniversity(item.getString("utf-8"));
                        }
                        else if ("academy".equals(name)) {
                            resume.setAcademy(item.getString("utf-8"));
                        }
                        else if ("profession".equals(name)) {
                            resume.setProfession(item.getString("utf-8"));
                        }
                        else if ("intention".equals(name)) {
                            resume.setIntention(item.getString("utf-8"));
                        }
                        else if ("address".equals(name)) {
                            resume.setAddress(item.getString("utf-8"));
                        }
                        else if ("phone".equals(name)) {
                            resume.setPhone(item.getString("utf-8"));
                        }
                        else if ("tongue".equals(name)) {
                            resume.setTongue(item.getString("utf-8"));
                        }
                        else if ("skill".equals(name)) {
                            resume.setSkill(item.getString("utf-8"));
                        }
                        else if ("introduce".equals(name)) {
                            resume.setIntroduce(item.getString("utf-8"));
                        }
                        else if ("schoolExperience".equals(name)) {
                            resume.setSchoolExperience(item.getString("utf-8"));
                        }
                        else if ("workExperience".equals(name)) {
                            resume.setWorkExperience(item.getString("utf-8"));
                        }


                    }
                    // 处理不在表单中的字段
                    else {
                        //path1用于标识是储存的word文档还是图片
                        String path1="";
                        String fileName = new File(item.getName()).getName();
                        if(!"".equals(fileName)) {
                            String endName = fileName.substring(fileName.indexOf("."));//后缀名
                            if (endName.equals(".jpg") || endName.equals(".gif") || endName.equals(".jpeg") || endName.equals(".bmp") || endName.equals(".png")) {
                                path1 = "images/stuImg/";
                            } else {
                                path1 = "word/";
                            }
                            String filePath = (new Date()).getTime() + endName;
                            File storeFile = new File(uploadPath + path1 + filePath);
                            // 保存文件到硬盘
                            item.write(storeFile);
                            if ("picture".equals(name)) {
                                resume.setPicture("/static/" + path1 + filePath);
                            }
                            if ("resumeFile".equals(name)) {
                                resume.setResumeFile("/static/" + path1 + filePath);
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }

        try {
            if(mapper.selectResumeId(resume.getStuUid())!=null){

                Resume resume1=mapper.showResume(((UserBase)session.getAttribute("currentUser")).getUserId());
                if(resume.getResumeFile()==null){
                    resume.setResumeFile(resume1.getResumeFile());
                }
                if(mapper.update(resume)==1){
                    sqlSession.commit();
                    if(mapper.updateStud(resume)==1){
                        sqlSession.commit();
                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"完善成功\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                        return;
                    }
                }
            }else {
            if(mapper.insertResume(resume)==1){
                sqlSession.commit();
                if(mapper.updateStud(resume)==1){
                    sqlSession.commit();
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"完善成功\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
                    return;
                }
            }
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }
    }
    private void listJob(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //查询出最新的招聘
        Job job=new Job();
        job.setStart(0);
        job.setPageNum(4);
        List<JobVo> list1=null;
        try {
            list1=mapper1.selectNewJob(job);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //查询出即将截止的招聘

        Job job2=new Job();
        job2.setStart(0);
        job2.setPageNum(4);
        List<JobVo> list2=null;
        try {
            list2=mapper1.selectJobEndTime(job2);
        } catch (Exception e) {
            e.printStackTrace();
        }




        Integer start = 0;
        Integer pageNum = 6;
        Integer pageNumber = null;
        Integer type=0;

        if (request.getParameter("number") != null) {
            start = Integer.parseInt(request.getParameter("number")) * pageNum;
        }

        Job job1 = new Job();
        job1.setStart(start);
        job1.setPageNum(pageNum);
        job1.setStatus(Short.parseShort("1"));

        UserBase user=null;
        if(session.getAttribute("currentUser")!=null){
            user=(UserBase)session.getAttribute("currentUser");
        }

        List list = null;
        try {
            list = mapper1.pageList(job1);
            //list3储存投递简历的工作

            List list3=new ArrayList<JobVo>();
            int size=list.size();
            for(int i=0;i<size;i++){
                ApplyResume applyResume=new ApplyResume();
                applyResume.setJobId(((JobVo)list.get(i)).getJobId());
                applyResume.setUserId(user.getUserId());
                ApplyResume ar=mapper2.selectApplyResume(applyResume);
                if(ar!=null) {
                    ((JobVo) list.get(i)).setApplyTime(ar.getApplyTime());
                }
                Short status=mapper2.selectStatus(applyResume);

                if(status==null){
                    //简历状态查看时若未投简历则移除

                    ((JobVo) list.get(i)).setType(0);//未投简历
                }else if(status==0){
                    list3.add(list.get(i));
                    ((JobVo) list.get(i)).setType(1);//未查看
                }else if(status==1){
                    list3.add(list.get(i));
                    ((JobVo) list.get(i)).setType(2);//简历通过
                }else if(status==2){
                    list3.add(list.get(i));
                    ((JobVo) list.get(i)).setType(3);//不匹配
                }
            }
            pageNumber = list.size();
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
            if("1".equals(request.getParameter("type"))){
                list=list3;
            }
            request.setAttribute("list", list);
            request.setAttribute("list1", list1);
            request.setAttribute("list2", list2);
            if("1".equals(request.getParameter("type"))){
                request.getRequestDispatcher("/jsp/stu/resumeList.jsp").forward(request, response);
            }else {
                request.getRequestDispatcher("/jsp/stu/jobList.jsp").forward(request, response);
            }


        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }

    }

}






