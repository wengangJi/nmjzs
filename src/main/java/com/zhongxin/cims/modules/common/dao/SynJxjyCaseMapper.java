package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.SynJxjyCase;

import java.util.List;

@MyBatisDao
public interface SynJxjyCaseMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SynJxjyCase record);

    int insertSelective(SynJxjyCase record);

    SynJxjyCase selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SynJxjyCase record);

    int updateByPrimaryKey(SynJxjyCase record);

    List<SynJxjyCase> list(SynJxjyCase synJxjyCase);

     int syn(Integer id);
}