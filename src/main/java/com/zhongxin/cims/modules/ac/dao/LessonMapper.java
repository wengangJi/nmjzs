package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.Lesson;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface LessonMapper {
    int deleteByPrimaryKey(Long lessonId);

    int insert(Lesson record);

    int insertSelective(Lesson record);

    Lesson selectByPrimaryKey(Long lessonId);

    Lesson selectByLessonId(Long lessonId);

    int updateByPrimaryKeySelective(Lesson record);

    int updateByPrimaryKey(Lesson record);

    List<Lesson> findByCourseId(Long courseId);

    List<Lesson> findCourseHoursBySoid(@Param("soid") String soid,@Param("courseId")Long courseId);

    List<Lesson> findAll();

    List<Lesson> list(Lesson lesson);
}