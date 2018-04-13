package com.zhongxin.cims.modules.cp.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.common.entity.SoMainCert;

import java.util.List;

/**
 * Created by lqyu_773 on 14-6-22.
 */
public class SoCpEntity extends BaseEntity<SoCpEntity>{
    private String soid;
    private So so;
    private SoMainCert soMainCert;
    private SoCpBase soCpBase;
    private List<SoCpResume> soCpResume;
    private SoCpPerformance soCpPerformance;
    private List<SoCpApprove> soCpApprove;
    private List<SoAttachment> soAttachments;


    private String startTime;
    private String endTime;
    private String[] seqs;


    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    private String sessionId;

    public String getActType() {
        return actType;
    }

    public void setActType(String actType) {
        this.actType = actType;
    }

    private String actType;

    public List<SoCpResume> getSoCpResume() {
        return soCpResume;
    }

    public void setSoCpResume(List<SoCpResume> soCpResume) {
        this.soCpResume = soCpResume;
    }


    public SoCpPerformance getSoCpPerformance() {
        return soCpPerformance;
    }

    public void setSoCpPerformance(SoCpPerformance soCpPerformance) {
        this.soCpPerformance = soCpPerformance;
    }

    public List<SoCpApprove> getSoCpApprove() {
        return soCpApprove;
    }

    public void setSoCpApprove(List<SoCpApprove> soCpApprove) {
        this.soCpApprove = soCpApprove;
    }

    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid;
    }

    public So getSo() {
        return so;
    }

    public void setSo(So so) {
        this.so = so;
    }

    public SoCpBase getSoCpBase() {
        return soCpBase;
    }

    public void setSoCpBase(SoCpBase soCpBase) {
        this.soCpBase = soCpBase;
    }

    public String[] getSeqs() {
        return seqs;
    }

    public void setSeqs(String[] seqs) {
        this.seqs = seqs;
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

    public List<SoAttachment> getSoAttachments() {
        return soAttachments;
    }

    public void setSoAttachments(List<SoAttachment> soAttachments) {
        this.soAttachments = soAttachments;
    }

    public SoMainCert getSoMainCert() { return soMainCert;}

    public void setSoMainCert(SoMainCert soMainCert) { this.soMainCert = soMainCert;  }
}
