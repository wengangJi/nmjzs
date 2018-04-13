package com.zhongxin.cims.modules.common.entity;

import com.fasterxml.jackson.databind.deser.Deserializers;
import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.comp.entity.Company;

import java.util.Date;

public class Serv extends BaseEntity<Serv> {
    private Integer servid;

    private String qrId;

    private String userId;

    private Integer companyId;

    private String batchId;

    private String appId;

    private String provinceId;

    private Integer localId;

    private Integer areaId;

    private String mongoFlag;

    private String backlistFlag;

    private String relationFlag;

    private Date applDate;

    private Date complDate;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    private String remarks;

    public Integer getServid() {
        return servid;
    }

    public void setServid(Integer servid) {
        this.servid = servid;
    }

    public String getQrId() {
        return qrId;
    }

    public void setQrId(String qrId) {
        this.qrId = qrId == null ? null : qrId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId == null ? null : batchId.trim();
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId == null ? null : appId.trim();
    }

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId == null ? null : provinceId.trim();
    }

    public Integer getLocalId() {
        return localId;
    }

    public void setLocalId(Integer localId) {
        this.localId = localId;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public String getMongoFlag() {
        return mongoFlag;
    }

    public void setMongoFlag(String mongoFlag) {
        this.mongoFlag = mongoFlag == null ? null : mongoFlag.trim();
    }

    public String getBacklistFlag() {
        return backlistFlag;
    }

    public void setBacklistFlag(String backlistFlag) {
        this.backlistFlag = backlistFlag == null ? null : backlistFlag.trim();
    }

    public String getRelationFlag() {
        return relationFlag;
    }

    public void setRelationFlag(String relationFlag) {
        this.relationFlag = relationFlag == null ? null : relationFlag.trim();
    }

    public Date getApplDate() {
        return applDate;
    }

    public void setApplDate(Date applDate) {
        this.applDate = applDate;
    }

    public Date getComplDate() {
        return complDate;
    }

    public void setComplDate(Date complDate) {
        this.complDate = complDate;
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

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    private Company company;

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }
}