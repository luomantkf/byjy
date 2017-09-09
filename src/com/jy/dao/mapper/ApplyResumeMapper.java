package com.jy.dao.mapper;

import com.jy.model.ApplyResume;
import com.jy.model.ApplyResumeVo;
import com.jy.model.Resume;
import org.apache.ibatis.annotations.Param;

/**
 * Created by Administrator on 2017/2/13.
 */
public interface ApplyResumeMapper extends BaseMapper{
    Integer insertApplyResume(ApplyResume applyResume)throws Exception;
    Short selectStatus(ApplyResume applyResume)throws Exception;
    Integer changStatus(@Param("applyResumeId") Integer applyResumeId, @Param("status") Integer status)throws Exception;
    ApplyResume selectApplyResume(ApplyResume applyResume)throws Exception;
}
