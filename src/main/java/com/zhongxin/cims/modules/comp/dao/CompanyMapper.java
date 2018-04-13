package com.zhongxin.cims.modules.comp.dao;


import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.Serv;
import com.zhongxin.cims.modules.comp.entity.Company;

import java.util.List;

@MyBatisDao
public interface CompanyMapper {
    int deleteByPrimaryKey(Integer companyId);

    int insert(Company record);

    int insertSelective(Company record);

    Company selectByPrimaryKey(Integer companyId);

    int updateByPrimaryKeySelective(Company record);

    int updateByPrimaryKey(Company record);

    Company selectByNameOrOrgCode(Company record);

    List<Company> selectList(Company record);

    List<Company> selectByName(String  companyName);




}