package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.dao.SoAuditMapper;
import com.zhongxin.cims.modules.ac.dao.SoHoursMapper;
import com.zhongxin.cims.modules.ac.entity.SoAudit;
import com.zhongxin.cims.modules.ac.entity.SoHours;
import com.zhongxin.cims.modules.ac.service.AuditService;
import com.zhongxin.cims.modules.ac.service.HoursService;
import com.zhongxin.cims.modules.exam.dao.ExamMapper;
import com.zhongxin.cims.modules.exam.entiy.ExamInfo;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by lqyu_773 on 14-10-4.
 */
@Controller
@RequestMapping(value = "${adminPath}/audit")
public class AuditController extends BaseController {

    @Autowired
    private SoAuditMapper auditMapper;

    @Autowired
    private AuditService auditService;

    @Autowired
    private HoursService hoursService;

    @Autowired
    private SoHoursMapper hoursMapper;

    @Autowired
    private ExamMapper examMapper;

    @ModelAttribute(value = "soAudit")
    public SoAudit get(@RequestParam(required=false) Long id) {
        if (id != null){
            return auditMapper.selectByPrimaryKey(id);
        } else {
            return new SoAudit();
        }
    }

    @RequiresPermissions("ac:reducehour:first")
    @RequestMapping(value = "reduceFirstAudit")
    public String reduceFirstAudit(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {

        soHours.setRsrvStr2(Constants.AUDIT_TYPE_REDUCE);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'
        if("0".equals(soHours.getPass())) {
            soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_NOPASSED);// 审核不通过
        } else {
            soHours.setAuditLevel(Constants.AUDIT_LEVEL_THIRD); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
        }

        auditService.audit(soHours);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/auditReduceList?auditLevel=" + Constants.AUDIT_LEVEL_FIRST;
    }

    @RequiresPermissions("ac:reducehour:second")
    @RequestMapping(value = "reduceSecondAudit")
    public String reduceSecondAudit(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        soHours.setRsrvStr2(Constants.AUDIT_TYPE_REDUCE);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'
        if("0".equals(soHours.getPass())) {
            soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_NOPASSED);// 审核不通过
        } else {
            soHours.setAuditLevel(Constants.AUDIT_LEVEL_THIRD); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
        }

        auditService.audit(soHours);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/auditReduceList?auditLevel=" + Constants.AUDIT_LEVEL_SECOND;
    }

    @RequiresPermissions("ac:reducehour:third")
    @RequestMapping(value = "reduceThirdAudit")
    public String reduceThirdAudit(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        soHours.setRsrvStr2(Constants.AUDIT_TYPE_REDUCE);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'
        if("0".equals(soHours.getPass())) {
            soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_NOPASSED);// 审核不通过
        } else {
            soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
        }

        auditService.audit(soHours);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/auditReduceList?auditLevel=" + Constants.AUDIT_LEVEL_THIRD;
    }

    @RequiresPermissions(value = {"ac:reducehour:first","ac:reducehour:second","ac:reducehour:third"},logical = Logical.OR)
    @RequestMapping(value = "batchReduceAudit")
    public String batchReduceAudit(String[] seqs,String batchPass,String batchAuditInfo,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {

        for(String id:seqs) {
            SoHours soHours = hoursMapper.selectByPrimaryKey(new Long(id));

            soHours.setRsrvStr2(Constants.AUDIT_TYPE_REDUCE);
            soHours.setPass(batchPass);
            soHours.setRsrvStr1(batchAuditInfo);
            if("0".equals(batchPass)) {
                // 审核不通过
                soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_NOPASSED);
            } else {
                if ("1".equals(soHours.getAuditLevel())) {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_THIRD);
                } else  if ("2".equals(soHours.getAuditLevel())) {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE);
                } else {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_SECOND);
                }
            }

            auditService.audit(soHours);
        }

        addMessage(redirectAttributes, "批量审核成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/auditReduceList/?repage";
    }

    @RequiresPermissions("ac:lessonhour:first")
    @RequestMapping(value = "hoursFirstAudit")
    public String hoursFirstAudit(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {

        soHours.setRsrvStr2(Constants.AUDIT_TYPE_HOURS);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'
        if("0".equals(soHours.getPass())) {
            soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_NOPASSED);// 审核不通过
            soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE);
            soHours.setRsrvStr3(Constants.AUDIT_LEVEL_THIRD);
        } else {
            //soHours.setAuditLevel(Constants.AUDIT_LEVEL_SECOND); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
            soHours.setAuditLevel(Constants.AUDIT_LEVEL_THIRD); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
            soHours.setRsrvStr3(Constants.AUDIT_LEVEL_THIRD);

        }

        auditService.audit(soHours);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/auditHoursList?auditLevel=" + Constants.AUDIT_LEVEL_FIRST;
    }

    @RequiresPermissions("ac:lessonhour:second")
    @RequestMapping(value = "hoursSecondAudit")
    public String hoursSecondAudit(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        soHours.setRsrvStr2(Constants.AUDIT_TYPE_HOURS);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'
        if("0".equals(soHours.getPass())) {
            soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_NOPASSED);// 审核不通过
        } else {
            soHours.setAuditLevel(Constants.AUDIT_LEVEL_THIRD); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
        }

        auditService.audit(soHours);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/auditHoursList?auditLevel=" + Constants.AUDIT_LEVEL_SECOND;
    }

    @RequiresPermissions("ac:lessonhour:third")
    @RequestMapping(value = "hoursThirdAudit")
    public String hoursThirdAudit(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        soHours.setRsrvStr2(Constants.AUDIT_TYPE_HOURS);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'
        if("0".equals(soHours.getPass())) {
            soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_NOPASSED);// 审核不通过
            soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE);
            soHours.setRsrvStr3(Constants.AUDIT_LEVEL_COMPLETE);

        } else {
            soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
            soHours.setRsrvStr3(Constants.AUDIT_LEVEL_COMPLETE);
        }

        auditService.audit(soHours);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/auditHoursList?auditLevel=" + Constants.AUDIT_LEVEL_THIRD;
    }

    @RequiresPermissions(value = {"ac:lessonhour:first","ac:lessonhour:second","ac:lessonhour:third"},logical = Logical.OR)
    @RequestMapping(value = "batchHoursAudit")
    public String batchHoursAudit(String[] seqs,String batchPass,String batchAuditInfo,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        String auditLevel = "";
        for(String id:seqs) {
            SoHours soHours = hoursMapper.selectByPrimaryKey(new Long(id));

            soHours.setRsrvStr2(Constants.AUDIT_TYPE_HOURS);
            soHours.setPass(batchPass);
            soHours.setRsrvStr1(batchAuditInfo);
            if("0".equals(batchPass)) {
                // 审核不通过
                soHours.setAuditTag(Constants.LEARN_HOURS_AUDIT_NOPASSED);
                if (Constants.AUDIT_LEVEL_FIRST.equals(soHours.getAuditLevel())) {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE);
                    soHours.setRsrvStr3(Constants.AUDIT_LEVEL_THIRD);
                    auditLevel = Constants.AUDIT_LEVEL_FIRST;
                } else  if (Constants.AUDIT_LEVEL_THIRD.equals(soHours.getAuditLevel())) {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE);
                    soHours.setRsrvStr3(Constants.AUDIT_LEVEL_COMPLETE);
                    auditLevel = Constants.AUDIT_LEVEL_THIRD;
                }
            } /*else {
                if (Constants.AUDIT_LEVEL_SECOND.equals(soHours.getAuditLevel())) {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_THIRD);
                } else  if (Constants.AUDIT_LEVEL_THIRD.equals(soHours.getAuditLevel())) {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE);
                } else {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_SECOND);
                }
            }*/

            else {
                if (Constants.AUDIT_LEVEL_FIRST.equals(soHours.getAuditLevel())) {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_THIRD);
                    soHours.setRsrvStr3(Constants.AUDIT_LEVEL_THIRD);
                    auditLevel = Constants.AUDIT_LEVEL_FIRST;
                } else  if (Constants.AUDIT_LEVEL_THIRD.equals(soHours.getAuditLevel())) {
                    soHours.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE);
                    soHours.setRsrvStr3(Constants.AUDIT_LEVEL_COMPLETE);
                    auditLevel = Constants.AUDIT_LEVEL_THIRD;
                }
            }



            auditService.audit(soHours);
        }

        addMessage(redirectAttributes, "批量审核成功");

        if(auditLevel!=null && !"".equals(auditLevel)){
            if(Constants.AUDIT_LEVEL_FIRST.equals(auditLevel)){
                return "redirect:"+ Global.getAdminPath()+"/hours/auditHoursList?auditLevel=" + Constants.AUDIT_LEVEL_FIRST;
            }else if(Constants.AUDIT_LEVEL_THIRD.equals(auditLevel)){
                return "redirect:"+ Global.getAdminPath()+"/hours/auditHoursList?auditLevel=" + Constants.AUDIT_LEVEL_THIRD;
            }
        }
        return "redirect:"+ Global.getAdminPath()+"/hours/auditHoursList/?repage";
    }
     @RequiresPermissions("ac:examAudit:first")
    @RequestMapping(value = "examFirstAudit")
    public String examFirstAudit(ExamInfo examInfo,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        examInfo.setRsrvStr2(Constants.AUDIT_TYPE_EXAM);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'

        if("0".equals(examInfo.getPass())) {
            examInfo.setAuditTag(Constants.EXAM_AUDIT_NOPASSED);// 审核不通过
        } else {
            examInfo.setAuditLevel(Constants.AUDIT_LEVEL_SECOND); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
        }

        auditService.auditExam(examInfo);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/exam/exam/auditExamList?auditLevel=" + Constants.AUDIT_LEVEL_FIRST;

     }

    @RequiresPermissions("ac:examAudit:second")
    @RequestMapping(value = "examSecondAudit")
    public String examSecondAudit(ExamInfo examInfo,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        examInfo.setRsrvStr2(Constants.AUDIT_TYPE_EXAM);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'

        if("0".equals(examInfo.getPass())) {
            examInfo.setAuditTag(Constants.EXAM_AUDIT_NOPASSED);// 审核不通过
        } else {
            examInfo.setAuditLevel(Constants.AUDIT_LEVEL_THIRD); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
        }

        auditService.auditExam(examInfo);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/exam/exam/auditExamList?auditLevel=" + Constants.AUDIT_LEVEL_SECOND;

    }

    @RequiresPermissions("ac:examAudit:third")
    @RequestMapping(value = "examThirdAudit")
    public String examThirdAudit(ExamInfo examInfo,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        examInfo.setRsrvStr2(Constants.AUDIT_TYPE_EXAM);//0-发票审核 1-学时减免审核 2-学时审核 3-考试审核'

        if("0".equals(examInfo.getPass())) {
            examInfo.setAuditTag(Constants.EXAM_AUDIT_NOPASSED);// 审核不通过
        } else {
            examInfo.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE); //0-初审 1-复审 2-终审 初审完进入复审，复审完进入终审
        }

        auditService.auditExam(examInfo);

        addMessage(redirectAttributes, "审核成功");
        return "redirect:"+ Global.getAdminPath()+"/exam/exam/auditExamList?auditLevel=" + Constants.AUDIT_LEVEL_THIRD;
    }


    @RequiresPermissions(value = {"ac:examAudit:first","ac:examAudit:second","ac:examAudit:third"},logical = Logical.OR)
    @RequestMapping(value = "batchExamAudit")
    public String batchExamAudit(String[] seqs,String examType,String batchPass,String batchAuditInfo,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        for(String id:seqs) {

            ExamInfo examInfo = examMapper.selectByPrimaryKey(new Long(id));
            if(examInfo==null){
                examInfo =examMapper.selectAgainByPrimaryKey(new Long(id));
            }

            examInfo.setRsrvStr2(Constants.AUDIT_TYPE_EXAM);
            examInfo.setPass(batchPass);
            examInfo.setRsrvStr1(batchAuditInfo);
            if("0".equals(batchPass)) {
                // 审核不通过
                examInfo.setAuditTag(Constants.EXAM_AUDIT_NOPASSED);
            } else {
                if (Constants.AUDIT_LEVEL_SECOND.equals(examInfo.getAuditLevel())) {
                    examInfo.setAuditLevel(Constants.AUDIT_LEVEL_THIRD);
                } else  if (Constants.AUDIT_LEVEL_THIRD.equals(examInfo.getAuditLevel())) {
                    examInfo.setAuditLevel(Constants.AUDIT_LEVEL_COMPLETE);
                } else {
                    examInfo.setAuditLevel(Constants.AUDIT_LEVEL_SECOND);
                }
            }

            auditService.auditExam(examInfo);
        }

        addMessage(redirectAttributes, "批量审核成功");
        return "redirect:"+ Global.getAdminPath()+"/exam/exam/auditExamList/?repage";

    }
}
