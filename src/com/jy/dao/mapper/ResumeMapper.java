package com.jy.dao.mapper;

import com.jy.model.Resume;

/**
 * Created by Administrator on 2017/2/13.
 */
public interface ResumeMapper extends BaseMapper{
    Integer insertResume(Resume resume)throws Exception;
    Integer updateStud(Resume resume)throws Exception;
    Resume showResume(Integer userId)throws  Exception;
    Resume showResume2(Integer userId)throws  Exception;
    Integer selectResumeId(Integer stuUid)throws  Exception;

}
