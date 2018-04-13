package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.utils.CacheUtils;
import com.zhongxin.cims.common.utils.FileUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.dao.SoPlanMapper;
import com.zhongxin.cims.modules.ac.entity.*;
import com.zhongxin.cims.modules.ac.service.*;
import com.zhongxin.cims.modules.common.dao.SealMapper;
import com.zhongxin.cims.modules.common.entity.Seal;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
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
@RequestMapping(value = "${adminPath}/video")
public class VideoController extends BaseController {

    @Autowired
    private PlanService planService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private LessonService lessonService;

    @Autowired
    private SoPlanMapper soPlanMapper;

    @Autowired
    private SealMapper sealMapper;

    @Autowired
    private VideoService videoService;
    private String fileVideoDirectory = Global.getVideoDir();
    private String fileSoImageDirectory = Global.getSoImageDir();



    @RequestMapping(value = "init")
    public String init(String soid,String courseId,String lessonId,String lessonName,String lessonInfo,HttpServletRequest request, Model model,RedirectAttributes redirectAttributes){
        // 先检查是否存在正在进行的学习记录
        model.addAttribute("soid",soid);
        model.addAttribute("courseId",courseId);
        model.addAttribute("lessonId",lessonId);
        model.addAttribute("lessonName",lessonName);
        model.addAttribute("lessonInfo",lessonInfo);
        return  "modules/flashPlayer/flashPlayer";
    }

    @RequestMapping(value = "initAdmin")
    public String initAdmin(String soid,String courseId,String lessonId,String lessonName,String lessonInfo,HttpServletRequest request, Model model){
        model.addAttribute("soid",soid);
        model.addAttribute("courseId",courseId);
        model.addAttribute("lessonId",lessonId);
        model.addAttribute("lessonName",lessonName);
        model.addAttribute("lessonInfo",lessonInfo);
        return  "modules/flashPlayer/adminFlashPlayer";
    }



    @RequestMapping(value = "video/{id}", method = RequestMethod.GET)
    public void lessonVideo(HttpServletResponse response, @PathVariable Long id,Model model) {
        Lesson lesson = lessonService.findByPrimaryKey(id);
        File videoFile = new File(lesson.getFileUrl());
        response.setContentType(lesson.getFileType());
        model.addAttribute("lesson",lesson);
        try {
            InputStream is = new FileInputStream(videoFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("视频播放失败 "+id, e);
        }
    }

    @RequestMapping(value = "adminVideo/{id}", method = RequestMethod.GET)
    public void adminVideo(HttpServletResponse response, @PathVariable Long id,Model model) {
        Lesson lesson = lessonService.findByLessonId(id);
        File videoFile = new File(lesson.getFileUrl());
        response.setContentType(lesson.getFileType());
        model.addAttribute("lesson",lesson);
        try {
            InputStream is = new FileInputStream(videoFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("视频播放失败 "+id, e);
        }
    }

    /**
     * 每次开始播放时检查是否有未播放完成图片存在，若存在先删除
     * @param response
     * @param request
     */
    @RequestMapping(value = "checkLockHourSvc")
    public String checkLockHourSvc(HttpServletRequest request,HttpServletResponse response,Model model) throws ServletException, IOException {
        //获取参数

        String courseId = request.getParameter("courseId");
        String soid = request.getParameter("soid");
        String lessonId = request.getParameter("lessonId");
        boolean flag = false;
        System.out.println("开始检查申报单：" + soid + " 课程：" + courseId + " 课件：" + lessonId + "是否存在锁定记录。开始检查时间：" + new Date());
         flag = videoService.checkLockHourSvc(soid);
        System.out.println("结束检查申报单：" + soid + " 课程：" + courseId + " 课件：" + lessonId + "是否存在锁定记录。结束检查时间：" + new Date()+"检查结果:"+flag);

        Map map = new HashMap();
        if(flag){
            map.put("flag", "1");
        }else{
            map.put("flag","0");
        }

        return JsonMapper.nonDefaultMapper().toJson(map);

    }
    /**
     * 每次开始播放时检查是否有未播放完成图片存在，若存在先删除
     * @param response
     * @param request
     */
    @RequestMapping(value = "removeHourSvc")
    public String removeHourSvc(HttpServletRequest request,HttpServletResponse response,Model model) throws ServletException, IOException {
        //获取参数

        String courseId = request.getParameter("courseId");
        String soid = request.getParameter("soid");
        String lessonId = request.getParameter("lessonId");

        System.out.println("开始检查申报单：" + soid + " 课程：" + courseId + " 课件：" + lessonId + "未完成学时无效学时、课程、图片检查。开始检查时间：" + new Date());

        //每次抓取图片的时候将之前已提交状态学时、课件、图片设置为无效状态
        SoHours soHours = new SoHours();
        soHours.setSoid(soid);
        soHours.setCourseId(new Long(courseId));
        soHours.setLessonId(new Long(lessonId));
        videoService.removeHours(soHours);
        System.out.println("申报单：" + soid + " 课程：" + courseId + " 课件：" + lessonId + "未完成学时无效图片清除完成。清除时间：" + new Date());



        Map map = new HashMap();
        map.put("flag", "0");
        return JsonMapper.nonDefaultMapper().toJson(map);

    }


    /**
     * 二级建造师图片获取
     * @param response
     * @param request
     */
    @RequestMapping(value = "videoImageUpload")
    public void videoImageUpload(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        //获取参数
        String currentVideoTime = request.getParameter("videoCurrentTime");
        if(currentVideoTime!=null && !"0".equals(currentVideoTime)){
            int c  = currentVideoTime.indexOf(".");
            if(c != -1){
                currentVideoTime = currentVideoTime.substring(0, currentVideoTime.indexOf("."));
            }

        }
        String duration =request.getParameter("duration");

        if(duration!=null && !"".equals(duration)&& !"0".equals(duration)){
            int i  = duration.indexOf(".");
            if(i != -1){
               duration = duration.substring(0, duration.indexOf("."));
            }
        }
        int fileId = SeqUtils.getNextValue("FILE_SEQ");
        String courseId = request.getParameter("courseId");
        String soid = request.getParameter("soid");
        String lessonId = request.getParameter("lessonId");
        String imageName = fileId +"-"+currentVideoTime+".png";
       // fileVideoDirectory = fileVideoDirectory+soid+"/"+courseId+"/"+lessonId;
        String filepath =fileSoImageDirectory+soid+"/"+courseId+"/"+lessonId+"/";
        String file = filepath+fileId +"-"+currentVideoTime+".png";


        System.out.println("开始为申报单：" + soid + " 课程：" + courseId + " 课件：" + lessonId + "生成学时图片。图片编号：" + imageName + "路径：" + file + "抓取时间：" + new Date());

        //将抓图图片存放磁盘
       /* File thumbnailFile = new File(file);
        ImageIO.write(thumbnail, "png", thumbnailFile);*/

        InputStream inputStream = request.getInputStream();
        FileUtils.createDirectory(filepath);
        FileOutputStream outputStream = new FileOutputStream(new File(file));
        int formlength = request.getContentLength();
        byte[] formcontent = new byte[formlength];
        int totalread = 0;
        int nowread = 0;
        while (totalread < formlength) {
            nowread = inputStream.read(formcontent, totalread, formlength);
            totalread += nowread;
        }
        outputStream.write(formcontent);
        outputStream.flush();
        outputStream.close();
        inputStream.close();

        //将抓图图片信息入库
        SoAttachment image = new SoAttachment();
         image.setName(imageName);
         image.setSoid(soid);
         image.setAppId(courseId);
         image.setSoType(lessonId);
         image.setThumbnailFilename(imageName);
         image.setNewFilename(imageName);
         image.setSize(new Long(duration));
         image.setThumbnailSize(new Long(currentVideoTime));
         image.setContentType(Constants.IMAGE_TYPE);
         image.setPath(filepath);
         image.setSts(Constants.IMAGE_STS_COMMMIT);
       videoService.saveImage(image);


 }

    @RequestMapping(value = {"findVideoImage"})
    public String findVideoImage(String soid,Long courseId,Long lessonId, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        List<SoAttachment> attachments =videoService.findAuditVideoImageBySoid(soid,courseId+"",lessonId+"");
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
            }

            model.addAttribute("files",attachments);
        }
        SoHours soHours = new SoHours();
        soHours.setSoid(soid);
        soHours.setCourseId(courseId);
        soHours.setLessonId(lessonId);
        model.addAttribute("soHours",soHours);
        return "modules/ac/acVideoImagePage";
    }

    @RequestMapping(value = {"confirmVideoHour"})
    public String confirmVideoHour(SoHours soHours, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        if (soHours==null){
            addMessage(redirectAttributes, "温馨提示：学时确认失败，学时信息不允许为空！");
            return "redirect:" + Global.getAdminPath()+"/video/findConfirmVideoImage/?repage";
        }

        // 学习完成将正在学习标记清除
        SoPlan soPlan = soPlanMapper.findBySoid(soHours.getSoid());
        if(soPlan!=null) {
            int playCount = sealMapper.selectByUserId(soPlan.getUserId(),soPlan.getSoid());
            if(playCount>1){
                addMessage(redirectAttributes, "温馨提示：存在多次学习记录，本次学习将不允许进行学时确认，请于一小时后再重新学习，再次学习请勿同时学习多个课程。");
                return "redirect:" + Global.getAdminPath()+"/video/acMoreViewConfirmForm?soid="+soPlan.getSoid()+"&courseId="+soHours.getCourseId()+"&lessonId="+soHours.getLessonId()+"&repage";
            }else if (playCount ==1){
                videoService.removeExistsPlayVideo(soPlan.getUserId(), soPlan.getSoid());
                logger.debug("本次学习记录：userid：" + soPlan.getUserId() + "soid：" + soPlan.getSoid() + "清除成功!可以继续学习!");

            }
        }
        //学时确认前检查-检查已提交确认信息
        boolean confirmFlag =videoService.checkVideoConfirmHour(soHours);
        if(!confirmFlag){
            addMessage(redirectAttributes, "温馨提示：已经存在本课件学时确认信息，在审核未完成前不允许再次确认。");
            return "redirect:" + Global.getAdminPath()+"/video/findConfirmVideoImage?soid="+soHours.getSoid()+"&courseId="+soHours.getCourseId()+"&lessonId="+soHours.getLessonId()+"&repage";
        }
        //学时确认前检查-检查已通过审核
        boolean auditedFlag =videoService.checkVideoAuditHour(soHours);
        if(!auditedFlag){
            addMessage(redirectAttributes, "温馨提示：已经存在本课件学时审核通过信息，已正式计入学时，不允许再次确认学时。");
            return "redirect:" + Global.getAdminPath()+"/video/findConfirmVideoImage?soid="+soHours.getSoid()+"&courseId="+soHours.getCourseId()+"&lessonId="+soHours.getLessonId()+"&repage";
        }
        //学时确认
        videoService.confirmVideoHour(soHours);
        addMessage(redirectAttributes, "温馨提示：您的本次申报："+soHours.getSoid()+"，学习课程："+ UserUtils.getCourseName(soHours.getCourseId().toString())+"，学习课件：" + UserUtils.getLessonName(soHours.getLessonId().toString())+"已确认成功，并已成功提交审核。");
        return "redirect:" + Global.getAdminPath()+"/video/findVideoImage?soid="+soHours.getSoid()+"&courseId="+soHours.getCourseId()+"&lessonId="+soHours.getLessonId()+"&repage";
    }

    @RequestMapping(value = "removeVideoHour")
    public String removeVideoHour(SoHours soHours,HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes){
        //学时确认
        videoService.removeHours(soHours);


        addMessage(redirectAttributes, "温馨提示：您的本次申报："+soHours.getSoid()+"，学习课程："+ UserUtils.getCourseName(soHours.getCourseId().toString())+"，学习课件：" + UserUtils.getLessonName(soHours.getLessonId().toString())+"已作废成功。作废后本次学习不计入学时，需重新学习。");
       // return "redirect:" + Global.getAdminPath()+"/video/findConfirmVideoImage?soid="+soHours.getSoid()+"&courseId="+soHours.getCourseId()+"&lessonId="+soHours.getLessonId()+"&repage";
        model.addAttribute("soHours",soHours);
        return "modules/ac/acVideoRemovePage";
    }


    @RequestMapping(value = {"findConfirmVideoImage"})
    public String findConfirmVideoImage(String soid, Long courseId,Long lessonId,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        List<SoAttachment> attachments =videoService.findConfirmVideoImageBySoid(soid,courseId+"",lessonId+"");
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/comThumbnail/" + attachment.getId());
            }

            model.addAttribute("files",attachments);
        }
        SoHours soHours = new SoHours();
        soHours.setSoid(soid);
        soHours.setCourseId(courseId);
        soHours.setLessonId(lessonId);
        model.addAttribute("soHours",soHours);
        return "modules/ac/acVideoConfirmForm";
    }


    @RequestMapping(value = {"acMoreViewConfirmForm"})
    public String acMoreViewConfirmForm(String soid, Long courseId,Long lessonId,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        List<SoAttachment> attachments =videoService.findConfirmVideoImageBySoid(soid,courseId+"",lessonId+"");
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/comThumbnail/" + attachment.getId());
            }

            model.addAttribute("files",attachments);
        }
        SoHours soHours = new SoHours();
        soHours.setSoid(soid);
        soHours.setCourseId(courseId);
        soHours.setLessonId(lessonId);
        model.addAttribute("soHours",soHours);
        return "modules/ac/acMoreViewConfirmForm";
    }


    @RequestMapping(value = {"syncVideoSvc"})
    public String syncHoursSvc(String soid, Long courseId,Long lessonId, String startTime, String finishTime,String videoTime,String playedTime,String imgNum,
                               HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {

      //  Date startDate = DateUtils.parseDate(startTime);
        //Date finishDate = DateUtils.parseDate(finishTime);
       //参数校验
       if(soid==null || "".equals(soid)){
           addMessage(redirectAttributes, "温馨提示:申报单位不允许为空，不能录入学时信息，请联系管理员！");
           return "modules/ac/acVideoImagePage";
       }
        if(courseId==null || "".equals(courseId)){
            addMessage(redirectAttributes, "温馨提示:课程编号不允许为空，不能录入学时信息，请联系管理员！");
            return "modules/ac/acVideoImagePage";
        }
        if(lessonId==null || "".equals(lessonId)){
            addMessage(redirectAttributes, "温馨提示:课件编号不允许为空，不能录入学时信息，请联系管理员！");
            return "modules/ac/acVideoImagePage";
        }
        if(videoTime==null || "".equals(videoTime)){
            addMessage(redirectAttributes, "温馨提示:课件总时长不允许为空，不能录入学时信息，请联系管理员！");
            return "modules/ac/acVideoImagePage";
        }
        if(playedTime==null || "".equals(playedTime)){
            addMessage(redirectAttributes, "温馨提示:课件播放时间不允许为空，不能录入学时信息，请联系管理员！");
            return "modules/ac/acVideoImagePage";
        }
        if(imgNum==null || "".equals(imgNum) ||imgNum=="0" ){
            addMessage(redirectAttributes, "温馨提示:抓取图片数量为0，不能录入学时信息，请联系管理员！");
            return "modules/ac/acVideoImagePage";
        }
        Long planId = null;
        String userId = null;
        SoPlan soPlan =  planService.findBySoid(soid);
        if(soPlan !=null){
            planId=soPlan.getPlanId();
            userId = soPlan.getUserId();

            int playCount = sealMapper.selectByUserId(soPlan.getUserId(),soPlan.getSoid());
            if(playCount>1){
                //将本次学习的照片删除
                addMessage(redirectAttributes, "温馨提示：存在多次学习记录，本次学习将不允许进行学时确认，请于一小时后再重新学习，再次学习请勿同时学习多个课程。");
                return "redirect:" + Global.getAdminPath()+"/video/acMoreViewConfirmForm?soid="+soid+"&courseId="+courseId+"&lessonId="+lessonId+"&repage";
            }

        }


        //检查是否存在已提交确认包含待审核及已审核学时，若存在则本次学习不计入学时。
        SoHours checkHours = new SoHours();
        checkHours.setSoid(soid);
        checkHours.setCourseId(courseId);
        checkHours.setLessonId(lessonId);
        boolean checkFlag = videoService.checkVideoExistsHour(checkHours);
        //学习信息入库
        if(checkFlag){
            videoService.syncHoursSvc(planId,soid,courseId,lessonId,videoTime,playedTime,startTime,finishTime,imgNum);
        }else{
            System.out.println("checkflag："+checkFlag);
            addMessage(redirectAttributes, "已存在本课件学习确认并已提交审核记录，无需再次进行学时确认！");
        }

       //进入学时确认页面
        return "redirect:" + Global.getAdminPath()+"/video/findConfirmVideoImage?soid="+soid+"&courseId="+courseId+"&lessonId="+lessonId+"&repage";

    }

}
