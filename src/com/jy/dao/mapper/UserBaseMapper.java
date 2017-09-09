package com.jy.dao.mapper;

import com.jy.model.UserBase;

/**
 * Created by Administrator on 2017/2/13.
 */
public interface UserBaseMapper extends BaseMapper{
    Integer selectDetail(UserBase userBase)throws Exception;
    Integer updatePwd(UserBase userBase)throws Exception;
}
