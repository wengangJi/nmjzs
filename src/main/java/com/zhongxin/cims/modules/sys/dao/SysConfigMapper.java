package com.zhongxin.cims.modules.sys.dao;


import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.sys.entity.SysBatch;

import java.util.List;


@MyBatisDao
public interface SysConfigMapper {
    int deleteByPrimaryKey(Integer batchId);

    int insert(SysBatch record);

    int insertSelective(SysBatch record);

    SysBatch selectByPrimaryKey(Integer batchId);

    int updateByPrimaryKeySelective(SysBatch record);

    int updateByPrimaryKey(SysBatch record);

    SysBatch selectByNameOrOrgCode(SysBatch record);

    List<SysBatch> selectBactchList(SysBatch record);

}