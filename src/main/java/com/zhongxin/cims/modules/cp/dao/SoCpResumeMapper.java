package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.SoCpResume;

import java.util.List;

@MyBatisDao
public interface SoCpResumeMapper {
    int insert(SoCpResume record);

    int insertSelective(SoCpResume record);

    int updateByPrimaryKey(SoCpResume record);


    List<SoCpResume> findSoCpResumeBySoid(String soid);
}