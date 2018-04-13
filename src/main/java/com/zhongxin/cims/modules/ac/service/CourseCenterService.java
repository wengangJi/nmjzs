package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.mapper.BeanCopierMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.ac.dao.CourseCenterMapper;
import com.zhongxin.cims.modules.ac.dao.CourseMapper;
import com.zhongxin.cims.modules.ac.dao.LessonMapper;
import com.zhongxin.cims.modules.ac.dao.SoCourseMapper;
import com.zhongxin.cims.modules.ac.entity.Course;
import com.zhongxin.cims.modules.ac.entity.CourseCenter;
import com.zhongxin.cims.modules.sys.utils.CourseCenterUtils;
import com.zhongxin.cims.modules.sys.utils.CourseUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lqyu_773 on 2014/8/30.
 */
@Component
@Transactional(readOnly = true)
public class CourseCenterService extends BaseService {
    @Autowired
    private CourseCenterMapper courseCenterMapper;

    @Autowired
    private LessonMapper lessonMapper;

    @Autowired
    private SoCourseMapper soCourseMapper;

    @Autowired
    private CourseMapper courseMapper;






    public Page<CourseCenter> list(Page<CourseCenter> coursePage, CourseCenter courseCenter) {
        List<CourseCenter> courseCenterss = courseCenterMapper.list(courseCenter);
        coursePage.setCount(courseCenterss.size());
        coursePage.setList(courseCenterss.subList(coursePage.getFirstResult(),coursePage.getLastResult()));
        return coursePage;
    }


    public List<CourseCenter> findCourseCenterList(String majorId,String planId){
        return courseCenterMapper.findCourseCenterList(majorId,planId);
    }



    public CourseCenter findByPK(Long courseId){
        return courseCenterMapper.selectByPrimaryKey(courseId);
    }

    public CourseCenter findByCourseId(Long courseId){
        return courseCenterMapper.selectByCourseId(courseId);
    }

@Transactional(readOnly = false)
    public void savePlanCourse(String planId,String[] seqs){
        for(String courseId:seqs){
            CourseCenter courseCenter = courseCenterMapper.selectByCourseId(new Long(courseId).longValue());
            if(courseCenter!=null){
                Course course = new Course();
                course.setPlanId(new Long(planId).longValue());
                BeanCopierMapper.copyProperties(courseCenter, course);
                courseMapper.insert(course);
            }
        }

    }


    /*public Page<Course> findCourseListByPlanId(Page<Course> coursePage, Long planId) {
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
    }*/

    @Transactional(readOnly = false)
    public void save(CourseCenter courseCenter) {
        if (courseCenter.getCourseId() != null) {
            courseCenterMapper.updateByPrimaryKey(courseCenter);
        } else {
            courseCenterMapper.insert(courseCenter);
        }
        CourseCenterUtils.removeCache();
    }

   @Transactional(readOnly = false)
    public void delete(CourseCenter courseCenter) {
        courseCenterMapper.deleteByPrimaryKey(courseCenter.getCourseId());
       CourseCenterUtils.removeCache();
    }
}
