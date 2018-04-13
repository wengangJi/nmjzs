package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.Plan;
import com.zhongxin.cims.modules.common.entity.SynJxjyCase;

import java.util.List;

@MyBatisDao
public interface PlanMapper {
    int deleteByPrimaryKey(String planId);

    int insert(Plan record);

    int insertSelective(Plan record);

    Plan selectByPrimaryKey(Long planId);

    int updateByPrimaryKeySelective(Plan record);

    int updateByPrimaryKey(Plan record);

    List<Plan> findAll();

    List<Plan> findPlanManager();

    List<Plan> list(Plan plan);


}