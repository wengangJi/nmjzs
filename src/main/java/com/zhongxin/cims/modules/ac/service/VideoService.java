package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.config.PropertiesUtil;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.modules.ac.dao.*;
import com.zhongxin.cims.modules.ac.entity.*;
import com.zhongxin.cims.modules.common.dao.SealMapper;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.entity.Seal;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.PlanUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by jwg on 2014/8/30.
 */
@Component
@Transactional(readOnly = true)
public class VideoService extends BaseService {
    @Autowired
    private SoAttachmentMapper soAttachmentMapper;
    @Autowired
    private SoHoursMapper soHoursMapper;
    @Autowired
    private SoLessonMapper soLessonMapper;
    @Autowired
    private LessonMapper lessonMapper;
    @Autowired
    private SoPlanMapper soPlanMapper;
    @Autowired
    private SealMapper sealMapper;


    /**
     * 存储抓取视频图片
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public void saveImage(SoAttachment image) { soAttachmentMapper.insert(image);  }


    /**
     * 作废处理
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    //逻辑 每次播放时清除没有经过提交确认及审核通过的无效视频数据
    @Transactional(readOnly = false)
    public void removeHours(SoHours soHours) {
        int imageCount = soAttachmentMapper.selectByVideo(soHours.getSoid(),soHours.getCourseId()+"",soHours.getLessonId()+"");
        if(imageCount!=0){
            soAttachmentMapper.removeImage(soHours.getSoid(),String.valueOf(soHours.getCourseId()),String.valueOf(soHours.getLessonId()));
        }
        int hoursCount = soHoursMapper.selectByVideo(soHours.getSoid(),soHours.getCourseId(),soHours.getLessonId());
        if(hoursCount!=0){
            soHoursMapper.removeHours(soHours.getSoid(),soHours.getCourseId(),soHours.getLessonId());
        }
        int lessonCount = soLessonMapper.selectByVideo(soHours.getSoid(),soHours.getLessonId());
        if(lessonCount!=0){
            soLessonMapper.removeLesson(soHours.getSoid(),soHours.getLessonId());
        }
        SoPlan soPlan = soPlanMapper.findBySoid(soHours.getSoid());
        if(soPlan!=null){
           /* int playCount = sealMapper.selectByUserId(soPlan.getUserId(),soPlan.getSoid());
            if(playCount==0){*/
                String remoteServerIp = "" ;
                String notify_url = PropertiesUtil.readData(Global.getUrlAliconfig(), "notify_url") ;
                if(notify_url !=null && !"".equals(notify_url)){
                    if("http://www.nmcia.org:8001/nmjzs/return_url.jsp".equals(notify_url)){
                        remoteServerIp = "10.15.16.155";
                    }else if("http://www.nmcia.org:8002/nmjzs/return_url.jsp".equals(notify_url)){
                        remoteServerIp = "10.15.16.159";
                    }else if("http://www.nmcia.org:8003/nmjzs/return_url.jsp".equals(notify_url)){
                        remoteServerIp = "10.15.16.163";
                    }else if("http://www.nmcia.org:8004/nmjzs/return_url.jsp".equals(notify_url)){
                        remoteServerIp = "10.15.16.167";
                    }
                }

                Seal seal = new Seal();
                seal.setSealId(soPlan.getUserId());
                seal.setLocalId(soPlan.getSoid());
                seal.setSealName(String.valueOf(soHours.getCourseId()));
                seal.setContentType(String.valueOf(soHours.getLessonId()));
                seal.setName(remoteServerIp);
                seal.setSts("0");
                seal.setCreateDate(new Date());
                sealMapper.insert(seal);
            /*}*/
        }

     }


    @Transactional(readOnly = true)
    public boolean checkLockHourSvc(String soid) {

        SoPlan soPlan = soPlanMapper.findBySoid(soid);
        if(soPlan!=null){
            int playCount = sealMapper.selectByUserId(soPlan.getUserId(),soPlan.getSoid());
            if(playCount>0){
               return true;
            }
        }
        return false;

    }

    public boolean findExistsPlayVideo(String userId, String soid){
        boolean flag = false;
        int playCount = sealMapper.selectByUserId(userId,soid);
        if(playCount!=0){
            flag= true;
        }
        return flag;
    }
    @Transactional(readOnly = false)
    public void removeExistsPlayVideo(String userId, String soid){
         sealMapper.removeByUserId(userId,soid);
    }

    /**
     * 根据申报单号获取视频图片
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public List<SoAttachment> findVideoImageBySoid(String soid){ return   soAttachmentMapper.selectBySoid(soid); }


    /**
     * 根据申报单号获取已审核视频图片
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public List<SoAttachment> findAuditVideoImageBySoid(String soid,String courseId,String lessonId){ return   soAttachmentMapper.selectAuditBySoid(soid,courseId,lessonId); }


    /**
     * 根据申报单号获取待确认视频图片
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public List<SoAttachment> findConfirmVideoImageBySoid(String soid,String courseId,String lessonId){ return   soAttachmentMapper.selectConfirmBySoid(soid,courseId,lessonId); }
    /**
     * 视频播放完毕同步接口
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public void syncHoursSvc(Long planId,String soid,Long courseId,Long lessonId,String videoTime,String playedTime, String startTime,String finishTime,String sendCount){
      //同步逻辑 每次在视频播放完自动同步，同步状态为初始提交状态，若不进行学时确认则在下次观看视频时自动清除
      //同步 so_lesson

        int a = videoTime.indexOf(".");
        if(a != -1){
            videoTime = videoTime.substring(0, videoTime.indexOf("."));
        }

        int b = playedTime.indexOf(".");
        if(b != -1){
            playedTime =playedTime.substring(0, playedTime.indexOf("."));
        }
        Integer imgNum =0;
        SoLesson soLesson = new SoLesson();
        soLesson.setSoid(soid);
        soLesson.setLessonId(lessonId);
        soLesson.setVideoTime(Integer.valueOf(videoTime).intValue());
        soLesson.setPlayedTime(Integer.valueOf(playedTime).intValue());
        soLesson.setUserId(UserUtils.getUser().getId());
        soLesson.setImgNum(Integer.valueOf(sendCount).intValue());
        soLesson.setSts(Constants.HOURS_STS_COMMMIT);
        soLesson.setStsDate(new Date());
        soLessonMapper.insert(soLesson);


      //同步 so_hours

        //查询本课件学时
        double hours =0;
        Lesson lesson = lessonMapper.selectByPrimaryKey(lessonId);
        if(lesson !=null){
             hours =Double.valueOf(lesson.getPlayTime());
        }
        Date startTimeDate = null;
        Date finishTimeDate = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
       try{
          startTimeDate = sdf.parse(startTime);
          finishTimeDate  = sdf.parse(finishTime);
       }catch (Exception e){
           e.printStackTrace();
       }

        SoHours soHours = new SoHours();
        soHours.setSoid(soid);
        soHours.setCourseId(courseId);
        soHours.setLessonId(lessonId);
        soHours.setHours(hours);
        soHours.setPlanId(planId);
        soHours.setAuditLevel(Constants.AUDIT_LEVEL_FIRST);
       //soHours.setStartTime(startTimeDate);
        //soHours.setFinishTime(finishTimeDate);
        soHours.setVideoTime(Integer.valueOf(videoTime).intValue());
        soHours.setPlayedTime(Integer.valueOf(playedTime).intValue());
        soHours.setType(Constants.LEARN_HOURS_TYPE_LESSON);
        soHours.setUserId(UserUtils.getUser().getId());
        soHours.setSts(Constants.HOURS_STS_COMMMIT);
        soHours.setStsDate(new Date());
        soHoursMapper.insert(soHours);

     /*  //同步 so_course
        //播放结束同步时将之前已提交状态图片设置待确认状态
        SoAttachment soAttachment = new SoAttachment();
        soAttachment.setSoid(soid);
        soAttachment.setAppId(courseId);
        soAttachment.setSoType(lessonId);
        soAttachment.setSts(Constants.IMAGE_STS_COMMMIT);
        soAttachmentMapper.updateImage(soAttachment);*/


    }



    @Transactional(readOnly = false)
    public void operSyncHoursSvc(String soid,Long courseId,Long lessonId,String videoTime,String playedTime, String startTime,String finishTime,String sendCount){
        //同步逻辑 每次在视频播放完自动同步，同步状态为初始提交状态，若不进行学时确认则在下次观看视频时自动清除
        //同步 so_lesson

        //查询本课件学时
        double hours =0;
        Long planId = new Long("0");
        String userId = null ;
        SoPlan soPlan = soPlanMapper.findBySoid(soid);
        if(soPlan !=null){
            planId=soPlan.getPlanId();
            userId = soPlan.getUserId();
            if(!"9".equals(soPlan.getRsrvStr1())){
                SoPlan soPlanNew = new SoPlan();
                soPlanNew.setRsrvStr1("9");
                soPlanNew.setSoid(soid);
                soPlanMapper.updateByPrimaryKeySelective(soPlanNew);

            }
        }
        Integer imgNum =0;
        SoLesson soLesson = new SoLesson();
        soLesson.setSoid(soid);
        soLesson.setLessonId(lessonId);
        soLesson.setVideoTime(Integer.valueOf(videoTime));
        soLesson.setPlayedTime(Integer.valueOf(playedTime));
        soLesson.setUserId(userId);
        soLesson.setImgNum(Integer.valueOf(sendCount).intValue());
        soLesson.setSts(Constants.HOURS_STS_NOMAL);
        soLesson.setStsDate(new Date());
        soLessonMapper.insert(soLesson);


        //同步 so_hours

        Lesson lesson = lessonMapper.selectByPrimaryKey(lessonId);
        if(lesson !=null){
            hours =Double.valueOf(lesson.getPlayTime());
        }


        SoHours soHours = new SoHours();
        soHours.setSoid(soid);
        soHours.setCourseId(courseId);
        soHours.setLessonId(lessonId);
        soHours.setHours(hours);
        soHours.setPlanId(planId);
        soHours.setAuditLevel(Constants.AUDIT_LEVEL_FIRST);
        soHours.setVideoTime(Integer.valueOf(videoTime));
        soHours.setPlayedTime(Integer.valueOf(playedTime));
        soHours.setType(Constants.LEARN_HOURS_TYPE_LESSON);
        soHours.setUserId(userId);
        soHours.setSts(Constants.HOURS_STS_NOMAL);
        soHours.setStsDate(new Date());
        soHoursMapper.insert(soHours);


     /*  //同步 so_course
        //播放结束同步时将之前已提交状态图片设置待确认状态
        SoAttachment soAttachment = new SoAttachment();
        soAttachment.setSoid(soid);
        soAttachment.setAppId(courseId);
        soAttachment.setSoType(lessonId);
        soAttachment.setSts(Constants.IMAGE_STS_COMMMIT);
        soAttachmentMapper.updateImage(soAttachment);*/


    }



    /**
     * 学时确认前检查
     * param index
     * aram request
     *param response
     *param model
     *return
     */

    public boolean checkVideoExistsHour(SoHours soHours){

        //学时检查逻辑，检查是否存在已经提交确认学时，包含待审核及已审核记录。若不存在返回true
        boolean checkFlag = false;

        int checkCount = soHoursMapper.selectByCheckExistsHours(soHours.getSoid(),soHours.getCourseId(),soHours.getLessonId());
        if (checkCount ==0){
            checkFlag= true;
        }
        if(checkCount>0){
            checkFlag = false;
        }
        return checkFlag;
    }


    public boolean checkVideoConfirmHour(SoHours soHours){

        //学时检查逻辑，检查存在已提交确认及待审核学时，若不存在则返回true
        boolean checkFlag = false;

        int checkCount = soHoursMapper.selectByCheckVideoConfirm(soHours.getSoid(),soHours.getCourseId(),soHours.getLessonId());
        if (checkCount ==0){
            checkFlag= true;
        }
        if(checkCount>0){
            checkFlag = false;
        }
        return checkFlag;
    }


    public boolean checkVideoAuditHour(SoHours soHours){

        //学时检查逻辑，检查已通过审核的学时，若不存在则返回true
        boolean checkFlag = false;

        int checkCount = soHoursMapper.selectByCheckVideoAudit(soHours.getSoid(),soHours.getCourseId(),soHours.getLessonId());
        if (checkCount ==0){
            checkFlag= true;
        }
        if(checkCount>0){
            checkFlag = false;
        }
        return checkFlag;
    }


    /**
     * 视频播放完毕学时确认
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public void confirmVideoHour(SoHours soHours){

        //学时确认第一步，检查存在已提交确认的学时，若存在则提示用户未审核完成之前不允许再次确认

        //学时确认第二步，将学时确认信息更新为有效状态、审核状态更新为待审核状态。

        //更新 so_lesson为有效状态
        SoLesson soLesson = new SoLesson();
        soLesson.setSoid(soHours.getSoid());
        soLesson.setLessonId(soHours.getLessonId());
        soLesson.setSts(Constants.HOURS_STS_NOMAL);
        soLesson.setStsDate(new Date());
        soLessonMapper.confirmLesson(soLesson);
        //更新 so_hours为有效状态
        SoHours confirmHours = new SoHours();
        confirmHours.setSoid(soHours.getSoid());
        confirmHours.setCourseId(soHours.getCourseId());
        confirmHours.setLessonId(soHours.getLessonId());
        soHours.setSts(Constants.HOURS_STS_NOMAL);
        soHours.setStsDate(new Date());
        soHoursMapper.confirmHours(soHours);

        //更新 so_attachment 为有效状态
        SoAttachment soAttachment = new SoAttachment();
        soAttachment.setSoid(soHours.getSoid());
        soAttachment.setAppId(soHours.getCourseId()+"");
        soAttachment.setSoType(soHours.getLessonId()+"");
        soAttachment.setSts(Constants.HOURS_STS_NOMAL);
        soAttachmentMapper.confirmImage(soAttachment);


    }
}
