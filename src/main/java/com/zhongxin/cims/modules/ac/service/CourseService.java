package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.ac.dao.CourseMapper;
import com.zhongxin.cims.modules.ac.dao.LessonMapper;
import com.zhongxin.cims.modules.ac.dao.SoCourseMapper;
import com.zhongxin.cims.modules.ac.entity.Course;
import com.zhongxin.cims.modules.sys.utils.CourseUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by lqyu_773 on 2014/8/30.
 */
@Component
@Transactional(readOnly = true)
public class CourseService extends BaseService {
    @Autowired
    private CourseMapper courseMapper;

    @Autowired
    private LessonMapper lessonMapper;

    @Autowired
    private SoCourseMapper soCourseMapper;


    public List<Course> findByPlanId(Long planId){
        return courseMapper.findByPlanId(planId);
    }

    public Course findByPK(Long id){
        return courseMapper.selectByPrimaryKey(id);
    }

    public Course findSoCourseByPlanId(Long courseId,Long planId){
        return courseMapper.selectSoCourseByPlanId(courseId, planId);
    }

    public List<Course> findProcessHoursBySoid(String soid,Long planId){
        return courseMapper.findProcessHoursBySoid(soid, planId);
    }

    public Page<Course> findCourseList(Page<Course> coursePage, Course course) {
        List<Course> courses = courseMapper.findCourseList(course);
        coursePage.setCount(courses.size());
        coursePage.setList(courses.subList(coursePage.getFirstResult(),coursePage.getLastResult()));
        return coursePage;
    }




    public Page<Course> list(Page<Course> coursePage, Course course) {
        List<Course> courses = courseMapper.list(course);
        coursePage.setCount(courses.size());
        coursePage.setList(courses.subList(coursePage.getFirstResult(),coursePage.getLastResult()));
        return coursePage;
    }

    public Page<Course> findCourseListByPlanId(Page<Course> coursePage, Long planId) {
        List<Course> courses = courseMapper.findByPlanId(planId);
        coursePage.setCount(courses.size());
        coursePage.setList(courses.subList(coursePage.getFirstResult(),coursePage.getLastResult()));
        return coursePage;
    }

    public Page<Course> findSoNoCourseListBySoid(Page<Course> coursePage, Long planId,String soid) {
        List<Course> courses = courseMapper.findNoCourseByPlanId(soid, planId);
        coursePage.setCount(courses.size());
        coursePage.setList(courses.subList(coursePage.getFirstResult(),coursePage.getLastResult()));
        return coursePage;
    }

    public Page<Course> findByUserId(Page<Course> coursePage, String userId) {
        List<Course> courses = soCourseMapper.findByUserId(userId);
        coursePage.setCount(courses.size());
        coursePage.setList(courses.subList(coursePage.getFirstResult(),coursePage.getLastResult()));
        return coursePage;
    }

    @Transactional(readOnly = false)
    public void save(Course course) {
        if (course.getCourseId() != null) {
            courseMapper.updateByPrimaryKey(course);
        } else {
            courseMapper.insert(course);
        }
        CourseUtils.removeCache();
    }



    @Transactional(readOnly = false)
    public void deleteById(Long id) {
        courseMapper.deleteByPrimaryKey(id);
        CourseUtils.removeCache();
    }
}
