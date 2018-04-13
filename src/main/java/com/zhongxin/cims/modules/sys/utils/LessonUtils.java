/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/zhongxin/cims">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.zhongxin.cims.modules.sys.utils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.zhongxin.cims.common.utils.CacheUtils;
import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.modules.ac.dao.CourseMapper;
import com.zhongxin.cims.modules.ac.entity.Course;

import java.util.List;
import java.util.Map;

/**
 * 字典工具类
 * @author ThinkGem
 * @version 2013-5-29
 */
public class LessonUtils {
	
	private static CourseMapper courseDao = SpringContextHolder.getBean(CourseMapper.class);

	public static final String CACHE_COURSE_MAP = "courseMap";
	
	public static Course getCourseByPlanId(Long planId){
		if (planId != null){
			for (Course course : getByPlanId(planId)){
				if (planId.equals(course.getCourseId())){
					return course;
				}
			}
		}
		return null;
	}

    public static List<Course> getByPlanId(Long type){
        @SuppressWarnings("unchecked")
        Map<String, List<Course>> courseMap = (Map<String, List<Course>>) CacheUtils.get(CACHE_COURSE_MAP);
        if (courseMap==null || courseMap!=null){//课件暂时全部从数据库中获取
            courseMap = Maps.newHashMap();
            for (Course course : courseDao.findByPlanId(type)){
                List<Course> courseList = courseMap.get(course.getCourseId());
                if (courseList != null){
                    courseList.add(course);
                }else{
                    courseMap.put(course.getCourseId() + "", Lists.newArrayList(course));
                }
            }
            CacheUtils.put(CACHE_COURSE_MAP, courseMap);
        }
        List<Course> courseList = courseMap.get(type);
        if (courseList == null){
            courseList = Lists.newArrayList();
        }
        return courseList;
    }
	
/*	public static Course getByPrimaryKey(Long type){
		@SuppressWarnings("unchecked")
        Course course =null;
        Map<String, Course> courseMap = (Map<String, Course>) CacheUtils.get(CACHE_COURSE_MAP);
        if (courseMap ==null || courseMap.get(type)==null ||courseMap!=null){  //课件暂时全部从数据库中获取
            courseMap = Maps.newHashMap();
			 course=courseDao.selectByPrimaryKey(type);
             courseMap.put(course.getCourseId() + "",course);
            CacheUtils.put(CACHE_COURSE_MAP, courseMap);
		}
        course = courseMap.get(type);
        return course;
	}*/

    public static Course getByCourseId(Long type){
        @SuppressWarnings("unchecked")
        Course course =null;
        Map<String, Course> courseMap = (Map<String, Course>) CacheUtils.get(CACHE_COURSE_MAP);
        if (courseMap ==null || courseMap.get(type)==null ||courseMap!=null){  //课件暂时全部从数据库中获取
            courseMap = Maps.newHashMap();
            course=courseDao.selectByCourseId(type);
            courseMap.put(course.getCourseId() + "",course);
            CacheUtils.put(CACHE_COURSE_MAP, courseMap);
        }
        course = courseMap.get(type);
        return course;
    }



    public static void removeCache() {
        CacheUtils.remove(CACHE_COURSE_MAP);
    }
	
}
