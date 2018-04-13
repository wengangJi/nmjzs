package com.zhongxin.cims.modules.cp.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructorBase;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructorMajor;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.Serv;
import com.zhongxin.cims.modules.common.entity.ServAttachment;

import java.util.List;

/**
 * Created by lqyu_773 on 14-6-12.
 */
public class ServCpEntity extends BaseEntity<ServCpEntity> {
    private Integer servid;
    private Serv serv;
    private Cert cert;
    private Personnel personnel;
    private List<ServCpResume> servCpResumes;
    private ServCpPerformance servCpPerformance;
    private List<ServAttachment> servAttachments;


    private String startTime;
    private String endTime;
    private String[] seqs;

    private String soid;

    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid;
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

    public String[] getSeqs() {
        return seqs;
    }

    public void setSeqs(String[] seqs) {
        this.seqs = seqs;
    }

    public Integer getServid() {
        return servid;
    }

    public void setServid(Integer servid) {
        this.servid = servid;
    }

    public Serv getServ() {
        return serv;
    }

    public void setServ(Serv serv) {
        this.serv = serv;
    }

    public Cert getCert() {
        return cert;
    }

    public void setCert(Cert cert) {
        this.cert = cert;
    }

    public Personnel getPersonnel() {  return personnel; }

    public void setPersonnel(Personnel personnel) {   this.personnel = personnel;  }

    public List<ServCpResume> getServCpResumes() {
        return servCpResumes;
    }

    public void setServCpResumes(List<ServCpResume> servCpResumes) {
        this.servCpResumes = servCpResumes;
    }

    public ServCpPerformance getServCpPerformance() {
        return servCpPerformance;
    }

    public void setServCpPerformance(ServCpPerformance servCpPerformance) { this.servCpPerformance = servCpPerformance; }

    public List<ServAttachment> getServAttachments() { return servAttachments;  }

    public void setServAttachments(List<ServAttachment> servAttachments) { this.servAttachments = servAttachments;  }





}
