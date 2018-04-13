package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructorBase;

@MyBatisDao
public interface AssociateConstructorBaseMapper {
    int insert(AssociateConstructorBase record);

    int insertSelective(AssociateConstructorBase record);
}