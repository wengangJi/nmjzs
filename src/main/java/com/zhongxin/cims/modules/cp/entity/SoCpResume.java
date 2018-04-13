package com.zhongxin.cims.modules.cp.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

public class SoCpResume  extends BaseEntity<SoCpResume> {


    private String soid;

    private String actType;

    private Integer seq;

    private String company;

    private String position;

    private Date effDate;

    private Date expDate;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;


    private String appId;

    public String getSoType() {
        return soType;
    }

    public void setSoType(String soType) {
        this.soType = soType;
    }

    private String soType;
    private String pageModule;


    public void setAppId(String appId) {
        this.appId = appId;
    }

    public void setPageModule(String pageModule) {
        this.pageModule = pageModule;
    }

    public String getAppId() {
        return appId;
    }

    public String getPageModule() {
        return pageModule;
    }




    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid == null ? null : soid.trim();
    }

    public String getActType() {
        return actType;
    }

    public void setActType(String actType) {
        this.actType = actType == null ? null : actType.trim();
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company == null ? null : company.trim();
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position == null ? null : position.trim();
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
}