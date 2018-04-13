
package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.ac.entity.SoPlanEntity;
import com.zhongxin.cims.modules.common.entity.So;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@MyBatisDao
public interface SoPlanMapper {
    int deleteByPrimaryKey(String soid);

    int insert(SoPlan record);

    int insertSelective(SoPlan record);

    SoPlan selectByPrimaryKey(String soid);

    int updateByPrimaryKeySelective(SoPlan record);

    int updateByPrimaryKey(SoPlan record);

    SoPlan findBySoid(String soid);

    SoPlanEntity findAllBySoid(String soid);

    List<SoPlan> findByUserId(String userId);

    List<SoPlan> findByPlanId(Long planId);

    List<SoPlan> findByCompanyId(Integer companyId);

    List<SoPlan> findPayListByUserId(@Param("userId") String userId ,@Param("feeState") String feeState );

    List<SoPlan> findAllPrePayList(SoPlan soPlan );


    List<SoPlan> findLearnListByUserId(@Param("userId") String userId ,@Param("learnState") String learnState );

    List<SoPlan> findHourListByUserId(@Param("userId") String userId ,@Param("hourState") String hourState );

    List<SoPlan> findExamListByUserId(@Param("userId") String userId ,@Param("examState") String examState );

    List<SoPlan> findAllExamListByUserId(@Param("userId") String userId);

    List<SoPlan> findAllCertListByUserId(@Param("userId") String userId);

    List<SoPlan> findAllReduceListByUserId(@Param("userId") String userId);

    List<SoPlan> findAllReduceListByCompanyId(@Param("companyId") Integer companyId);


    List<SoPlan> findReduceListByUserId(@Param("userId") String userId);

    List<SoPlan> findAllReduceList(SoPlan soPlan);

    List<SoPlan> findAllReduceList(SoPlanEntity soPlanEntity);

    List<SoPlan> findListBySoPlan(SoPlan soPlan);

    List<SoPlanEntity> findListBySoPlanEntity(SoPlanEntity soPlanEntity);

    List<SoPlan> findListBySoPlanEntitys(SoPlanEntity soPlanEntity);


    List<SoPlan> findCanReduceHoursPlan(@Param("userId") String userId );
}