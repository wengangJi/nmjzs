package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.List;

/**
 * Created by lqyu_773 on 14-8-29.
 */
public class SoPlanEntity extends BaseEntity<SoPlanEntity> {
    private String soid; // 申请编码
    private SoPlan soPlan; // 申请的计划
    private List<Course> courses;
    private List<SoCourse> soCourses; // 选课列表
    private SoInvoice soInvoice; // 发票信息
    private ServAssociateConstructor servAcInfo;

    public List<Course> getCourses() {
        return courses;
    }

    public void setCourses(List<Course> courses) {
        this.courses = courses;
    }




    private String startTime;
    private String endTime;
    private Long[] seqs;
    private String planRadio;

    public String getPlanRadio() {
        return planRadio;
    }

    public void setPlanRadio(String planRadio) {
        this.planRadio = planRadio;
    }

    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid;
    }

    public SoPlan getSoPlan() {
        return soPlan;
    }

    public void setSoPlan(SoPlan soPlan) {
        this.soPlan = soPlan;
    }

    public List<SoCourse> getSoCourses() {
        return soCourses;
    }

    public void setSoCourses(List<SoCourse> soCourses) {
        this.soCourses = soCourses;
    }

    public SoInvoice getSoInvoice() {
        return soInvoice;
    }

    public void setSoInvoice(SoInvoice soInvoice) {
        this.soInvoice = soInvoice;
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

    public Long[] getSeqs() {
        return seqs;
    }

    public void setSeqs(Long[] seqs) {
        this.seqs = seqs;
    }

    public ServAssociateConstructor getServAcInfo() {
        return servAcInfo;
    }

    public void setServAcInfo(ServAssociateConstructor servAcInfo) {
        this.servAcInfo = servAcInfo;
    }
}
