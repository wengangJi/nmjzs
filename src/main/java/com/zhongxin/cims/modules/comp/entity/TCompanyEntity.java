package com.zhongxin.cims.modules.comp.entity;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;

/**
 * Created by lqyu_773 on 14-6-10.
 */
@Entity
@javax.persistence.Table(name = "t_company", schema = "", catalog = "cims")
public class TCompanyEntity {
    private int companyId;

    @Id
    @javax.persistence.Column(name = "COMPANY_ID")
    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    private String companyName;

    @Basic
    @javax.persistence.Column(name = "COMPANY_NAME")
    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    private String companyType;

    @Basic
    @javax.persistence.Column(name = "COMPANY_TYPE")
    public String getCompanyType() {
        return companyType;
    }

    public void setCompanyType(String companyType) {
        this.companyType = companyType;
    }

    private String orgCode;

    @Basic
    @javax.persistence.Column(name = "ORG_CODE")
    public String getOrgCode() {
        return orgCode;
    }

    public void setOrgCode(String orgCode) {
        this.orgCode = orgCode;
    }

    private String taxNo;

    @Basic
    @javax.persistence.Column(name = "TAX_NO")
    public String getTaxNo() {
        return taxNo;
    }

    public void setTaxNo(String taxNo) {
        this.taxNo = taxNo;
    }

    private String licenceNo;

    @Basic
    @javax.persistence.Column(name = "LICENCE_NO")
    public String getLicenceNo() {
        return licenceNo;
    }

    public void setLicenceNo(String licenceNo) {
        this.licenceNo = licenceNo;
    }

    private String economicType;

    @Basic
    @javax.persistence.Column(name = "ECONOMIC_TYPE")
    public String getEconomicType() {
        return economicType;
    }

    public void setEconomicType(String economicType) {
        this.economicType = economicType;
    }

    private String qualLevel;

    @Basic
    @javax.persistence.Column(name = "QUAL_LEVEL")
    public String getQualLevel() {
        return qualLevel;
    }

    public void setQualLevel(String qualLevel) {
        this.qualLevel = qualLevel;
    }

    private String qualType;

    @Basic
    @javax.persistence.Column(name = "QUAL_TYPE")
    public String getQualType() {
        return qualType;
    }

    public void setQualType(String qualType) {
        this.qualType = qualType;
    }

    private String qualCertNo;

    @Basic
    @javax.persistence.Column(name = "QUAL_CERT_NO")
    public String getQualCertNo() {
        return qualCertNo;
    }

    public void setQualCertNo(String qualCertNo) {
        this.qualCertNo = qualCertNo;
    }

    private String legPerson;

    @Basic
    @javax.persistence.Column(name = "LEG_PERSON")
    public String getLegPerson() {
        return legPerson;
    }

    public void setLegPerson(String legPerson) {
        this.legPerson = legPerson;
    }

    private String legIdType;

    @Basic
    @javax.persistence.Column(name = "LEG_ID_TYPE")
    public String getLegIdType() {
        return legIdType;
    }

    public void setLegIdType(String legIdType) {
        this.legIdType = legIdType;
    }

    private String legNo;

    @Basic
    @javax.persistence.Column(name = "LEG_NO")
    public String getLegNo() {
        return legNo;
    }

    public void setLegNo(String legNo) {
        this.legNo = legNo;
    }

    private String registerType;

    @Basic
    @javax.persistence.Column(name = "REGISTER_TYPE")
    public String getRegisterType() {
        return registerType;
    }

    public void setRegisterType(String registerType) {
        this.registerType = registerType;
    }

    private String registerAddr;

    @Basic
    @javax.persistence.Column(name = "REGISTER_ADDR")
    public String getRegisterAddr() {
        return registerAddr;
    }

    public void setRegisterAddr(String registerAddr) {
        this.registerAddr = registerAddr;
    }

    private String registerCapital;

    @Basic
    @javax.persistence.Column(name = "REGISTER_CAPITAL")
    public String getRegisterCapital() {
        return registerCapital;
    }

    public void setRegisterCapital(String registerCapital) {
        this.registerCapital = registerCapital;
    }

    private Date effDate;

    @Basic
    @javax.persistence.Column(name = "EFF_DATE")
    public Date getEffDate() {
        return effDate;
    }

    public void setEffDate(Date effDate) {
        this.effDate = effDate;
    }

    private Date expDate;

    @Basic
    @javax.persistence.Column(name = "EXP_DATE")
    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
    }

    private String address;

    @Basic
    @javax.persistence.Column(name = "ADDRESS")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    private String postCode;

    @Basic
    @javax.persistence.Column(name = "POST_CODE")
    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    private String contactPerson;

    @Basic
    @javax.persistence.Column(name = "CONTACT_PERSON")
    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    private String contactPhone;

    @Basic
    @javax.persistence.Column(name = "CONTACT_PHONE")
    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    private String fax;

    @Basic
    @javax.persistence.Column(name = "FAX")
    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    private String email;

    @Basic
    @javax.persistence.Column(name = "EMAIL")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    private String profile;

    @Basic
    @javax.persistence.Column(name = "PROFILE")
    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    private String provinceId;

    @Basic
    @javax.persistence.Column(name = "PROVINCE_ID")
    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId;
    }

    private Integer localId;

    @Basic
    @javax.persistence.Column(name = "LOCAL_ID")
    public Integer getLocalId() {
        return localId;
    }

    public void setLocalId(Integer localId) {
        this.localId = localId;
    }

    private Integer areaId;

    @Basic
    @javax.persistence.Column(name = "AREA_ID")
    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    private String rsrvStr1;

    @Basic
    @javax.persistence.Column(name = "RSRV_STR1")
    public String getRsrvStr1() {
        return rsrvStr1;
    }

    public void setRsrvStr1(String rsrvStr1) {
        this.rsrvStr1 = rsrvStr1;
    }

    private String rsrvStr2;

    @Basic
    @javax.persistence.Column(name = "RSRV_STR2")
    public String getRsrvStr2() {
        return rsrvStr2;
    }

    public void setRsrvStr2(String rsrvStr2) {
        this.rsrvStr2 = rsrvStr2;
    }

    private String rsrvStr3;

    @Basic
    @javax.persistence.Column(name = "RSRV_STR3")
    public String getRsrvStr3() {
        return rsrvStr3;
    }

    public void setRsrvStr3(String rsrvStr3) {
        this.rsrvStr3 = rsrvStr3;
    }

    private String remarks;

    @Basic
    @javax.persistence.Column(name = "REMARKS")
    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    private String sts;

    @Basic
    @javax.persistence.Column(name = "STS")
    public String getSts() {
        return sts;
    }

    public void setSts(String sts) {
        this.sts = sts;
    }

    private Date stsDate;

    @Basic
    @javax.persistence.Column(name = "STS_DATE")
    public Date getStsDate() {
        return stsDate;
    }

    public void setStsDate(Date stsDate) {
        this.stsDate = stsDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TCompanyEntity that = (TCompanyEntity) o;

        if (companyId != that.companyId) return false;
        if (address != null ? !address.equals(that.address) : that.address != null) return false;
        if (areaId != null ? !areaId.equals(that.areaId) : that.areaId != null) return false;
        if (companyName != null ? !companyName.equals(that.companyName) : that.companyName != null) return false;
        if (companyType != null ? !companyType.equals(that.companyType) : that.companyType != null) return false;
        if (contactPerson != null ? !contactPerson.equals(that.contactPerson) : that.contactPerson != null)
            return false;
        if (contactPhone != null ? !contactPhone.equals(that.contactPhone) : that.contactPhone != null) return false;
        if (economicType != null ? !economicType.equals(that.economicType) : that.economicType != null) return false;
        if (effDate != null ? !effDate.equals(that.effDate) : that.effDate != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (expDate != null ? !expDate.equals(that.expDate) : that.expDate != null) return false;
        if (fax != null ? !fax.equals(that.fax) : that.fax != null) return false;
        if (legIdType != null ? !legIdType.equals(that.legIdType) : that.legIdType != null) return false;
        if (legNo != null ? !legNo.equals(that.legNo) : that.legNo != null) return false;
        if (legPerson != null ? !legPerson.equals(that.legPerson) : that.legPerson != null) return false;
        if (licenceNo != null ? !licenceNo.equals(that.licenceNo) : that.licenceNo != null) return false;
        if (localId != null ? !localId.equals(that.localId) : that.localId != null) return false;
        if (orgCode != null ? !orgCode.equals(that.orgCode) : that.orgCode != null) return false;
        if (postCode != null ? !postCode.equals(that.postCode) : that.postCode != null) return false;
        if (profile != null ? !profile.equals(that.profile) : that.profile != null) return false;
        if (provinceId != null ? !provinceId.equals(that.provinceId) : that.provinceId != null) return false;
        if (qualCertNo != null ? !qualCertNo.equals(that.qualCertNo) : that.qualCertNo != null) return false;
        if (qualLevel != null ? !qualLevel.equals(that.qualLevel) : that.qualLevel != null) return false;
        if (qualType != null ? !qualType.equals(that.qualType) : that.qualType != null) return false;
        if (registerAddr != null ? !registerAddr.equals(that.registerAddr) : that.registerAddr != null) return false;
        if (registerCapital != null ? !registerCapital.equals(that.registerCapital) : that.registerCapital != null)
            return false;
        if (registerType != null ? !registerType.equals(that.registerType) : that.registerType != null) return false;
        if (remarks != null ? !remarks.equals(that.remarks) : that.remarks != null) return false;
        if (rsrvStr1 != null ? !rsrvStr1.equals(that.rsrvStr1) : that.rsrvStr1 != null) return false;
        if (rsrvStr2 != null ? !rsrvStr2.equals(that.rsrvStr2) : that.rsrvStr2 != null) return false;
        if (rsrvStr3 != null ? !rsrvStr3.equals(that.rsrvStr3) : that.rsrvStr3 != null) return false;
        if (sts != null ? !sts.equals(that.sts) : that.sts != null) return false;
        if (stsDate != null ? !stsDate.equals(that.stsDate) : that.stsDate != null) return false;
        if (taxNo != null ? !taxNo.equals(that.taxNo) : that.taxNo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = companyId;
        result = 31 * result + (companyName != null ? companyName.hashCode() : 0);
        result = 31 * result + (companyType != null ? companyType.hashCode() : 0);
        result = 31 * result + (orgCode != null ? orgCode.hashCode() : 0);
        result = 31 * result + (taxNo != null ? taxNo.hashCode() : 0);
        result = 31 * result + (licenceNo != null ? licenceNo.hashCode() : 0);
        result = 31 * result + (economicType != null ? economicType.hashCode() : 0);
        result = 31 * result + (qualLevel != null ? qualLevel.hashCode() : 0);
        result = 31 * result + (qualType != null ? qualType.hashCode() : 0);
        result = 31 * result + (qualCertNo != null ? qualCertNo.hashCode() : 0);
        result = 31 * result + (legPerson != null ? legPerson.hashCode() : 0);
        result = 31 * result + (legIdType != null ? legIdType.hashCode() : 0);
        result = 31 * result + (legNo != null ? legNo.hashCode() : 0);
        result = 31 * result + (registerType != null ? registerType.hashCode() : 0);
        result = 31 * result + (registerAddr != null ? registerAddr.hashCode() : 0);
        result = 31 * result + (registerCapital != null ? registerCapital.hashCode() : 0);
        result = 31 * result + (effDate != null ? effDate.hashCode() : 0);
        result = 31 * result + (expDate != null ? expDate.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + (postCode != null ? postCode.hashCode() : 0);
        result = 31 * result + (contactPerson != null ? contactPerson.hashCode() : 0);
        result = 31 * result + (contactPhone != null ? contactPhone.hashCode() : 0);
        result = 31 * result + (fax != null ? fax.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (profile != null ? profile.hashCode() : 0);
        result = 31 * result + (provinceId != null ? provinceId.hashCode() : 0);
        result = 31 * result + (localId != null ? localId.hashCode() : 0);
        result = 31 * result + (areaId != null ? areaId.hashCode() : 0);
        result = 31 * result + (rsrvStr1 != null ? rsrvStr1.hashCode() : 0);
        result = 31 * result + (rsrvStr2 != null ? rsrvStr2.hashCode() : 0);
        result = 31 * result + (rsrvStr3 != null ? rsrvStr3.hashCode() : 0);
        result = 31 * result + (remarks != null ? remarks.hashCode() : 0);
        result = 31 * result + (sts != null ? sts.hashCode() : 0);
        result = 31 * result + (stsDate != null ? stsDate.hashCode() : 0);
        return result;
    }
}
