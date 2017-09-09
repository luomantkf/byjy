package com.jy.dao.mapper;

import com.jy.model.Manager;

/**
 * Created by Administrator on 2017/2/13.
 */
public interface ManagerMapper extends BaseMapper{
    String getUserName(Integer id) throws Exception;
    Integer insertManager(Manager manager)throws Exception;
    Integer deleteManager(Integer managerId);
}
