/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/zhongxin/cims">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.zhongxin.cims.modules.sys.dao;
import  java.util.*;
import com.zhongxin.cims.common.persistence.BaseDao;
import com.zhongxin.cims.common.persistence.Parameter;
import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.sys.entity.Dict;
import com.zhongxin.cims.modules.sys.entity.SysBatch;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 字典DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@MyBatisDao
public interface BatchDao {

    int insert(SysBatch record);

    int insertSelective(SysBatch record);


    List<SysBatch> selectBactchList(SysBatch record);
    List<SysBatch> selectBactchListByCompanyId(Integer companyId);
    List<SysBatch> selectBactchSeq(SysBatch record);
    List<SysBatch> selectBactchListByAppId(String appId);
    List<SysBatch> selectBactchAllByAppId(String appId);
    SysBatch getBatchInfoByBatchId(@Param("batchId") String batchId);

    int updateBatchStsByPk(SysBatch record);

}
