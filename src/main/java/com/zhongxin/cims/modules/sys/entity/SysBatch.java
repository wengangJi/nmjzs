package com.zhongxin.cims.modules.sys.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.sys.utils.DictUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;

import java.util.Date;

public class SysBatch extends BaseEntity<SysBatch> {
    private String batchId;

    private String batchType;

    private String batchName;

    private Integer batchYear;

    private Integer batchMonth;

    private Integer batchSeq;

    private Integer beginNo;

    private Integer endNo;

    private String appId;

    private Integer companyId;

    private String createBy;

    private Date createDate;

    private String updateBy;

    private Date updateDate;

    private String deleteBy;

    private Date deleteDate;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    public String geneSysBatchId(){
        return      this.getBatchYear().toString()+this.getBatchMonth().toString()+this.getAppId()+UserUtils.getUser().getUserCompany().getCompanyId()+this.getBatchType()+this.getBatchSeq().toString();

    }
    public String geneSysBatchName(){
        return      DictUtils.getDictLabel(this.appId, "APP_ID", "")+
                     DictUtils.getDictLabel(this.batchType, "BATCH_TYPE", "")+
                     DictUtils.getDictLabel(this.getBatchYear().toString(), "BATCH_YEAR", "")+
                     DictUtils.getDictLabel(this.getBatchMonth().toString(), "BATCH_MONTH", "")+
                     DictUtils.getDictLabel(this.getBatchSeq().toString(), "BATCH_SEQ", "") +"(" +
                     UserUtils.getUser().getUserCompany().getCompanyName() +")" ;


    }
    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId == null ? null : batchId.trim();
    }

    public String getBatchType() {
        return batchType;
    }

    public void setBatchType(String batchType) {
        this.batchType = batchType == null ? null : batchType.trim();
    }

    public String getBatchName() {
        return batchName;
    }

    public void setBatchName(String batchName) {
        this.batchName = batchName == null ? null : batchName.trim();
    }

    public Integer getBatchYear() {
        return batchYear;
    }

    public void setBatchYear(Integer batchYear) {
        this.batchYear = batchYear;
    }

    public Integer getBatchMonth() {
        return batchMonth;
    }

    public void setBatchMonth(Integer batchMonth) {
        this.batchMonth = batchMonth;
    }

    public Integer getBatchSeq() {
        return batchSeq;
    }

    public void setBatchSeq(Integer batchSeq) {
        this.batchSeq = batchSeq;
    }

    public Integer getBeginNo() {
        return beginNo;
    }

    public void setBeginNo(Integer beginNo) {
        this.beginNo = beginNo;
    }

    public Integer getEndNo() {
        return endNo;
    }

    public void setEndNo(Integer endNo) {
        this.endNo = endNo;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId == null ? null : appId.trim();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getDeleteBy() {
        return deleteBy;
    }

    public void setDeleteBy(String deleteBy) {
        this.deleteBy = deleteBy == null ? null : deleteBy.trim();
    }

    public Date getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
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