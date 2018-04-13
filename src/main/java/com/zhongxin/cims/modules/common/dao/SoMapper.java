package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.So;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface SoMapper {
    int deleteByPrimaryKey(String soid);

    int insert(So record);

    int insertSelective(So record);

    So selectByPrimaryKey(String soid);

    int updateByPrimaryKeySelective(So record);

    int updateByPrimaryKey(So record);

    int updateStsByPrimaryKey(So record);

    int removeByPrimaryKey(String soid);

    List<So> findBySts(String sts);

    So findSoidByPara(@Param("appId") String appId,@Param("soType") String soType,@Param("userId") String userId,@Param("companyId") Integer companyId,@Param("localId") Integer localId);

    List<So> findSoForCheckBefore(@Param("appId") String appid,@Param("idNo") String idNo,@Param("soType") String soType);
}