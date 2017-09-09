package com.jy.dao.mapper;

import com.jy.model.Enterprise;
import com.jy.model.Job;
import com.jy.model.JobVo;
import com.jy.model.UserBase;

import java.util.List;

/**
 * Created by Administrator on 2017/2/13.
 */
public interface JobMapper extends BaseMapper{
   Integer insertJob(Job job)throws Exception;
   JobVo selectById(Integer jobId)throws Exception;
   Integer changStatus(Integer enterpriseId)throws Exception;
   List<JobVo> selectByEnterpriseName(JobVo jobVo)throws Exception;
   List<JobVo> selectByJobName(JobVo jobVo)throws Exception;
   List<JobVo> selectNewJob(Job job)throws Exception;
   List<JobVo> selectJobEndTime(Job job)throws Exception;
}
