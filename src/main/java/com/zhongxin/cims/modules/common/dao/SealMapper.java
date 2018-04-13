package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.Seal;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface SealMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Seal record);

    int insertSelective(Seal record);

    Seal selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Seal record);

    int updateByPrimaryKey(Seal record);

    Seal selectBySealId(@Param("sealid") String sealid,@Param("localid") String localid);

    int selectByUserId(@Param("sealid") String sealid,@Param("localid") String localid);

    void removeByUserId(@Param("sealid") String sealid,@Param("localid") String localid);

    List<Seal> selectBySelective(Seal record);

    int  selectCountByName(String  name);
}