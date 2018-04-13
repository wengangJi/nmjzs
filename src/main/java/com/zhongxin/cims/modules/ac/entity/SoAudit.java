package com.zhongxin.cims.modules.ac.entity;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/10/3
 * Time: 8:58
 * To change this template use File | Settings | File Templates.
 */

public class SoAudit {
    private Long id;

    private String soid;

    private String auditType;//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'

    private  String auditTag;//审核标记

    private  String auditBy;//审核人

    private  String auditLevel;//0-初审 1-复审 2-终审

    private Date auditDate ;//'审核时间'

    private  String auditInfo;//'审核信息'

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    public SoAudit(){
        this.sts = "0";
        this.stsDate = new Date();
    }

    // 临时属性
    private Long soHoursId;

    public Long getSoHoursId() {
        return soHoursId;
    }

    public void setSoHoursId(Long soHoursId) {
        this.soHoursId = soHoursId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid == null ? null : soid.trim();
    }

    public String getAuditType() {
        return auditType;
    }

    public void setAuditType(String auditType) {
        this.auditType = auditType == null ? null : auditType.trim();
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

    public String getAuditLevel() {
        return auditLevel;
    }

    public void setAuditLevel(String auditLevel) {
        this.auditLevel = auditLevel == null ? null : auditLevel.trim();
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
