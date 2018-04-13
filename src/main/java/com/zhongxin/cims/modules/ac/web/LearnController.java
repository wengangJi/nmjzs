package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.*;
import com.zhongxin.cims.modules.ac.service.CourseService;
import com.zhongxin.cims.modules.ac.service.LessonService;
import com.zhongxin.cims.modules.ac.service.PlanService;
import com.zhongxin.cims.modules.ac.service.ServAssociateConstructorService;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.DictUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
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
import java.util.List;

/**
 * 二级建造师Controller
 * @author liuqy
 * @version 2014-06-12
 */
@Controller
@RequestMapping(value = "${adminPath}/learn")
public class LearnController extends BaseController {

    @Autowired
    private PlanService planService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private LessonService lessonService;

    @Autowired
    private ServAssociateConstructorService servAssociateConstructorService;

    @ModelAttribute
    public SoPlan get(@RequestParam(required=false) String soid) {
        if (soid != null){
            SoPlan soPlan = planService.findBySoid(soid);
            return soPlan;
        }else{
            return new SoPlan();
        }
    }
    @RequestMapping(value = "apply")
    public String learn(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findPayListByUserId(user.getId(),"1");
        model.addAttribute("soPlans",soPlans);
        return "modules/ac/learnForm";
    }

    @RequestMapping(value = "learnProcess")
    public String learnProcess(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findPayListByUserId(user.getId(),"1");
        model.addAttribute("soPlans",soPlans);
        return "modules/ac/learnProcessPage";
    }

    @RequestMapping(value = "learnAllProcess1")
    public String learnAllProcess1(SoPlan soPlan ,HttpServletRequest request,HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findListBySoPlan(new Page<SoPlan>(request, response), soPlan);
        model.addAttribute("page",page);
        return "modules/ac/learnAllProcessPage";
    }

    @RequestMapping(value = "learnAllProcess")
    public String learnAllProcess(SoPlanEntity soPlanEntity ,HttpServletRequest request,HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findListBySoPlanEntitys(new Page<SoPlan>(request, response), soPlanEntity);
        model.addAttribute("page",page);
        return "modules/ac/learnAllProcessPage";
    }

    @RequestMapping(value = "learnProcessQuery")
    public String learnProcessQuery(String soid,Long planId,HttpServletRequest request, Model model){
        List<Course> courses= courseService.findProcessHoursBySoid(soid,planId);
        model.addAttribute("courses",courses);
        return  "modules/ac/acHoursQuery";
    }

    @RequestMapping(value = "findSoCourseBySoid")
    public String findSoCourseBySoid(String soid,HttpServletRequest request,Model model) {
        List<SoCourse> soCourses = planService.findSoCourseListBySoid(soid);
        model.addAttribute("soCourses",soCourses);
        return  "modules/ac/acLearnCourse";
    }


    @RequestMapping(value = "findCourseListByPlanId")
    public String findCourseListByPlanId(Long planId,HttpServletRequest request,HttpServletResponse response,Model model) {
        Page<Course> page = courseService.findCourseListByPlanId(new Page<Course>(request,response),planId);
        model.addAttribute("page",page);
        return "modules/ac/acLearnCourse";
    }

    @RequestMapping(value = "getCourses")
    @ResponseBody
    public List<Course> getCourse(Long planId,HttpServletRequest request, Model model) {
        List<Course> courses = courseService.findByPlanId(planId);
        for(Course course: courses){
            course.setRsrvStr1(DictUtils.getDictLabel(course.getCourseType(), "COURSE_TYPE", "选修课"));
        }

        model.addAttribute("courses", courses);
        return courses;
    }

    @RequestMapping(value = "getPlan")
    @ResponseBody
    public Plan getPlan(Long planId,HttpServletRequest request, Model model) {
        Plan plan = planService.findByPrimaryKey(planId);
        plan.setRsrvStr1(DictUtils.getDictLabel(plan.getPlanType(), "PLAN_TYPE", ""));
        plan.setRsrvStr2(DictUtils.getDictLabel(plan.getMajorId(), "MAJOR", ""));
        return plan;
    }

    @RequestMapping(value = "getCoursesByIds")
    @ResponseBody
    public List<Course> getCoursesByIds(Long[] courseIds,HttpServletRequest request, Model model) {
        List<Course> courses = new ArrayList<Course>();
        for (Long id:courseIds) {
            Course course = courseService.findByPK(id);
            courses.add(course);

        }
        for(Course course: courses){
            course.setRsrvStr1(DictUtils.getDictLabel(course.getCourseType(), "COURSE_TYPE", "选修课"));
        }
        return courses;
    }

    @RequestMapping(value = "save")
    public String save(SoPlanEntity soPlanEntity,HttpServletRequest request, Model model,RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();

        // 发票实体
        SoInvoice soInvoice = soPlanEntity.getSoInvoice();
        soInvoice.setUserId(user.getId());

        // 计划实体
        SoPlan soPlan = new SoPlan();
        soPlan.setPlanId(new Long(soPlanEntity.getPlanRadio()));
        soPlan.setUserId(user.getId());
        soPlan.setLocalId(user.getUserCompany()!=null?user.getUserCompany().getLocalId():471);
        soPlan.setFeeId("100"); // 费用类型,目前没用,留后续扩展
        soPlan.setFee(soInvoice.getFee());

        // 课程实体
        List<SoCourse> courses = new ArrayList<SoCourse>();
        for(Long courseId : soPlanEntity.getSeqs()) {
            SoCourse course = new SoCourse();
            Course course1 = new Course();
            course1.setCourseId(courseId);
            course.setCourse(course1);
            course.setUserId(user.getId());
            course.setValid("0");
            courses.add(course);
        }

        soPlanEntity.setSoPlan(soPlan);
        soPlanEntity.setSoCourses(courses);
        String soid = planService.save(soPlanEntity);
        addMessage(redirectAttributes, "温馨提示：您的培训申请已经成功提交。申请流水：" + soid);
        return "redirect:" + Global.getAdminPath()+"/plan/acNoPayListByUser/?repage";
    }





    @RequestMapping(value = "acPayListByUser")
    public String acPayListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findPayListByUserId(user.getId(),"1");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoList";
    }


    @RequestMapping(value = "acNoPayListByUser")
    public String acNoPayListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findPayListByUserId(user.getId(),"0");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoList";
    }



}
