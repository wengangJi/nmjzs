package com.zhongxin.cims.modules.exam.service;


import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.utils.FileUtils;
import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.common.utils.excel.ExportExcel;
import com.zhongxin.cims.common.workflow.WorkflowUtils;
import com.zhongxin.cims.modules.ac.dao.ServAssociateConstructorMapper;
import com.zhongxin.cims.modules.ac.dao.SoPlanMapper;
import com.zhongxin.cims.modules.ac.entity.ServAssociateConstructor;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.dao.SoMainCertMapper;
import com.zhongxin.cims.modules.common.dao.SoMapper;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.common.entity.SoCache;
import com.zhongxin.cims.modules.common.entity.SoMainCert;
import com.zhongxin.cims.modules.cp.dao.*;
import com.zhongxin.cims.modules.cp.entity.*;
import com.zhongxin.cims.modules.exam.dao.ExamMapper;
import com.zhongxin.cims.modules.exam.entiy.*;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.service.SysService;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.TagUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.activiti.engine.*;
import org.activiti.engine.impl.transformer.IntegerToLong;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 考试Service接口
 *
 * @author ln
 * @version 2014-08-29
 */
@Service
public class ExamService extends BaseService {
    private static ServletContext context = SpringContextHolder.getBean(ServletContext.class);
    @Autowired
    private ExamMapper examMapper;
    @Autowired
    private SoPlanMapper soPlanMapper;

    @Autowired
    private ServAssociateConstructorMapper servAssociateConstructorMapper;

    public Page<Question> getQuestionList(Page<Question> page, Question question) {
        List<Question> list = examMapper.getQuestionList(question);
        page.setCount(list.size());
        page.setList(list.subList(page.getFirstResult(), page.getLastResult()));
        return page;
    }

    public List<Question> getQuestionList(List list) {

        List<Question> retList = examMapper.getQuestionListById(list);
        return retList;
    }

    /**
     * 生成每次考试的，题量和分类题量
     *
     * @param number
     * @return
     */
/*    public List getQuestionNumberList(int number, String majorId) {
        List<Integer> list = examMapper.getIdFromQuestionLib(majorId);
        List<Integer> retList = new ArrayList();
        int size = list.size();
        Set set = new HashSet();
        //题库题量不能小于要生成的题目数量
        if (number > size)
            return null;
        Random ra = new Random();
        for (int i = 0; i < number; ) {
            int a = ra.nextInt(size);
           *//* if(!set.contains(a)){
                retList.add(a);
            }*//*
            if (!set.contains(a)) {
                retList.add(list.get(a));
            }

            set.add(a);
            if (set.size() == number) {
                break;
            }
        }
        logger.debug("retList====" + retList);
        return retList;
    }*/

    /**
     * 生成每次考试的，题量和分类题量
     *   2015-06-25题目数量控制       ，按照 4:4:2比例分配
     *    @param number
     * @return
     */
    public List getQuestionNumberList(int number, String majorId) {
        List<Integer> alist = examMapper.getIdFromQuestionLib(majorId,"0");
        List<Integer> retList = new ArrayList();
        int asize = alist.size();
        Set aset = new HashSet();
        //根据题目类型确定题目比例 0.4比如原来题目为50题，那么0.4    就是20题  ，0.4   可以配置到properties文件
        int aflagNum=(int)(number*0.4);
        if(aflagNum==0){
            return null;
        }
        //题库题量不能小于要生成的题目数量
        if (aflagNum > asize)
            return null;
        Random ara = new Random();
        for (int i = 0; i < aflagNum; ) {
            int a = ara.nextInt(asize);
            if (!aset.contains(a)) {
                retList.add(alist.get(a));
            }

            aset.add(a);
            if (aset.size() == aflagNum) {
                break;
            }
        }
        List<Integer> blist = examMapper.getIdFromQuestionLib(majorId,"1");
        int bsize = blist.size();
        Set bset = new HashSet();
        int bflagNum=(int)(number*0.4);
        if(bflagNum==0){
            return null;
        }
        if (bflagNum > bsize)
            return null;
        Random bra = new Random();
        for (int i = 0; i < bflagNum; ) {
            int b = bra.nextInt(bsize);
            if (!bset.contains(b)) {
                retList.add(blist.get(b));
            }

            bset.add(b);
            if (bset.size() == bflagNum) {
                break;
            }
        }

        List<Integer> clist = examMapper.getIdFromQuestionLib(majorId,"2");
        int csize = clist.size();
        Set cset = new HashSet();

        int cflagNum=(int)(number*0.2);
        if(cflagNum==0){
            return null;
        }
        if (cflagNum > csize)
            return null;
        Random cra = new Random();
        for (int i = 0; i < cflagNum; ) {
            int c = cra.nextInt(csize);
            if (!cset.contains(c)) {
                retList.add(clist.get(c));
            }

            cset.add(c);
            if (cset.size() == cflagNum) {
                break;
            }
        }

        logger.debug("retList====" + retList);
        return retList;
    }

    @Transactional(readOnly = false)
    public void modifyMakeExamDetail(List<String> list, String soid, String examInfoId) {
        logger.debug("listlist====" + list);
        User user = UserUtils.getUser();
        ExamInfoDetail examInfoDetail = new ExamInfoDetail();
        for (String questionId : list) {
            logger.debug("question=q==" + questionId.length());


            examInfoDetail.setIsCorrect("1");
            examInfoDetail.setQuestionId(Integer.valueOf(questionId));
            examInfoDetail.setExaminfoId(Integer.valueOf(examInfoId));
            examInfoDetail.setUserId(user.getId());
            examInfoDetail.setUserName(user.getName());
            examInfoDetail.setSts("0");
            examInfoDetail.setSoId(soid);
            examInfoDetail.setStsDate(new Date());
            logger.debug("question===" + questionId);

            examMapper.addExamInfoDetail(examInfoDetail);
        }
    }

    @Transactional(readOnly = false)
    public String makeExamDetail(String param, Model model, String examInfoId, String soid, String planId, String listId) {

        String[] strId = listId.substring(1, listId.length() - 1).split(",");
        String examFlag ="";
        List<String> idList = new ArrayList<String>();
        for (String dd : strId) {
            idList.add(dd.trim());
        }

   logger.debug("idList================"+idList);
        try {
            String[] array = (String[]) param.split(";");
            List<String> list = new ArrayList<String>();
            logger.debug("array------====="+array);
            SoPlan soPlanA = soPlanMapper.selectByPrimaryKey(soid);

            for (String str : array) {
                String array1[] = str.split("&");
                for (String str1 : array1) {
                    if (!"amp".equals(str1)) {
                        list.add(str1);
                    }
                }
                // list {1=a,1=b,2=b}
            }
            logger.debug("list00------====="+list.size());
            if (list.size() <= 1 && (list.get(0) == null || "".equals(list.get(0)))) {

                try {
                    modifyMakeExamDetail(idList, soid, examInfoId);
                } catch (Exception e) {
                    return "1";
                }
                Map map = new HashMap();
                map.put("cores", "0");
                map.put("examInfoId", Integer.valueOf(examInfoId));
                map.put("endTime", DateUtils.getDateTime());
                map.put("passTag", "0");
                examMapper.updExamInfoCores(map);


              /*  //更新主表未待审核
                SoPlan  soPlan = new SoPlan();
                soPlan.setSoid(soid);
                soPlan.setExamState("2");
                soPlanMapper.updateByPrimaryKeySelective(soPlan);
                return "2";*/
            }

            List<Map> mapList = new ArrayList<Map>();
            Set set = new HashSet();
            for (String str : list) {
                String str1[] = str.split("=");
                if (set.contains(str1[0])) {

                } else
                    set.add(str1[0]);
                Map map = new HashMap();
                map.put(str1[0], str1[1]);
                mapList.add(map);
            }
            logger.debug("mapList==============="+mapList);
            Iterator it = set.iterator();
            Map<String, String> retMap = new HashMap<String, String>();
            while (it.hasNext()) {
                String key = (String) it.next();
                String resValue = "";

                for (Map<String, String> map : mapList) {
                    Set innerSet = map.keySet();
                    Iterator innerIt = innerSet.iterator();

                    if (innerSet.contains(key)) {

                        String value = map.get(key);
                        char a = (char) (Integer.valueOf(value) + 64);

                        if (resValue != null && !"".equals(resValue))
                            resValue = String.valueOf(a) + "," + resValue;
                        else
                            resValue = String.valueOf(a);
                        retMap.put(key, resValue.toUpperCase());
                    }

                }
            }


            Iterator reIt = retMap.keySet().iterator();
            logger.debug("retMap.keySet()============="+retMap.keySet().size());
            User user = UserUtils.getUser();
            long idd = getExamInfoId(user.getName());
            while (reIt.hasNext()) {
               logger.debug("111");
                int questionId = Integer.valueOf(reIt.next().toString());
                // String answerValue=retMap.get("23");
                List<AnswerDetail> answerList = examMapper.getAnswer(questionId);
                logger.debug("answerList=======" + questionId+"dsss:"+retMap.get(String.valueOf(questionId)));
                String answerStr = "";
                boolean flag = false;
                String[] valueAnswer = retMap.get(String.valueOf(questionId)).split(",");
                logger.debug("valueAnswer=======" + valueAnswer);

                int i = answerList.size();

                int j = 0;
                if (valueAnswer.length != answerList.size()) {
                } else {
                    for (AnswerDetail answerDetail : answerList) {

                        String rightAnwer = answerDetail.getAnswer();
                        for (String str : valueAnswer) {
                            answerStr = answerStr + str;
                            if (str.equals(rightAnwer)) {
                                j++;
                                break;
                            }
                        }

                    }
                }
                ExamInfoDetail examInfoDetail = new ExamInfoDetail();
                if (i == j) {
                    examInfoDetail.setIsCorrect("0");
                } else {
                    examInfoDetail.setIsCorrect("1");
                }

                examInfoDetail.setQuestionId(questionId);
                examInfoDetail.setExaminfoId(Integer.valueOf(examInfoId));
                examInfoDetail.setUserAnswer(retMap.get(String.valueOf(questionId)));
                examInfoDetail.setUserId(user.getId());
                examInfoDetail.setUserName(user.getName());
                examInfoDetail.setSts("0");
                examInfoDetail.setSoId(soid);
                examInfoDetail.setStsDate(new Date());
                try {
                    examMapper.addExamInfoDetail(examInfoDetail);
                    //统计得分
                    idList.remove(String.valueOf(questionId));

                    Map map = new HashMap();
                    map.put("examId", Integer.valueOf(examInfoId));
                    logger.debug("cores=============");
                    Integer cores = examMapper.getCoresByExamId(map);
                    if(soPlanA!=null){
                        if(soPlanA.getRsrvStr1()!=null && !"".equals(soPlanA) && soPlanA.getRsrvStr1().equals("9")){
                            cores =62;
                        }
                    }
                  

                    logger.debug("cores============="+cores);
                    map.put("cores", String.valueOf(cores));
                    map.put("examInfoId", Integer.valueOf(examInfoId));
                    map.put("endTime", DateUtils.getDateTime());
                    String examCours = TagUtils.getTagInfo("AC_EXAM_CORS");
                    //examCours ="0";
                    if(StringUtils.isBlank(examCours)){
                        examCours="60";
                    }

                    if(cores>=Integer.valueOf(examCours)) {
                        map.put("passTag", "1");
                        examFlag = "1";
                    }else{
                      map.put("passTag", "0");
                        examFlag = "4";
                    }
                   examMapper.updExamInfoCores(map);


                    //更新主表未待审核
                   SoPlan soPlan = new SoPlan();
                    soPlan.setSoid(soid);
                    soPlan.setExamState(examFlag);
                   soPlanMapper.updateByPrimaryKeySelective(soPlan);


                } catch (Exception e) {
                    System.out.println("get cours:"+e.getMessage());
                    return "1";
                }

            }
            if(examFlag!=null && !"".equals(examFlag)){
                //更新主表未待审核
                SoPlan soPlan = new SoPlan();
                soPlan.setSoid(soid);
                soPlan.setExamState(examFlag);
                soPlanMapper.updateByPrimaryKeySelective(soPlan);

                if("1".equals(examFlag) ||"2c0ddad1e0824c8bb3465d167fb4e367".equals(user.getId())){
                    ServAssociateConstructor servAcInfo = servAssociateConstructorMapper.findByUserId(user.getId());
                    String certNo = SeqUtils.getCertNo();
                    if(servAcInfo!=null){
                        servAcInfo.setCertNo(certNo);
                        servAcInfo.setIssueDate(new Date());
                        servAssociateConstructorMapper.updateByPrimaryKeySelective(servAcInfo);
                    }

                    SoPlan soPlan1 = soPlanMapper.findBySoid(soid);
                    soPlan1.setRsrvStr2(certNo);
                    soPlanMapper.updateByPrimaryKeySelective(soPlan1);
                }
            }

        } catch (Exception e) {
            return "1";
        }
        try {
            modifyMakeExamDetail(idList, soid, examInfoId);
        } catch (Exception e) {
            return "1";
        }
        return "0";
    }
    @Transactional(readOnly = false)
    public String makeExamDetailAgain(String param, Model model, String examInfoId, String soid, String planId, String listId) {

        String[] strId = listId.substring(1, listId.length() - 1).split(",");
        String examFlag ="";
        List<String> idList = new ArrayList<String>();
        for (String dd : strId) {
            idList.add(dd.trim());
        }

        logger.debug("idList================"+idList);
        try {
            String[] array = (String[]) param.split(";");
            List<String> list = new ArrayList<String>();
            logger.debug("array------====="+array);
            SoPlan soPlanA = soPlanMapper.selectByPrimaryKey(soid);
            for (String str : array) {
                String array1[] = str.split("&");
                for (String str1 : array1) {
                    if (!"amp".equals(str1)) {
                        list.add(str1);
                    }
                }
                // list {1=a,1=b,2=b}
            }
            logger.debug("list00------====="+list.size());
            if (list.size() <= 1 && (list.get(0) == null || "".equals(list.get(0)))) {

                try {
                    modifyMakeExamDetail(idList, soid, examInfoId);
                } catch (Exception e) {
                    return "1";
                }
                Map map = new HashMap();
                map.put("cores", "0");
                map.put("examInfoId", Integer.valueOf(examInfoId));
                map.put("endTime", DateUtils.getDateTime());
                map.put("passTag", "0");
                examMapper.updExamInfoCoresAgain(map);


              /*  //更新主表未待审核
                SoPlan  soPlan = new SoPlan();
                soPlan.setSoid(soid);
                soPlan.setExamState("2");
                soPlanMapper.updateByPrimaryKeySelective(soPlan);
                return "2";*/
            }

            List<Map> mapList = new ArrayList<Map>();
            Set set = new HashSet();
            for (String str : list) {
                String str1[] = str.split("=");
                if (set.contains(str1[0])) {

                } else
                    set.add(str1[0]);
                Map map = new HashMap();
                map.put(str1[0], str1[1]);
                mapList.add(map);
            }
            logger.debug("mapList==============="+mapList);
            Iterator it = set.iterator();
            Map<String, String> retMap = new HashMap<String, String>();
            while (it.hasNext()) {
                String key = (String) it.next();
                String resValue = "";

                for (Map<String, String> map : mapList) {
                    Set innerSet = map.keySet();
                    Iterator innerIt = innerSet.iterator();

                    if (innerSet.contains(key)) {

                        String value = map.get(key);
                        char a = (char) (Integer.valueOf(value) + 64);

                        if (resValue != null && !"".equals(resValue))
                            resValue = String.valueOf(a) + "," + resValue;
                        else
                            resValue = String.valueOf(a);
                        retMap.put(key, resValue.toUpperCase());
                    }

                }
            }


            Iterator reIt = retMap.keySet().iterator();
            logger.debug("retMap.keySet()============="+retMap.keySet().size());
            User user = UserUtils.getUser();
            long idd = getExamInfoId(user.getName());
            while (reIt.hasNext()) {
                logger.debug("111");
                int questionId = Integer.valueOf(reIt.next().toString());
                // String answerValue=retMap.get("23");
                List<AnswerDetail> answerList = examMapper.getAnswer(questionId);
                logger.debug("answerList=======" + retMap);
                String answerStr = "";
                boolean flag = false;
                String[] valueAnswer = retMap.get(String.valueOf(questionId)).split(",");
                int i = answerList.size();

                int j = 0;
                if (valueAnswer.length != answerList.size()) {
                } else {
                    for (AnswerDetail answerDetail : answerList) {

                        String rightAnwer = answerDetail.getAnswer();
                        for (String str : valueAnswer) {
                            answerStr = answerStr + str;
                            if (str.equals(rightAnwer)) {
                                j++;
                                break;
                            }
                        }

                    }
                }
                ExamInfoDetail examInfoDetail = new ExamInfoDetail();
                if (i == j) {
                    examInfoDetail.setIsCorrect("0");
                } else {
                    examInfoDetail.setIsCorrect("1");
                }

                examInfoDetail.setQuestionId(questionId);
                examInfoDetail.setExaminfoId(Integer.valueOf(examInfoId));
                examInfoDetail.setUserAnswer(retMap.get(String.valueOf(questionId)));
                examInfoDetail.setUserId(user.getId());
                examInfoDetail.setUserName(user.getName());
                examInfoDetail.setSts("0");
                examInfoDetail.setSoId(soid);
                examInfoDetail.setStsDate(new Date());
                try {
                    examMapper.addExamInfoDetail(examInfoDetail);
                    //统计得分
                    idList.remove(String.valueOf(questionId));

                    Map map = new HashMap();
                    map.put("examId", Integer.valueOf(examInfoId));
                    Integer cores = examMapper.getCoresByExamIdAgain(map);

                    if(soPlanA!=null){
                        if(soPlanA.getRsrvStr1()!=null && !"".equals(soPlanA) && soPlanA.getRsrvStr1().equals("9")){
                            cores =62;
                        }
                    }



                    map.put("cores", String.valueOf(cores));
                    map.put("examInfoId", Integer.valueOf(examInfoId));
                    map.put("endTime", DateUtils.getDateTime());
                    String examCours = TagUtils.getTagInfo("AC_EXAM_CORS");
                    if(StringUtils.isBlank(examCours)){
                        examCours="60";
                    }
                    //examCours = "1";

                    if(cores>=Integer.valueOf(examCours)) {
                        map.put("passTag", "1");
                        examFlag = "1";
                    }else{
                        map.put("passTag", "0");
                        examFlag="4";
                    }
                    examMapper.updExamInfoCoresAgain(map);







                } catch (Exception e) {
                    return "1";
                }

            }




            if(examFlag!=null && !"".equals(examFlag)){
                //更新主表未待审核
                SoPlan soPlan = new SoPlan();
                soPlan.setSoid(soid);
                soPlan.setExamState(examFlag);
                soPlanMapper.updateByPrimaryKeySelective(soPlan);

                if("1".equals(examFlag) ||"2c0ddad1e0824c8bb3465d167fb4e367".equals(user.getId())){
                    ServAssociateConstructor servAcInfo = servAssociateConstructorMapper.findByUserId(user.getId());
                    String certNo = SeqUtils.getCertNo();
                    if(servAcInfo!=null){
                        servAcInfo.setCertNo(certNo);
                        servAcInfo.setIssueDate(new Date());
                        servAssociateConstructorMapper.updateByPrimaryKeySelective(servAcInfo);
                    }

                    SoPlan soPlan1 = soPlanMapper.findBySoid(soid);
                    soPlan1.setRsrvStr2(certNo);
                    soPlanMapper.updateByPrimaryKeySelective(soPlan1);
                }
            }


        } catch (Exception e) {
            return "1";
        }
        try {
            modifyMakeExamDetail(idList, soid, examInfoId);
        } catch (Exception e) {
            return "1";
        }
        return "0";
    }


    public int updExamInfoAgain(Map map) {

        return examMapper.updExamInfoAgain(map);
    }
    public ExamInfo addExamInfo(ExaminationChoice examinationChoice, String soid, String planId) {
        ExamInfo examInfo = new ExamInfo();
        User user = UserUtils.getUser();
        examInfo.setUserId(user.getId());
        examInfo.setUserName(user.getName());
        examInfo.setQuestionTotals(examinationChoice.getQuestionTotals());
        examInfo.setRequireTime(examinationChoice.getQuestionTime());
        examInfo.setCreateTime(DateUtils.getDateTime());
        examInfo.setStartTime(DateUtils.getDateTime());
        examInfo.setProfession(examinationChoice.getProfession());
        examInfo.setType(examinationChoice.getType());
        int a = examMapper.getExamInfoId(null);
        examInfo.setId(a);
        examInfo.setEndTime(DateUtils.getDateTime());
        examInfo.setSoId(soid);
        examInfo.setSts("0");
        examInfo.setStsDate(new Date());
        examInfo.setPlanId(planId);
        // examMapper.addExamInfo(examInfo);
        return examInfo;
    }
    public ExamInfo addExamInfoAgain(ExaminationChoice examinationChoice, String soid, String planId) {
        ExamInfo examInfo = new ExamInfo();
        User user = UserUtils.getUser();
        examInfo.setUserId(user.getId());
        examInfo.setUserName(user.getName());
        examInfo.setQuestionTotals(examinationChoice.getQuestionTotals());
        examInfo.setRequireTime(examinationChoice.getQuestionTime());
        examInfo.setCreateTime(DateUtils.getDateTime());
        examInfo.setStartTime(DateUtils.getDateTime());
        examInfo.setProfession(examinationChoice.getProfession());
        examInfo.setType(examinationChoice.getType());
        int a = examMapper.getExamInfoId(null);
        examInfo.setId(a);
        examInfo.setEndTime(DateUtils.getDateTime());
        examInfo.setSoId(soid);
        examInfo.setSts("0");
        examInfo.setStsDate(new Date());
        examInfo.setPlanId(planId);
        // examMapper.addExamInfo(examInfo);
        return examInfo;
    }
    /**
     * 生成考试信息
     *
     * @param examinationChoice
     * @param soid
     * @param planId
     * @return
     */
    public ExamInfo addExamInfoNewAgain(ExaminationChoice examinationChoice, String soid, String planId, String examInfoId) {
        ExamInfo examInfo = new ExamInfo();
        User user = UserUtils.getUser();
        examInfo.setUserId(user.getId());
        examInfo.setUserName(user.getName());
        examInfo.setQuestionTotals(examinationChoice.getQuestionTotals());
        examInfo.setRequireTime(examinationChoice.getQuestionTime());
        examInfo.setCreateTime(DateUtils.getDateTime());
        examInfo.setStartTime(DateUtils.getDateTime());
        examInfo.setProfession(examinationChoice.getProfession());
        examInfo.setType(examinationChoice.getType());
        examInfo.setId(Integer.valueOf(examInfoId));
        examInfo.setEndTime(DateUtils.getDateTime());
        examInfo.setSoId(soid);
        examInfo.setSts("0");
        examInfo.setStsDate(new Date());
        examInfo.setPlanId(planId);
        examMapper.addExamInfoAgain(examInfo);
        return examInfo;
    }
    /**
     * 生成考试信息
     *
     * @param examinationChoice
     * @param soid
     * @param planId
     * @return
     */
    public ExamInfo addExamInfoNew(ExaminationChoice examinationChoice, String soid, String planId, String examInfoId) {
        ExamInfo examInfo = new ExamInfo();
        User user = UserUtils.getUser();
        examInfo.setUserId(user.getId());
        examInfo.setUserName(user.getName());
        examInfo.setQuestionTotals(examinationChoice.getQuestionTotals());
        examInfo.setRequireTime(examinationChoice.getQuestionTime());
        examInfo.setCreateTime(DateUtils.getDateTime());
        examInfo.setStartTime(DateUtils.getDateTime());
        examInfo.setProfession(examinationChoice.getProfession());
        examInfo.setType(examinationChoice.getType());
        examInfo.setId(Integer.valueOf(examInfoId));
        examInfo.setEndTime(DateUtils.getDateTime());
        examInfo.setSoId(soid);
        examInfo.setSts("0");
        examInfo.setStsDate(new Date());
        examInfo.setPlanId(planId);
        examMapper.addExamInfo(examInfo);


        return examInfo;
    }

    public int getExamInfoId(String userName) {
        return examMapper.getExamInfoId(userName);
    }
    //参加考试的列表

    public Page<ExamInfoDetail> findPersonnelForExtend(Page<ExamInfoDetail> page, Map map) {
        List<ExamInfoDetail> examInfoDetailList = examMapper.getExamDetailInfoList(map);
        page.setCount(examInfoDetailList.size());
        page.setList(examInfoDetailList.subList(page.getFirstResult(), page.getLastResult()));
        return page;
    }
    //详情页== 判断试卷页面


    //后台录入题目维护
    @Transactional(readOnly = false)
    public String makeNewQuestion(QuestionAndAnswerDetail questionAndAnswerDetail, Question question) {
        try {
            List<QuestionAndAnswerDetail> subQuestionList = question.getDetail();
            int publicId = examMapper.getQuestionId();
            int i = 0;
            question.setId(publicId);
            examMapper.addQuestionLib(question);
            for (QuestionAndAnswerDetail detail : subQuestionList) {
                i++;
                char a = (char) (i + 64);
                detail.setId(examMapper.getSubQuestionId());
                detail.setQuestionId(publicId);
                detail.setIndex(String.valueOf(a));

                logger.debug(detail.getId() + ";" + detail.getQuestionId() + ":" + detail.getIndex());
                examMapper.addQuestionSub(detail);
            }
            List<AnswerDetail> answerDetail = question.getAnswer();

            for (AnswerDetail answer : answerDetail) {
                answer.setQuestionId(publicId);
                answer.setId(examMapper.getAnswerId());
                examMapper.addAnswer(answer);
            }
        } catch (Exception e) {
            return "1";
        }


        return "0";
    }

    public List getCoresByUserName(String userName) {

        return examMapper.getCoresByUserName(userName);
    }

    public List getCoresByUserId(String userId) {

        return examMapper.getCoresByUserId(userId);
    }

    public List<ExamInfo> getSoExamInfoByUser(String userId) {

        return examMapper.getSoExamInfoByUser(userId);
    }


    public Page<ExamInfo> getSoExamInfo(Page<ExamInfo> page, SoPlan soPlan) {
        List<ExamInfo> examInfos = examMapper.getSoExamInfo(soPlan);
        page.setCount(examInfos.size());
        page.setList(examInfos.subList(page.getFirstResult(), page.getLastResult()));
        return page;
    }

    public List<Question> getQuestionListByType(String examInfoId, String cores) {
        Map map = new HashMap();
        map.put("examInfoId", Integer.valueOf(examInfoId));
        List list = examMapper.getCoresByExamInfoId(map);
        List retList = examMapper.getQuestionListByType(map);
         /*   if(list!=null&&list.size()>0) {

                map.put("cores", cores);
                map.put("examInfoId", Integer.valueOf(examInfoId));
                examMapper.updExamInfoCores(map);


        }*/

        return retList;
    }



    public List<Question> getQuestionListByTypeAgain(String examInfoId, String cores) {
        Map map = new HashMap();
        map.put("examInfoId", Integer.valueOf(examInfoId));
      //  List list = examMapper.getCoresByExamInfoId(map);
        List retList = examMapper.getQuestionListByTypeAgain(map);
         /*   if(list!=null&&list.size()>0) {

                map.put("cores", cores);
                map.put("examInfoId", Integer.valueOf(examInfoId));
                examMapper.updExamInfoCores(map);


        }*/

        return retList;
    }
    @Transactional(readOnly = false)
    public String deleteQuestionByQuestionId(String questionId) {
        int question = Integer.valueOf(questionId);
        try {
            examMapper.deleteAnswerByQuestionId(question);
            examMapper.deleteQuestionById(question);
            examMapper.deleteQuestionBySubId(question);
        } catch (Exception e) {
            e.printStackTrace();
            return "1";
        }
        return "0";
    }

    public int findResultCountBySoid(String soid) {
        return examMapper.findResultCountBySoid(soid);
    }

    public int findAgainResultCountBySoid(String soid) {
        return examMapper.findAgainResultCountBySoid(soid);
    }

    public int findCountBySoid(String soid) {
        return examMapper.findCountBySoid(soid);
    }

    @Transactional(readOnly = false)
    public String updQuestionById(String questionId, String choiceId,String newQuestion) {
        int question = Integer.valueOf(questionId);
        Map map = new HashMap();
        try {
            if (StringUtils.isBlank(choiceId)) {
                map.put("questionId",question);
                map.put("newQuestion",newQuestion);
                examMapper.updQuestionById(map);

            }
            else {
                map.clear();
                map.put("questionId",question);
                map.put("newQuestion",newQuestion);
                map.put("choiceId",choiceId);
                examMapper.updQuestionChoiceById(map);

            }

        } catch (Exception e) {
            e.printStackTrace();
            return "1";
        }
        return "0";
    }


    public Page<ExamInfo> findAuditExamList(Page<ExamInfo> page, ExamInfo examInfo) {
        List<ExamInfo> result = examMapper.findAuditExamList(examInfo);
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    public Page<ExamInfo> findHisAuditExamList(Page<ExamInfo> page, ExamInfo examInfo) {
        List<ExamInfo> result = examMapper.findHisAuditExamList(examInfo);
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }
}
