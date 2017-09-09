package com.jy.model;

/**
 * Created by Administrator on 2017/2/16.
 */
public class Manager extends UserBase{
    public String getManagerId() {
        return managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }

    private String managerId;
    private String phone;

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
