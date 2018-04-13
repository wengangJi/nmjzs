package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.SoMainCert;

@MyBatisDao
public interface SoMainCertMapper {
    int insert(SoMainCert record);

    int insertSelective(SoMainCert record);

    int updateBySoid(SoMainCert record);

    SoMainCert findBySoid(String soid);
}