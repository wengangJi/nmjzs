package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

public class ServAssociateConstructor extends BaseEntity<ServAssociateConstructor> {
    private Integer servid;

    private String userId;

    private Integer companyId;

    private String appId;

    private String provinceId;

    private Integer localId;

    private Integer areaId;

    private String name;

    private String sex;

    private Date birthDate;

    private String idType;

    private String idNo;

    private String gardSchool;

    private Date gardDate;

    private String gardMajor;

    private String degree;

    private String education;

    private String contactPerson;

    private String contactPhone;

    private String contactAddr;

    private String postCode;

    private String mail;

    private String certType;

    private String certNo;

    private String issueBy;

    private Date issueDate;

    private String regiNo;

    private Date regiDate;

    private String educNo;

    private Date educDate;

    private String majorFirst;

    private String majorSecond;

    private String majorThird;

    private String majorFourth;

    private String majorFifth;

    private String majorSixth;

    private String patchId;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    private String remarks;

    private String empFlag;

    public Date getWorkingDate() {
        return workingDate;
    }

    public void setWorkingDate(Date workingDate) {
        this.workingDate = workingDate;
    }

    private Date workingDate;


    public String getEmpFlag() {
        return empFlag;
    }

    public void setEmpFlag(String empFlag) {
        this.empFlag = empFlag;
    }
    public Integer getServid() {
        return servid;
    }

    public void setServid(Integer servid) {
        this.servid = servid;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId == null ? null : appId.trim();
    }

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId == null ? null : provinceId.trim();
    }

    public Integer getLocalId() {
        return localId;
    }

    public void setLocalId(Integer localId) {
        this.localId = localId;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
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

    public String getGardMajor() {
        return gardMajor;
    }

    public void setGardMajor(String gardMajor) {
        this.gardMajor = gardMajor == null ? null : gardMajor.trim();
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

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson == null ? null : contactPerson.trim();
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone == null ? null : contactPhone.trim();
    }

    public String getContactAddr() {
        return contactAddr;
    }

    public void setContactAddr(String contactAddr) {
        this.contactAddr = contactAddr == null ? null : contactAddr.trim();
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

    public String getCertType() {
        return certType;
    }

    public void setCertType(String certType) {
        this.certType = certType == null ? null : certType.trim();
    }

    public String getCertNo() {
        return certNo;
    }

    public void setCertNo(String certNo) {
        this.certNo = certNo == null ? null : certNo.trim();
    }

    public String getIssueBy() {
        return issueBy;
    }

    public void setIssueBy(String issueBy) {
        this.issueBy = issueBy == null ? null : issueBy.trim();
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public String getRegiNo() {
        return regiNo;
    }

    public void setRegiNo(String regiNo) {
        this.regiNo = regiNo == null ? null : regiNo.trim();
    }

    public Date getRegiDate() {
        return regiDate;
    }

    public void setRegiDate(Date regiDate) {
        this.regiDate = regiDate;
    }

    public String getEducNo() {
        return educNo;
    }

    public void setEducNo(String educNo) {
        this.educNo = educNo == null ? null : educNo.trim();
    }

    public Date getEducDate() {
        return educDate;
    }

    public void setEducDate(Date educDate) {
        this.educDate = educDate;
    }

    public String getMajorFirst() {
        return majorFirst;
    }

    public void setMajorFirst(String majorFirst) {
        this.majorFirst = majorFirst == null ? null : majorFirst.trim();
    }

    public String getMajorSecond() {
        return majorSecond;
    }

    public void setMajorSecond(String majorSecond) {
        this.majorSecond = majorSecond == null ? null : majorSecond.trim();
    }

    public String getMajorThird() {
        return majorThird;
    }

    public void setMajorThird(String majorThird) {
        this.majorThird = majorThird == null ? null : majorThird.trim();
    }

    public String getMajorFourth() {
        return majorFourth;
    }

    public void setMajorFourth(String majorFourth) {
        this.majorFourth = majorFourth == null ? null : majorFourth.trim();
    }

    public String getMajorFifth() {
        return majorFifth;
    }

    public void setMajorFifth(String majorFifth) {
        this.majorFifth = majorFifth == null ? null : majorFifth.trim();
    }

    public String getMajorSixth() {
        return majorSixth;
    }

    public void setMajorSixth(String majorSixth) {
        this.majorSixth = majorSixth == null ? null : majorSixth.trim();
    }

    public String getPatchId() {
        return patchId;
    }

    public void setPatchId(String patchId) {
        this.patchId = patchId == null ? null : patchId.trim();
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

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }
}