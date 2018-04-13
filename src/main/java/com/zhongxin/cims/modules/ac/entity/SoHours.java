package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

public class SoHours extends BaseEntity<SoHours> {
    private Long id;

    private String soid;

    private String userId;

    private String type;

    private Long planId;

    private Long courseId;

    private Long lessonId;

    public Double getHours() {
        return hours;
    }

    public void setHours(Double hours) {
        this.hours = hours;
    }

    private Double hours;

    private Integer videoTime;

    private Integer playedTime;

    private Date createDate;

    private String auditTag;

    private String auditBy;

    private Date auditDate;

    private String companyName;

    private String reduceReason;

    private String certNo;

    private String remark;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String qryStr1;

    public String getQryStr5() {
        return qryStr5;
    }

    public void setQryStr5(String qryStr5) {
        this.qryStr5 = qryStr5;
    }

    private String qryStr5;

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

    private String qryStr2;

    private String qryStr3;

    private String qryStr4;

    private String sts;

    private Date stsDate;

    private String auditLevel; // 0-初审 1-二审 3-终审

    public String getAuditLevel() {
        return auditLevel;
    }

    public void setAuditLevel(String auditLevel) {
        this.auditLevel = auditLevel;
    }

    // 临时属性
    private String userName;
    private String pass;

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Date finishTime) {
        this.finishTime = finishTime;
    }

    private Date startTime;

    private Date finishTime;

    public SoHours(){
        this.sts = "0";
        this.auditTag = "0";
        this.auditLevel = "0";
        this.createDate = new Date();
        this.stsDate = new Date();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Long getPlanId() {
        return planId;
    }

    public void setPlanId(Long planId) {
        this.planId = planId;
    }

    public Long getCourseId() {
        return courseId;
    }

    public void setCourseId(Long courseId) {
        this.courseId = courseId;
    }

    public Long getLessonId() {
        return lessonId;
    }

    public void setLessonId(Long lessonId) {
        this.lessonId = lessonId;
    }



    public Integer getVideoTime() {
        return videoTime;
    }

    public void setVideoTime(Integer videoTime) {
        this.videoTime = videoTime;
    }

    public Integer getPlayedTime() {
        return playedTime;
    }

    public void setPlayedTime(Integer playedTime) {
        this.playedTime = playedTime;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName == null ? null : companyName.trim();
    }

    public String getReduceReason() {
        return reduceReason;
    }

    public void setReduceReason(String reduceReason) {
        this.reduceReason = reduceReason == null ? null : reduceReason.trim();
    }

    public String getCertNo() {
        return certNo;
    }

    public void setCertNo(String certNo) {
        this.certNo = certNo == null ? null : certNo.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
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