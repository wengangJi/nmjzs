package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

public class SoCourse extends BaseEntity<SoCourse> {
    private String soid;

    private String userId;

    private Course course;

    private Date applyDate;

    private Date startDate;

    private Date finishDate;

    private Date expDate;

    private String auditTag;

    private String valid;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    public SoCourse() {
        this.sts = "0";
        this.stsDate = new Date();
        this.applyDate = new Date();
        this.auditTag = "0";
    }

    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid == null ? null : soid.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
    }

    public String getAuditTag() {
        return auditTag;
    }

    public void setAuditTag(String auditTag) {
        this.auditTag = auditTag == null ? null : auditTag.trim();
    }

    public String getValid() {
        return valid;
    }

    public void setValid(String valid) {
        this.valid = valid == null ? null : valid.trim();
    }

    public String getRsrvStr1() {
        return rsrvStr1;
    }

    public void setRsrvStr1(String rsrvStr1) {
        this.rsrvStr1 = rsrvStr1 == null ? null : rsrvStr1.trim();
    }

    public String getRsrvStr2() {
        return rsrvStr2;
    }

    public void setRsrvStr2(String rsrvStr2) {
        this.rsrvStr2 = rsrvStr2 == null ? null : rsrvStr2.trim();
    }

    public String getRsrvStr3() {
        return rsrvStr3;
    }

    public void setRsrvStr3(String rsrvStr3) {
        this.rsrvStr3 = rsrvStr3 == null ? null : rsrvStr3.trim();
    }

    public String getSts() {
        return sts;
    }

    public void setSts(String sts) {
        this.sts = sts == null ? null : sts.trim();
    }

    public Date getStsDate() {
        return stsDate;
    }

    public void setStsDate(Date stsDate) {
        this.stsDate = stsDate;
    }
}