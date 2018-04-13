package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.CourseCenter;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface CourseCenterMapper {
    int deleteByPrimaryKey(Long courseId);

    int insert(CourseCenter record);

    int insertSelective(CourseCenter record);

    CourseCenter selectByPrimaryKey(Long courseId);

    CourseCenter selectByCourseId(Long courseId);

    int updateByPrimaryKeySelective(CourseCenter record);

    int updateByPrimaryKey(CourseCenter record);


    List<CourseCenter> list(CourseCenter courseCenter);

    List<CourseCenter> findCourseCenterList(@Param("majorId") String majorId, @Param("planId") String planId );



    List<CourseCenter> listAll();



}