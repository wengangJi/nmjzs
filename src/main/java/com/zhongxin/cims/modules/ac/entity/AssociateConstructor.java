package com.zhongxin.cims.modules.ac.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.Serv;

import java.util.List;

/**
 * Created by lqyu_773 on 14-6-12.
 */
public class AssociateConstructor extends BaseEntity<AssociateConstructor> {
    private Integer servid;
    private Serv serv;
    private Cert cert;
    private AssociateConstructorBase associateConstructorBase;
    private List<AssociateConstructorMajor> associateConstructorMajorList;

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

    public AssociateConstructorBase getAssociateConstructorBase() {
        return associateConstructorBase;
    }

    public void setAssociateConstructorBase(AssociateConstructorBase associateConstructorBase) {
        this.associateConstructorBase = associateConstructorBase;
    }

    public List<AssociateConstructorMajor> getAssociateConstructorMajorList() {
        return associateConstructorMajorList;
    }

    public void setAssociateConstructorMajorList(List<AssociateConstructorMajor> associateConstructorMajorList) {
        this.associateConstructorMajorList = associateConstructorMajorList;
    }
}
