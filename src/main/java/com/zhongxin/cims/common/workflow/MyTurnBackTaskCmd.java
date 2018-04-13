package com.zhongxin.cims.common.workflow;

import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.impl.bpmn.behavior.UserTaskActivityBehavior;
import org.activiti.engine.impl.cmd.NeedsActiveTaskCmd;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.PvmException;
import org.activiti.engine.impl.pvm.delegate.SignallableActivityBehavior;
import org.activiti.engine.task.IdentityLinkType;

import java.lang.reflect.Method;

/**
 * Created by lqyu_773 on 14-7-6.
 */
public class MyTurnBackTaskCmd extends NeedsActiveTaskCmd<Void> {

    private static final long serialVersionUID = 7703437592432994011L;

    private String destinationTaskKey;

    /**
     * @param taskId             执行退回操作的任务实例ID
     * @param destinationTaskKey 退回目标任务的key即任务定义ID
     */
    public MyTurnBackTaskCmd(String taskId, String destinationTaskKey) {
        super(taskId);
        this.destinationTaskKey = destinationTaskKey;
    }

    @Override
    protected Void execute(CommandContext commandContext, TaskEntity task) {
        if (destinationTaskKey == null) {
            //表示执行任务完成操作，如果是退回操作的话不激活任务完成事件
            task.fireEvent(TaskListener.EVENTNAME_COMPLETE);
        }

        if (Authentication.getAuthenticatedUserId() != null && task.getProcessInstanceId() != null) {
            task.getProcessInstance()
                    .involveUser(Authentication.getAuthenticatedUserId(), IdentityLinkType.PARTICIPANT);
        }
        //删除任务实例
        Context.getCommandContext().getTaskEntityManager().deleteTask(task, TaskEntity.DELETE_REASON_COMPLETED, false);

        if (task.getExecutionId() != null) {
            ExecutionEntity execution = task.getExecution();
            execution.removeTask(task);

            signal(execution, destinationTaskKey);
        }

        return null;
    }

    private void signal(ExecutionEntity execution, String destinationTaskKey) {

        try {
            // 通过反射调用 ExecutionEntity 的方法ensureActivityInitialized,此处源码操作保持一致
            Method method = ExecutionEntity.class.getDeclaredMethod("ensureActivityInitialized");
            method.setAccessible(true);
            method.invoke(execution);

        } catch (Exception e) {
            e.printStackTrace();
        }

        SignallableActivityBehavior activityBehavior = (SignallableActivityBehavior) execution.getActivity().getActivityBehavior();
        try {
            if (activityBehavior instanceof UserTaskActivityBehavior) {

                MyUserTaskActivityBehavior mutab = new MyUserTaskActivityBehavior();

                mutab.setActivityBehavior((UserTaskActivityBehavior) activityBehavior);
                mutab.signal(execution, destinationTaskKey, null, null);

            } else {
                //未考虑多实例任务,故采用Activiti自身api执行
                activityBehavior.signal(execution, null, null);
            }
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            throw new PvmException("couldn't process signal '" + "" + "' on activity '" + execution.getActivity().getId() + "': " + e.getMessage(), e);
        }
    }
}