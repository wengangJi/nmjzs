package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

public class Lesson extends BaseEntity<Lesson> {
    private Long lessonId;

    private Long courseId;

    private String lessonName;

    private String lessonInfo;

    private String payTag;

    private Integer watchTimes;

    private String fileType;

    private String fileUrl;

    private String playTime;

    private String createBy;

    private Date createDate;

    private String updateBy;

    private Date updateDate;

    private Integer showIndex;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    private Plan plan;
    private Course course;

    public Long getLessonIdTmp() {
        return lessonIdTmp;
    }

    public void setLessonIdTmp(Long lessonIdTmp) {
        this.lessonIdTmp = lessonIdTmp;
    }

    private Long lessonIdTmp;

    public CourseCenter getCourseCenter() {
        return courseCenter;
    }

    public void setCourseCenter(CourseCenter courseCenter) {
        this.courseCenter = courseCenter;
    }

    private CourseCenter courseCenter;

    public Plan getPlan() {
        return plan;
    }

    public void setPlan(Plan plan) {
        this.plan = plan;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    //临时属性，用于课件已学信息展示
    private String soid;

    public Double getHours() {
        return hours;
    }

    public void setHours(Double hours) {
        this.hours = hours;
    }

    private Double hours;
    private Integer videoTime;
    private Integer playedTime;
    private String auditTag;

    private Integer planId;
    private String year;

    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid;
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

    public String getAuditTag() {
        return auditTag;
    }

    public void setAuditTag(String auditTag) {
        this.auditTag = auditTag;
    }




    public Lesson() {
        this.sts = "0";
        this.stsDate = new Date();
        this.createDate = new Date();
    }

    public Long getLessonId() {
        return lessonId;
    }

    public void setLessonId(Long lessonId) {
        this.lessonId = lessonId;
    }

    public Long getCourseId() {
        return courseId;
    }

    public void setCourseId(Long courseId) {
        this.courseId = courseId;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName == null ? null : lessonName.trim();
    }

    public String getLessonInfo() {
        return lessonInfo;
    }

    public void setLessonInfo(String lessonInfo) {
        this.lessonInfo = lessonInfo == null ? null : lessonInfo.trim();
    }

    public String getPayTag() {
        return payTag;
    }

    public void setPayTag(String payTag) {
        this.payTag = payTag == null ? null : payTag.trim();
    }

    public Integer getWatchTimes() {
        return watchTimes;
    }

    public void setWatchTimes(Integer watchTimes) {
        this.watchTimes = watchTimes;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType == null ? null : fileType.trim();
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl == null ? null : fileUrl.trim();
    }

    public String getPlayTime() {
        return playTime;
    }

    public void setPlayTime(String playTime) {
        this.playTime = playTime == null ? null : playTime.trim();
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

    public Integer getShowIndex() {
        return showIndex;
    }

    public void setShowIndex(Integer showIndex) {
        this.showIndex = showIndex;
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