/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.exam.web;


import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.Plan;
import com.zhongxin.cims.modules.ac.entity.ServAssociateConstructor;
import com.zhongxin.cims.modules.ac.entity.SoHours;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.ac.service.PlanService;
import com.zhongxin.cims.modules.ac.service.ServAssociateConstructorService;
import com.zhongxin.cims.modules.alipay.entity.Ipsorder;
import com.zhongxin.cims.modules.exam.entiy.ExamInfo;
import com.zhongxin.cims.modules.exam.entiy.ExaminationChoice;
import com.zhongxin.cims.modules.exam.entiy.Question;
import com.zhongxin.cims.modules.exam.entiy.QuestionAndAnswerDetail;
import com.zhongxin.cims.modules.exam.service.ExamService;
import com.zhongxin.cims.modules.sys.entity.SysBatch;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.PlanUtils;
import com.zhongxin.cims.modules.sys.utils.TagUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "${adminPath}/exam/exam")
public class ExamController extends BaseController {

    @Autowired
    private ExamService examService;
    @Autowired
    private PlanService planService;
    @Autowired
    private ServAssociateConstructorService servAssociateConstructorService;


    /**
     * 考试首页选择相应考试类别
     *
     * @param param
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = {"examPageChoice"})
    public String examPageChoice(ExaminationChoice examinationChoice, String param, HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/exam/examPageChoice";
    }

    /**
     * 本次考试，考试题列表
     *
     * @param planId
     * @param model
     * @return
     */
    @RequestMapping(value = {"examQuestionList"})
    public String examQuestionList(String planId, String soid, Model model, RedirectAttributes redirectAttributes) {

        //校验本项目是否已经经过考试。如果已经经过考试不允许再次考试。
        int resultCount = examService.findResultCountBySoid(soid);
        if(resultCount>0){
            addMessage(redirectAttributes, "提示：已经存在您的考试记录并已提交审核，审核未完成前不可以再次参加考试。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }
        ExaminationChoice examinationChoice = new ExaminationChoice();
        examinationChoice.setQuestionTotals(TagUtils.getTagInfo("AC_EXAM_NUM"));
        examinationChoice.setQuestionTime(TagUtils.getTagInfo("AC_EXAM_TIME"));
        examinationChoice.setProfession(PlanUtils.getPlanById(planId).getMajorId());
        examinationChoice.setType(PlanUtils.getPlanById(planId).getPlanType());
        ExamInfo examInfo = examService.addExamInfo(examinationChoice, soid, planId);
        /**
         * 此处要做随机数字选题判断,此处默认为 3来测试，可从前台控制，也可从配置文件读，来设定每次考试的题量
         */
       // List<Integer> listId = examService.getQuestionNumberList(Integer.valueOf(TagUtils.getTagInfo("AC_QUESTION_NUM_LIST")), PlanUtils.getPlanById(planId).getMajorId());
        List<Integer> listId = new ArrayList<Integer>();
        if(TagUtils.getTagInfo("AC_QUESTION_NUM_LIST")==null ||TagUtils.getTagInfo("AC_QUESTION_NUM_LIST").equals("0")){
            addMessage(redirectAttributes, "提示：系统未设置总试题数量，请联系管理员添加试题总量数据。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }
        Integer totleQuestionNum = Integer.valueOf(TagUtils.getTagInfo("AC_QUESTION_NUM_LIST"));
        Integer pubQuestionNum = (int)(totleQuestionNum*0.2);
        Integer majorQuestionNum =(int)(totleQuestionNum*0.8);
        //首先获取综合科目题量
        List<Integer> pubListIds = examService.getQuestionNumberList(pubQuestionNum, "0");
          if(pubListIds!=null && pubListIds.size()>0){
               for(Integer pubListId:pubListIds){
                   listId.add(pubListId);
               }
           }else{
              addMessage(redirectAttributes, "提示：您考试综合科目试题数量没有达到规定试题数量，请联系管理员添加综合科目试题。");
              return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
          }

        //再次获取专业科目题量
        List<Integer> majorListIds =examService.getQuestionNumberList(majorQuestionNum, PlanUtils.getPlanById(planId).getMajorId());
         if(majorListIds!=null && majorListIds.size()>0){
             for(Integer majorListId:majorListIds){
                 listId.add(majorListId);
             }
         }else{
             addMessage(redirectAttributes, "提示：您考试专业科目试题数量没有达到规定试题数量，请联系管理员添加专业科目试题。");
             return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
         }

        System.out.println("listId==="+PlanUtils.getPlanById(planId).getMajorId());
        if (listId.size() == 0) {
            addMessage(redirectAttributes, "提示：您考试试题数量没有达到规定试题数量，请联系管理员添加试题。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }


        List<Question> list = examService.getQuestionList(listId);
        model.addAttribute("QuestionList", list);
        model.addAttribute("examInfo", examInfo);
        model.addAttribute("listId",listId);
        return "modules/exam/examQuestionList";
    }

    /**
     * 补考考试，考试题列表
     *
     * @param planId
     * @param model
     * @return
     */
    @RequestMapping(value = {"examQuestionListAagin"})
    public String examQuestionListAagin(String planId, String soid, Model model, RedirectAttributes redirectAttributes) {

        //校验本项目是否已经经过考试。如果已经经过考试不允许再次考试。
        /*int resultCount = examService.findResultCountBySoid(soid);
        if(resultCount>0){
            addMessage(redirectAttributes, "提示：已经存在您的考试记录并已提交审核，审核未完成前不可以再次参加考试。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }*/

        //校验本项目是否已经经过考试。如果已经经过考试不允许再次考试。
        int resultCount = examService.findAgainResultCountBySoid(soid);
        if(resultCount>=2){
            addMessage(redirectAttributes, "提示：考试允许两次补考机会，您已完成两次补考，不允许再次补考。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }
        ExaminationChoice examinationChoice = new ExaminationChoice();
        examinationChoice.setQuestionTotals(TagUtils.getTagInfo("AC_EXAM_NUM"));
        examinationChoice.setQuestionTime(TagUtils.getTagInfo("AC_EXAM_TIME"));
        examinationChoice.setProfession(PlanUtils.getPlanById(planId).getMajorId());
        examinationChoice.setType(PlanUtils.getPlanById(planId).getPlanType());
        ExamInfo examInfo = examService.addExamInfoAgain(examinationChoice, soid, planId);
        /**
         * 此处要做随机数字选题判断,此处默认为 3来测试，可从前台控制，也可从配置文件读，来设定每次考试的题量
         */
      //  List<Integer> listId = examService.getQuestionNumberList(Integer.valueOf(TagUtils.getTagInfo("AC_QUESTION_NUM_LIST")), PlanUtils.getPlanById(planId).getMajorId());

        List<Integer> listId = new ArrayList<Integer>();
        if(TagUtils.getTagInfo("AC_QUESTION_NUM_LIST")==null ||TagUtils.getTagInfo("AC_QUESTION_NUM_LIST").equals("0")){
            addMessage(redirectAttributes, "提示：系统未设置总试题数量，请联系管理员添加试题总量数据。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }
        Integer totleQuestionNum = Integer.valueOf(TagUtils.getTagInfo("AC_QUESTION_NUM_LIST"));
        Integer pubQuestionNum = (int)(totleQuestionNum*0.2);
        Integer majorQuestionNum =(int)(totleQuestionNum*0.8);
        //首先获取综合科目题量
        List<Integer> pubListIds = examService.getQuestionNumberList(pubQuestionNum, "0");
        if(pubListIds!=null && pubListIds.size()>0){
            for(Integer pubListId:pubListIds){
                listId.add(pubListId);
            }
        }else{
            addMessage(redirectAttributes, "提示：您考试综合科目试题数量没有达到规定试题数量，请联系管理员添加综合科目试题。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }

        //再次获取专业科目题量
        List<Integer> majorListIds =examService.getQuestionNumberList(majorQuestionNum, PlanUtils.getPlanById(planId).getMajorId());
        if(majorListIds!=null && majorListIds.size()>0){
            for(Integer majorListId:majorListIds){
                listId.add(majorListId);
            }
        }else{
            addMessage(redirectAttributes, "提示：您考试专业科目试题数量没有达到规定试题数量，请联系管理员添加专业科目试题。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }

        System.out.println("listId==="+PlanUtils.getPlanById(planId).getMajorId());
        if (listId.size() == 0) {
            addMessage(redirectAttributes, "提示：您考试试题数量没有达到规定试题数量，请联系管理员添加试题。");
            return "redirect:" + Global.getAdminPath()+"/plan/acExamListByUser?repage";
        }


        List<Question> list = examService.getQuestionList(listId);
        model.addAttribute("QuestionList", list);
        model.addAttribute("examInfo", examInfo);
        model.addAttribute("listId",listId);
        return "modules/exam/examQuestionListAgain";
    }

    /**
     * 限制重复提交试卷
     * @param soid
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"checkIsSubmit"})
    public String checkIsSubmit( String soid, Model model){
        Map map = new HashMap();
        String flag = "0";

        int a=examService.findCountBySoid(soid);
        if(a>0){
            flag="1";
        }
        map.put("flag", flag);

        return JsonMapper.nonDefaultMapper().toJson(map);

    }
    @ResponseBody
    @RequestMapping(value = {"addDataInfoExamInfo"})
    public String addDataInfoExamInfo(String planId, String soid, String examInfoId, Model model, RedirectAttributes redirectAttributes) {
        ExaminationChoice examinationChoice = new ExaminationChoice();
        examinationChoice.setQuestionTotals(TagUtils.getTagInfo("AC_EXAM_NUM"));
        examinationChoice.setQuestionTime(TagUtils.getTagInfo("AC_EXAM_TIME"));
        examinationChoice.setProfession(PlanUtils.getPlanById(planId).getMajorId());
        examinationChoice.setType(PlanUtils.getPlanById(planId).getPlanType());
        ExamInfo examInfo = examService.addExamInfoNew(examinationChoice, soid, planId, examInfoId);
        return "";
    }

    @ResponseBody
    @RequestMapping(value = {"addDataInfoExamInfoAgain"})
    public String addDataInfoExamInfoAgain(String planId, String soid, String examInfoId, Model model, RedirectAttributes redirectAttributes) {
        ExaminationChoice examinationChoice = new ExaminationChoice();
        examinationChoice.setQuestionTotals(TagUtils.getTagInfo("AC_EXAM_NUM"));
        examinationChoice.setQuestionTime(TagUtils.getTagInfo("AC_EXAM_TIME"));
        examinationChoice.setProfession(PlanUtils.getPlanById(planId).getMajorId());
        examinationChoice.setType(PlanUtils.getPlanById(planId).getPlanType());
        ExamInfo examInfo = examService.addExamInfoNewAgain(examinationChoice, soid, planId, examInfoId);
        return "";
    }
    /**
     * 题库管理，题库展示列表
     *
     * @param question
     * @param model
     * @return
     */
    @RequestMapping(value = {"questionList"})
    public String questionList(Question question, Model model,HttpServletRequest request, HttpServletResponse response) {
        Page<Question> page = examService.getQuestionList(new Page<Question>(request, response),question);
        model.addAttribute("page", page);
        return "modules/exam/questionList";
    }

    /**
     * 提交考试答案，生成考试试卷
     *
     * @param examinationChoice
     * @param model
     * @param param
     * @param examInfoId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"makeResultToExamInfoDeatail"})
    public String makeResultToExamInfoDeatail(ExaminationChoice examinationChoice,String listId, Model model, String param, String examInfoId, String soid, String planId) {
        Map map = new HashMap();
        String flag = examService.makeExamDetail(param, model, examInfoId, soid, planId,listId);
        map.put("flag", flag);
        return JsonMapper.nonDefaultMapper().toJson(map);
    }
    /**
     * 提交考试答案，生成考试试卷
     *
     * @param examinationChoice
     * @param model
     * @param param
     * @param examInfoId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"makeResultToExamInfoDeatailAgain"})
    public String makeResultToExamInfoDeatailAgain(ExaminationChoice examinationChoice,String listId, Model model, String param, String examInfoId, String soid, String planId) {
        Map map = new HashMap();
        String flag = examService.makeExamDetailAgain(param, model, examInfoId, soid, planId,listId);
        map.put("flag", flag);
        return JsonMapper.nonDefaultMapper().toJson(map);
    }

    /**
     * 跳转到，题库管理首页
     *
     * @param model
     * @param param
     * @param question
     * @return
     */
    @RequestMapping(value = {"examPlanList"})
    public String examPlanList(Model model, String param, Question question) {
        List<Plan> plans = planService.findAll();
        model.addAttribute("plans", plans);
        return "modules/ac/examPlanList";
    }

    /**
     * 跳转到，题库管理首页
     *
     * @param model
     * @param param
     * @param question
     * @return
     */
    @RequestMapping(value = {"makeNewQuestionPre"})
    public String makeNewQuestionPre(String planId, Model model, String param, Question question) {
        //Plan plan = PlanUtils.getPlanById(planId);
       // model.addAttribute("plan", plan);
        return "modules/exam/makeNewQuestion";
    }

    /**
     * 生成考题
     *
     * @param model
     * @param param
     * @param question
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"makeNewQuestion"})
    public String makeNewQuestion(Model model, String param, Question question) {
        System.out.println(question.getQuestion());
        Map map = new HashMap();
        String flag = examService.makeNewQuestion(null, question);
        map.put("flag",flag);
        return JsonMapper.nonDefaultMapper().toJson(map);
    }

    /**
     * 成绩查询
     *
     * @param model
     * @param userName
     * @return
     */
    @RequestMapping(value = {"getCoresByUserName"})
    public String getCoresByUserName(Model model, String userName) {
        model.addAttribute("list", examService.getCoresByUserName(userName));
        return "modules/exam/Cores";
    }

    @RequestMapping(value = {"getCoresByUserId"})
    public String getCoresByUserId(Model model, String userId) {
        if(userId ==null || "".equals(userId)){
            userId = UserUtils.getUser().getId();
        }
       // model.addAttribute("list", examService.getCoresByUserId(userId));
        List<SoPlan> soPlans = planService.findAllExamListByUserId(userId);
        model.addAttribute("list",soPlans);
        return "modules/exam/coresUser";
    }

    /**
     * 个人用户试题情况查询
     *
     * @param model
     * @param userId
     * @return
     */
    @RequestMapping(value = {"getSoExamInfoByUser"})
    public String getSoExamInfoByUser(Model model, String userId) {
        if(userId==null || "".equals(userId)){
            userId = UserUtils.getUser().getId();
        }
        List<ExamInfo>  examInfos = examService.getSoExamInfoByUser(userId);
        model.addAttribute("examInfos",examInfos);
        return "modules/exam/soExamInfoUser";
    }

    /**
     * 协会用户试题情况查询
     *
     * @param model
     * @return
     */
    @RequestMapping(value = {"initSoExamInfo"})
    public String initSoExamInfo(Model model) {
        model.addAttribute("soPlan",new SoPlan());
        return "modules/exam/soExamInfo";
    }

    /**
     * 协会用户试题情况查询
     *
     * @param model
     * @param soPlan
     * @return
     */
    @RequestMapping(value = {"getSoExamInfo"})
    public String getSoExamInfo(HttpServletRequest request, HttpServletResponse response,Model model, SoPlan soPlan) {
        Page<ExamInfo> page   = examService.getSoExamInfo(new Page<ExamInfo>(request, response),soPlan);
        model.addAttribute("page", page);
        return "modules/exam/soExamInfo";
    }

    /**
     * 协会用户试题情况查询
     *
     * @param model
     * @param soPlan
     * @return
     */
    @RequestMapping(value = {"getUserSoExamInfo"})
    public String getUserSoExamInfo(HttpServletRequest request, HttpServletResponse response,Model model, SoPlan soPlan) {
       String userId = UserUtils.getUser().getId();
        if(soPlan!=null){
            soPlan.setUserId(userId);
        }
        Page<ExamInfo> page   = examService.getSoExamInfo(new Page<ExamInfo>(request, response),soPlan);
        model.addAttribute("page", page);
        return "modules/exam/soUserExamInfo";
    }



    @RequestMapping(value = {"getCompanySoExamInfo"})
    public String getCompanySoExamInfo(HttpServletRequest request, HttpServletResponse response,Model model, SoPlan soPlan) {
        soPlan.setCompanyId(UserUtils.getUser().getUserCompany().getCompanyId());
        Page<ExamInfo> page   = examService.getSoExamInfo(new Page<ExamInfo>(request, response),soPlan);
        model.addAttribute("page", page);
        return "modules/exam/soCompanyExamInfo";
    }

    /**
     * 根据id查看该次试卷的结果
     *
     * @param model
     * @param examInfoId
     * @param question
     * @return
     */
    @RequestMapping(value = {"getQuestionListByType"})
    public String getQuestionListByType(Model model, String examInfoId, Question question, String flag, String cores) {
        System.out.println("examid===="+examInfoId);
        model.addAttribute("examQuesiontlist", examService.getQuestionListByType(examInfoId, cores));
        //根据flag的值来判断是否需要在试卷上显示正确答案 0 需要显示 1 不需要显示
        model.addAttribute("flag", flag);
        if ("1".equals(flag))
            return "modules/exam/myExamInfoResultUser";
        else
            return "modules/exam/myExamInfoResult";
    }


    /**
     * 根据id查看该次试卷的结果
     *
     * @param model
     * @param examInfoId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"updateExamInfoAgain"})
    public String updateExamInfoAgain(Model model, String examInfoId) {
        System.out.println("examid===="+examInfoId);

        Map map = new HashMap();
        map.put("examInfoId", Integer.valueOf(examInfoId));
        int flag = examService.updExamInfoAgain(map);

        Map newMap = new HashMap();
        newMap.put("flag",flag);
        return JsonMapper.nonDefaultMapper().toJson(newMap);

    }
    /**
     * 根据id查看该次试卷的结果
     *
     * @param model
     * @param examInfoId
     * @param question
     * @return
     */
    @RequestMapping(value = {"getQuestionListByTypeAgain"})
    public String getQuestionListByTypeAgain(Model model, String examInfoId, Question question, String flag, String cores) {
        System.out.println("examid===="+examInfoId);
        model.addAttribute("examQuesiontlist", examService.getQuestionListByTypeAgain(examInfoId, cores));
        //根据flag的值来判断是否需要在试卷上显示正确答案 0 需要显示 1 不需要显示
        model.addAttribute("flag", flag);
        if ("1".equals(flag))
            return "modules/exam/myExamInfoResultUser";
        else
            return "modules/exam/myExamInfoResult";
    }
    /**
     * 删除试题
     *
     * @param model
     * @param questionId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"deleteQuestionByQuestionId"})
    public String deleteQuestionByQuestionId(Model model, String questionId) {
        Map map = new HashMap();
        String flag = examService.deleteQuestionByQuestionId(questionId);
        map.put("flag", flag);
        return JsonMapper.nonDefaultMapper().toJson(map);
    }

    @RequestMapping(value = {"creatdit"})
    public String deleteQuestionByQuestionId(Model model) {
    return "modules/ac/creatdit";
    }

    /**
     * 修改试题
     * @param model
     * @param questionId
     * @param choiceId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"updQuestionById"})
   public String updQuestionById(Model model, String questionId,String choiceId,String newQuestion){
        System.out.println("questionId:"+questionId+"choiceId:"+choiceId+"newQuestion:"+newQuestion);
        Map map = new HashMap();
        String flag = examService.updQuestionById(questionId,choiceId,newQuestion);
        map.put("flag", flag);
        return JsonMapper.nonDefaultMapper().toJson(map);
   }

    @RequestMapping(value = "auditExamList")
    public String auditExamList(ExamInfo examInfo,String auditLevel,Model model,HttpServletRequest request,HttpServletResponse response){
        if(!"".equals(auditLevel)) {
            examInfo.setAuditLevel(auditLevel);
        }
        Page<ExamInfo> page = examService.findAuditExamList(new Page<ExamInfo>(request, response), examInfo);
        model.addAttribute("page", page);
        return "modules/exam/examAuditList";
    }


    @RequestMapping(value = "auditHisExamList")
    public String auditHisExamList(ExamInfo examInfo,Model model,HttpServletRequest request,HttpServletResponse response){
        Page<ExamInfo> page = examService.findHisAuditExamList(new Page<ExamInfo>(request, response), examInfo);
        model.addAttribute("page", page);
        return "modules/exam/examHisAuditList";
    }
}
