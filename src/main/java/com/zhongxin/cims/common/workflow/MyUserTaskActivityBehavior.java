package com.zhongxin.cims.common.workflow;

import org.activiti.engine.delegate.Expression;
import org.activiti.engine.impl.bpmn.behavior.UserTaskActivityBehavior;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.ProcessDefinitionImpl;
import org.activiti.engine.impl.pvm.process.TransitionImpl;
import org.activiti.engine.impl.task.TaskDefinition;

/**
 * Created by lqyu_773 on 14-7-6.
 */
public class MyUserTaskActivityBehavior {
    public static final String TASK_ROLL_BACK = "rollback";

    private UserTaskActivityBehavior activityBehavior;

    public UserTaskActivityBehavior getActivityBehavior() {
        return activityBehavior;
    }

    public void setActivityBehavior(UserTaskActivityBehavior activityBehavior) {
        this.activityBehavior = activityBehavior;
    }

    public synchronized void signal(ActivityExecution execution, String destinationTaskKey, String signalName, Object signalData) {
        try {
            if (destinationTaskKey != null) {

                ActivityImpl currentActivity = (ActivityImpl) execution.getActivity();

                ProcessDefinitionImpl pd = (ProcessDefinitionImpl) currentActivity.getProcessDefinition();

                //创建源任务与目标回退任务之间的连线
                TransitionImpl transitionImpl = currentActivity.createOutgoingTransition(TASK_ROLL_BACK);
                //获取目标回退任务
                ActivityImpl destionationTask = (ActivityImpl) pd.findActivity(destinationTaskKey);
                //获取任务定义信息
                TaskDefinition td = (TaskDefinition) destionationTask.getProperty("taskDefinition");
                System.out.println(td.getAssigneeExpression());

                Expression oldAssigneeExpression = td.getAssigneeExpression();

                //创建任务处理人设置表达  此处假设原目标任务处理人为 hxlzp
                Expression assigneeExpression = Context.getProcessEngineConfiguration()
                        .getExpressionManager().createExpression("hxlzp");
                //设置任务定义的处理人表达式
                td.setAssigneeExpression(assigneeExpression);

                transitionImpl.setDestination(destionationTask);
                transitionImpl.setProperty("name", TASK_ROLL_BACK);

                execution.take(transitionImpl);

                td.setAssigneeExpression(oldAssigneeExpression);
                //执行回退后 清除上述创建的连线
                currentActivity.getOutgoingTransitions().remove(transitionImpl);
            } else {
                activityBehavior.signal(execution, signalName, signalData);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
