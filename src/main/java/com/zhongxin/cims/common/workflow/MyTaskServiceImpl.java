package com.zhongxin.cims.common.workflow;

import com.zhongxin.cims.common.workflow.cmd.RollbackTaskCmd;
import com.zhongxin.cims.common.workflow.cmd.WithdrawTaskCmd;
import org.activiti.engine.impl.TaskServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * Created by lqyu_773 on 14-7-6.
 */
@Service
@Transactional(readOnly = true)
public class MyTaskServiceImpl {

    @Autowired
    private TaskServiceImpl taskService;

    /**
     * <p/>
     * 完成任务
     * <p/>
     *
     * @param
     * @return
     */
    public void completeTask(String taskId) {
        turnBackTask(taskId, null);
    }

    /**
     * <p/>
     * 任务退回操作
     * <p/>
     *
     * @param taskId             执行退回操作的任务实例ID
     * @param destinationTaskKey 退回任务的KEY即任务定义ID,如果为null表示为完成任务操作
     */
    public void turnBackTask(String taskId, String destinationTaskKey) {

        taskService.getCommandExecutor().execute(new MyTurnBackTaskCmd(taskId, destinationTaskKey));
    }

    /**
     * <p/>
     * 默认退回
     * <p/>
     *
     * @param taskId 执行默认退回的任务实例ID
     */
    public void defaultTurnBack(String taskId) {

        //taskService.getCommandExecutor().execute(new MyDefaultTurnBackTaskCmd(taskId));
    }

    /**
     * 任务回退
     * @param taskId
     * @param destinationTaskKey
     * @param type jump跳跃 ，turnback 退回（）
     * @param variable
     */
    @Transactional(readOnly = false)
    public void rejectTask(String taskId, String destinationTaskKey, String type, Map<String, Object> variable) {
        taskService.getCommandExecutor().execute(new TaskCommitCmd(taskId, destinationTaskKey, type, variable));
    }

    @Transactional(readOnly = false)
    public Integer rollback(String taskId){
        return taskService.getCommandExecutor().execute(new RollbackTaskCmd(taskId));
    }

    public Integer withdrawTask(String histroyTaskId){
        return taskService.getCommandExecutor().execute(new WithdrawTaskCmd(histroyTaskId));
    }
}
