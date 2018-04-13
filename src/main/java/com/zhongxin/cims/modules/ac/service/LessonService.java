package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.ac.dao.LessonMapper;
import com.zhongxin.cims.modules.ac.entity.Lesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by lqyu_773 on 2014/8/30.
 */
@Component
@Transactional(readOnly = true)
public class LessonService extends BaseService {
    @Autowired
    private LessonMapper lessonMapper;

    public List<Lesson> findByCourseId(Long courseId){
        return lessonMapper.findByCourseId(courseId);
    }

    public List<Lesson> findCourseHoursBySoid(String soid,Long courseId){
        return lessonMapper.findCourseHoursBySoid(soid, courseId);
    }



    public Lesson findByPrimaryKey(Long lessonId){return lessonMapper.selectByPrimaryKey(lessonId); }

    public Lesson findByLessonId(Long lessonId){return lessonMapper.selectByLessonId(lessonId); }

    @Transactional(readOnly = false)
    public void save(Lesson lesson) {
        if (lesson.getLessonId() != null) {
            lessonMapper.updateByPrimaryKey(lesson);
        } else {
            lessonMapper.insert(lesson);
        }
    }

    @Transactional(readOnly = false)
    public void modify(Lesson lesson) {
        if (lesson.getLessonId() != null) {
            lessonMapper.updateByPrimaryKeySelective(lesson);
        }
    }

    public Page<Lesson> list(Page<Lesson> page, Lesson lesson) {
        List<Lesson> lessons = lessonMapper.list(lesson);
        page.setCount(lessons.size());
        page.setList(lessons.subList(page.getFirstResult(), page.getLastResult()));
        return page;
    }

    @Transactional(readOnly = false)
    public void delete(Lesson lesson) {
        lessonMapper.deleteByPrimaryKey(lesson.getLessonId());
    }

    @Transactional(readOnly = false)
    public void deleteByLessonId(Long lessonId) {
        lessonMapper.deleteByPrimaryKey(lessonId);
    }
}
