package com.zhongxin.cims.modules.se.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.se.entity.SafetyEngineering;

@MyBatisDao
public interface SafetyEngineeringMapper {
    int insert(SafetyEngineering record);

    int insertSelective(SafetyEngineering record);
}