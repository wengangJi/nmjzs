package com.zhongxin.cims.modules.cp.web;

import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.common.workflow.Variable;
import com.zhongxin.cims.common.workflow.WorkflowEntity;
import com.zhongxin.cims.common.workflow.WorkflowUtils;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.cp.entity.SoAssess;
import com.zhongxin.cims.modules.cp.service.SoAssessService;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by lqyu_773 on 14-6-25.
 */
@Controller
@RequestMapping(value = "${adminPath}/cp/assess")
public class SoAssessController extends BaseController {

    @Autowired
    private SoAssessService soAssessService;

    @Autowired
    private IdentityService identityService;

    @Autowired
    private SoAttachmentMapper soAttachmentMapper;


    @ModelAttribute
    public SoAssess get(@RequestParam(required=false) String soid) {
        if (soid != null){
            SoAssess soAssess = soAssessService.findBySoid(soid);
            List<SoAttachment> attachments = soAttachmentMapper.selectBySoid(soid);
            soAssess.setSoAttachments(attachments);
            return soAssess;
        }else{
            return new SoAssess();
        }
    }

    /**
     * 获取审核明细
     * @param soid
     * @param model
     * @return
     */
    @RequiresPermissions("cp:assess:view")
    @RequestMapping(value = "detail")
    public String detail(String soid, HttpServletRequest request, Model model) {
        SoAssess soAssess = soAssessService.findBySoid(soid);
        // 获取申请单附件
        List<SoAttachment> attachments = soAttachmentMapper.selectBySoid(soid);
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
            }
            model.addAttribute("files",attachments);
            soAssess.setSoAttachments(attachments);
        }
        model.addAttribute("soAssess", soAssess);
        model.addAttribute("workflowEntity", WorkflowUtils.getWorkflowEntity(soAssess.getSo().getBpmId()));
        return "modules/cp/assessDetail";
    }

    /**
     * 批量审核
     * @param seqs
     * @param auditRemark
     * @param request
     * @param response
     * @param model
     * @return
     */
   // @RequiresPermissions("cp:assess:batchAudit")
    @RequestMapping(value = "batchAssess")
    public String batchAssess(String[] seqs,String auditRemark, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        for(String soid:seqs){
            SoAssess soAssess = soAssessService.findBySoid(new String(soid));
            WorkflowEntity workflowEntity = WorkflowUtils.getWorkflowEntity(soAssess.getSo().getBpmId());
            soAssess.getSo().setAuditRemarks(auditRemark);
            soAssess.getSo().setPass("1");
            String taskKey = workflowEntity.getTask().getTaskDefinitionKey();

            Variable variable = new Variable();
            if("localAudit".equals(taskKey)){
                variable.setKeys("localPass");
            } else if ("localLeaderAudit".equals(taskKey)) {
                variable.setKeys("localLeaderPass");
            } else if ("localMainLeaderAudit".equals(taskKey)) {
                variable.setKeys("localMainLeaderPass");
            } else if ("constructionCpLeaderAudit".equals(taskKey)) {
                variable.setKeys("constructionCpLeaderPass");
            } else if ("constructionAllLeaderAudit".equals(taskKey)) {
                variable.setKeys("constructionAllLeaderPass");
            } else if ("directorAudit".equals(taskKey)) {
                variable.setKeys("directorPass");
            }

            variable.setValues(soAssess.getSo().getPass());
            variable.setTypes("B");
            soAssessService.complete(soAssess,variable);
        }
        addMessage(redirectAttributes,"审核成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/tasks?repage";
    }

    /**
     * 批量签收
     * @param seqs
     * @param redirectAttributes
     * @return
     */
  //  @RequiresPermissions("cp:assess:batchAudit")
    @RequestMapping(value = "batchSign")
    public String batchSign(String[] seqs, RedirectAttributes redirectAttributes){
        User user = UserUtils.getUser();
        for(String processInstanceId:seqs){
            soAssessService.claim(processInstanceId);
        }
        addMessage(redirectAttributes,"任务已签收");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/claims?repage";
    }



    /**
     * 获取正常待办任务列表
     * @param soAssess
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("cp:assess:view")
    @RequestMapping(value = {"tasks"})
    public String findTodoTasks(SoAssess soAssess,HttpServletRequest request, HttpServletResponse response, Model model) {
        List<Group> groups = identityService.createGroupQuery().groupMember(UserUtils.getUser().getId()).list();
        boolean flag = false; // 盟市和厅级审核的开始环节标识
        for(Group group:groups){
            if("cp:assess:localAudit".equals(group.getId()) || "cp:assess:constructionCpLeaderAudit".equals(group.getId())){
                flag = true;
                break;
            }
        }
        Page<SoAssess> page;
        // 非盟市审核和非建设厅领导审核环节，要看到包括签收和待办的所有任务，不走签收环节
        if(!flag){
            page = soAssessService.findAllDueTasks(new Page<SoAssess>(request, response),soAssess);
        } else {
            page = soAssessService.findDueTasks(new Page<SoAssess>(request, response),soAssess);
        }
        model.addAttribute("page", page);
        return "modules/cp/assessList";
    }


    /**
     * 获取警示待办任务列表
     * @param soAssess
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("cp:assess:view")
    @RequestMapping(value = {"warnTasks"})
    public String findTodoWarnTasks(SoAssess soAssess,HttpServletRequest request, HttpServletResponse response, Model model) {
        List<Group> groups = identityService.createGroupQuery().groupMember(UserUtils.getUser().getId()).list();
        boolean flag = false; // 盟市和厅级审核的开始环节标识
        for(Group group:groups){
            if("cp:assess:localAudit".equals(group.getId()) || "cp:assess:constructionCpLeaderAudit".equals(group.getId())){
                flag = true;
                break;
            }
        };
        Page<SoAssess> page;
        // 非盟市审核和非建设厅领导审核环节，要看到包括签收和待办的所有任务，不走签收关节
        if(!flag){
            page = soAssessService.findOverdueTasks(new Page<SoAssess>(request, response), soAssess);
        } else {
            page = soAssessService.findOverdueTasks(new Page<SoAssess>(request, response), soAssess);
        }

        model.addAttribute("page", page);
        return "modules/cp/assessWarnList";
    }

    /**
     * 获取警示待办任务列表
     * @param soAssess
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("cp:assess:view")
    @RequestMapping(value = {"allTasks"})
    public String findTodoAllTasks(SoAssess soAssess,HttpServletRequest request, HttpServletResponse response, Model model) {
        List<Group> groups = identityService.createGroupQuery().groupMember(UserUtils.getUser().getId()).list();
        boolean flag = false; // 盟市和厅级审核的开始环节标识
        for(Group group:groups){
            if("cp:assess:localAudit".equals(group.getId()) || "cp:assess:constructionCpLeaderAudit".equals(group.getId())){
                flag = true;
                break;
            }
        };
        Page<SoAssess> page;
        // 非盟市审核和非建设厅领导审核环节，要看到包括签收和待办的所有任务，不走签收关节
        if(!flag){
            page = soAssessService.findOverdueTasks(new Page<SoAssess>(request, response), soAssess);
        } else {
            page = soAssessService.findOverdueTasks(new Page<SoAssess>(request, response), soAssess);
        }

        model.addAttribute("page", page);
        return "modules/cp/assessAllTodoTask";
    }

    /**
     * 获取正常待办任务列表(签收)
     * @param soAssess
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("cp:assess:view")
    @RequestMapping(value = {"claims"})
    public String findClaimTasks(SoAssess soAssess,HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<SoAssess> page = soAssessService.findClaimTasks(new Page<SoAssess>(request, response), soAssess);
        model.addAttribute("page", page);
        return "modules/cp/cpAssClaimList";
    }


    /**
     * 获取警示待办任务列表(签收)
     * @param soAssess
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("cp:assess:view")
    @RequestMapping(value = {"overclaims"})
    public String findOverClaimTasks(SoAssess soAssess,HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<SoAssess> page = soAssessService.findOverClaimTasks(new Page<SoAssess>(request, response), soAssess);
        model.addAttribute("page", page);
        return "modules/cp/cpAssOverClaimList";
    }

    /**
     * 正常任务签收
     */
    @RequestMapping(value = "task/claim/{id}")
    public String claim(@PathVariable("id") String processInstanceId, RedirectAttributes redirectAttributes) {
        soAssessService.claim(processInstanceId);
        addMessage(redirectAttributes, "任务已签收");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/claims?repage";
    }
    /**
     * 超时任务签收
     */
    @RequestMapping(value = "task/overclaim/{id}")
    public String overclaim(@PathVariable("id") String processInstanceId, RedirectAttributes redirectAttributes) {
        soAssessService.claim(processInstanceId);
        addMessage(redirectAttributes, "任务已签收");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/overclaims?repage";
    }

    /**
     * 盟市审核
     * @param soAssess
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("cp:assess:localAudit")
    @RequestMapping(value = "localAudit")
    public String localAudit(SoAssess soAssess, RedirectAttributes redirectAttributes) {
        // 这个变量暂时先放在这，后续从页面传入
        Variable variable = new Variable();
        //variable.setKeys("localPass");
        variable.setKeys("pass,consistentOriginal,backActivity");
        variable.setValues(soAssess.getSo().getPass()+","+soAssess.getSo().getConsistentOriginal()+","+soAssess.getSo().getBackActivity());
        variable.setTypes("S,S,S");
        soAssessService.complete(soAssess, variable);
        addMessage(redirectAttributes, "审批成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/tasks?repage";
    }

    /**
     * 盟市分管领导审核
     * @param soAssess
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("cp:assess:localLeaderAudit")
    @RequestMapping(value = "localLeaderAudit")
    public String localLeaderAudit(SoAssess soAssess, RedirectAttributes redirectAttributes) {
        // 这个变量暂时先放在这，后续从页面传入
        Variable variable = new Variable();
        //variable.setKeys("localLeaderPass");
        variable.setKeys("pass,consistentOriginal,backActivity");
        variable.setValues(soAssess.getSo().getPass()+","+soAssess.getSo().getConsistentOriginal()+","+soAssess.getSo().getBackActivity());
        variable.setTypes("S,S,S");
        soAssessService.complete(soAssess, variable);
        addMessage(redirectAttributes, "审批成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/tasks?repage";
    }

    /**
     * 盟市主管领导审核
     * @param soAssess
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("cp:assess:localMainLeaderAudit")
    @RequestMapping(value = "localMainLeaderAudit")
    public String localMainLeaderAudit(SoAssess soAssess, RedirectAttributes redirectAttributes) {
        // 这个变量暂时先放在这，后续从页面传入
        Variable variable = new Variable();
        //variable.setKeys("localMainLeaderPass");
        variable.setKeys("pass,consistentOriginal,backActivity");
        variable.setValues(soAssess.getSo().getPass()+","+soAssess.getSo().getConsistentOriginal()+","+soAssess.getSo().getBackActivity());
        variable.setTypes("S,S,S");
        soAssessService.complete(soAssess,variable);
        addMessage(redirectAttributes, "审批成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/tasks?repage";
    }

    /**
     * 建设厅主管领导审核
     * @param soAssess
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("cp:assess:constructionCpLeaderAudit")
    @RequestMapping(value = "constructionCpLeaderAudit")
    public String constructionCpLeaderAudit(SoAssess soAssess, RedirectAttributes redirectAttributes) {
        // 这个变量暂时先放在这，后续从页面传入
        Variable variable = new Variable();
        //variable.setKeys("constructionCpLeaderPass");
        variable.setKeys("pass,consistentOriginal,backActivity");
        variable.setValues(soAssess.getSo().getPass()+","+soAssess.getSo().getConsistentOriginal()+","+soAssess.getSo().getBackActivity());
        variable.setTypes("S,S,S");
        soAssessService.complete(soAssess, variable);
        addMessage(redirectAttributes, "审批成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/tasks?repage";
    }

    /**
     * 建设厅分管领导审核
     * @param soAssess
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("cp:assess:constructionAllLeaderAudit")
    @RequestMapping(value = "constructionAllLeaderAudit")
    public String constructionAllLeaderAudit(SoAssess soAssess, RedirectAttributes redirectAttributes) {
        // 这个变量暂时先放在这，后续从页面传入
        Variable variable = new Variable();
        //variable.setKeys("constructionAllLeaderPass");
        variable.setKeys("pass,consistentOriginal,backActivity");
        variable.setValues(soAssess.getSo().getPass()+","+soAssess.getSo().getConsistentOriginal()+","+soAssess.getSo().getBackActivity());
        variable.setTypes("S,S,S");
        soAssessService.complete(soAssess, variable);
        addMessage(redirectAttributes, "审批成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/tasks?repage";
    }

    /**
     * 厅长审核
     * @param soAssess
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("cp:assess:directorAudit")
    @RequestMapping(value = "directorAudit")
    public String directorAudit(SoAssess soAssess, RedirectAttributes redirectAttributes) {
        // 这个变量暂时先放在这，后续从页面传入
        Variable variable = new Variable();
        //variable.setKeys("directorPass");
        variable.setKeys("pass,consistentOriginal,backActivity");
        variable.setValues(soAssess.getSo().getPass()+","+soAssess.getSo().getConsistentOriginal()+","+soAssess.getSo().getBackActivity());
        variable.setTypes("S,S,S");
        soAssessService.complete(soAssess, variable);
        addMessage(redirectAttributes, "审批成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/assess/tasks?repage";
    }


    /**
     * 获取已办申报列表
     * //@param soCpEntity
     * //@param request
     * //@param response
     * //@param model
     * //@return
     */

    @RequiresPermissions("cp:assess:view")
    @RequestMapping(value = {"doneTasks"})
    public String findDoneTasks(SoAssess soAssess,HttpServletRequest request, HttpServletResponse response, Model model) {
       if (soAssess.getSo() == null ){
            soAssess.setSo(new So());
        }
        soAssess.getSo().setUserId(UserUtils.getUser().getId());
        Page<SoAssess>    page = soAssessService.findDoneTasks(new Page<SoAssess>(request, response),soAssess);
        model.addAttribute("page", page);
        return "modules/cp/assessDoneList";
    }

    /**
     * 重新上报
     *
     * //@param soAssess so实体
     * @return
     */
    @RequestMapping(value = "soCpReStartProcess")
    public String soCpReStartProcess(String soid,RedirectAttributes redirectAttributes) {
        SoAssess soAssess = soAssessService.findBySoid(soid);
        WorkflowEntity workflowEntity = WorkflowUtils.getWorkflowEntity(soAssess.getSo().getBpmId());
        soAssess.getSo().setAuditRemarks("企业重新上报");
        soAssess.getSo().setPass("1");
        String taskKey = workflowEntity.getTask().getTaskDefinitionKey();
        Variable variable = new Variable();
        if("localAudit".equals(taskKey)){
            variable.setKeys("localPass");
        } else if ("localLeaderAudit".equals(taskKey)) {
            variable.setKeys("localLeaderPass");
        } else if ("localMainLeaderAudit".equals(taskKey)) {
            variable.setKeys("localMainLeaderPass");
        } else if ("constructionCpLeaderAudit".equals(taskKey)) {
            variable.setKeys("constructionCpLeaderPass");
        } else if ("constructionAllLeaderAudit".equals(taskKey)) {
            variable.setKeys("constructionAllLeaderPass");
        } else if ("directorAudit".equals(taskKey)) {
            variable.setKeys("directorPass");
        }

        variable.setValues(soAssess.getSo().getPass());
        variable.setTypes("B");
        soAssessService.complete(soAssess,variable);
        return "redirect:" + Global.getAdminPath() + "/cp/soCp/query/?repage";

    }
}
