package com.jy.dao.mapper;

import java.util.List;

/**
 * Created by Administrator on 2017/2/14.
 */
public interface BaseMapper {
    //新增
    Integer insert(Object obj);
    //编辑
    Integer update(Object obj);
    //删除
    Integer delete(Object obj);
    //查询
    Object select(Object obj);
    //分页行数查询
    Integer pageRows(Object obj);
    //分页数据
    List<Object> pageList(Object obj);
}
