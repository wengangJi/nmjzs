package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.Personnel;
import com.zhongxin.cims.modules.cp.entity.ServCpEntity;
import com.zhongxin.cims.modules.cp.entity.ServCpPerformance;
import com.zhongxin.cims.modules.cp.entity.ServCpResume;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface PersonnelMapper {
    int insertPersonnel(Personnel record);

    int insertSelective(Personnel record);

    List<Personnel> find(Personnel record);

    List<Personnel> findPersonnelForExtend(Personnel record);

    List<Personnel> findListByIdNo(Personnel record);

    ServCpEntity findCpServInfoById(Integer servId);

    ServCpEntity findCpServInfoByIdNo(@Param("companyId") Integer companyId,@Param("idNo") String idNo,@Param("personType") String personType);


    List<ServCpResume> findPersonnelResumes(Integer servId);

    ServCpPerformance findPersonnelPerformance(Integer servId);

    List getDtree();
}