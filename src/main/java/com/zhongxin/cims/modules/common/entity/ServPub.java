package com.zhongxin.cims.modules.common.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructorBase;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructorMajor;
import com.zhongxin.cims.modules.comp.entity.Company;
import com.zhongxin.cims.modules.cp.entity.Personnel;

import java.util.Date;

public class ServPub extends BaseEntity<ServPub> {
    private Serv serv;
    private Cert servCert;
    private Personnel servCpBase;
    private AssociateConstructor servAc;


    public Serv getServ() {
        return serv;
    }

    public void setServ(Serv serv) {
        this.serv = serv;
    }

    public Cert getServCert() {
        return servCert;
    }

    public void setServCert(Cert servCert) {
        this.servCert = servCert;
    }

    public Personnel getServCpBase() {
        return servCpBase;
    }

    public void setServCpBase(Personnel servCpBase) {
        this.servCpBase = servCpBase;
    }

    public AssociateConstructor getServAc() {
        return servAc;
    }

    public void setServAc(AssociateConstructor servAc) {
        this.servAc = servAc;
    }
}