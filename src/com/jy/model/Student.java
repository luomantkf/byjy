package com.jy.model;

/**
 * Created by Administrator on 2017/2/18.
 */
public class Student extends UserBase{
    private int stuUid;
    private int resumeId;

    public int getResumeId() {
        return resumeId;
    }

    public void setResumeId(int resumeId) {
        this.resumeId = resumeId;
    }

    private String stuName;
    private String stuID;
    private short sex;
    private String idCard;
    private String education;
    private String workWhere;
    private String phone;

    public String getSchoolExperience() {
        return schoolExperience;
    }

    public void setSchoolExperience(String schoolExperience) {
        this.schoolExperience = schoolExperience;
    }

    public String getWorkExperience() {
        return workExperience;
    }

    public void setWorkExperience(String workExperience) {
        this.workExperience = workExperience;
    }

    private String academy;
    private String profession;
    private String intention;
    private String positionName;
    private String condition;
    private String schoolExperience;
    private String workExperience;

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getAcademy() {
        return academy;
    }

    public void setAcademy(String academy) {
        this.academy = academy;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getIntention() {
        return intention;
    }

    public void setIntention(String intention) {
        this.intention = intention;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getStuUid() {
        return stuUid;
    }

    public void setStuUid(int stuUid) {
        this.stuUid = stuUid;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getStuID() {
        return stuID;
    }

    public void setStuID(String stuID) {
        this.stuID = stuID;
    }

    public short getSex() {
        return sex;
    }

    public void setSex(short sex) {
        this.sex = sex;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getWorkWhere() {
        return workWhere;
    }

    public void setWorkWhere(String workWhere) {
        this.workWhere = workWhere;
    }
}
