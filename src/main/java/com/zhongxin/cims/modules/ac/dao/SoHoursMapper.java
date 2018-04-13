package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.SoHours;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface SoHoursMapper {
    int deleteByPrimaryKey(Long id);

    int insert(SoHours record);

    int insertSelective(SoHours record);

    SoHours selectByPrimaryKey(Long id);

    List<SoHours> selectBySoid(String soid);

    List<SoHours> selectReduceBySoid(String soid);

    int updateByPrimaryKeySelective(SoHours record);

    int updateByPrimaryKey(SoHours record);

    List<SoHours> findByUserId(@Param("userId") String userId);

    List<SoHours> findReduceByUserId(@Param("userId") String userId);

    List<SoHours> findAuditList();

    int selectByVideo(@Param("soid") String soid,@Param("courseId")Long courseId,@Param("lessonId") Long lessonId);

    int selectByCheckExistsHours(@Param("soid") String soid,@Param("courseId")Long courseId,@Param("lessonId") Long lessonId);

    int selectByCheckVideoConfirm(@Param("soid") String soid,@Param("courseId")Long courseId,@Param("lessonId") Long lessonId);

    int selectByCheckVideoAudit(@Param("soid") String soid,@Param("courseId")Long courseId,@Param("lessonId") Long lessonId);

    int removeHours(@Param("soid") String soid,@Param("courseId")Long courseId,@Param("lessonId") Long lessonId);

    int confirmHours(SoHours record);

    List<SoHours> findAuditList(SoHours soHours);

    List<SoHours> findAuditedList(SoHours soHours);

    List<SoHours> findOwnAuditList(SoHours soHours);

    List<SoHours> findAuditedNoPassList(SoHours soHours);




    double getTotalHours(@Param("soid") String soid);
}