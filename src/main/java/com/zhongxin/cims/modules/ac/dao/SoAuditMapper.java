package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.SoAudit;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface SoAuditMapper {
    int deleteByPrimaryKey(Long id);

    int insert(SoAudit record);

    int insertSelective(SoAudit record);

    SoAudit selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SoAudit record);

    int updateByPrimaryKey(SoAudit record);

    List<SoAudit> selectBySoid(String soid);

    List<SoAudit> findBySoidAndSoHoursId(@Param("soid") String soid,@Param("soHoursId") Long soHoursId);
}