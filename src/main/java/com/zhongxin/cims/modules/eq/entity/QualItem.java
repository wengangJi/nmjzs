package com.zhongxin.cims.modules.eq.entity;

import java.util.Date;

public class QualItem {
    private Integer servid;

    private Integer seq;

    private String parentQualType;

    private String mainFlag;

    private String qualType;

    private String qualLevel;

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

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getParentQualType() {
        return parentQualType;
    }

    public void setParentQualType(String parentQualType) {
        this.parentQualType = parentQualType == null ? null : parentQualType.trim();
    }

    public String getMainFlag() {
        return mainFlag;
    }

    public void setMainFlag(String mainFlag) {
        this.mainFlag = mainFlag == null ? null : mainFlag.trim();
    }

    public String getQualType() {
        return qualType;
    }

    public void setQualType(String qualType) {
        this.qualType = qualType == null ? null : qualType.trim();
    }

    public String getQualLevel() {
        return qualLevel;
    }

    public void setQualLevel(String qualLevel) {
        this.qualLevel = qualLevel == null ? null : qualLevel.trim();
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
}