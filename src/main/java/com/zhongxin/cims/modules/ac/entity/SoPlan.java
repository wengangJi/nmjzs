
package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

public class SoPlan extends BaseEntity<SoPlan> {
    private String soid;

    private String userId;

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    private Integer companyId;

    private Long planId;

    private Date applyDate;

    private Date finishDate;

    private Date expDate;

    private String feeId;

    private Float fee;

    private String feeState;

    private Integer localId;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    private String hourState;

    private String learnState;

    private String examState;

    private String certState;

    private String reduceFlag;

    private String cores;

    private String examTime;

    private String checkLevel;

    private String oflineUser;

    public String getOflineUser() {
        return oflineUser;
    }

    public void setOflineUser(String oflineUser) {
        this.oflineUser = oflineUser;
    }

    public String getOflineNo() {
        return oflineNo;
    }

    public void setOflineNo(String oflineNo) {
        this.oflineNo = oflineNo;
    }

    public String getOflineRemarks() {
        return oflineRemarks;
    }

    public void setOflineRemarks(String oflineRemarks) {
        this.oflineRemarks = oflineRemarks;
    }

    public String getOflinePath() {
        return oflinePath;
    }

    public void setOflinePath(String oflinePath) {
        this.oflinePath = oflinePath;
    }

    public String getOflineSts() {
        return oflineSts;
    }

    public void setOflineSts(String oflineSts) {
        this.oflineSts = oflineSts;
    }

    public Date getOflineStsDate() {
        return oflineStsDate;
    }

    public void setOflineStsDate(Date oflineStsDate) {
        this.oflineStsDate = oflineStsDate;
    }

    public String getOflineAuditBy() {
        return oflineAuditBy;
    }

    public void setOflineAuditBy(String oflineAuditBy) {
        this.oflineAuditBy = oflineAuditBy;
    }

    private String oflineNo;

    private String oflineRemarks;

    private String oflinePath;

    private String oflineSts;

    private Date oflineStsDate;

    private String oflineAuditBy;



    public String getAuditTag() {
        return auditTag;
    }

    public void setAuditTag(String auditTag) {
        this.auditTag = auditTag;
    }

    private String auditTag;

    public String getPassTag() {
        return passTag;
    }

    public void setPassTag(String passTag) {
        this.passTag = passTag;
    }

    private String passTag;

    public String getExamType() {
        return examType;
    }

    public void setExamType(String examType) {
        this.examType = examType;
    }

    private String examType;

    public String getCheckLevel() {
        return checkLevel;
    }

    public void setCheckLevel(String checkLevel) {
        this.checkLevel = checkLevel;
    }

    public String getCores() {
        return cores;
    }

    public void setCores(String cores) {
        this.cores = cores;
    }

    public String getExamTime() {
        return examTime;
    }

    public void setExamTime(String examTime) {
        this.examTime = examTime;
    }

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

    public String[] getSeqs() {
        return seqs;
    }

    public void setSeqs(String[] seqs) {
        this.seqs = seqs;
    }

    private String startTime;
    private String endTime;
    private String[] seqs;

    public Integer getLocalId() {
        return localId;
    }

    public void setLocalId(Integer localId) {
        this.localId = localId;
    }

    public SoPlan() {
        this.sts = "0";
        this.stsDate = new Date();
        this.applyDate = new Date();
        this.rsrvStr3 ="0";
       /* this.feeState = "0";
        this.hourState="0";
        this.learnState="0";
        this.examState="0";
        this.certState="0";
        this.reduceFlag="0";*/
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

    public Long getPlanId() {
        return planId;
    }

    public void setPlanId(Long planId) {
        this.planId = planId;
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
    }

    public String getFeeId() {
        return feeId;
    }

    public void setFeeId(String feeId) {
        this.feeId = feeId == null ? null : feeId.trim();
    }

    public Float getFee() {
        return fee;
    }

    public void setFee(Float fee) {
        this.fee = fee;
    }

    public String getFeeState() {
        return feeState;
    }

    public void setFeeState(String feeState) {
        this.feeState = feeState == null ? null : feeState.trim();
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

    public String getHourState() {
        return hourState;
    }

    public void setHourState(String hourState) {
        this.hourState = hourState;
    }

    public String getLearnState() {
        return learnState;
    }

    public void setLearnState(String learnState) {
        this.learnState = learnState;
    }

    public String getExamState() {
        return examState;
    }

    public void setExamState(String examState) {
        this.examState = examState;
    }

    public String getCertState() {
        return certState;
    }

    public void setCertState(String certState) {
        this.certState = certState;
    }

    public String getReduceFlag() {
        return reduceFlag;
    }

    public void setReduceFlag(String reduceFlag) {
        this.reduceFlag = reduceFlag;
    }
}