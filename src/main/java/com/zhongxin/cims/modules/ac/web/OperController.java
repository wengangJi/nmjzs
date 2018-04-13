package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.utils.FileUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.*;
import com.zhongxin.cims.modules.ac.service.CourseService;
import com.zhongxin.cims.modules.ac.service.LessonService;
import com.zhongxin.cims.modules.ac.service.PlanService;
import com.zhongxin.cims.modules.ac.service.VideoService;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 二级建造师Controller
 * @author jiwg
 * @version 2014-06-12
 */
@Controller
@RequestMapping(value = "${adminPath}/oper")
public class OperController extends BaseController {

    @Autowired
    private PlanService planService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private LessonService lessonService;

    @Autowired
    private SoAttachmentMapper attachmentMapper;

    @Autowired
    private VideoService videoService;
    private String fileVideoDirectory = Global.getVideoDir();
    private String fileSoImageDirectory = Global.getSoImageDir();



    @RequestMapping(value = "operSoPlanList")
    public String operSoPlanList(SoPlanEntity soPlanEntity ,HttpServletRequest request,HttpServletResponse response, Model model){
        Page<SoPlan> page = planService.findListBySoPlanEntitys(new Page<SoPlan>(request, response), soPlanEntity);
        model.addAttribute("page",page);
        return "modules/ac/operSoPlanList";
    }

    @RequestMapping(value = "operProcess")
    public String operProcess(String soid,Long planId,HttpServletRequest request,HttpServletResponse response, Model model){
        List<Course> courses= courseService.findProcessHoursBySoid(soid, planId);
        if(courses!=null && courses.size()>0){
            for(Course course:courses){
                course.setTmpSoid(soid);
            }
        }
        model.addAttribute("courses",courses);
        return "modules/ac/operProcess";
    }


    @RequestMapping(value = {"operVideoSvc"})
    public String operVideoSvc(String soid, Long courseId,Long lessonId, String startTime, String finishTime,String videoTime,String playedTime,String imgNum,
                               HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {

        //  Date startDate = DateUtils.parseDate(startTime);
        //Date finishDate = DateUtils.parseDate(finishTime);
        //参数校验


        Long planId = null;
        SoPlan soPlan = planService.findBySoid(soid);
        if(soPlan!=null){
           planId = soPlan.getPlanId();
        }
       if(courseId==null || "".equals(courseId)){
            addMessage(redirectAttributes, "温馨提示:课程编号不允许为空，不能录入学时信息，请联系管理员！");
            return "redirect:" + Global.getAdminPath()+"/oper/operProcess?soid="+soid+"&planId="+planId+"&repage";
        }
        if(lessonId==null || "".equals(lessonId)){
            addMessage(redirectAttributes, "温馨提示:课件编号不允许为空，不能录入学时信息，请联系管理员！");
            return "redirect:" + Global.getAdminPath()+"/oper/operProcess?soid="+soid+"&planId="+planId+"&repage";
        }

        //先检查图片是否上传

        List<SoAttachment> soAttachments = attachmentMapper.selectAuditBySoid(soid,String.valueOf(courseId),String.valueOf(lessonId));
        if(soAttachments==null || soAttachments.size()==0){
            addMessage(redirectAttributes, "您还未上传该课程图片，请上传后再生成学时！");
            return "redirect:" + Global.getAdminPath()+"/oper/operProcess?soid="+soid+"&planId="+planId+"&repage";
        }

        //检查是否存在已提交确认包含待审核及已审核学时，若存在则本次学习不计入学时。
        SoHours checkHours = new SoHours();
        checkHours.setSoid(soid);
        checkHours.setCourseId(courseId);
        checkHours.setLessonId(lessonId);
        boolean checkFlag = videoService.checkVideoExistsHour(checkHours);

        int maxSize =0;
        maxSize =attachmentMapper.selectMaxBySoid(soid,courseId.toString(),lessonId.toString());
        if(videoTime ==null || "".equals(videoTime)){
            videoTime =String.valueOf(maxSize);
        }
        if(playedTime ==null || "".equals(playedTime)){
            playedTime =String.valueOf(maxSize);
        }
        if(imgNum ==null || "".equals(imgNum)){
            imgNum ="10";
        }

        if(!checkFlag){
            System.out.println("checkflag："+checkFlag);
            addMessage(redirectAttributes, "已存在本课件学习确认并已提交审核记录，无需再次生成学时！");
        }
        //学习信息入库
        if(checkFlag){
            videoService.operSyncHoursSvc(soid,courseId,lessonId,videoTime,playedTime,startTime,finishTime,imgNum);
        }

        return "redirect:" + Global.getAdminPath()+"/oper/operProcess?soid="+soid+"&planId="+planId+"&repage";

    }



    /**
     * 导航附件上传页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "operAttachment")
    public String operAttachment(String soid,String appId,String soType,String pageModule,SoAttachment soAttachment, HttpServletRequest request,Model model) {
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
        return "modules/file/operUpload";
    }



}
