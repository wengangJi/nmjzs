package com.zhongxin.cims.modules.sys.entity;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;

/**
 * Created by lqyu_773 on 14-6-10.
 */
@Entity
@javax.persistence.Table(name = "sys_batch", schema = "", catalog = "cims")
public class TSysEntity {
    private int batchId;

    @Id
    @javax.persistence.Column(name = "BATCH_ID")
    public int getBatchId() {
        return batchId;
    }

    public void setBatchId(int batchId) {
        this.batchId = batchId;
    }

    private String batchType;

    @Basic
    @javax.persistence.Column(name = "BATCH_TYPE")
    public String getBatchType() {
        return batchType;
    }

    public void setBatchType(String batchType) {
        this.batchType = batchType;
    }

    private String batchName;

    @Basic
    @javax.persistence.Column(name = "BATCH_NAME")
    public String getBatchName() {
        return batchName;
    }

    public void setBatchName(String batchName) {
        this.batchName = batchName;
    }

    private int beginNo;

    @Basic
    @javax.persistence.Column(name = "BEGIN_NO")
    public int getBeginNo() {
        return beginNo;
    }

    public void setBeginNo(int beginNo) {
        this.beginNo = beginNo;
    }

    private int endNo;

    @Basic
    @javax.persistence.Column(name = "END_NO")
    public int getEndNo() {
        return endNo;
    }

    public void setEndNo(int endNo) {
        this.endNo = endNo;
    }

    private String appId;

    @Basic
    @javax.persistence.Column(name = "APP_ID")
    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    private int companyId;

    @Basic
    @javax.persistence.Column(name = "COMPANY_ID")
    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    private String createBy;

    @Basic
    @javax.persistence.Column(name = "CREATE_BY")
    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    private Date createDate;

    @Basic
    @javax.persistence.Column(name = "CREATE_DATE")
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    private String updateBy;

    @Basic
    @javax.persistence.Column(name = "UPDATE_BY")
    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    private Date updateDate;

    @Basic
    @javax.persistence.Column(name = "LEG_PERSON")
    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    private String deleteBy;

    @Basic
    @javax.persistence.Column(name = "DELETE_BY")
    public String getDeleteBy() {
        return deleteBy;
    }

    public void setDeleteBy(String deleteBy) {
        this.deleteBy = deleteBy;
    }

    private Date deleteDate;

    @Basic
    @javax.persistence.Column(name = "DELETE_DATE")
    public Date getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
    }

    private String rsrvStr1;

    @Basic
    @javax.persistence.Column(name = "RSRV_STR1")
    public String getRsrvStr1() {
        return rsrvStr1;
    }

    public void setRsrvStr1(String rsrvStr1) {
        this.rsrvStr1 = rsrvStr1;
    }

    private String rsrvStr2;

    @Basic
    @javax.persistence.Column(name = "RSRV_STR2")
    public String getRsrvStr2() {
        return rsrvStr2;
    }

    public void setRsrvStr2(String rsrvStr2) {
        this.rsrvStr2 = rsrvStr2;
    }

    private String rsrvStr3;

    @Basic
    @javax.persistence.Column(name = "RSRV_STR3")
    public String getRsrvStr3() {
        return rsrvStr3;
    }

    public void setRsrvStr3(String rsrvStr3) {
        this.rsrvStr3 = rsrvStr3;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TSysEntity that = (TSysEntity) o;

        if (batchId != that.batchId) return false;
        if (batchType != null ? !batchType.equals(that.batchType) : that.batchType != null) return false;
        if (batchName != null ? !batchName.equals(that.batchName) : that.batchName != null) return false;
        if (beginNo != that.beginNo) return false;
        if (endNo != that.endNo) return false;
        if (appId != null ? !appId.equals(that.appId) : that.appId != null) return false;
        if (companyId != that.companyId) return false;
        if (createBy != null ? !createBy.equals(that.createBy) : that.createBy != null)
            return false;
        if (createDate != null ? !createDate.equals(that.createDate) : that.createDate != null) return false;
        if (updateBy != null ? !updateBy.equals(that.updateBy) : that.updateBy != null) return false;
        if (updateDate != null ? !updateDate.equals(that.updateDate) : that.updateDate != null) return false;
        if (deleteBy != null ? !deleteBy.equals(that.deleteBy) : that.deleteBy != null) return false;
        if (deleteDate != null ? !deleteDate.equals(that.deleteDate) : that.deleteDate != null) return false;
        if (rsrvStr1 != null ? !rsrvStr1.equals(that.rsrvStr1) : that.rsrvStr1 != null) return false;
        if (rsrvStr2 != null ? !rsrvStr2.equals(that.rsrvStr2) : that.rsrvStr2 != null) return false;
        if (rsrvStr3 != null ? !rsrvStr3.equals(that.rsrvStr3) : that.rsrvStr3 != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = batchId;
        result = 31 * result + (batchType != null ? batchType.hashCode() : 0);
        result = 31 * result + (batchName != null ? batchName.hashCode() : 0);
        result = 31 * result + beginNo;
        result = 31 * result + endNo;
        result = 31 * result + (appId != null ? appId.hashCode() : 0);
        result = 31 * result + companyId;
        result = 31 * result + (createBy != null ? createBy.hashCode() : 0);
        result = 31 * result + (createDate != null ? createDate.hashCode() : 0);
        result = 31 * result + (updateBy != null ? updateBy.hashCode() : 0);
        result = 31 * result + (updateDate != null ? updateDate.hashCode() : 0);
        result = 31 * result + (deleteBy != null ? deleteBy.hashCode() : 0);
        result = 31 * result + (deleteDate != null ? deleteDate.hashCode() : 0);
        result = 31 * result + (rsrvStr1 != null ? rsrvStr1.hashCode() : 0);
        result = 31 * result + (rsrvStr2 != null ? rsrvStr2.hashCode() : 0);
        result = 31 * result + (rsrvStr3 != null ? rsrvStr3.hashCode() : 0);

        return result;
    }
}
