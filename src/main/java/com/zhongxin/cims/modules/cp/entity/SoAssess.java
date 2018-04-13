package com.zhongxin.cims.modules.cp.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;

import java.util.Date;
import java.util.List;

/**
 * Created by lqyu_773 on 14-6-22.
 */
public class SoAssess extends BaseEntity<SoAssess>{
    private String soid;
    private So so;
    private SoCpBase soCpBase;
    private List<SoCpApprove> soCpApproves;
    private List<SoAttachment> soAttachments;

    private String startTime;
    private String endTime;
    private String[] seqs;

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

    public List<SoCpApprove> getSoCpApproves() {
        return soCpApproves;
    }

    public void setSoCpApproves(List<SoCpApprove> soCpApproves) {
        this.soCpApproves = soCpApproves;
    }

    public List<SoAttachment> getSoAttachments() {
        return soAttachments;
    }

    public void setSoAttachments(List<SoAttachment> soAttachments) {
        this.soAttachments = soAttachments;
    }
}
