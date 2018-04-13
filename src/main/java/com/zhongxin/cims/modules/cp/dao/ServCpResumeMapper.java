package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.ServCpResume;

import java.util.List;

@MyBatisDao
public interface ServCpResumeMapper {
    int insert(ServCpResume record);

    int insertSelective(ServCpResume record);

    int updateByPrimaryKeySelective(ServCpResume record);

    List<ServCpResume>  selectByPrimaryKey(Integer servId);
}