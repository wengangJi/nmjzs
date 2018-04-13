package com.zhongxin.cims.modules.exam.entiy;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/8/30
 * Time: 21:31
 * To change this template use File | Settings | File Templates.
 */

public class ExamInfo extends BaseEntity<ExamInfo> {
    private   int  id;
    private   String profession;
    private   String type;
    private   String startTime;
    private   String  requireTime;
    private   String endTime;
    private   String userId;
    private   String userName;
    private   String questionTotals;
    private   String createTime;
    private String soId;
    private String sts;
    private Date stsDate;
    private String rsrvStr1;
    private String rsrvStr2;
    private String rsrvStr3;

    private String qryStr1;

    public String getQryStr1() {
        return qryStr1;
    }

    public void setQryStr1(String qryStr1) {
        this.qryStr1 = qryStr1;
    }

    public String getQryStr2() {
        return qryStr2;
    }

    public void setQryStr2(String qryStr2) {
        this.qryStr2 = qryStr2;
    }

    public String getQryStr3() {
        return qryStr3;
    }

    public void setQryStr3(String qryStr3) {
        this.qryStr3 = qryStr3;
    }

    public String getQryStr4() {
        return qryStr4;
    }

    public void setQryStr4(String qryStr4) {
        this.qryStr4 = qryStr4;
    }

    public String getQryStr5() {
        return qryStr5;
    }

    public void setQryStr5(String qryStr5) {
        this.qryStr5 = qryStr5;
    }

    private String qryStr2;
    private String qryStr3;
    private String qryStr4;
    private String qryStr5;

    private String auditTag;

    private String auditBy;

    private Date auditDate;

    private String auditLevel; // 0-初审 1-二审 3-终审

    private String passTag;

    private String pass;//临时属性

    public String getExamType() {
        return examType;
    }

    public void setExamType(String examType) {
        this.examType = examType;
    }

    private String examType;

    public String getAuditInfo() {
        return auditInfo;
    }

    public void setAuditInfo(String auditInfo) {
        this.auditInfo = auditInfo;
    }

    private String auditInfo;//临时属性

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getRsrvStr1() {
        return rsrvStr1;
    }

    public void setRsrvStr1(String rsrvStr1) {
        this.rsrvStr1 = rsrvStr1;
    }

    public String getRsrvStr2() {
        return rsrvStr2;
    }

    public void setRsrvStr2(String rsrvStr2) {
        this.rsrvStr2 = rsrvStr2;
    }

    public String getRsrvStr3() {
        return rsrvStr3;
    }

    public void setRsrvStr3(String rsrvStr3) {
        this.rsrvStr3 = rsrvStr3;
    }

    public String getPassTag() {
        return passTag;
    }

    public void setPassTag(String passTag) {
        this.passTag = passTag;
    }

    public String getAuditTag() {
        return auditTag;
    }

    public void setAuditTag(String auditTag) {
        this.auditTag = auditTag;
    }

    public String getAuditBy() {
        return auditBy;
    }

    public void setAuditBy(String auditBy) {
        this.auditBy = auditBy;
    }

    public Date getAuditDate() {
        return auditDate;
    }

    public void setAuditDate(Date auditDate) {
        this.auditDate = auditDate;
    }

    public String getAuditLevel() {
        return auditLevel;
    }

    public void setAuditLevel(String auditLevel) {
        this.auditLevel = auditLevel;
    }


    public ExamInfo(){
        this.sts = "0";
        this.auditTag = "0";
        this.auditLevel = "0";
        this.passTag="0";
        this.stsDate = new Date();
    }


    public String getCores() {
        return cores;
    }

    public void setCores(String cores) {
        this.cores = cores;
    }

    private String cores;

    public String getExamState() {
        return examState;
    }

    public void setExamState(String examState) {
        this.examState = examState;
    }

    private String examState;

    public String getSts() {
        return sts;
    }

    public void setSts(String sts) {
        this.sts = sts;
    }

    public Date getStsDate() {
        return stsDate;
    }

    public void setStsDate(Date stsDate) {
        this.stsDate = stsDate;
    }

    public String getSoId() {
        return soId;
    }

    public void setSoId(String soId) {
        this.soId = soId;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    private   String planId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getRequireTime() {
        return requireTime;
    }

    public void setRequireTime(String requireTime) {
        this.requireTime = requireTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getQuestionTotals() {
        return questionTotals;
    }

    public void setQuestionTotals(String questionTotals) {
        this.questionTotals = questionTotals;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
