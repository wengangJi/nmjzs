package com.zhongxin.cims.modules.se.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.Serv;

import java.util.Date;

public class SafetyEngineering extends BaseEntity<SafetyEngineering> {
    private Integer servid;
    private Serv serv;
    private Cert cert;


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
}