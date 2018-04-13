package com.zhongxin.cims.modules.cp.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

public class SoCpPerformance  extends BaseEntity<SoCpPerformance> {
    private String soid;

    private String actType;

    private Integer seq;

    private String honorCase;

    private String penaltyCase;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    public String getSoType() {
        return soType;
    }

    public void setSoType(String soType) {
        this.soType = soType;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    private String soType;

    private String appId;


    public String getPageModule() {
        return pageModule;
    }

    public void setPageModule(String pageModule) {
        this.pageModule = pageModule;
    }

    private String pageModule;

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

    public String getHonorCase() {
        return honorCase;
    }

    public void setHonorCase(String honorCase) {
        this.honorCase = honorCase == null ? null : honorCase.trim();
    }

    public String getPenaltyCase() {
        return penaltyCase;
    }

    public void setPenaltyCase(String penaltyCase) {
        this.penaltyCase = penaltyCase == null ? null : penaltyCase.trim();
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