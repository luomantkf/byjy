package com.jy.model;

/**
 * Created by Administrator on 2017/2/21.
 */
public class Job extends UserBase{
    private int jobId;
    private int enterpriseId;
    private String jobName;
    private String jobNeed;
    //≤È—Ø≈–∂œÃÌº”
    private String condition;

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public int getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(int enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getJobNeed() {
        return jobNeed;
    }

    public void setJobNeed(String jobNeed) {
        this.jobNeed = jobNeed;
    }

    public String getJobAddress() {
        return jobAddress;
    }

    public void setJobAddress(String jobAddress) {
        this.jobAddress = jobAddress;
    }

    public String getJobAmount() {
        return jobAmount;
    }

    public void setJobAmount(String jobAmount) {
        this.jobAmount = jobAmount;
    }

    public String getJobSalary() {
        return jobSalary;
    }

    public void setJobSalary(String jobSalary) {
        this.jobSalary = jobSalary;
    }

    public String getJobEndTime() {
        return jobEndTime;
    }

    public void setJobEndTime(String jobEndTime) {
        this.jobEndTime = jobEndTime;
    }

    private String jobAddress;
    private String jobAmount;
    private String jobSalary;
    private String jobEndTime;
    private short status;

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    private String remark;


    public short getStatus() {
        return status;
    }

    public void setStatus(short status) {
        this.status = status;
    }
}
