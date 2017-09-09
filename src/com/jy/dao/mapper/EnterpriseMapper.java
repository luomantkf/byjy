package com.jy.dao.mapper;

import com.jy.model.Enterprise;
import com.jy.model.Student;
import com.jy.model.UserBase;

/**
 * Created by Administrator on 2017/2/13.
 */
public interface EnterpriseMapper extends BaseMapper{
   Integer insertEnterprise(Enterprise enterprise)throws Exception;
    Integer updateBaseDetail(Enterprise enterprise)throws Exception;
    Short getStatus(UserBase userBase)throws Exception;
    Integer changStatus(Integer enterpriseId)throws Exception;
    Enterprise selectById(Integer enterpriseId)throws Exception;
}
