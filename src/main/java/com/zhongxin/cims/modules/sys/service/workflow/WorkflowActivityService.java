package com.zhongxin.cims.modules.sys.service.workflow;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lqyu_773 on 14-7-10.
 */
@Service
public class WorkflowActivityService {
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    protected TaskService taskService;
    @Autowired
    protected HistoryService historyService;
    @Autowired
    protected RepositoryService repositoryService;

    /**
     * 根据流程实例ID获得当前节点的上一节点ID，目前只考虑单线流程
     * @param processInstanceId
     * @return
     */
    public PvmActivity getPreActivity(String processInstanceId){
        Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
                .singleResult();
        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
                .getDeployedProcessDefinition(processInstance.getProcessDefinitionId());
        List<ActivityImpl> activitiList = processDefinition.getActivities();//获得当前任务的所有节点
        PvmActivity ac = null;
        for(ActivityImpl activityImpl:activitiList){
            String id = activityImpl.getId();
            if(task.getTaskDefinitionKey().equals(id)){
                System.out.println("当前任务："+activityImpl.getProperty("name")); //输出某个节点的某种属性
                List<PvmTransition> inTransitions = activityImpl.getIncomingTransitions();
                for(PvmTransition tr:inTransitions){
                    ac = tr.getSource();
                    System.out.println("上一步任务任务："+ac.getProperty("name"));
                }
                break;
            }
        }
        return ac;
    }

    /**
     * 根据流程实例ID获得当前节点的下一节点ID，目前只考虑单线流程
     * @param processInstanceId
     * @return
     */
    public PvmActivity getNextActivity(String processInstanceId){
        Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
                .singleResult();
        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
                .getDeployedProcessDefinition(processInstance.getProcessDefinitionId());
        List<ActivityImpl> activitiList = processDefinition.getActivities();//获得当前任务的所有节点

        PvmActivity ac = null;
        for(ActivityImpl activityImpl:activitiList){
            String id = activityImpl.getId();
            if(task.getTaskDefinitionKey().equals(id)){
                System.out.println("当前任务："+activityImpl.getProperty("name")); //输出某个节点的某种属性
                List<PvmTransition> outTransitions = activityImpl.getOutgoingTransitions();//获取从某个节点出来的所有线路
                for(PvmTransition tr:outTransitions){
                    ac = tr.getDestination(); //获取线路的终点节点
                    System.out.println("下一步任务任务："+ac.getProperty("name"));
                }
                break;
            }
        }
        return ac;
    }

    /**
     * 根据流程实例ID获得当前节点ID，目前只考虑单线流程
     * @param processInstanceId
     * @return
     */
    public String getCurrentActivity(String processInstanceId){
        Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId)
                .singleResult();
        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
                .getDeployedProcessDefinition(processInstance.getProcessDefinitionId());
        List<ActivityImpl> activitiList = processDefinition.getActivities();//获得当前任务的所有节点

        String activityid = "";
        for(ActivityImpl activityImpl:activitiList){
            String id = activityImpl.getId();
            if(task.getTaskDefinitionKey().equals(id)){
                System.out.println("当前任务："+activityImpl.getProperty("name")); //输出某个节点的某种属性
                activityid = activityImpl.getId();
            }
        }
        return activityid;
    }

    /**
     * 根据流程实例ID获取所有历史执行节点实例
     * @param processInstanceId
     * @return
     */
    public  List<HistoricActivityInstance> getHisActivityInstances(String processInstanceId){
        return historyService.createHistoricActivityInstanceQuery().processInstanceId(processInstanceId).list();
    }
}
