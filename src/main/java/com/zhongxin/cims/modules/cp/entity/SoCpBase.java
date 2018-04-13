package com.zhongxin.cims.modules.cp.entity;

import java.util.Date;
import com.zhongxin.cims.common.persistence.BaseEntity;

public class SoCpBase extends BaseEntity<SoCpBase> {
    private String soid;

    private String actType;

    private Integer seq;

    private String name;

    private String sex;

    private Date birthDate;

    private String idType;

    private String idNo;

    private String personType;

    private Date examDate;

    private String examScore;

    private String telephone;

    private Integer companyId;

    private String qualLevel;

    private String address;

    private String postCode;

    private String mail;

    private String gardSchool;

    private Date gardDate;

    private String major;

    private String titleLevel;

    private String titleType;

    private String degree;

    private String education;

    private Date workingDate;

    private Integer workExpe;

    private String learnExpe;

    private String certExpe;

    private String pathId;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String appId;

    public String getSoType() {
        return soType;
    }

    public void setSoType(String soType) {
        this.soType = soType;
    }

    private String soType;

    private String pageModule;


    public void setAppId(String appId) {
        this.appId = appId;
    }

    public void setPageModule(String pageModule) {
        this.pageModule = pageModule;
    }



    public String getAppId() {
        return appId;
    }

    public String getPageModule() {
        return pageModule;
    }


    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid == null ? null : soid.trim();
    }

    public String getActType() {
        return actType;
    }

    public void setActType(String actType) {
        this.actType = actType == null ? null : actType.trim();
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType == null ? null : idType.trim();
    }

    public String getIdNo() {
        return idNo;
    }

    public void setIdNo(String idNo) {
        this.idNo = idNo == null ? null : idNo.trim();
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType == null ? null : personType.trim();
    }

    public Date getExamDate() {
        return examDate;
    }

    public void setExamDate(Date examDate) {
        this.examDate = examDate;
    }

    public String getExamScore() {
        return examScore;
    }

    public void setExamScore(String examScore) {
        this.examScore = examScore == null ? null : examScore.trim();
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone == null ? null : telephone.trim();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getQualLevel() {
        return qualLevel;
    }

    public void setQualLevel(String qualLevel) {
        this.qualLevel = qualLevel == null ? null : qualLevel.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode == null ? null : postCode.trim();
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail == null ? null : mail.trim();
    }

    public String getGardSchool() {
        return gardSchool;
    }

    public void setGardSchool(String gardSchool) {
        this.gardSchool = gardSchool == null ? null : gardSchool.trim();
    }

    public Date getGardDate() {
        return gardDate;
    }

    public void setGardDate(Date gardDate) {
        this.gardDate = gardDate;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major == null ? null : major.trim();
    }

    public String getTitleLevel() {
        return titleLevel;
    }

    public void setTitleLevel(String titleLevel) {
        this.titleLevel = titleLevel == null ? null : titleLevel.trim();
    }

    public String getTitleType() {
        return titleType;
    }

    public void setTitleType(String titleType) {
        this.titleType = titleType == null ? null : titleType.trim();
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree == null ? null : degree.trim();
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education == null ? null : education.trim();
    }

    public Date getWorkingDate() {
        return workingDate;
    }

    public void setWorkingDate(Date workingDate) {
        this.workingDate = workingDate;
    }

    public Integer getWorkExpe() {
        return workExpe;
    }

    public void setWorkExpe(Integer workExpe) {
        this.workExpe = workExpe;
    }

    public String getLearnExpe() {
        return learnExpe;
    }

    public void setLearnExpe(String learnExpe) {
        this.learnExpe = learnExpe == null ? null : learnExpe.trim();
    }

    public String getCertExpe() {
        return certExpe;
    }

    public void setCertExpe(String certExpe) {
        this.certExpe = certExpe == null ? null : certExpe.trim();
    }

    public String getPathId() {
        return pathId;
    }

    public void setPathId(String pathId) {
        this.pathId = pathId == null ? null : pathId.trim();
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
}