package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.SoCpBase;

@MyBatisDao
public interface SoCpBaseMapper {
    int insert(SoCpBase record);

    int insertSelective(SoCpBase record);

    int updateByPrimaryKey(SoCpBase record);


    SoCpBase findSoCpBaseBySoid(String soid);
}