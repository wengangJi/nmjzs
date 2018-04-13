package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.cp.entity.Personnel;
import com.zhongxin.cims.modules.cp.entity.ServCpEntity;
import com.zhongxin.cims.modules.eq.entity.QualifyCert;
import com.zhongxin.cims.modules.se.entity.SafetyEngineering;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface CertMapper {
    int insert(Cert record);

    int insertSelective(Cert record);

    Cert selectByServid(Integer servId);

    List<Cert> find(Cert cert);

    List<QualifyCert> findeq(QualifyCert qualifyCert);

    List<AssociateConstructor> findacPerson(AssociateConstructor associateConstructor);

    List<AssociateConstructor> findacMajor(AssociateConstructor associateConstructor);

    List<SafetyEngineering> findse(SafetyEngineering safetyEngineering);

    List<ServCpEntity> findCPAssignCert(ServCpEntity servCpEntity);

    List<ServCpEntity> findCpManagerCert(ServCpEntity servCpEntity);

    List<ServCpEntity> findCPAssCertByCompanyId(@Param("companyId") Integer companyId);

    List<ServCpEntity> findCPManCertByCompanyId(@Param("companyId") Integer companyId);

    int updateByServid(Cert record);

    int updateByPrimaryKeySelective(Cert record);

}