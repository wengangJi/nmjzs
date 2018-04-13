package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.ServCpBase;

@MyBatisDao
public interface ServCpBaseMapper {
    int deleteByPrimaryKey(Integer servid);

    int insert(ServCpBase record);

    int insertSelective(ServCpBase record);

    ServCpBase selectByPrimaryKey(Integer servid);

    int updateByPrimaryKeySelective(ServCpBase record);

    int updateByPrimaryKey(ServCpBase record);
}