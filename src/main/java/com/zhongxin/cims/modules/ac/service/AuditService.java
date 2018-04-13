package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.ac.dao.PlanMapper;
import com.zhongxin.cims.modules.ac.dao.SoAuditMapper;
import com.zhongxin.cims.modules.ac.dao.SoHoursMapper;
import com.zhongxin.cims.modules.ac.dao.SoPlanMapper;
import com.zhongxin.cims.modules.ac.entity.Plan;
import com.zhongxin.cims.modules.ac.entity.SoAudit;
import com.zhongxin.cims.modules.ac.entity.SoHours;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.exam.dao.ExamMapper;
import com.zhongxin.cims.modules.exam.entiy.ExamInfo;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by lqyu_773 on 14-10-4.
 */
@Component
@Transactional(readOnly = true)
public class AuditService extends BaseService {

    @Autowired
    private SoAuditMapper auditMapper;

    @Autowired
    private SoHoursMapper hoursMapper;

    @Autowired
    private ExamMapper examMapper;

    @Autowired
    private SoPlanMapper planMapper;

    @Autowired
    private PlanMapper tPlanMapper;

    @Autowired
    private SoAttachmentMapper attachmentMapper;


    @Transactional(readOnly = false)
    public void save(SoAudit soAudit) {
        //hoursMapper.
        auditMapper.insert(soAudit);
    }
    @Transactional(readOnly = false)
    public void audit(SoHours soHours) {
        // 更新学时表
        soHours.setAuditBy(UserUtils.getUser().getId());
        soHours.setAuditDate(new Date());


        // 插入审核信息
        SoAudit soAudit = new SoAudit();
        soAudit.setSoid(soHours.getSoid());
        soAudit.setAuditTag(soHours.getPass());
        soAudit.setAuditBy(soHours.getAuditBy());
        soAudit.setAuditInfo(soHours.getRsrvStr1());
        soAudit.setAuditType(soHours.getRsrvStr2());
        soAudit.setAuditDate(soHours.getAuditDate());
       // soAudit.setAuditLevel(soHours.getAuditLevel());
        soAudit.setAuditLevel(soHours.getRsrvStr3());
        soAudit.setSoHoursId(soHours.getId());
        auditMapper.insert(soAudit);

        // 如果是减免学时审核,执行如下逻辑
        if (Constants.AUDIT_TYPE_REDUCE.equals(soAudit.getAuditType())) {
            // 如果终审完成，并通过，则更新so_plan表的减免状态
            if (Constants.AUDIT_LEVEL_COMPLETE.equals(soHours.getAuditLevel()) && "1".equals(soHours.getPass())) {

                soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_PASSED);// 审核通过
                hoursMapper.updateByPrimaryKeySelective(soHours);

                // 查询审核通过的学时数是否已经满足申报项目的学时数,如果满足,则更新SO_PLAN表学时状态为完成
                // 获取审核通过的总学时数
                SoPlan soPlan = planMapper.findBySoid(soHours.getSoid());
                soPlan.setReduceFlag("1");
                double totalHours = hoursMapper.getTotalHours(soHours.getSoid());

                // 重新获取下soHour
                SoHours hours = hoursMapper.selectByPrimaryKey(soHours.getId());

                Plan plan = tPlanMapper.selectByPrimaryKey(hours.getPlanId());

                soPlan.setRsrvStr3(ObjectUtils.toString(totalHours));
                logger.debug("已经审核通过学时数: " + totalHours);
                logger.debug("申报项目要求学时数: " + plan.getPlanHours());
                if(totalHours >= new Integer(plan.getPlanHours())) {
                    soPlan.setHourState("1");
                }
                planMapper.updateByPrimaryKeySelective(soPlan);
            } else {
                hoursMapper.updateByPrimaryKeySelective(soHours);
            }
        }

        // 如果是课件学时审核,执行如下逻辑
        if (Constants.AUDIT_TYPE_HOURS.equals(soAudit.getAuditType())) {
            if (Constants.AUDIT_LEVEL_COMPLETE.equals(soHours.getAuditLevel()) && "1".equals(soHours.getPass())) {
                // 更新so_hours表状态为审核通过
                soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_PASSED);// 审核通过
                hoursMapper.updateByPrimaryKeySelective(soHours);
                // 查询审核通过的学时数是否已经满足申报项目的学时数,如果满足,则更新SO_PLAN表学时状态为完成
                // 获取审核通过的总学时数
                double totalHours = hoursMapper.getTotalHours(soHours.getSoid());

                // 重新获取下soHour
                SoHours hours = hoursMapper.selectByPrimaryKey(soHours.getId());

                Plan plan = tPlanMapper.selectByPrimaryKey(hours.getPlanId());

                logger.debug("已经审核通过学时数: " + totalHours);
                logger.debug("申报项目要求学时数: " + plan.getPlanHours());
               //如果学时总数大于等于计划学时，将学时状态改为已学满状态
                if(totalHours >= new Integer(plan.getPlanHours())) {
                    SoPlan soPlan = planMapper.findBySoid(soHours.getSoid());
                    soPlan.setRsrvStr3(ObjectUtils.toString(totalHours));
                    soPlan.setHourState("1");
                    planMapper.updateByPrimaryKeySelective(soPlan);
                }else{
                    //如果没有，不更新学满状态，将已学学时计入主表已学字段
                    SoPlan soPlan = planMapper.findBySoid(soHours.getSoid());
                    soPlan.setRsrvStr3(ObjectUtils.toString(totalHours));
                    planMapper.updateByPrimaryKeySelective(soPlan);
                }

                // 终审完成后，修改附件pass状态为1
                SoAttachment attach = new SoAttachment();
                attach.setSoid(soHours.getSoid());
                attach.setAppId(soHours.getCourseId() + "");
                attach.setSoType(soHours.getLessonId() + "");
                List<SoAttachment> attachments = attachmentMapper.findBySelective(attach);
                for(SoAttachment attachment : attachments) {
                    attachment.setPass("1");
                    attachment.setPassDate(new Date());
                    attachment.setPassUserId(soHours.getAuditBy());
                    attachmentMapper.updateByPrimaryKey(attachment);
                }
            } else {
                hoursMapper.updateByPrimaryKeySelective(soHours);
            }
            // 如果不通过，更新附件表pass状态为不通过
            if ("0".equals(soHours.getPass())) {
                SoAttachment attach = new SoAttachment();
                attach.setSoid(soHours.getSoid());
                attach.setAppId(soHours.getCourseId() + "");
                attach.setSoType(soHours.getLessonId() + "");
                List<SoAttachment> attachments = attachmentMapper.findBySelective(attach);
                for(SoAttachment attachment : attachments) {
                    attachment.setPass("2");
                    attachment.setPassDate(new Date());
                    attachment.setPassUserId(soHours.getAuditBy());
                    attachmentMapper.updateByPrimaryKeySelective(attachment);
                }
            }
        }
    }

    @Transactional(readOnly = false)
    public void auditExam(ExamInfo examInfo) {
        // 更新考试信息表
        examInfo.setAuditBy(UserUtils.getUser().getId());
        examInfo.setAuditDate(new Date());


        // 插入审核信息
        SoAudit soAudit = new SoAudit();
        soAudit.setSoid(examInfo.getSoId());
        soAudit.setAuditTag(examInfo.getPass());
        soAudit.setAuditBy(examInfo.getAuditBy());
        soAudit.setAuditInfo(examInfo.getAuditInfo());
        soAudit.setAuditType(examInfo.getRsrvStr2());
        soAudit.setAuditDate(examInfo.getAuditDate());
        soAudit.setAuditLevel(examInfo.getAuditLevel());
        auditMapper.insert(soAudit);



        // 如果终审完成，并通过，则更新so_plan表的考试状态
        SoPlan soPlan = planMapper.findBySoid(examInfo.getSoId());
        //如果存在审核不通过的情况，终止审核并更新主表为审核不通过状态
        if(Constants.EXAM_AUDIT_NOPASSED.equals(examInfo.getAuditTag())){
            // 更新SO_PLAN表考试状态为审核未通过
            soPlan.setExamState("4");
            planMapper.updateByPrimaryKeySelective(soPlan);
        }

        if(Constants.EXAM_AUDIT_TYPE_NOMAL.equals(examInfo.getExamType())){
            if (Constants.AUDIT_LEVEL_COMPLETE.equals(examInfo.getAuditLevel()) && "1".equals(examInfo.getPass())) {
                //更新考试状态为审核通过
                examInfo.setAuditTag(Constants.EXAM_AUDIT_PASSED);
                examMapper.updateByPrimaryKeySelective(examInfo);
                // 更新SO_PLAN表考试状态为审核成功
                soPlan.setExamState("1");
                planMapper.updateByPrimaryKeySelective(soPlan);
            }else if (Constants.AUDIT_LEVEL_COMPLETE.equals(examInfo.getAuditLevel()) && "0".equals(examInfo.getPass())) {
                //更新考试状态为审核不通过
                examInfo.setAuditTag(Constants.EXAM_AUDIT_NOPASSED);
                examMapper.updateByPrimaryKeySelective(examInfo);
                // 更新SO_PLAN表考试状态为审核不通过
                soPlan.setExamState("4");
                planMapper.updateByPrimaryKeySelective(soPlan);
            }else {
                examMapper.updateByPrimaryKeySelective(examInfo);

            }

        }else if (Constants.EXAM_AUDIT_TYPE_AGAIN.equals(examInfo.getExamType())){
            if (Constants.AUDIT_LEVEL_COMPLETE.equals(examInfo.getAuditLevel()) && "1".equals(examInfo.getPass())) {
                //更新考试状态为审核通过
                examInfo.setAuditTag(Constants.EXAM_AUDIT_PASSED);
                examMapper.updateAgainByPrimaryKeySelective(examInfo);
                // 更新SO_PLAN表考试状态为审核成功
                soPlan.setExamState("1");
                planMapper.updateByPrimaryKeySelective(soPlan);
            }else if (Constants.AUDIT_LEVEL_COMPLETE.equals(examInfo.getAuditLevel()) && "0".equals(examInfo.getPass())) {
                //更新考试状态为审核不通过
                examInfo.setAuditTag(Constants.EXAM_AUDIT_NOPASSED);
                examMapper.updateAgainByPrimaryKeySelective(examInfo);
                // 更新SO_PLAN表考试状态为审核不通过
                soPlan.setExamState("4");
                planMapper.updateByPrimaryKeySelective(soPlan);
            }else {
                examMapper.updateAgainByPrimaryKeySelective(examInfo);

            }
        }

  }

}
