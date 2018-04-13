package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.Course;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface CourseMapper {

    int deleteByPrimaryKey(Long id);

    int insert(Course record);

    int insertSelective(Course record);

    Course selectByPrimaryKey(Long id );

    Course selectByCourseId(Long courseId);

    Course selectSoCourseByPlanId(@Param("courseId") Long courseId,@Param("planId") Long planId  );

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);

    List<Course> findByPlanId(Long planId);

    List<Course> list(Course course);

    List<Course> listAll();

    List<Course> findNoCourseByPlanId(@Param("soid") String soid,@Param("planId") Long planId  );
    List<Course> findProcessHoursBySoid(@Param("soid") String soid,@Param("planId") Long planId  );
    List<Course> findCourseList(Course record);



}