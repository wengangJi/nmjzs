package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.BeanCopierMapper;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.*;
import com.zhongxin.cims.modules.ac.service.*;
import com.zhongxin.cims.modules.sys.utils.PlanUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lqyu_773 on 2014/8/30.
 */
@Controller
@RequestMapping(value = "${adminPath}/course")
public class CourseController extends BaseController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private CourseCenterService courseCenterService;

    @Autowired
    private LessonService lessonService;

    @Autowired
    private PlanService planService;

    @Autowired
    private VideoService videoService;

    @ModelAttribute
    public CourseCenter get(@RequestParam(required=false) Long courseId) {
        if (courseId != null && !"".equals(courseId)){
            CourseCenter courseCenter = courseCenterService.findByPK(courseId);
            return courseCenter;
        }else{
            return new CourseCenter();
        }
    }

    @RequestMapping(value = "detail")
    public String detail(Long courseId,String soid,HttpServletRequest request,Model model) {
        CourseCenter courseCenter = courseCenterService.findByPK(courseId);
        model.addAttribute("course",courseCenter);
        return "modules/ac/courseDetail";
    }

    @RequestMapping(value = "detailBySoid")
    public String detailBySoid(Long courseId,String soid,HttpServletRequest request,Model model) {
        SoPlan soPlan = planService.findBySoid(soid);

        Course course = courseService.findSoCourseByPlanId(courseId,soPlan.getPlanId());
        List<Lesson> lessons = lessonService.findCourseHoursBySoid(soid,courseId);
        model.addAttribute("lessons",lessons);
        model.addAttribute("course",course);
        model.addAttribute("soPlan",soPlan);
        return "modules/ac/acSoCourseDetail";
    }


    /**
     * 校验是否存在正在进行学习情况
     *
     * @param courseId
     * @param model
     * @param soid
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"checkExistsPlayVideo"})
    public String checkExistsPlayVideo(String courseId,String soid, Model model) {
        Map map = new HashMap();
        boolean  flag = videoService.findExistsPlayVideo(UserUtils.getUser().getId().toString(),soid);
        map.put("flag", flag);
        return JsonMapper.nonDefaultMapper().toJson(map);
    }

/*    @RequestMapping(value = "ulist")
    public String ulist( userId,HttpServletRequest request,Model model) {
        Page<Course> page = courseService.findByUserId(new Page<Course>(request,response),course);
        model.addAttribute("page", page);
    }*/

    @RequestMapping(value = "list")
    public String list(CourseCenter courseCenter,HttpServletRequest request,HttpServletResponse response,Model model) {
        Page<CourseCenter> page = courseCenterService.list(new Page<CourseCenter>(request,response),courseCenter);
        model.addAttribute("page",page);
        return "modules/ac/courseList";
    }



    @RequiresPermissions("course:edit")
    @RequestMapping(value = "courseForm")
    public String courseForm(CourseCenter courseCenter,Model model){
        if (courseCenter.getCourseId() != null) {
            model.addAttribute("disabled","true");
        }

        model.addAttribute("courseCenter", courseCenter);
        return "modules/ac/course/courseForm";
    }

    @RequiresPermissions("course:edit")
    @RequestMapping(value = "save")
    public String save(CourseCenter courseCenter,Model model,RedirectAttributes redirectAttributes,HttpServletRequest request) {
        if (!beanValidator(model, courseCenter)){
            return courseForm(courseCenter, model);
        }

        courseCenter.setImagePath(request.getParameter("imagePath"));
        courseCenterService.save(courseCenter);
        addMessage(redirectAttributes, "保存成功！");
        return "redirect:"+ Global.getAdminPath()+"/course/list/?repage";
    }


    @RequiresPermissions("course:edit")
    @RequestMapping(value = "savePlanCourse")
    public String savePlanCourse(SoPlanEntity soPlanEntity,String[] seqs,Model model,RedirectAttributes redirectAttributes,HttpServletRequest request) {
        if(soPlanEntity.getPlanRadio()==null || "".equals(soPlanEntity.getPlanRadio()) || seqs ==null || seqs.length==0){

        }
        courseCenterService.savePlanCourse(soPlanEntity.getPlanRadio(),seqs);
        addMessage(redirectAttributes, "项目与课程绑定成功！");
        return "redirect:"+ Global.getAdminPath()+"/plan/acPlanCourseForm/?repage";
    }

    @ResponseBody
    @RequestMapping(value = "getCourseByPlan")
    public String getCourseByPlan(Long planId) {
        if (planId != null) {
            List<Course> courseList = courseService.findByPlanId(planId);
            return JsonMapper.nonDefaultMapper().toJson(courseList);
        } else {
            return null;
        }
    }

    @RequiresPermissions("course:edit")
    @RequestMapping(value = "delete")
    public String delete (CourseCenter courseCenter,RedirectAttributes redirectAttributes) {
        courseCenterService.delete(courseCenter);
        addMessage(redirectAttributes,"删除成功！");
        return "redirect:"+ Global.getAdminPath()+"/course/list/?repage";
    }

    @RequestMapping(value = "findCourseList")
    public String findCourseList (Course course,RedirectAttributes redirectAttributes,Model model,HttpServletRequest request,HttpServletResponse response) {


        if (course.getPlan() == null) {
            Plan plan = new Plan();
            course.setPlan(plan);
        }
        model.addAttribute("planList", PlanUtils.getAllPlanByYear(course.getPlan().getYear()));
        if (course != null && course.getPlan() != null && course.getPlan().getYear() != null) {
            model.addAttribute("courseList",courseService.findByPlanId(course.getPlanId()));
        }

        Page<Course> page = courseService.findCourseList(new Page<Course>(request,response),course);
        model.addAttribute("page",page);
        return "modules/ac/course/coursePlanList";
    }


    @RequiresPermissions("course:edit")
    @RequestMapping(value = "deleteCourseById")
    public String deleteCourseById(String id,RedirectAttributes redirectAttributes) {

        if(id!=null && !"".equals(id)){
           /* Course course = courseService.findByPK(Long.valueOf(id).longValue());
            if(course!=null){
                List<SoPlan> soPlans = planService.findByPlanId(course.getPlanId());
                if(soPlans.size()>0){
                    addMessage(redirectAttributes,"存在未完成申报，不允许解除！");
                    return "redirect:"+ Global.getAdminPath()+"/course/findCourseList/?repage";
                }
            }*/
            courseService.deleteById(Long.valueOf(id).longValue());
            addMessage(redirectAttributes,"解除绑定成功！");
        }
        return "redirect:"+ Global.getAdminPath()+"/course/findCourseList/?repage";
    }

}
