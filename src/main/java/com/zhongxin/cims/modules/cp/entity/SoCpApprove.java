package com.zhongxin.cims.modules.cp.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

public class SoCpApprove  extends BaseEntity<SoCpApprove> {
    private String soid;

    private String apprId;

    private Integer seq;

    private String apprType;

    private String apprUserId;

    private String apprOfficeId;

    private Date apprDate;

    private String content;

    private String inContent;

    private String outContent;

    private String signature;

    private String seal;

    private String pathId;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String sts;

    private Date stsDate;

    private String remarks;

    private String consistentOriginal; //是否与原件一致
    private String taskName;//审批环节名称

    private String contentMon;      //用做临时转化
    private String contentLoc;      //用做临时转化

    public String getSoType() {
        return soType;
    }

    public void setSoType(String soType) {
        this.soType = soType;
    }

    private String soType;


    public String getAppId() {
        return appId;
    }

    public String getPageModule() {
        return pageModule;
    }

    private String appId;


    public void setAppId(String appId) {
        this.appId = appId;
    }

    public void setPageModule(String pageModule) {
        this.pageModule = pageModule;
    }

    private String pageModule;

    public void setContentMon(String contentMon) {
        this.contentMon = contentMon;
    }

    public void setContentLoc(String contentLoc) {
        this.contentLoc = contentLoc;
    }

    public String getContentLoc() {
        return contentLoc;
    }



    public String getContentMon() {
        return contentMon;
    }



    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid == null ? null : soid.trim();
    }

    public String getApprId() {
        return apprId;
    }

    public void setApprId(String apprId) {
        this.apprId = apprId == null ? null : apprId.trim();
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getApprType() {
        return apprType;
    }

    public void setApprType(String apprType) {
        this.apprType = apprType == null ? null : apprType.trim();
    }

    public String getApprUserId() {
        return apprUserId;
    }

    public void setApprUserId(String apprUserId) {
        this.apprUserId = apprUserId == null ? null : apprUserId.trim();
    }

    public String getApprOfficeId() {
        return apprOfficeId;
    }

    public void setApprOfficeId(String apprOfficeId) {
        this.apprOfficeId = apprOfficeId == null ? null : apprOfficeId.trim();
    }

    public Date getApprDate() {
        return apprDate;
    }

    public void setApprDate(Date apprDate) {
        this.apprDate = apprDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getInContent() {
        return inContent;
    }

    public void setInContent(String inContent) {
        this.inContent = inContent == null ? null : inContent.trim();
    }

    public String getOutContent() {
        return outContent;
    }

    public void setOutContent(String outContent) {
        this.outContent = outContent == null ? null : outContent.trim();
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature == null ? null : signature.trim();
    }

    public String getSeal() {
        return seal;
    }

    public void setSeal(String seal) {
        this.seal = seal == null ? null : seal.trim();
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

    public String getConsistentOriginal() {
        return consistentOriginal;
    }

    public void setConsistentOriginal(String consistentOriginal) {
        this.consistentOriginal = consistentOriginal;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }
}