package com.zhongxin.cims.modules.ac.entity;

import java.util.Date;

public class AssociateConstructorMajor {
    private Integer servid;

    private Integer seq;

    private String parentMajor;

    private String major;

    private Date effDate;

    private Date expDate;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private Integer presTime;

    private Integer elecTime;

    private String sts;

    private Date stsDate;

    private String remarks;

    public Integer getServid() {
        return servid;
    }

    public void setServid(Integer servid) {
        this.servid = servid;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getParentMajor() {
        return parentMajor;
    }

    public void setParentMajor(String parentMajor) {
        this.parentMajor = parentMajor == null ? null : parentMajor.trim();
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major == null ? null : major.trim();
    }

    public Date getEffDate() {
        return effDate;
    }

    public void setEffDate(Date effDate) {
        this.effDate = effDate;
    }

    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
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

    public Integer getPresTime() {
        return presTime;
    }

    public void setPresTime(Integer presTime) {
        this.presTime = presTime;
    }

    public Integer getElecTime() {
        return elecTime;
    }

    public void setElecTime(Integer elecTime) {
        this.elecTime = elecTime;
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

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }
}