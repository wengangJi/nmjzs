package com.zhongxin.cims.modules.common.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.cp.entity.SoCpApprove;
import com.zhongxin.cims.modules.cp.entity.SoCpBase;
import com.zhongxin.cims.modules.cp.entity.SoCpPerformance;
import com.zhongxin.cims.modules.cp.entity.SoCpResume;

import java.util.List;

/**
 * Created by caill on 2014/6/29.
 */
public class SoCache extends BaseEntity {

    private So so ;
    private SoCpBase soCpBase;
    //private SoCpResume soCpResume;
    private SoCpPerformance soCpPerformance;
    private SoCpApprove soCpApprove;
    private List<SoCpResume> soCpResumeList;

    private String sessionId;


    public List<SoCpResume> getSoCpResumeList() {
        return soCpResumeList;
    }

    public void setSoCpResumeList(List<SoCpResume> soCpResumeList) {
        this.soCpResumeList = soCpResumeList;
    }


    public void setSo(So so) {
        this.so = so;
    }

    public void setSoCpBase(SoCpBase soCpBase) {
        this.soCpBase = soCpBase;
    }

   /* public void setSoCpResume(SoCpResume soCpResume) {
        this.soCpResume = soCpResume;
    }*/

    public void setSoCpPerformance(SoCpPerformance soCpPerformance) {
        this.soCpPerformance = soCpPerformance;
    }

    public void setSoCpApprove(SoCpApprove soCpApprove) {
        this.soCpApprove = soCpApprove;
    }

    public So getSo() {
        return so;
    }

    public SoCpBase getSoCpBase() {
        return soCpBase;
    }

/*
    public SoCpResume getSoCpResume() {
        return soCpResume;
    }
*/

    public SoCpPerformance getSoCpPerformance() {
        return soCpPerformance;
    }

    public SoCpApprove getSoCpApprove() {
        return soCpApprove;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
}
