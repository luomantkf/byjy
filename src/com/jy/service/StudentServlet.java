package com.jy.service;



import com.jy.dao.mapper.ManagerMapper;
import com.jy.dao.mapper.StudentMapper;
import com.jy.model.Manager;
import com.jy.model.Student;
import com.jy.model.UserBase;
import com.jy.util.DbUtil;
import com.jy.util.MD5Util;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.ibatis.session.SqlSession;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *增加用户的处理类
 */
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    //
    private static List<Student> slist=null;
    //用来保存查询学生的状态
    private static StringBuilder condition=null;
    DbUtil dbUtil=new DbUtil();
    StudentMapper mapper=null;
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
        session = request.getSession();

        //每次会话都要重新建立以防止mybatis的一级缓存
        try {
            sqlSession = dbUtil.getSqlSession();
        } catch (Exception e) {
            e.printStackTrace();
        }
        mapper = sqlSession.getMapper(StudentMapper.class);

        int action = Integer.parseInt(request.getParameter("action"));
        switch (action) {
            case 0:
                exprotStudent(request, response);
                break;
            case 1:
                listStudent(request, response);
                break;
            case 2:
                showStudent(request,response);break;
            case 3:
                deleteStudent(request, response);
                break;
        }
    }

    /**
     * 导入毕业生信息
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void exprotStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Student student=null;
        UserBase userBase=null;
        Workbook wb=null;
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

        try {
            List<FileItem> formItems = null;
            try {
                formItems = upload.parseRequest(request);
            } catch (FileUploadException e) {
                e.printStackTrace();
            }

            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    //处理在表单的数据
                    if (item.isFormField()) {
                    }
                    // 处理不在表单中的字段
                    else {
                        String fileName = new File(item.getName()).getName();
                        if(fileName.equals("")){
                            PrintWriter pw = response.getWriter();
                            pw.print("<script>alert(\"未选文件\");window.location.href=\"/studentServlet.do?action=1\"</script>");
                            return;
                        }
                        String endName = fileName.substring(fileName.indexOf("."));//后缀名
                        if (endName.equals(".xlsx")) {
                            try {
                                wb = new XSSFWorkbook(item.getInputStream());
                            } catch (IOException e) {

                            }
                        }
                        if(endName.equals(".xls")){
                            POIFSFileSystem poifsFileSystem=null;
                            try {
                                poifsFileSystem=new POIFSFileSystem(item.getInputStream());
                            } catch (IOException e1) {
                                e1.printStackTrace();
                            }
                            wb=new HSSFWorkbook(poifsFileSystem);
                        }


                            try {
                                if(wb!=null){
                                    for(int sheetIndex=0;sheetIndex<wb.getNumberOfSheets();sheetIndex++){//得到sheet数
                                        Sheet sheet=wb.getSheetAt(sheetIndex);
                                        if(sheet!=null){

                                            for(int rowIndex=1;rowIndex<=sheet.getLastRowNum();rowIndex++){//得到总行数
                                                Row row=sheet.getRow(rowIndex);
                                                if(row!=null){
                                                    student=new Student();
                                                    for(int columnIndex=0;columnIndex<row.getPhysicalNumberOfCells();columnIndex++){//得到总列数
                                                        Cell cell=row.getCell(columnIndex);
                                                        for(int i=0;i<10;i++){

                                                        }
                                                        if(cell!=null) {
                                                            switch (columnIndex){
                                                                case 0:student.setStuID(getValue(cell));break;
                                                                case 1:student.setStuName(getValue(cell));break;
                                                                case 2:student.setAcademy(getValue(cell));break;
                                                                case 3:student.setProfession(getValue(cell));break;

                                                                case 4:if(getValue(cell).equals("男")){
                                                                    student.setSex(Short.parseShort("1"));
                                                                }else {
                                                                    student.setSex(Short.parseShort("0"));
                                                                }break;
                                                                case 5:student.setPhone(getValue(cell));break;
                                                                case 6:student.setEducation(getValue(cell));break;
                                                                case 7:student.setIdCard(getValue(cell));
                                                                    student.setPassword(MD5Util.EncoderPwdByMd5(getValue(cell).substring(getValue(cell).length()-6,getValue(cell).length())));
                                                                    break;

                                                                case 8:if(getValue(cell).equals("未就业")){
                                                                    student.setWorkWhere(null);
                                                                }
                                                                    else{
                                                                    student.setWorkWhere(getValue(cell));
                                                                }break;
                                                                case 9:student.setIntention(getValue(cell));break;
                                                                case 10:if(getValue(cell).equals("无")){
                                                                    student.setPositionName(null);
                                                                }
                                                                else{
                                                                    student.setPositionName(getValue(cell));
                                                                }break;

                                                                }
                                                            }
                                                    }
                                                            student.setUserType(Short.parseShort("1"));
                                                            if(student!=null){
                                                                try {
                                                                    if(mapper.insertStudent(student)==1){
                                                                        sqlSession.commit();
                                                                    }
                                                                    if(mapper.insert(student)==1){
                                                                        sqlSession.commit();
                                                                    }else{
                                                                        PrintWriter pw = response.getWriter();
                                                                        pw.print("<script>alert(\"error\");window.location.href=\"/studentServlet.do?action=1\"</script>");
                                                                        return;
                                                                    }
                                                                } catch (Exception e) {
                                                                    //PrintWriter pw = response.getWriter();
                                                                    //pw.print("<script>alert(\"\");window.location.href=\"/studentServlet.do?action=1\"</script>");
                                                                    //return;
                                                                }
                                                            }

                                                        }

                                                    }
                                                    dbUtil.closeSqlSession(sqlSession);
                                                    PrintWriter pw = response.getWriter();
                                                    pw.print("<script>alert(\"添加成功\");window.location.href=\"/studentServlet.do?action=1\"</script>");
                                                     return;

                                                }
                                            }
                                        }


                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                }


                }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    private void listStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {





        Integer start=0;
        Integer pageNum=6;
        Integer pageNumber=null;
        Integer status=null;

        //根据是否就业的条件来筛选
        if(request.getParameter("status")!=null){
            condition=new StringBuilder();
            //判别是否就业
            status=Integer.parseInt(request.getParameter("status"));
            if(status==0){
                condition.append("  AND workWhere is  null ");
            }else {
                condition.append("  AND workWhere is not null ");
            }
        }



        if(request.getParameter("number")!=null){
            start=Integer.parseInt(request.getParameter("number"))*pageNum;
        }


        Student student=new Student();
        student.setUserId(20);
        student.setDetail(1);
        student.setUserType(Short.parseShort("1"));
        student.setStart(start);
        student.setPageNum(pageNum);
        //根据条件来筛选
        if(request.getParameter("condition")!=null){
            condition=new StringBuilder();
            String condition1=request.getParameter("condition");
            //4040404代表是从主页面跳转的需要置condition为null
            if(!"".equals(condition1)&&!"4040404".equals(condition1)){
                if(request.getParameter("type")!=null){
                    int type=Integer.parseInt(request.getParameter("type"));
                    switch (type){
                        case 0: condition.append("AND stuID like \"%" + condition1 + "%\"");break;
                        case 1: condition.append("AND stuName like \"%" + condition1 + "%\"");break;
                        case 2: condition.append("AND academy like \"%"+condition1+"%\"");break;
                        case 3: condition.append("AND intention like \"%"+condition1+"%\"");break;
                        case 4: condition.append("AND profession like \"%"+condition1+"%\"");break;
                    }
                }
            }else {
                condition=null;
            }
        }
        if(condition!=null) {
            student.setCondition(condition.toString());
        }

        List list = null;
        list =mapper.pageList(student);
        slist=list;
        pageNumber=mapper.pageRows(student);
        float ratio=0;
        //计算就业率
        List list11=null;
        //只有在根据学院进行搜索的时候才根据条件来查就业率
        if(!"2".equals(request.getParameter("type"))){
            student.setCondition(null);
        }
        if((list11=mapper.listAll(student)).size()!=0) {
            int notWorkCount = 0;
            for (int i = 0; i < list11.size(); i++) {
                Student student1 = (Student) list11.get(i);
                if (student1.getWorkWhere() == null || student1.getPositionName()==null) {
                    notWorkCount++;
                }
            }
            ratio = ((float)(list11.size()-notWorkCount) / (float) list11.size()) * 100;
            //保留两位小数点
            DecimalFormat decimal=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
            ratio=Float.parseFloat(decimal.format(ratio));        //format 返回的是字符串
        }

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
        request.setAttribute("ratio",String.valueOf(ratio));
        request.setAttribute("number", String.valueOf(number));
        request.setAttribute("maxPage", String.valueOf(maxPage));
        request.setAttribute("pageNumber",String.valueOf(pageNumber));
        request.setAttribute("list", list);
        if("1".equals(request.getParameter("ctype"))){
            request.getRequestDispatcher("/jsp/enterprise/studList.jsp").forward(request,response);
        }else {
            request.getRequestDispatcher("/jsp/manager/studList.jsp").forward(request, response);
        }
    }
    private void showStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer stuUid=Integer.parseInt(request.getParameter("stuUid"));
        try {
            Student student=mapper.selectById(stuUid);
            if(student!=null){
                request.setAttribute("student",student);
                request.getRequestDispatcher("/jsp/manager/showStu.jsp").forward(request,response);
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/mainPage.jsp\"</script>");
            return;
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId=Integer.parseInt(request.getParameter("userId"));
        Integer managerId=Integer.parseInt(request.getParameter("stuUid"));

        try {
            if(mapper.deleteStudent(managerId)==1&&mapper.delete(userId)==1){
                sqlSession.commit();
                dbUtil.closeSqlSession(sqlSession);
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"删除成功\");window.location.href=\"/studentServlet.do?action=1\"</script>");
                return;
            }
        } catch (Exception e) {
            PrintWriter pw = response.getWriter();
            pw.print("<script>alert(\"error\");window.location.href=\"/studentServlet.do?action=1\"</script>");
            return;
        }
    }
    /**
     * 得到不同类型的单元格值
     * @param cell
     * @return
     */
    public static String getValue(Cell cell){
        String cellValue=null;
        switch(cell.getCellType()){
            case XSSFCell.CELL_TYPE_BOOLEAN:
                cellValue=String.valueOf(cell.getBooleanCellValue());
                break;
            case XSSFCell.CELL_TYPE_STRING:
                cellValue=String.valueOf(cell.getStringCellValue());
                break;
            case XSSFCell.CELL_TYPE_NUMERIC:
                DecimalFormat df=new DecimalFormat("0");
                cellValue=df.format(cell.getNumericCellValue());
                break;
        }
        return  cellValue;
    }
}






