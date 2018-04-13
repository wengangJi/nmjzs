package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

/**
 * Created by lqyu_773 on 14-6-13.
 */
public class ACPerson extends BaseEntity<ACPerson> {
    private String certNo;
    private String acId;
    private String name;
    private String sex;
    private Date birthDate;
    private String idNo;
    private String degree;
    private String education;
    private String gardSchool;
    private Date gardDate;
    private String gardMajor;
    private Date issueDate;
    private Date expDate;
    private String remarks;
    private String sts;


    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }


    public String getCertNo() {
        return certNo;
    }

    public void setCertNo(String certNo) {
        this.certNo = certNo;
    }

    public String getAcId() {
        return acId;
    }

    public void setAcId(String acId) {
        this.acId = acId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getIdNo() {
        return idNo;
    }

    public void setIdNo(String idNo) {
        this.idNo = idNo;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getGardSchool() {
        return gardSchool;
    }

    public void setGardSchool(String gardSchool) {
        this.gardSchool = gardSchool;
    }

    public Date getGardDate() {
        return gardDate;
    }

    public void setGardDate(Date gardDate) {
        this.gardDate = gardDate;
    }

    public String getGardMajor() {
        return gardMajor;
    }

    public void setGardMajor(String gardMajor) {
        this.gardMajor = gardMajor;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
    }

    public String getSts() {
        return sts;
    }

    public void setSts(String sts) {
        this.sts = sts;
    }
}
