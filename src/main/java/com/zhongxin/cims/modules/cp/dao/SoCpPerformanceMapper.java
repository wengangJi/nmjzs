package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.SoCpPerformance;

import java.util.List;

@MyBatisDao
public interface SoCpPerformanceMapper {
    int insert(SoCpPerformance record);

    int insertSelective(SoCpPerformance record);

    int updateByPrimaryKey(SoCpPerformance record);

    SoCpPerformance findSoCpPerformanceBySoid(String soid);
}