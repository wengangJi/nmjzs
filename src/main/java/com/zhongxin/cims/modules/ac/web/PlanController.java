package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.*;
import com.zhongxin.cims.modules.ac.service.*;
import com.zhongxin.cims.modules.common.entity.Seal;
import com.zhongxin.cims.modules.common.entity.SynJxjyCase;
import com.zhongxin.cims.modules.exam.service.ExamService;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.DictUtils;
import com.zhongxin.cims.modules.sys.utils.PlanUtils;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 二级建造师Controller
 * @author liuqy
 * @version 2014-06-12
 */
@Controller
@RequestMapping(value = "${adminPath}/plan")
public class PlanController extends BaseController {

    @Autowired
    private PlanService planService;

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private CourseCenterService courseCenterService;

    @Autowired
    private LessonService lessonService;

    @Autowired
    private ServAssociateConstructorService servAssociateConstructorService;

    @Autowired
    private VideoService videoImageService;

    @Autowired
    private ExamService examService;

    @ModelAttribute
    public SoPlanEntity get(@RequestParam(required=false) String soid) {
        if (soid != null){
            SoPlanEntity soPlanEntity = planService.findAllBySoid(soid);
            return soPlanEntity;
        }else{
            return new SoPlanEntity();
        }
    }

    @ModelAttribute(value = "plan")
    public Plan get(@RequestParam(required=false) Long planId) {
        if (planId != null && !"".equals(planId)){
            Plan plan = planService.findByPrimaryKey(planId);
            return plan;
        }else{
            return new Plan();
        }
    }

    @RequestMapping(value = "apply")
    public String soPlan(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(UserUtils.getUser().getId());
        if(servAcInfo == null ){
            model.addAttribute("servFlag","1");
        }else{
            model.addAttribute("servFlag","0");
        }
        List<Plan> planList = planService.findAll();
        model.addAttribute("plans",planList);
        SoInvoice soInvoice = new SoInvoice();
        soInvoice.setRemark("邮箱格式:xxxxxx@xx.com");

        SoPlanEntity soPlanEntity = new SoPlanEntity();
        soPlanEntity.setSoInvoice(soInvoice);
        model.addAttribute(soPlanEntity);

        return "modules/ac/purchasePlanForm";
    }


    @RequestMapping(value = "acPlanCourseForm")
    public String acPlanCourseForm(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
        List<Plan> planList = planService.findAll();
        model.addAttribute("plans",planList);

        return "modules/ac/acPlanCourseForm";
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

    @RequestMapping(value = "getPlanCourseCenters")
    @ResponseBody
    public List<CourseCenter> getPlanCourseCenters(Long planId,HttpServletRequest request, Model model) {
        Plan plan = PlanUtils.getPlanById(planId.toString());

        List<CourseCenter> courseCenters = courseCenterService.findCourseCenterList(plan.getMajorId(),plan.getPlanId().toString());
        for(CourseCenter courseCenter: courseCenters){
            courseCenter.setRsrvStr1(DictUtils.getDictLabel(courseCenter.getCourseType(), "COURSE_TYPE", "专业课"));
            courseCenter.setRsrvStr2(DictUtils.getDictLabel(courseCenter.getMajorId(), "MAJOR", "公共"));
        }
        model.addAttribute("courseCenters", courseCenters);
        return courseCenters;
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
        ServAssociateConstructor servAcInfo = new ServAssociateConstructor();
        if(user.getId()!=null){
             servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
            if(servAcInfo ==null) {
                addMessage(redirectAttributes, "温馨提示：您尚未录入二级建造师信息，请先录入再申请培训。" );
                return "redirect:" + Global.getAdminPath()+"/plan/acNoPayListByUser/?repage";
            }
        }
        soPlan.setCompanyId(servAcInfo.getCompanyId());
        //soPlan.setLocalId(user.getUserCompany() != null ? user.getUserCompany().getLocalId() : 471);
        soPlan.setLocalId(user.getLocalId()!=null ?user.getLocalId():47);
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
        List<SoPlan> soPlans = planService.findPayListByUserId(user.getId(), "0");
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);
       return  "modules/ac/acSoList";
    }

    @RequestMapping(value = "findOflinePre")
    public String findOflinePre(SoPlan soPlan,HttpServletRequest request,HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findAllPrePayList(new Page<SoPlan>(request, response), soPlan);
        model.addAttribute("page",page);
        return  "modules/ac/acSoPreList";
    }

   /* @RequestMapping(value = "findOflinePre")
    public String findOflinePre(HttpServletRequest request, Model model){

        List<SoPlan> soPlans = planService.findAllPrePayList("0");
        if(soPlans!=null && soPlans.size()>0){
            for(SoPlan soPlan:soPlans){
                ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(soPlan.getUserId());
                soPlan.setRsrvStr1(servAcInfo.getName());
                soPlan.setRsrvStr2(servAcInfo.getIdNo());

            }

        }
        model.addAttribute("soPlans",soPlans);
        return  "modules/ac/acSoPreList";
    }
*/
    @RequestMapping(value = "acPayOffLine")
    public String acPayOffLine(String soid ,HttpServletRequest request, Model model){

        SoPlan soPlan = new SoPlan();
        soPlan = planService.findBySoid(soid);
        model.addAttribute("soPlan",soPlan);
        return  "modules/ac/acPayOffline";
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

    @RequestMapping(value = "acListByUser")
    public String acListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findByUserId(user.getId());
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);
        return  "modules/ac/acSoProcessList";
    }

    @RequestMapping(value = "acListByComapnyId")
    public String acListByComapnyId(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findByCompanyId(user.getUserCompany().getCompanyId());
        model.addAttribute("soPlans",soPlans);
        return  "modules/ac/acCompanySoProcessList";
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
        List<SoPlan> soPlans = planService.findHourListByUserId(user.getId(), "3");
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

    /**
     * 可补考申请
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "acExamListByUserAgain")
    public String acExamListByUserAgain(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findExamListByUserId(user.getId(), "4");
        for(SoPlan soPlan:soPlans){
            int resultCount = examService.findAgainResultCountBySoid(soPlan.getSoid());
            if(resultCount>=2){
                soPlan.setRsrvStr3("2");
            }
        }
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        model.addAttribute("servAcInfo",servAcInfo);

        return  "modules/ac/acSoExamListAgain";
    }

    @RequestMapping(value = "acFinishExamListByUser")
    public String acFinishExamListByUser(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findExamListByUserId(user.getId(), "1");
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


        return  "modules/ac/acAllSoReduceList";
    }


    @RequestMapping(value = "acAllReduceListByCompanyId")
    public String acAllReduceListByCompanyId(HttpServletRequest request, Model model){
        User user = UserUtils.getUser();
        List<SoPlan> soPlans = planService.findAllReduceListByUserId(user.getId());
        model.addAttribute("soPlans",soPlans);
        return  "modules/ac/acCompanySoReduceList";
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

    @RequestMapping(value = "acAllReduceList")
    public String acAllReduceList(SoPlanEntity soPlanEntity,HttpServletRequest request, HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findAllReduceList(new Page<SoPlan>(request, response), soPlanEntity);
        model.addAttribute("page",page);
        return  "modules/ac/acSoAllReduceList";
    }

    @RequestMapping(value = "acAllReduceList1")
    public String acAllReduceList1(SoPlan soPlan,HttpServletRequest request, HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findAllReduceList(new Page<SoPlan>(request, response), soPlan);
        model.addAttribute("page",page);
        return  "modules/ac/acSoAllReduceList";
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
        List<SoPlan> soPlans = planService.findPayListByUserId(user.getId(), "0");
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
             addMessage(redirectAttributes, "温馨提示：培训申请：" + soid + "作废成功！");
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
        model.addAttribute("soid",soid);
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

/*    @RequestMapping(value = "planForm")
    public String planForm(HttpServletRequest request, Model model){
        Plan plan = new Plan();
        model.addAttribute("plan",plan);
        return "modules/ac/acPlanForm";
    }*/

    @RequestMapping(value = "saveAcForm")
    public String saveAcForm(Plan plan,HttpServletRequest request, Model model ,HttpServletResponse response,RedirectAttributes redirectAttributes){
        plan.setSts(Constants.PLAN_STS_COMMIT);
        plan.setPlanName(DictUtils.getDictLabel(plan.getMajorId() == null ? "" : plan.getMajorId(), "MAJOR", "") + Constants.PLAN_NAME_CONCAT + DictUtils.getDictLabel(plan.getPlanType() == null ? "" : plan.getPlanType(), "PLAN_TYPE", ""));
        plan.setLocalId(47);//默认为全区
        planService.savePlan(plan);
        model.addAttribute("plan",plan);
        addMessage(redirectAttributes, "温馨提示：创建培训项目成功！");
        return "redirect:" + Global.getAdminPath()+"/plan/planForm/?repage";
    }

    @RequestMapping(value = "removePlan")
    public String removePlan(Long  planId,HttpServletRequest request, Model model ,HttpServletResponse response,RedirectAttributes redirectAttributes){
        Plan plan = planService.findByPrimaryKey(planId);
        if(plan !=null){
            /*if(Constants.PLAN_STS_AUDITED.equals(plan.getSts())){
                addMessage(redirectAttributes, "温馨提示：培训项目已通过审核，不允许删除！");
                return "redirect:" + Global.getAdminPath()+"/plan/planManager/?repage";
            }*/
            Plan removePlan = new Plan();
            removePlan.setPlanId(planId);
            removePlan.setSts(Constants.PLAN_STS_REMOVE);
            removePlan.setStsDate(new Date());
            planService.modifyPlan(removePlan);
        }

        addMessage(redirectAttributes, "温馨提示：培训项目已作废成功！");
        return "redirect:" + Global.getAdminPath()+"/plan/list/?repage";

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
        model.addAttribute("soPlan", soPlan);
        return  "modules/ac/acSoQueryInfo";
    }

    @RequestMapping(value = "findAllList1")
    public String findListBySoPlan(SoPlanEntity soPlanEntity,HttpServletRequest request,HttpServletResponse response, Model model){
        Page<SoPlanEntity> page = planService.findListBySoPlanEntity(new Page<SoPlanEntity>(request, response), soPlanEntity);
        model.addAttribute("page",page);
        return  "modules/ac/acSoQueryInfo";
    }

    @RequestMapping(value = "findAllList")
    public String findListBySoPlanEntity(SoPlanEntity soPlanEntity,HttpServletRequest request,HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findListBySoPlanEntitys(new Page<SoPlan>(request, response), soPlanEntity);
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

    @ResponseBody
    @RequestMapping(value = "getPlanByYear")
    public String getPlanByYear(String year,Model model) {
        if (year != null) {
            List<Plan> planList = PlanUtils.getAllPlanByYear(year);
            model.addAttribute("planList",planList);
            return JsonMapper.nonDefaultMapper().toJson(planList);
        } else {
            return null;
        }
    }

    @RequiresPermissions("plan:edit")
    @RequestMapping(value = "planForm")
    public String planForm(Plan plan,Model model) {
        model.addAttribute("plan",plan);
        return "modules/ac/course/planForm";
    }

    @RequestMapping(value = "list")
    public String list(Plan plan,HttpServletRequest request,HttpServletResponse response,Model model) {
        Page<Plan> page = planService.list(new Page<Plan>(request, response), plan);
        model.addAttribute("page",page);
        return "modules/ac/course/planList";
    }

    @RequestMapping(value = "synlist")
    public String synlist(SynJxjyCase synJxjyCase,HttpServletRequest request,HttpServletResponse response,Model model) {
        Page<SynJxjyCase> page = planService.synList(new Page<SynJxjyCase>(request, response), synJxjyCase);
        model.addAttribute("page",page);
        return "modules/ac/synJxjyCaseList";
    }

    @RequestMapping(value = "syn")
    public String syn(String id,HttpServletRequest request,HttpServletResponse response,Model model) {
        planService.syn(id);
        return "redirect:"+ Global.getAdminPath()+"/plan/synlist/?repage";
    }

    @RequestMapping(value = "batchSyn")
    public String batchSyn(String[] seqs, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        planService.batchSyn(seqs);
        addMessage(redirectAttributes,"批量同步成功");
        return "redirect:"+ Global.getAdminPath()+"/plan/synlist/?repage";
    }

    @RequiresPermissions("lock:edit")
    @RequestMapping(value = "lockList")
    public String lockList(Seal seal,HttpServletRequest request,HttpServletResponse response,Model model) {
        Page<Seal> page = planService.findLockList(new Page<Seal>(request, response), seal);
        model.addAttribute("page",page);
        return "modules/ac/acLockList";
    }

    @RequestMapping(value = "removeLockById")
    public String removeLockById(String lockId,HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) {
        planService.removeLockById(lockId);
        addMessage(redirectAttributes, "温馨提示：解锁成功！");
        Seal seal = new Seal();
        Page<Seal> page = planService.findLockList(new Page<Seal>(request, response), seal);
        model.addAttribute("page",page);
        return "modules/ac/acLockList";
       // return "redirect:" + Global.getAdminPath()+"/plan/lockList/?repage";
    }

    @RequestMapping(value = "removeBatchLock")
    public String removeBatchLock(String[] seqs,HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) {
       planService.removeBatchLock(seqs);
        addMessage(redirectAttributes, "温馨提示：解锁成功！");
        Seal seal = new Seal();
        Page<Seal> page = planService.findLockList(new Page<Seal>(request, response), seal);
        model.addAttribute("page",page);
        return "modules/ac/acLockList";
        //return "redirect:" + Global.getAdminPath()+"/plan/lockList/?repage";
    }



    @RequestMapping(value = "saveOflineInfo")
    public String saveOflineInfo(SoPlan soPlan,HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) {
        if(soPlan!=null){
            SoPlan soPlanNew = new SoPlan();
            soPlanNew.setSoid(soPlan.getSoid());
            soPlanNew.setOflineNo(soPlan.getOflineNo());
            soPlanNew.setOflineUser(soPlan.getOflineUser());
            soPlanNew.setOflineRemarks(soPlan.getOflineRemarks());
            soPlanNew.setOflineSts("0");
            soPlanNew.setOflineStsDate(new Date());
            soPlanNew.setOflinePath(soPlan.getOflinePath());
            planService.modifySoPlan(soPlanNew);
        }

        addMessage(redirectAttributes, "温馨提示：处理成功，已提交审核！");
        return "redirect:" + Global.getAdminPath()+"/plan/acNoPayListByUser/?repage";
    }



    @RequestMapping(value = "passSoPlanPre")
    public String passSoPlanPre(SoPlan soPlan,HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) {
        if(soPlan!=null){
            SoPlan soPlanNew = new SoPlan();
            soPlanNew.setSoid(soPlan.getSoid());
            soPlanNew.setOflineSts("1");
            soPlanNew.setOflineStsDate(new Date());
            soPlanNew.setFeeState("1");
            planService.modifySoPlan(soPlanNew);
        }

        addMessage(redirectAttributes, "温馨提示：处理成功，已通过审核！");
        return "redirect:" + Global.getAdminPath()+"/plan/findOflinePre/?repage";
    }

    @RequestMapping(value = "noPassSoPlanPre")
    public String noPassSoPlanPre(SoPlan soPlan,HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) {
        if(soPlan!=null){
            SoPlan soPlanNew = new SoPlan();
            soPlanNew.setSoid(soPlan.getSoid());
            soPlanNew.setOflineSts("2");
            soPlanNew.setOflineStsDate(new Date());
            planService.modifySoPlan(soPlanNew);
        }

        addMessage(redirectAttributes, "温馨提示：处理成功，该支付审核不通过！");
        return "redirect:" + Global.getAdminPath()+"/plan/findOflinePre/?repage";
    }

    @RequiresPermissions("plan:edit")
    @RequestMapping(value = "savePlan")
    public String savePlan(Plan plan,Model model,RedirectAttributes redirectAttributes,HttpServletRequest request) {
        if (!beanValidator(model, plan)){
            return planForm(plan, model);
        }
        plan.setLocalId(47);//默认为全区
        plan.setYear("2015");
        planService.savePLan(plan);
        addMessage(redirectAttributes, "保存成功！");
        return "redirect:"+ Global.getAdminPath()+"/plan/list/?repage";
    }
}
