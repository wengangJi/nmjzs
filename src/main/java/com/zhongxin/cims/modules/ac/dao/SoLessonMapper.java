package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.Lesson;
import com.zhongxin.cims.modules.ac.entity.SoLesson;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface SoLessonMapper {

    int insert(SoLesson record);

    SoLesson selectByPSoid(String soid);

    int updateByPrimaryKeySelective(SoLesson record);

    int selectByVideo(@Param("soid") String soid,@Param("lessonId") Long lessonId);

    int removeLesson(@Param("soid") String soid,@Param("lessonId") Long lessonId);

    int confirmLesson(SoLesson record);





}