package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.ServAssociateConstructor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface ServAssociateConstructorMapper {


    int deleteByPrimaryKey(Integer servid);

    int insert(ServAssociateConstructor record);

    int insertSelective(ServAssociateConstructor record);

    ServAssociateConstructor selectByPrimaryKey(Integer servid);

    ServAssociateConstructor findByUserId(String userId);

    ServAssociateConstructor checkServExist(@Param("idNo") String idNo, @Param("certNo") String certNo);


    int updateByPrimaryKeySelective(ServAssociateConstructor record);

    int updateByPrimaryKey(ServAssociateConstructor record);

    List<ServAssociateConstructor> findByServAcInfo(ServAssociateConstructor servAssociateConstructor);
}