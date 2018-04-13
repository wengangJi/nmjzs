package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.ServCpPerformance;

@MyBatisDao
public interface ServCpPerformanceMapper {
    int deleteByPrimaryKey(Integer servid);

    int insert(ServCpPerformance record);

    int insertSelective(ServCpPerformance record);

    ServCpPerformance selectByPrimaryKey(Integer servid);

    int updateByPrimaryKeySelective(ServCpPerformance record);

    int updateByPrimaryKey(ServCpPerformance record);
}