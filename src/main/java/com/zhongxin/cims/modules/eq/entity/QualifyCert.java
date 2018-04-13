package com.zhongxin.cims.modules.eq.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.Serv;

import java.util.List;

/**
 * Created by lqyu_773 on 14-6-12.
 */
public class QualifyCert extends BaseEntity<QualifyCert> {
    private Integer servid;
    private Serv serv;
    private Cert cert;
    private List<QualItem> qualItems;

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

    public List<QualItem> getQualItems() {
        return qualItems;
    }

    public void setQualItems(List<QualItem> qualItems) {
        this.qualItems = qualItems;
    }
}
