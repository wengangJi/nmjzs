package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.Course;
import com.zhongxin.cims.modules.ac.entity.SoCourse;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface SoCourseMapper {
    int insert(SoCourse record);

    int insertSelective(SoCourse record);

    int updateByPrimaryKeySelective(SoCourse record);

    int updateByPrimaryKey(SoCourse record);

    List<SoCourse> findBySoid(String soid);

    List<Course> findByUserId(String userId);



}