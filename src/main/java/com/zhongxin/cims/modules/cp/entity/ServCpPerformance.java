package com.zhongxin.cims.modules.cp.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.cp.dao.ServCpPerformanceMapper;

import java.util.Date;

public class ServCpPerformance extends BaseEntity<ServCpPerformance> {
    private Integer servid;

    private String honorCase;

    private String penaltyCase;

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