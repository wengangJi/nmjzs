package com.zhongxin.cims.modules.cp.service;

import com.google.common.collect.Lists;
import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.workflow.MyTaskServiceImpl;
import com.zhongxin.cims.common.workflow.Variable;
import com.zhongxin.cims.common.workflow.WorkflowUtils;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.dao.SoMapper;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.cp.dao.SoAssessMapper;
import com.zhongxin.cims.modules.cp.dao.SoCpApproveMapper;
import com.zhongxin.cims.modules.cp.entity.SoAssess;
import com.zhongxin.cims.modules.cp.entity.SoCpApprove;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.service.workflow.WorkflowActivityService;
import com.zhongxin.cims.modules.sys.service.workflow.WorkflowProcessDefinitionService;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricTaskInstanceQuery;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.ProcessDefinitionImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lqyu_773 on 14-6-29.
 */
@Component
@Transactional(readOnly = true)
public class SoAssessService extends BaseService {
    @Autowired
    private SoMapper soMapper;

    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    protected TaskService taskService;
    @Autowired
    protected MyTaskServiceImpl myTaskService;
    @Autowired
    protected HistoryService historyService;
    @Autowired
    protected RepositoryService repositoryService;
    @Autowired
    private IdentityService identityService;

    @Autowired
    private WorkflowActivityService workflowActivityService;

    @Autowired
    private SoAssessMapper assessMapper;

    @Autowired
    private SoCpApproveMapper approveMapper;

    @Autowired
    private SoAttachmentMapper soAttachmentMapper;

    private String processDefinitionKey = "cpAssess";

    public Page<SoAssess> findAssessList(Page<SoAssess> page, SoAssess soAssess){
        List<SoAssess> soAssesses = assessMapper.findAssessList(soAssess);
        page.setCount(soAssesses.size());
        page.setList(soAssesses.subList(page.getFirstResult(),page.getLastResult()));

        return page;
    }

    /**
     * 获取办理任务列表
     * @param page
     * @param soAssess
     * @return
     */
    public Page<SoAssess> findDueTasks(Page<SoAssess> page, SoAssess soAssess) {
        User user = UserUtils.getUser();
        //增加地市过滤
        if(!"47".equals(user.getCompany().getId()) && !"1".equals(user.getCompany().getId())){
            if(soAssess == null) {
                soAssess = new SoAssess();
            }
            if(soAssess.getSo() == null){
                So so = new So();
                so.setLocalId(new Integer(user.getCompany().getArea().getId()));
                soAssess.setSo(so);
            }
            soAssess.getSo().setLocalId(new Integer(user.getCompany().getArea().getId()));
        }
        //获取所有未未完成任务
        List<SoAssess> soAssesses = assessMapper.findTodoTasks(soAssess);
        List<SoAssess> result = Lists.newArrayList();
        //过滤出当前用户的任务
        if(soAssesses.size()>0) {
            List<Task> tasks =Lists.newArrayList();
            List<Task> dueList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).dueAfter(new Date()).taskAssignee(ObjectUtils.toString(user.getId())).active().list();
            List<Task> nodueList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).withoutDueDate().taskAssignee(ObjectUtils.toString(user.getId())).active().list();
            tasks.addAll(dueList);
            tasks.addAll(nodueList);
            for (Task task : tasks) {
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (businessKey == null) {
                    continue;
                }
                for (SoAssess assess:soAssesses) {
                    if(assess.getSoid().equals(businessKey)){
                        assess.getSo().setTask(task);
                        assess.getSo().setProcessInstance(processInstance);
                        assess.getSo().setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                        result.add(assess);
                    }

                }
            }
        }

        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 获取超时办理任务列表
     * @param page
     * @param soAssess
     * @return
     */
    public Page<SoAssess> findOverdueTasks(Page<SoAssess> page, SoAssess soAssess) {
        User user = UserUtils.getUser();
        //增加地市过滤
        if(!"47".equals(user.getCompany().getId()) && !"1".equals(user.getCompany().getId())){
            if(soAssess == null) {
                soAssess = new SoAssess();
            }
            if(soAssess.getSo() == null){
                So so = new So();
                so.setLocalId(new Integer(user.getCompany().getArea().getId()));
                soAssess.setSo(so);
            }
            soAssess.getSo().setLocalId(new Integer(user.getCompany().getArea().getId()));
        }
        //获取所有未未完成任务
        List<SoAssess> soAssesses = assessMapper.findTodoTasks(soAssess);
        List<SoAssess> result = Lists.newArrayList();
        //过滤出当前用户的任务
        if(soAssesses.size()>0) {
            List<Task> tasks =Lists.newArrayList();
            List<Task> overdueList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).dueBefore(new Date()).taskAssignee(ObjectUtils.toString(user.getId())).active().list();
            tasks.addAll(overdueList);
            for (Task task : tasks) {
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (businessKey == null) {
                    continue;
                }
                for (SoAssess assess:soAssesses) {
                    if(assess.getSoid().equals(businessKey)){
                        assess.getSo().setTask(task);
                        assess.getSo().setProcessInstance(processInstance);
                        assess.getSo().setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                        result.add(assess);
                    }

                }
            }
        }
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 获取办理任务列表，包括未签收的
     * @param page
     * @param soAssess
     * @return
     */
    public Page<SoAssess> findAllDueTasks(Page<SoAssess> page, SoAssess soAssess) {
        User user = UserUtils.getUser();
        //增加地市过滤
        if(!"47".equals(user.getCompany().getId()) && !"1".equals(user.getCompany().getId())){
            if(soAssess == null) {
                soAssess = new SoAssess();
            }
            if(soAssess.getSo() == null){
                So so = new So();
                so.setLocalId(new Integer(user.getCompany().getArea().getId()));
                soAssess.setSo(so);
            }
            soAssess.getSo().setLocalId(new Integer(user.getCompany().getArea().getId()));
        }
        //获取所有未未完成任务
        List<SoAssess> soAssesses = assessMapper.findTodoTasks(soAssess);
        List<SoAssess> result = Lists.newArrayList();
        //过滤出当前用户的任务
        if(soAssesses.size()>0) {
            List<Task> tasks =Lists.newArrayList();
            List<Task> dueList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).dueAfter(new Date()).taskAssignee(ObjectUtils.toString(user.getId())).active().list();
            List<Task> nodueList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).withoutDueDate().taskAssignee(ObjectUtils.toString(user.getId())).active().list();
            // 未签收的
            List<Task> dueUnsignedList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).dueAfter(new Date()).taskCandidateUser(ObjectUtils.toString(user.getId())).active().list();
            List<Task> nodueUnsignedList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).withoutDueDate().taskCandidateUser(ObjectUtils.toString(user.getId())).active().list();
            tasks.addAll(dueUnsignedList);
            tasks.addAll(nodueUnsignedList);
            tasks.addAll(dueList);
            tasks.addAll(nodueList);
            for (Task task : tasks) {
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (businessKey == null) {
                    continue;
                }
                for (SoAssess assess:soAssesses) {
                    if(assess.getSoid().equals(businessKey)){
                        assess.getSo().setTask(task);
                        assess.getSo().setProcessInstance(processInstance);
                        assess.getSo().setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                        result.add(assess);
                    }

                }
            }
        }

        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 获取超时办理任务列表，包括未签收的
     * @param page
     * @param soAssess
     * @return
     */
    public Page<SoAssess> findAllOverdueTasks(Page<SoAssess> page, SoAssess soAssess) {
        User user = UserUtils.getUser();
        //增加地市过滤
        if(!"47".equals(user.getCompany().getId()) && !"1".equals(user.getCompany().getId())){
            if(soAssess == null) {
                soAssess = new SoAssess();
            }
            if(soAssess.getSo() == null){
                So so = new So();
                so.setLocalId(new Integer(user.getCompany().getArea().getId()));
                soAssess.setSo(so);
            }
            soAssess.getSo().setLocalId(new Integer(user.getCompany().getArea().getId()));
        }
        //获取所有未未完成任务
        List<SoAssess> soAssesses = assessMapper.findTodoTasks(soAssess);
        List<SoAssess> result = Lists.newArrayList();
        //过滤出当前用户的任务
        if(soAssesses.size()>0) {
            List<Task> tasks =Lists.newArrayList();
            List<Task> overdueList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).dueBefore(new Date()).taskAssignee(ObjectUtils.toString(user.getId())).active().list();
            List<Task> overdueUnsignedList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).dueBefore(new Date()).taskCandidateUser(ObjectUtils.toString(user.getId())).active().list();
            tasks.addAll(overdueUnsignedList);
            tasks.addAll(overdueList);
            for (Task task : tasks) {
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (businessKey == null) {
                    continue;
                }
                for (SoAssess assess:soAssesses) {
                    if(assess.getSoid().equals(businessKey)){
                        assess.getSo().setTask(task);
                        assess.getSo().setProcessInstance(processInstance);
                        assess.getSo().setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                        result.add(assess);
                    }

                }
            }
        }
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 获取签收任务列表
     * @param page
     * @param soAssess
     * @return
     */
    public Page<SoAssess> findClaimTasks(Page<SoAssess> page, SoAssess soAssess) {
        User user = UserUtils.getUser();
        //增加地市过滤
        if(!"47".equals(user.getCompany().getId()) && !"1".equals(user.getCompany().getId())){
            if(soAssess == null) {
                soAssess = new SoAssess();
            }
            if(soAssess.getSo() == null){
                So so = new So();
                so.setLocalId(new Integer(user.getCompany().getArea().getId()));
                soAssess.setSo(so);
            }
            soAssess.getSo().setLocalId(new Integer(user.getCompany().getArea().getId()));
        }
        //获取所有未未完成任务
        List<SoAssess> soAssesses = assessMapper.findTodoTasks(soAssess);
        List<SoAssess> result = Lists.newArrayList();
        //过滤出当前用户的任务
        if(soAssesses.size()>0) {
            List<Task> tasks =Lists.newArrayList();
            List<Task> dueUnsignedList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).dueAfter(new Date()).taskCandidateUser(ObjectUtils.toString(user.getId())).active().list();
            List<Task> nodueUnsignedList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).withoutDueDate().taskCandidateUser(ObjectUtils.toString(user.getId())).active().list();
            tasks.addAll(dueUnsignedList);
            tasks.addAll(nodueUnsignedList);
            for (Task task : tasks) {
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (businessKey == null) {
                    continue;
                }
                for (SoAssess assess:soAssesses) {
                    if(assess.getSoid().equals(businessKey)){
                        assess.getSo().setTask(task);
                        assess.getSo().setProcessInstance(processInstance);
                        assess.getSo().setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                        result.add(assess);
                    }

                }
            }
        }

        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 获取超时签收任务列表
     * @param page
     * @param soAssess
     * @return
     */
    public Page<SoAssess> findOverClaimTasks(Page<SoAssess> page, SoAssess soAssess) {
        User user = UserUtils.getUser();
        //增加地市过滤
        if(!"47".equals(user.getCompany().getId()) && !"1".equals(user.getCompany().getId())){
            if(soAssess == null) {
                soAssess = new SoAssess();
            }
            if(soAssess.getSo() == null){
                So so = new So();
                so.setLocalId(new Integer(user.getCompany().getArea().getId()));
                soAssess.setSo(so);
            }
            soAssess.getSo().setLocalId(new Integer(user.getCompany().getArea().getId()));
        }
        //获取所有未未完成任务
        List<SoAssess> soAssesses = assessMapper.findTodoTasks(soAssess);
        List<SoAssess> result = Lists.newArrayList();
        //过滤出当前用户的任务
        if(soAssesses.size()>0) {
            List<Task> tasks =Lists.newArrayList();
            List<Task> overdueUnsignedList = taskService.createTaskQuery().processDefinitionKey(processDefinitionKey).dueBefore(new Date()).taskCandidateUser(ObjectUtils.toString(user.getId())).active().list();
            tasks.addAll(overdueUnsignedList);
            for (Task task : tasks) {
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (businessKey == null) {
                    continue;
                }
                for (SoAssess assess:soAssesses) {
                    if(assess.getSoid().equals(businessKey)){
                        assess.getSo().setTask(task);
                        assess.getSo().setProcessInstance(processInstance);
                        assess.getSo().setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                        result.add(assess);
                    }

                }
            }
        }
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 根据申请单号查找审核信息
     * @param soid
     * @return
     */
    public SoAssess findBySoid(String soid){
        List<SoCpApprove> soCpApproves = approveMapper.findSoCpApproveBySoid(soid);
        SoAssess soAssess = assessMapper.findBySoid(soid);
        soAssess.setSoCpApproves(soCpApproves);
        return soAssess;
    }

    @Transactional(readOnly = false)
    public void complete(SoAssess soAssess,Variable variable) {
        So so = soAssess.getSo();
        String processInstanceId = so.getBpmId();
        Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();

        // 签收
        WorkflowUtils.claim(processInstanceId);
        //添加批注
        taskService.addComment(task.getId(),so.getBpmId(),so.getAuditRemarks());

        Map<String,Object> map = variable.getVariableMap();

        String taskId = task.getId();
        String taskName = task.getName();
        String definitionKey = task.getTaskDefinitionKey();

        if("1".equals(so.getPass())){
            //完成任务
            taskService.complete(task.getId(),map);
        } else {

            String taskKey = "cpapply";//填写申请环节
            if(Constants.BACK_ACTIVITY_PRE.equals(map.get("backActivity"))){
                //获取当前节点的上一个节点
                PvmActivity activity = workflowActivityService.getPreActivity(processInstanceId);
                if(activity != null){
                    taskKey = activity.getId();
                    map.put("initiator",so.getUserId());
                    // 回退上一节点
                    myTaskService.rejectTask(task.getId(),taskKey,"turnback",map);
                }

            } else if(Constants.BACK_ACTIVITY_START.equals(map.get("backActivity"))){
                map.put("initiator",so.getUserId());
                //跳跃节点
                myTaskService.rejectTask(task.getId(),taskKey,"jump",map);
            }
            //回退任务
            //myTaskService.rejectTask(task.getId(),taskKey,"turnback",map);
            //Integer result = myTaskService.rollback(taskId);
            //Integer result = myTaskService.withdrawTask(taskId);
        }

        //更新申请主表状态
        task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();
        // sts 状态 0-竣工 1-提交 2-已接收 3-审核中 4-审核完成 5-注销 6-注销中 7-已作废
        if (task != null) {
            so.setProcessSts(task.getName());
            so.setProcessDate(new Date());
            so.setSts(Constants.SO_STS_AUDITING);
            if(Constants.BACK_ACTIVITY_START.equals(map.get("backActivity"))){
                so.setSts(Constants.SO_STS_BACK);
            }
            so.setStsDate(new Date());
        } else {
            so.setProcessSts("已完成");
            so.setProcessDate(new Date());
            so.setSts(Constants.SO_STS_AUDITED);
            so.setStsDate(new Date());
        }
        soMapper.updateByPrimaryKeySelective(so);

        //处理图片审核信息
        if(soAssess.getSoAttachments() != null && !soAssess.getSoAttachments().isEmpty()){
            for(SoAttachment attachment:soAssess.getSoAttachments()){
                attachment.setUpdateDate(new Date());
                attachment.setSts("1");
                soAttachmentMapper.updateByPrimaryKeySelective(attachment);
            }
        }
        //保存日志信息
        User user = UserUtils.getUser();
        SoCpApprove soCPApprove = new SoCpApprove();
        soCPApprove.setSoid(so.getSoid());
        soCPApprove.setSts(so.getPass());
        soCPApprove.setApprUserId(user.getId());
        soCPApprove.setApprDate(new Date());
        soCPApprove.setStsDate(new Date());
        soCPApprove.setApprOfficeId(user.getOffice().getId());
        soCPApprove.setApprId(taskId);
        soCPApprove.setContent(so.getAuditRemarks());
        soCPApprove.setSeq(0);
        soCPApprove.setTaskName(taskName);
        soCPApprove.setConsistentOriginal(so.getConsistentOriginal());
        soCPApprove.setSeal(so.getSeal());
        if("localAudit".equals(definitionKey) || "localLeaderAudit".equals(definitionKey) || "localMainLeaderAudit".equals(definitionKey)){
            soCPApprove.setApprType("01");
        } else if("constructionCpLeaderAudit".equals(definitionKey) || "constructionAllLeaderAudit".equals(definitionKey) || "directorAudit".equals(definitionKey)){
            soCPApprove.setApprType("00");
        } else {
            soCPApprove.setApprType("02");
        }
        approveMapper.insert(soCPApprove);
    }

    /**
     * 签收
     * @param processInstanceId
     */
    @Transactional(readOnly = false)
    public void claim(String processInstanceId) {
        // 任务签收
        WorkflowUtils.claim(processInstanceId);

        //更新下申请主表的状态
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
        String businessKey = processInstance.getBusinessKey();
        So so = soMapper.selectByPrimaryKey(businessKey);
        so.setSts(Constants.SO_STS_RECIVED);
        soMapper.updateByPrimaryKeySelective(so);
    }
    /**
     * 查询流程定义对象
     *
     * @param processDefinitionId 流程定义ID
     * @return
     */
    protected ProcessDefinition getProcessDefinition(String processDefinitionId) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
        return processDefinition;
    }

    /**
     * 查询已办申报列表
     *
     * //@param soAssess so实体
     * @return
     */
    public Page<SoAssess> findDoneTasks(Page<SoAssess> page, SoAssess soAssess) {
        List<SoAssess> soAssesses = assessMapper.findDoneTasks(soAssess);
        page.setCount(soAssesses.size());
        page.setList(soAssesses.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }
}
