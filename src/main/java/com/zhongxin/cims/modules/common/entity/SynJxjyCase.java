package com.zhongxin.cims.modules.common.entity;

import java.util.Date;

public class SynJxjyCase {
    private Integer id;

    private String xm;

    private String zjhm;

    private String zcbh;

    private String zylb;

    private String hgzbh;

    private Date qfrq;

    private Integer bxxs;

    private Integer xxxs;

    private String gzdw;

    private Date pxsjq;

    private Date pxsjz;

    private Date zhgxsj;

    private Integer state;

    private String pass;

    private String createby;

    private Date creaetdate;

    private String updateby;

    private Date updatedate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getXm() {
        return xm;
    }

    public void setXm(String xm) {
        this.xm = xm == null ? null : xm.trim();
    }

    public String getZjhm() {
        return zjhm;
    }

    public void setZjhm(String zjhm) {
        this.zjhm = zjhm == null ? null : zjhm.trim();
    }

    public String getZcbh() {
        return zcbh;
    }

    public void setZcbh(String zcbh) {
        this.zcbh = zcbh == null ? null : zcbh.trim();
    }

    public String getZylb() {
        return zylb;
    }

    public void setZylb(String zylb) {
        this.zylb = zylb == null ? null : zylb.trim();
    }

    public String getHgzbh() {
        return hgzbh;
    }

    public void setHgzbh(String hgzbh) {
        this.hgzbh = hgzbh == null ? null : hgzbh.trim();
    }

    public Date getQfrq() {
        return qfrq;
    }

    public void setQfrq(Date qfrq) {
        this.qfrq = qfrq;
    }

    public Integer getBxxs() {
        return bxxs;
    }

    public void setBxxs(Integer bxxs) {
        this.bxxs = bxxs;
    }

    public Integer getXxxs() {
        return xxxs;
    }

    public void setXxxs(Integer xxxs) {
        this.xxxs = xxxs;
    }

    public String getGzdw() {
        return gzdw;
    }

    public void setGzdw(String gzdw) {
        this.gzdw = gzdw == null ? null : gzdw.trim();
    }

    public Date getPxsjq() {
        return pxsjq;
    }

    public void setPxsjq(Date pxsjq) {
        this.pxsjq = pxsjq;
    }

    public Date getPxsjz() {
        return pxsjz;
    }

    public void setPxsjz(Date pxsjz) {
        this.pxsjz = pxsjz;
    }

    public Date getZhgxsj() {
        return zhgxsj;
    }

    public void setZhgxsj(Date zhgxsj) {
        this.zhgxsj = zhgxsj;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass == null ? null : pass.trim();
    }

    public String getCreateby() {
        return createby;
    }

    public void setCreateby(String createby) {
        this.createby = createby == null ? null : createby.trim();
    }

    public Date getCreaetdate() {
        return creaetdate;
    }

    public void setCreaetdate(Date creaetdate) {
        this.creaetdate = creaetdate;
    }

    public String getUpdateby() {
        return updateby;
    }

    public void setUpdateby(String updateby) {
        this.updateby = updateby == null ? null : updateby.trim();
    }

    public Date getUpdatedate() {
        return updatedate;
    }

    public void setUpdatedate(Date updatedate) {
        this.updatedate = updatedate;
    }
}