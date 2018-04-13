package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.*;
import com.zhongxin.cims.modules.ac.service.*;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.DictUtils;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
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
import java.util.Date;
import java.util.List;

/**
 * 二级建造师Controller
 * @author jiwg
 * @version 2014-06-12
 */
@Controller
@RequestMapping(value = "${adminPath}/cert")
public class CertController extends BaseController {

    @Autowired
    private PlanService planService;

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private LessonService lessonService;

    @Autowired
    private ServAssociateConstructorService servAssociateConstructorService;


    @RequestMapping(value = "initCertPage")
    public String initCertPage(String soid,HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        SoPlan soPlan = planService.findBySoid(soid);
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlan",soPlan);
        model.addAttribute("servAcInfo",servAcInfo);
        model.addAttribute("newDate",new Date());
        return "modules/ac/acCertPrintPage";
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
        soPlan.setLocalId(user.getUserCompany() != null ? user.getUserCompany().getLocalId() : 471);
        soPlan.setFeeId("100"); // 费用类型,目前没用,留后续扩展
        soPlan.setFeeState(Constants.NO_PAY_FEE_STATE);
        soPlan.setHourState(Constants.IS_HOUR_STATE_COMMIT);
        soPlan.setLearnState(Constants.IS_LEARN_STATE_COMMIT);
        soPlan.setExamState(Constants.IS_EXAM_STATE_COMMIT);
        soPlan.setCertState(Constants.IS_CERT_STATE_COMMIT);
        soPlan.setReduceFlag(Constants.IS_REDUCE_FLAG_COMMIT);
        soPlan.setFee(soInvoice.getFee());
         // 课程实体
        List<SoCourse> courses = new ArrayList<SoCourse>();
       /* for(String courseId : soPlanEntity.getSeqs()) {
            SoCourse course = new SoCourse();
            Course course1 = new Course();
            course1.setCourseId(courseId);
            course.setCourse(course1);
            course.setUserId(user.getId());
            course.setValid("0");
            courses.add(course);
        }*/
         soPlanEntity.setSoPlan(soPlan);
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

    @RequestMapping(value = "acLearnListByUser")
    public String acLearnListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findLearnListByUserId(user.getId(), "1");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);
        return  "modules/ac/acSoCourseList";
    }

    @RequestMapping(value = "acNoLearnListByUser")
    public String acNoLearnListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findLearnListByUserId(user.getId(), "0");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);
        return  "modules/ac/acSoCourseList";
    }

    @RequestMapping(value = "acHourListByUser")
    public String acHourListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findHourListByUserId(user.getId(), "1");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);
        return  "modules/ac/acSoHourList";
    }

    @RequestMapping(value = "acNoHourListByUser")
    public String acNoHourListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findHourListByUserId(user.getId(), "0");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);
        return  "modules/ac/acSoHourList";
    }

    @RequestMapping(value = "acAuditListByUser")
    public String acAuditListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findHourListByUserId(user.getId(),"3");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);
        return  "modules/ac/acSoHourList";
    }

    @RequestMapping(value = "acExamListByUser")
    public String acExamListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findExamListByUserId(user.getId(), "0");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoExamList";
    }

    @RequestMapping(value = "acFinishExamListByUser")
    public String acFinishExamListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findExamListByUserId(user.getId(),"1");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoExamList";
    }

    @RequestMapping(value = "acAllExamListByUser")
    public String acAllExamListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findAllExamListByUserId(user.getId());
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoExamList";
    }

    @RequestMapping(value = "acAllReduceListByUser")
    public String acAllReduceListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findAllReduceListByUserId(user.getId());
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);


        return  "modules/ac/acSoReduceList";
    }

    @RequestMapping(value = "acReduceListByUser")
    public String acReduceListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findReduceListByUserId(user.getId());
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoReduceList";
    }

    @RequestMapping(value = "acAllCertListByUser")
    public String acAllCertListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findAllCertListByUserId(user.getId());
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoCertList";
    }

    @RequestMapping(value = "acAllListByUser")
    public String acAllListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findByUserId(user.getId());
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoAllList";
    }



    @RequestMapping(value = "findFinishCourseByUserId")
    public String findFinishCourseByUserId(HttpServletRequest request,HttpServletResponse response,Model model) {
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findPayListByUserId(user.getId(),"0");
        if(soPlans!=null){
            for(SoPlan soPlan:soPlans){
                Page<Course> page = courseService.findCourseListByPlanId(new Page<Course>(request,response),soPlan.getPlanId());
          }
           // model.addAttribute("page",page);
        }
     return "modules/ac/acLearnCourse";
    }

    @RequestMapping(value = "findSoAllInfo")
    public String findSoAllInfo(String soid,HttpServletRequest request, Model model){
        SoPlanEntity soPlanEntity = new SoPlanEntity();
        SoPlan soPlan = planService.findBySoid(soid);
        if(soPlan!=null){
            SoInvoice soInvoice = invoiceService.findBySoid(soid);
            List<Course> courses = courseService.findByPlanId(soPlan.getPlanId());
            soPlanEntity.setSoPlan(soPlan);
            soPlanEntity.setCourses(courses);
            soPlanEntity.setSoInvoice(soInvoice);
        }
        model.addAttribute("soPlanEntity",soPlanEntity);
       return  "modules/ac/acSoInfo";
    }

    @RequestMapping(value = "removeSoPlan")
    public String removeSoPlan(String soid,HttpServletRequest request, Model model,RedirectAttributes redirectAttributes){
        User user = UserUtils.getUser();
        SoPlan soPlan = planService.findBySoid(soid);
        if(soPlan!=null){
           if(Constants.IS_PAY_FEE_STATE.equals(soPlan.getFeeState())) {
               addMessage(redirectAttributes, "温馨提示：培训申请：" + soid+"已经缴费，不能作废！");
               return "redirect:" + Global.getAdminPath()+"/plan/acNoPayListByUser/?repage";
           }
           planService.removeSoAllInfo(soid);
             addMessage(redirectAttributes, "温馨提示：培训申请：" + soid+"作废成功！");
        }
        return "redirect:" + Global.getAdminPath()+"/plan/acNoPayListByUser/?repage";
    }


    @RequestMapping(value = "findSoCourseBySoid")
    public String findSoCourseBySoid(String soid,HttpServletRequest request,Model model) {
        List<SoCourse> soCourses = planService.findSoCourseListBySoid(soid);
        model.addAttribute("soCourses",soCourses);
        return  "modules/ac/acFinishCourse";
    }

    @RequestMapping(value = "findSoNoCourseBySoid")
    public String findSoNoCourseBySoid(Long planId,String soid,HttpServletRequest request, HttpServletResponse response,Model model) {
        Page<Course> page = courseService.findSoNoCourseListBySoid(new Page<Course>(request, response), planId, soid);
        model.addAttribute("page",page);
        return "modules/ac/acLearnCourse";
    }

    @RequestMapping(value = "findCourseByPlanId")
    public String findCourseByPlanId(Long planId,HttpServletRequest request,Model model) {
        List<Course> courses = courseService.findByPlanId(planId);
        model.addAttribute("courses",courses);
        return  "modules/ac/acSoCourseInfo";
    }

    @RequestMapping(value = "findAcPlanInfo")
    public String findAcPlanInfo(HttpServletRequest request, Model model){
        List<Plan> planList = planService.findAll();
        model.addAttribute("plans",planList);
        return "modules/ac/acPlanInfo";
    }

    @RequestMapping(value = "planManager")
    public String planManager(HttpServletRequest request, Model model){
        List<Plan> planList = planService.findPlanManager();
        model.addAttribute("plans",planList);
        return "modules/ac/acPlanManager";
    }

    @RequestMapping(value = "planForm")
    public String planForm(HttpServletRequest request, Model model){
        Plan plan = new Plan();
        model.addAttribute("plan",plan);
        return "modules/ac/acPlanForm";
    }

    @RequestMapping(value = "saveAcForm")
    public String saveAcForm(Plan plan,HttpServletRequest request, Model model ,HttpServletResponse response,RedirectAttributes redirectAttributes){
        //plan.setPlanId(Integer.valueOf(SeqUtils.getNextValue("PLAN_SEQ")).toString());
        plan.setSts(Constants.PLAN_STS_COMMIT);
        plan.setPlanName(DictUtils.getDictLabel(plan.getMajorId() == null ? "" : plan.getMajorId(), "MAJOR", "") + Constants.PLAN_NAME_CONCAT + DictUtils.getDictLabel(plan.getPlanType() == null ? "" : plan.getPlanType(), "PLAN_TYPE", ""));
        planService.savePlan(plan);
        model.addAttribute("plan",plan);
        addMessage(redirectAttributes, "温馨提示：创建培训项目成功！");
        return "redirect:" + Global.getAdminPath()+"/plan/planForm/?repage";
    }

    @RequestMapping(value = "removePlan")
    public String removePlan(Long  planId,HttpServletRequest request, Model model ,HttpServletResponse response,RedirectAttributes redirectAttributes){
        Plan plan = planService.findByPrimaryKey(planId);
        if(plan !=null){
            if(Constants.PLAN_STS_AUDITED.equals(plan.getSts())){
                addMessage(redirectAttributes, "温馨提示：培训项目已通过审核，不允许删除！");
                return "redirect:" + Global.getAdminPath()+"/plan/planManager/?repage";
            }
            Plan removePlan = new Plan();
            removePlan.setPlanId(planId);
            removePlan.setSts(Constants.PLAN_STS_REMOVE);
            removePlan.setStsDate(new Date());
            planService.modifyPlan(removePlan);
        }

        addMessage(redirectAttributes, "温馨提示：培训项目已作废成功！");
        return "redirect:" + Global.getAdminPath()+"/plan/planManager/?repage";

    }

    @RequestMapping(value = "auditPlan")
    public String auditPlan(Long  planId,HttpServletRequest request, Model model ,HttpServletResponse response,RedirectAttributes redirectAttributes){
        Plan plan = planService.findByPrimaryKey(planId);
        if(plan !=null){
            if(Constants.PLAN_STS_AUDITED.equals(plan.getSts())){
                addMessage(redirectAttributes, "温馨提示：培训项目已通过审核，不能再次审核！");
                return "redirect:" + Global.getAdminPath()+"/plan/planManager/?repage";
            }
            Plan auditPlan = new Plan();
            auditPlan.setPlanId(planId);
            auditPlan.setSts(Constants.PLAN_STS_AUDITED);
            auditPlan.setStsDate(new Date());
            planService.modifyPlan(auditPlan);
        }

        addMessage(redirectAttributes, "温馨提示：培训项目已审核成功！");
        return "redirect:" + Global.getAdminPath()+"/plan/planManager/?repage";

    }


    @RequestMapping(value = "initAllList")
    public String initAllList(HttpServletRequest request, Model model){
        SoPlan soPlan = new SoPlan();
        model.addAttribute("soPlan",soPlan);
        return  "modules/ac/acSoQueryInfo";
    }

    @RequestMapping(value = "findAllList")
    public String findListBySoPlan(SoPlan soPlan,HttpServletRequest request,HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findListBySoPlan(new Page<SoPlan>(request, response), soPlan);
        model.addAttribute("page",page);
        return  "modules/ac/acSoQueryInfo";
    }

    @RequestMapping(value = "initReductList")
    public String initReductList(HttpServletRequest request, Model model){
        SoPlan soPlan = new SoPlan();
        model.addAttribute("soPlan",soPlan);
        return  "modules/ac/acReduceQueryInfo";
    }

    @RequestMapping(value = "findReduceList")
    public String findReduceList(SoPlan soPlan,HttpServletRequest request,HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findListBySoPlan(new Page<SoPlan>(request, response), soPlan);
        model.addAttribute("page",page);
        return  "modules/ac/acReduceQueryInfo";
    }

    @RequestMapping(value = "init")
    public String init(HttpServletRequest request, Model model){
        SoPlan soPlan = new SoPlan();
        model.addAttribute("soPlan",soPlan);
        return  "modules/captureFacePlayer/CaptureFacePlayer";
    }

}
