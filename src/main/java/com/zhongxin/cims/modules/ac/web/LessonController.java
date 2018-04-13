package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.dao.CourseCenterMapper;
import com.zhongxin.cims.modules.ac.dao.CourseMapper;
import com.zhongxin.cims.modules.ac.dao.LessonMapper;
import com.zhongxin.cims.modules.ac.entity.Course;
import com.zhongxin.cims.modules.ac.entity.CourseCenter;
import com.zhongxin.cims.modules.ac.entity.Lesson;
import com.zhongxin.cims.modules.ac.entity.Plan;
import com.zhongxin.cims.modules.ac.service.CourseCenterService;
import com.zhongxin.cims.modules.ac.service.LessonService;
import com.zhongxin.cims.modules.sys.utils.PlanUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.List;

/**
 * Created by lqyu_773 on 2014/8/30.
 */
@Controller
@RequestMapping(value = "${adminPath}/lesson")
public class LessonController extends BaseController {
    private String fileUploadDirectory = Global.getVideoDir();

    @Autowired
    private LessonService lessonService;

    @Autowired
    private CourseMapper courseMapper;

    @Autowired
    private LessonMapper lessonMapper;

    @Autowired
    private CourseCenterMapper courseCenterMapper;

    @Autowired
    private CourseCenterService courseCenterService;

    @ModelAttribute
    public Lesson get(@RequestParam(required=false) Long lessonId) {
        if (lessonId != null && !"".equals(lessonId)){
            Lesson lesson = lessonMapper.selectByPrimaryKey(lessonId);
            return lesson;
        }else{
            return new Lesson();
        }
    }
    @RequiresPermissions("lesson:edit")
    @RequestMapping(value = "lessonForm")
    public String lessonForm(Lesson lesson,Model model){
        if (lesson.getCourseId() != null) {
            CourseCenter courseCenter = courseCenterMapper.selectByPrimaryKey(lesson.getCourseId());
            lesson.setCourseCenter(courseCenter);
            model.addAttribute("disabled","true");
        }
        if (lesson.getCourseCenter() == null) {

            CourseCenter courseCenter = new CourseCenter();
            lesson.setCourseCenter(courseCenter);
        }


        model.addAttribute("lesson", lesson);
        return "modules/ac/course/lessonForm";
    }


    @RequiresPermissions("lesson:edit")
    @RequestMapping(value = "lessonModifyForm")
    public String lessonModifyForm(String lessonId,Model model){

        Lesson lesson = lessonMapper.selectByLessonId(Long.valueOf(lessonId));
         model.addAttribute("lesson", lesson);
        return "modules/ac/course/lessonModifyForm";
    }

    @RequestMapping(value = "list")
    public String list(Lesson lesson,HttpServletRequest request,HttpServletResponse response,Model model) {

        if (lesson.getPlan() == null) {
            Plan plan = new Plan();
            lesson.setPlan(plan);
        }
        model.addAttribute("planList", PlanUtils.getAllPlanByYear(lesson.getPlan().getYear()));
        if (lesson != null && lesson.getPlan() != null && lesson.getPlan().getYear() != null) {
            model.addAttribute("courseList",courseMapper.findByPlanId(lesson.getPlan().getPlanId()));
        }

        Page<Lesson> page = lessonService.list(new Page<Lesson>(request,response),lesson);
        model.addAttribute("page",page);
        return "modules/ac/course/lessonList";
    }

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public @ResponseBody
    Map upload(MultipartHttpServletRequest request, HttpServletResponse response) {
        logger.debug("uploadPost called");

        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf;
        Map map = new HashMap();
        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            logger.debug("Uploading {}", mpf.getOriginalFilename());

            String newFilenameBase = UUID.randomUUID().toString();
            String originalFileExtension = mpf.getOriginalFilename().substring(mpf.getOriginalFilename().lastIndexOf("."));
            String newFilename = newFilenameBase + originalFileExtension;
            String storageDirectory = fileUploadDirectory;
            String contentType = mpf.getContentType();

            File newFile = new File(storageDirectory + "/" + newFilename);
            try {
                mpf.transferTo(newFile);
            } catch(IOException e) {
                logger.error("上传文件失败： "+mpf.getOriginalFilename(), e);
            }
            map.put("file",newFile);
        }

        return map;
    }

    @RequiresPermissions("lesson:edit")
    @RequestMapping(value = "save")
    public String save(Lesson lesson,Model model,RedirectAttributes redirectAttributes,HttpServletRequest request) {
        if (!beanValidator(model, lesson)){
            return lessonForm(lesson, model);
        }
        if (lesson.getCourseCenter() != null && lesson.getCourseId() == null) {
            lesson.setCourseId(lesson.getCourseCenter().getCourseId());
        }
        lessonService.save(lesson);
        CourseCenter courseCenter = courseCenterService.findByPK(lesson.getCourseId());
        model.addAttribute("course",courseCenter);
        addMessage(redirectAttributes, "保存成功！");
        return "modules/ac/courseDetail";
    }


    @RequiresPermissions("lesson:edit")
    @RequestMapping(value = "modify")
    public String modify(Lesson lesson,Model model,RedirectAttributes redirectAttributes,HttpServletRequest request) {
        lesson.setLessonId(lesson.getLessonIdTmp());
        lessonService.modify(lesson);
        CourseCenter courseCenter = courseCenterService.findByPK(lesson.getCourseId());
        model.addAttribute("course",courseCenter);
        addMessage(redirectAttributes, "修改成功！");
        return "modules/ac/courseDetail";
    }

    @RequiresPermissions("lesson:edit")
    @RequestMapping(value = "delete")
    public String delete(Lesson lesson,RedirectAttributes redirectAttributes,Model model) {
        lessonService.delete(lesson);
        CourseCenter courseCenter = courseCenterService.findByPK(lesson.getCourseId());
        model.addAttribute("course",courseCenter);
        addMessage(redirectAttributes,"删除成功！");
        return "modules/ac/courseDetail";
/*
        return "redirect:"+ Global.getAdminPath()+"/lesson/list/?repage";
*/
    }


    @RequiresPermissions("lesson:edit")
    @RequestMapping(value = "deleteByLessonId")
    public String deleteByLessonId(String lessonId,RedirectAttributes redirectAttributes,Model model) {
        Lesson lesson = lessonMapper.selectByLessonId(Long.valueOf(lessonId));
        Long courseId = null;
        if(lesson!=null){
             lessonService.deleteByLessonId(Long.valueOf(lessonId));
            courseId = lesson.getCourseId();
        }

        CourseCenter courseCenter = courseCenterService.findByPK(courseId);
        model.addAttribute("course",courseCenter);
        addMessage(redirectAttributes,"删除成功！");
        return "modules/ac/courseDetail";
/*
        return "redirect:"+ Global.getAdminPath()+"/lesson/list/?repage";
*/
    }





}
