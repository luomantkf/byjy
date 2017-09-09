package com.jy.model;

/**
 * Created by Administrator on 2017/2/26.
 */
public class ApplyResume extends UserBase{
    private int applyResumeId;
    private int jobId;
    private int userId;
    private short status;
    private String applyTime;

    public int getApplyResumeId() {
        return applyResumeId;
    }

    public void setApplyResumeId(int applyResumeId) {
        this.applyResumeId = applyResumeId;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public short getStatus() {
        return status;
    }

    public void setStatus(short status) {
        this.status = status;
    }

    public String getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(String applyTime) {
        this.applyTime = applyTime;
    }
}
