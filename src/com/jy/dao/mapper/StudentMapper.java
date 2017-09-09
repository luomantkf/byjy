package com.jy.dao.mapper;

import com.jy.model.Manager;
import com.jy.model.Student;

import java.util.List;

/**
 * Created by Administrator on 2017/2/13.
 */
public interface StudentMapper extends BaseMapper{
    Integer insertStudent(Student student)throws Exception;
    Integer deleteStudent(Integer stuUid)throws Exception;
    String selectStuName(String stuId)throws Exception;
    Student selectById(Integer stuUid)throws Exception;
    List<Student> listAll(Student student);
}
