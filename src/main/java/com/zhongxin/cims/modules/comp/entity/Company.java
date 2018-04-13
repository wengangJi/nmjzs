package com.zhongxin.cims.modules.comp.entity;

import com.google.common.collect.Lists;
import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.sys.entity.User;
import org.hibernate.annotations.*;
import org.hibernate.annotations.Cache;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "t_company")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Company extends BaseEntity<Company> {

    private static final long serialVersionUID = 1L;

    private Integer companyId;

    private String companyName;

    private String companyType;

    private String orgCode;

    private String taxNo;

    private String licenceNo;

    private String economicType;

    private String qualLevel;

    private String qualType;

    private String qualCertNo;

    private String legPerson;

    private String legIdType;

    private String legNo;

    private String registerType;

    private String registerAddr;

    private String registerCapital;

    private Date effDate;

    private Date expDate;

    private String address;

    private String postCode;

    private String contactPerson;

    private String contactPhone;

    private String fax;

    private String email;

    private String profile;

    private String provinceId;

    private Integer localId;

    private Integer areaId;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String remarks;

    private String sts;

    private Date stsDate;

    private String queryType;

    private String portalCode;

    private List<User> userList = Lists.newArrayList();   // 拥有用户列表

    public Company() {
        this.sts = "0";
        this.stsDate = new Date();
    }

    @Transient
    public String getQueryType() {
        return queryType;
    }

    @Transient
    public void setQueryType(String queryType) {
        this.queryType = queryType;
    }

    @Id
    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName == null ? null : companyName.trim();
    }

    public String getCompanyType() {
        return companyType;
    }

    public void setCompanyType(String companyType) {
        this.companyType = companyType == null ? null : companyType.trim();
    }

    public String getOrgCode() {
        return orgCode;
    }

    public void setOrgCode(String orgCode) {
        this.orgCode = orgCode == null ? null : orgCode.trim();
    }

    public String getTaxNo() {
        return taxNo;
    }

    public void setTaxNo(String taxNo) {
        this.taxNo = taxNo == null ? null : taxNo.trim();
    }

    public String getLicenceNo() {
        return licenceNo;
    }

    public void setLicenceNo(String licenceNo) {
        this.licenceNo = licenceNo == null ? null : licenceNo.trim();
    }

    public String getEconomicType() {
        return economicType;
    }

    public void setEconomicType(String economicType) {
        this.economicType = economicType == null ? null : economicType.trim();
    }

    public String getQualLevel() {
        return qualLevel;
    }

    public void setQualLevel(String qualLevel) {
        this.qualLevel = qualLevel == null ? null : qualLevel.trim();
    }

    public String getQualType() {
        return qualType;
    }

    public void setQualType(String qualType) {
        this.qualType = qualType == null ? null : qualType.trim();
    }

    public String getQualCertNo() {
        return qualCertNo;
    }

    public void setQualCertNo(String qualCertNo) {
        this.qualCertNo = qualCertNo == null ? null : qualCertNo.trim();
    }

    public String getLegPerson() {
        return legPerson;
    }

    public void setLegPerson(String legPerson) {
        this.legPerson = legPerson == null ? null : legPerson.trim();
    }

    public String getLegIdType() {
        return legIdType;
    }

    public void setLegIdType(String legIdType) {
        this.legIdType = legIdType == null ? null : legIdType.trim();
    }

    public String getLegNo() {
        return legNo;
    }

    public void setLegNo(String legNo) {
        this.legNo = legNo == null ? null : legNo.trim();
    }

    public String getRegisterType() {
        return registerType;
    }

    public void setRegisterType(String registerType) {
        this.registerType = registerType == null ? null : registerType.trim();
    }

    public String getRegisterAddr() {
        return registerAddr;
    }

    public void setRegisterAddr(String registerAddr) {
        this.registerAddr = registerAddr == null ? null : registerAddr.trim();
    }

    public String getRegisterCapital() {
        return registerCapital;
    }

    public void setRegisterCapital(String registerCapital) {
        this.registerCapital = registerCapital == null ? null : registerCapital.trim();
    }

    public Date getEffDate() {
        return effDate;
    }

    public void setEffDate(Date effDate) {
        this.effDate = effDate;
    }

    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
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

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax == null ? null : fax.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile == null ? null : profile.trim();
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

    @Column(name = "area_id")
    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
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

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
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

    public String getPortalCode() {
        return portalCode;
    }

    public void setPortalCode(String portalCode) {
        this.portalCode = portalCode;
    }

    @OneToMany(mappedBy = "company", fetch=FetchType.LAZY)
    @Where(clause="del_flag='"+DEL_FLAG_NORMAL+"'")
    @OrderBy(value="id") @Fetch(FetchMode.SUBSELECT)
    @NotFound(action = NotFoundAction.IGNORE)
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }
}