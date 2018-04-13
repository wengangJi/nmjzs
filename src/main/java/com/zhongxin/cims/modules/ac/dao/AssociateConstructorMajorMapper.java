package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructorMajor;

@MyBatisDao
public interface AssociateConstructorMajorMapper {
    int insert(AssociateConstructorMajor record);

    int insertSelective(AssociateConstructorMajor record);
}