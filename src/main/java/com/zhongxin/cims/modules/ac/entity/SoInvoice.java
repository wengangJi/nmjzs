package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.common.utils.excel.annotation.ExcelField;

import java.util.Date;

public class SoInvoice extends BaseEntity<SoInvoice> {
    @ExcelField(title="申报单号", align=2, sort=60)
    private String soid;
    private String userId;
    @ExcelField(title="发票抬头", align=2, sort=62)
    private String title;
    @ExcelField(title="发票申请时间", align=2, sort=63)
    private Date applyDate;

    private Float fee;
    @ExcelField(title="联系电话", align=2, sort=68)

    private String contactPhone;
    @ExcelField(title="联系人", align=2, sort=67)

    private String contactName;
    @ExcelField(title="邮编", align=2, sort=66)
    private String postCode;
    @ExcelField(title="邮寄地址", align=2, sort=65)
    private String postAddress;
    @ExcelField(title="支付方式", align=2, sort=70)
    private String companyName;

    private String remark;

    private String auditTag;

    private String auditBy;

    private Date auditDate;

    private String auditInfo;
    @ExcelField(title="物流单号", align=2, sort=69)
    private String rsrvStr1;
    @ExcelField(title="发票金额", align=2, sort=64)
    private String rsrvStr2;
    @ExcelField(title="发票申请人", align=2, sort=61)
    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    // 临时属性
    private String startTime;
    private String endTime;

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public SoInvoice() {
        this.sts = "0";
        this.stsDate = new Date();
        this.applyDate = new Date();
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public Float getFee() {
        return fee;
    }

    public void setFee(Float fee) {
        this.fee = fee;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone == null ? null : contactPhone.trim();
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName == null ? null : contactName.trim();
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode == null ? null : postCode.trim();
    }

    public String getPostAddress() {
        return postAddress;
    }

    public void setPostAddress(String postAddress) {
        this.postAddress = postAddress == null ? null : postAddress.trim();
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName == null ? null : companyName.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getAuditTag() {
        return auditTag;
    }

    public void setAuditTag(String auditTag) {
        this.auditTag = auditTag == null ? null : auditTag.trim();
    }

    public String getAuditBy() {
        return auditBy;
    }

    public void setAuditBy(String auditBy) {
        this.auditBy = auditBy == null ? null : auditBy.trim();
    }

    public Date getAuditDate() {
        return auditDate;
    }

    public void setAuditDate(Date auditDate) {
        this.auditDate = auditDate;
    }

    public String getAuditInfo() {
        return auditInfo;
    }

    public void setAuditInfo(String auditInfo) {
        this.auditInfo = auditInfo == null ? null : auditInfo.trim();
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