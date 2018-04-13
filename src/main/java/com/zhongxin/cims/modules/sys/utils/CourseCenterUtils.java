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
import com.zhongxin.cims.modules.ac.dao.CourseCenterMapper;
import com.zhongxin.cims.modules.ac.dao.CourseMapper;
import com.zhongxin.cims.modules.ac.entity.CourseCenter;

import java.util.List;
import java.util.Map;

/**
 * 字典工具类
 * @author ThinkGem
 * @version 2013-5-29
 */
public class CourseCenterUtils {
	
	private static CourseCenterMapper courseCenterMapper = SpringContextHolder.getBean(CourseCenterMapper.class);

	public static final String CACHE_COURSE_CENTER_MAP = "courseCenterMap";
	

	
/*
	public static Course getByPrimaryKey(Long type){
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
	}
*/

    public static CourseCenter getByCourseId(Long type){
        @SuppressWarnings("unchecked")
        CourseCenter courseCenter =null;
        Map<String, CourseCenter> courseCenterMap = (Map<String, CourseCenter>) CacheUtils.get(CACHE_COURSE_CENTER_MAP);
        if (courseCenterMap ==null || courseCenterMap.get(type)==null ||courseCenterMap!=null){  //课件暂时全部从数据库中获取
            courseCenterMap = Maps.newHashMap();
            courseCenter=courseCenterMapper.selectByCourseId(type);
            courseCenterMap.put(courseCenter.getCourseId() + "",courseCenter);
            CacheUtils.put(CACHE_COURSE_CENTER_MAP, courseCenterMap);
        }
      //  course = courseMap.get(type);
        return courseCenter;
    }



    public static void removeCache() {
        CacheUtils.remove(CACHE_COURSE_CENTER_MAP);
    }
	
}
