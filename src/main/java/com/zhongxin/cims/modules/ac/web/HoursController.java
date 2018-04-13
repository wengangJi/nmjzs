package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.dao.SoAuditMapper;
import com.zhongxin.cims.modules.ac.entity.ServAssociateConstructor;
import com.zhongxin.cims.modules.ac.entity.SoAudit;
import com.zhongxin.cims.modules.ac.entity.SoHours;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.ac.service.HoursService;
import com.zhongxin.cims.modules.ac.service.PlanService;
import com.zhongxin.cims.modules.ac.service.ServAssociateConstructorService;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
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
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lqyu_773 on 14-9-12.
 */
@Controller
@RequestMapping(value = "${adminPath}/hours")
public class HoursController extends BaseController {

    @Autowired
    private HoursService hoursService;

    @Autowired
    private PlanService planService;

    @Autowired
    private SoAttachmentMapper attachmentMapper;

    @Autowired
    private SoAuditMapper auditMapper;

    @Autowired
    private SoAttachmentMapper soAttachmentMapper;

    @Autowired
    private ServAssociateConstructorService servAssociateConstructorService;
    @ModelAttribute
    public SoHours get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return hoursService.get(id);
        } else {
            return new SoHours();
        }
    }

    @ModelAttribute(value = "soAudit")
    public SoAudit get(@RequestParam(required=false) Long id) {
        return new SoAudit();
    }

    @RequestMapping(value = "reduceApply")
    public String apply(Long planId,String soid,Model model,RedirectAttributes redirectAttributes){
        //List<SoPlan> soPlans = planService.findCanReduceHoursPlan(UserUtils.getUser().getId());
        //model.addAttribute("soPlans",soPlans);
        SoHours soHours = new SoHours();
        soHours.setPlanId(planId);
        soHours.setSoid(soid);
        model.addAttribute("soHours",soHours);
        return "modules/ac/reduceHoursApply";
    }

    @RequestMapping(value = "initReduceModify")
    public String initReduceModify(String id,Model model,RedirectAttributes redirectAttributes){
        SoHours soHours = hoursService.get(id);
        model.addAttribute("soPlans",soHours);

        return "modules/ac/reduceHoursModify";
    }

    @RequestMapping(value = "reduceModify")
    public String reduceModify(SoHours soHours,Model model,RedirectAttributes redirectAttributes){
       hoursService.modify(soHours);
      return "modules/ac/reduceHoursModify";
    }

    @RequestMapping(value = "reduceList")
    public String list(Model model){
        List<SoHours> soHoursList = hoursService.findByUserId(UserUtils.getUser().getId());
        model.addAttribute("soHoursList", soHoursList);
        return "modules/ac/reduceHoursList";
    }

    @RequestMapping(value = "reduceListByUser")
    public String reduceListByUser(Model model){
        List<SoHours> soHoursList = hoursService.findReduceByUserId(UserUtils.getUser().getId());
        model.addAttribute("soHoursList", soHoursList);
        return "modules/ac/reduceHoursList";
    }

    @RequestMapping(value = "reduceBySoid")
    public String list(String soid,Model model){
        List<SoHours> soHourses = hoursService.selectReduceBySoid(soid);
        List<SoAudit> soAudits = auditMapper.selectBySoid(soid);


        if(soHourses ==null || soHourses.size() ==0 ){
            soHourses = new ArrayList<SoHours>();
            soHourses.add(new SoHours());
        }
        model.addAttribute("soAudits",soAudits);

        model.addAttribute("soHourses", soHourses);

        return "modules/ac/reduceHoursInfo";
    }

    @RequestMapping(value = "modify")
    public String modify(SoHours soHours,HttpServletRequest request, Model model, RedirectAttributes redirectAttributes){
        User user = UserUtils.getUser();
        soHours.setUserId(user.getId());
        soHours.setType(Constants.LEARN_HOURS_TYPE_REDUCE);
        hoursService.modify(soHours);
        addMessage(redirectAttributes, "继续教育冲抵学时修改成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/reduceListByUser/?repage";
    }

    @RequestMapping(value = "save")
    public String save(SoHours soHours,HttpServletRequest request, Model model, RedirectAttributes redirectAttributes){
        User user = UserUtils.getUser();
        soHours.setUserId(user.getId());
        soHours.setType(Constants.LEARN_HOURS_TYPE_REDUCE);
        hoursService.save(soHours);
        addMessage(redirectAttributes, "继续教育冲抵学时申请成功");
        return "redirect:"+ Global.getAdminPath()+"/hours/reduceListByUser/?repage";
    }

    @RequestMapping(value = "delete")
    public String delete(String id, RedirectAttributes redirectAttributes) {

        hoursService.delete(id);
        addMessage(redirectAttributes, "申请删除成功");
        return "redirect:"+Global.getAdminPath()+"/hours/reduceListByUser/?repage";
    }

    @RequestMapping(value = "auditReduceList")
    public String auditReduceList(SoHours soHours,String auditLevel,Model model,HttpServletRequest request,HttpServletResponse response){
        if(!"".equals(auditLevel)) {
            soHours.setAuditLevel(auditLevel);
        }
        soHours.setType(Constants.LEARN_HOURS_TYPE_REDUCE); //类型：0-减免申请 1-课程学时
        Page<SoHours> page = hoursService.findAuditList(new Page<SoHours>(request, response), soHours);
        model.addAttribute("page", page);
        return "modules/ac/auditReduceHoursList";
    }

    @RequestMapping(value = "auditHoursList")
    public String auditHoursList(SoHours soHours,String auditLevel,Model model,HttpServletRequest request,HttpServletResponse response){
        if(!"".equals(auditLevel)) {
            soHours.setAuditLevel(auditLevel);
        }
        soHours.setType(Constants.LEARN_HOURS_TYPE_LESSON); //类型：0-减免申请 1-课程学时
        Page<SoHours> page = hoursService.findAuditList(new Page<SoHours>(request, response), soHours);
        model.addAttribute("page", page);
        return "modules/ac/auditHoursList";
    }


    @RequestMapping(value = "qryHisCompleteHoursList")
    public String qryHisCompleteHoursList(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response){
        Page<SoHours> page = null;
        soHours.setType(Constants.LEARN_HOURS_TYPE_LESSON); //类型：0-减免申请 1-课程学时
        //如果是查询未通过，单独调用
        page = hoursService.findAuditedNoPassList(new Page<SoHours>(request, response), soHours);


        model.addAttribute("page", page);
        return "modules/ac/acHisCompleteHoursList";
    }



    @RequestMapping(value = "qryHisHoursListInfo")
    public String qryHisHoursListInfo(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response){
        Page<SoHours> page = null;
        soHours.setType(Constants.LEARN_HOURS_TYPE_LESSON); //类型：0-减免申请 1-课程学时

        page = hoursService.findAuditedList(new Page<SoHours>(request, response), soHours);
        //如果是查询未通过，单独调用
     /*   if(soHours.getQryStr3()== null && soHours.getQryStr4() ==null){
            page = hoursService.findAuditedList(new Page<SoHours>(request, response), soHours);
        }else if(soHours.getQryStr3().equals("2")){

            page = hoursService.findAuditedNoPassList(new Page<SoHours>(request, response), soHours);
        }else if(soHours.getQryStr3().equals("1")){

        }else if(soHours.getQryStr3().equals("0")){

        }*/

        model.addAttribute("page", page);
        return "modules/ac/acHisHoursList";
    }


    @RequestMapping(value = "qryHisHoursList")
    public String qryHisHoursList(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response){
        Page<SoHours> page = new Page<SoHours>();
         model.addAttribute("page", page);
        return "modules/ac/acHisHoursList";
    }


    @RequestMapping(value = "qryOwnHoursList")
    public String qryOwnHoursList(SoHours soHours,Model model,HttpServletRequest request,HttpServletResponse response){
        soHours.setUserId(UserUtils.getUser().getId());
        soHours.setType(Constants.LEARN_HOURS_TYPE_LESSON); //类型：0-减免申请 1-课程学时
        Page<SoHours> page = hoursService.findOwnAuditList(new Page<SoHours>(request, response), soHours);
        model.addAttribute("page", page);
        return "modules/ac/acOwnHoursList";
    }


    @RequestMapping(value = "qryHisReduceHoursList")
    public String qryReduceList(SoHours soHours,String auditLevel,Model model,HttpServletRequest request,HttpServletResponse response){
        soHours.setType(Constants.LEARN_HOURS_TYPE_REDUCE); //类型：0-减免申请 1-课程学时
        Page<SoHours> page = hoursService.findAuditedList(new Page<SoHours>(request, response), soHours);
        model.addAttribute("page", page);
        return "modules/ac/acHisReduceHoursList";
    }

    @RequestMapping(value = "auditReduceHours")
    public String auditReduceHours(SoHours soHours,RedirectAttributes redirectAttributes){
        hoursService.auditReduceHours(soHours);
        addMessage(redirectAttributes, "审核成功！");
        return "redirect:"+ Global.getAdminPath()+"/hours/auditReduceList/?repage";
    }

    @RequestMapping(value = "batchReduceAudit")
    public String batchAssess(String[] seqs,String auditRemark, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        for(String id:seqs){
            hoursService.audit(new Long(id),"1",auditRemark);
        }
        addMessage(redirectAttributes,"审核成功");
        return "redirect:"+ Global.getAdminPath()+"/invoice/list?repage";
    }

    /**
     * 导航附件上传页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "acReduceAttachment")
    public String cpAttachment(String soid,String appId,String soType,String pageModule,SoAttachment soAttachment, HttpServletRequest request,Model model) {
        SoAttachment attach = new SoAttachment();
        attach.setSoid(soid);
        attach.setSoType(soType);
        List<SoAttachment> attachments = attachmentMapper.findBySelective(attach);
        soAttachment.setSoid(soid);
        soAttachment.setAppId(appId);
        soAttachment.setSoType(soType);
        soAttachment.setPageModule(pageModule);
        model.addAttribute("soAttachment",soAttachment) ;

        if(attachments.size() > 0) {
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
                attachment.setDeleteUrl(request.getContextPath()+Global.getAdminPath() + "/file/delete/"+attachment.getId());
                attachment.setDeleteType("DELETE");
            }
            model.addAttribute("files",attachments) ;
        }
        return "modules/file/upload";
    }

    @RequestMapping(value = "auditReduceDetail")
    public String auditDetail(SoHours soHours, HttpServletRequest request,Model model) {
       // List<SoAudit> soAudits = auditMapper.selectBySoid(soHours.getSoid());
        List<SoAudit> soAudits = auditMapper.findBySoidAndSoHoursId(soHours.getSoid(),soHours.getId());

        model.addAttribute("soAudits",soAudits);

        SoAttachment attach = new SoAttachment();
        attach.setSoid(soHours.getSoid());
        attach.setSoType(Constants.SO_TYPE_REDUCE_HOURS);

        List<SoAttachment> attachments = attachmentMapper.findBySelective(attach);
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
            }
            model.addAttribute("files", attachments);
        }

        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(soHours.getUserId());
        model.addAttribute("servAcInfo", servAcInfo);
        return "modules/ac/auditReduceDetail";
    }


    @RequestMapping(value = "auditHisReduceDetail")
    public String auditHisReduceDetail(SoHours soHours, HttpServletRequest request,Model model) {
        // List<SoAudit> soAudits = auditMapper.selectBySoid(soHours.getSoid());
        List<SoAudit> soAudits = auditMapper.findBySoidAndSoHoursId(soHours.getSoid(),soHours.getId());

        model.addAttribute("soAudits",soAudits);

        SoAttachment attach = new SoAttachment();
        attach.setSoid(soHours.getSoid());
       // attach.setSoType(Constants.SO_TYPE_REDUCE_HOURS);

        List<SoAttachment> attachments = attachmentMapper.findHisBySelective(attach);
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
            }
            model.addAttribute("files", attachments);
        }

        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(soHours.getUserId());
        model.addAttribute("servAcInfo", servAcInfo);
        return "modules/ac/auditHisReduceDetail";
    }

    @RequestMapping(value = "auditHoursDetail")
    public String auditHoursDetail(SoHours soHours, HttpServletRequest request,Model model) {
        List<SoAudit> soAudits = auditMapper.findBySoidAndSoHoursId(soHours.getSoid(),soHours.getId());
        model.addAttribute("soAudits",soAudits);

        SoAttachment attach = new SoAttachment();
        attach.setSoid(soHours.getSoid());
        attach.setAppId(soHours.getCourseId() + "");
        attach.setSoType(soHours.getLessonId() + "");
        attach.setPass(Constants.LEARN_HOURS_AUDIT_COMMIT);

        List<SoAttachment> attachments = attachmentMapper.findBySelective(attach);
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
            }
            model.addAttribute("files", attachments);
        }
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(soHours.getUserId());
        model.addAttribute("servAcInfo", servAcInfo);

        return "modules/ac/auditHoursDetail";
    }


    @RequestMapping(value = "auditHisHoursDetail")
    public String auditHisHoursDetail(SoHours soHours, HttpServletRequest request,Model model) {
        List<SoAudit> soAudits = auditMapper.findBySoidAndSoHoursId(soHours.getSoid(),soHours.getId());
        model.addAttribute("soAudits",soAudits);

        SoAttachment attach = new SoAttachment();
        attach.setSoid(soHours.getSoid());
        attach.setAppId(soHours.getCourseId() + "");
        attach.setSoType(soHours.getLessonId() + "");
        //attach.setPass(Constants.LEARN_HOURS_AUDIT_COMMIT);

        List<SoAttachment> attachments = attachmentMapper.findHisBySelective(attach);
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
            }
            model.addAttribute("files", attachments);
        }
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(soHours.getUserId());
        model.addAttribute("servAcInfo", servAcInfo);

        return "modules/ac/auditHisHoursDetail";
    }
}
