package com.zhongxin.cims.modules.ac.service;

import com.alibaba.druid.sql.dialect.oracle.ast.stmt.OracleSelectRestriction;
import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.modules.ac.dao.*;
import com.zhongxin.cims.modules.ac.entity.*;
import com.zhongxin.cims.modules.common.dao.SealMapper;
import com.zhongxin.cims.modules.common.dao.SynJxjyCaseMapper;
import com.zhongxin.cims.modules.common.entity.Seal;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SynJxjyCase;
import com.zhongxin.cims.modules.exam.dao.ExamMapper;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.PlanUtils;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by lqyu_773 on 14-8-29.
 */
@Component
@Transactional(readOnly = true)
public class PlanService extends BaseService {
    @Autowired
    private PlanMapper planMapper;

    @Autowired
    private CourseMapper courseMapper;

    @Autowired
    private LessonMapper lessonMapper;

    @Autowired
    private SoPlanMapper soPlanMapper;

    @Autowired
    private SoCourseMapper soCourseMapper;

    @Autowired
    private SoInvoiceMapper soInvoiceMapper;

    @Autowired
    private SealMapper sealMapper;

    @Autowired
    private SynJxjyCaseMapper synJxjyCaseMapper;

    @Autowired
    private ExamMapper examMapper;


    @Autowired
    private ServAssociateConstructorService servAssociateConstructorService;
    public List<Plan> findAll(){ return planMapper.findAll(); }

    public List<Plan> findPlanManager(){ return planMapper.findPlanManager();}

    public Plan findByPrimaryKey(Long planId){ return planMapper.selectByPrimaryKey(planId);}

    public SoPlan findBySoid(String soid){ return soPlanMapper.findBySoid(soid);}

    public SoPlanEntity findAllBySoid(String soid){ return soPlanMapper.findAllBySoid(soid);}

    public List<SoPlan> findByUserId(String userId){  return  soPlanMapper.findByUserId(userId); }

    public List<SoPlan> findByPlanId(Long planId){  return  soPlanMapper.findByPlanId(planId); }

    public List<SoPlan> findByCompanyId(Integer companyId){  return  soPlanMapper.findByCompanyId(companyId); }

    public List<SoPlan> findPayListByUserId(String userId ,String feeState){  return  soPlanMapper.findPayListByUserId(userId, feeState); }

    public List<SoPlan> findLearnListByUserId(String userId ,String learnState){  return  soPlanMapper.findLearnListByUserId(userId, learnState); }

    public List<SoPlan> findHourListByUserId(String userId ,String hourState){  return  soPlanMapper.findHourListByUserId(userId, hourState); }

    public List<SoPlan> findExamListByUserId(String userId ,String examState){  return  soPlanMapper.findExamListByUserId(userId, examState); }

    public List<SoPlan> findAllExamListByUserId(String userId){  return  soPlanMapper.findAllExamListByUserId(userId); }

    public List<SoPlan> findAllReduceListByUserId(String userId){  return  soPlanMapper.findAllReduceListByUserId(userId); }

    public List<SoPlan> findAllReduceListByCompanyId(Integer companyId){  return  soPlanMapper.findAllReduceListByCompanyId(companyId); }


    public List<SoPlan> findReduceListByUserId(String userId){  return  soPlanMapper.findReduceListByUserId(userId); }

    public List<SoPlan> findAllCertListByUserId(String userId){  return  soPlanMapper.findAllCertListByUserId(userId); }

/*
    public List<SoPlan> findAllPrePayList(String oflineSts){  return  soPlanMapper.findAllPrePayList( oflineSts); }
*/

    public Page<SoPlan> findAllPrePayList(Page<SoPlan> soPlanPage,SoPlan soPlan) {
        List<SoPlan> soPlans = soPlanMapper.findAllPrePayList(soPlan);
        if(soPlans!=null && soPlans.size()>0){
            for(SoPlan soPlan2:soPlans){
                ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(soPlan2.getUserId());
                soPlan2.setRsrvStr1(servAcInfo.getName());
                soPlan2.setRsrvStr2(servAcInfo.getIdNo());

            }

        }
        soPlanPage.setCount(soPlans.size());
        soPlanPage.setList(soPlans.subList(soPlanPage.getFirstResult(),soPlanPage.getLastResult()));
        return soPlanPage;
    }



    public Page<SoPlan> findListBySoPlan(Page<SoPlan> soPlanPage, SoPlan soPlan) {
        List<SoPlan> soPlans = soPlanMapper.findListBySoPlan(soPlan);
        soPlanPage.setCount(soPlans.size());
        soPlanPage.setList(soPlans.subList(soPlanPage.getFirstResult(),soPlanPage.getLastResult()));
        return soPlanPage;
    }

    public Page<SoPlanEntity> findListBySoPlanEntity(Page<SoPlanEntity> soPlanPage, SoPlanEntity soPlanEntity) {
        List<SoPlanEntity> soPlanEntitys = soPlanMapper.findListBySoPlanEntity(soPlanEntity);
        soPlanPage.setCount(soPlanEntitys.size());
        soPlanPage.setList(soPlanEntitys.subList(soPlanPage.getFirstResult(),soPlanPage.getLastResult()));
        return soPlanPage;
    }

    public Page<SoPlan> findListBySoPlanEntitys(Page<SoPlan> soPlanPage, SoPlanEntity soPlanEntity) {
        List<SoPlan> soPlans = soPlanMapper.findListBySoPlanEntitys(soPlanEntity);
        soPlanPage.setCount(soPlans.size());
        soPlanPage.setList(soPlans.subList(soPlanPage.getFirstResult(),soPlanPage.getLastResult()));
        return soPlanPage;
    }

    public Page<SoPlan> findAllReduceList(Page<SoPlan> soPlanPage, SoPlan soPlan) {
        List<SoPlan> soPlans = soPlanMapper.findAllReduceList(soPlan);
        soPlanPage.setCount(soPlans.size());
        soPlanPage.setList(soPlans.subList(soPlanPage.getFirstResult(),soPlanPage.getLastResult()));
        return soPlanPage;
    }

    public Page<SoPlan> findAllReduceList(Page<SoPlan> soPlanPage, SoPlanEntity soPlanEntity) {
        List<SoPlan> soPlans = soPlanMapper.findAllReduceList(soPlanEntity);
        soPlanPage.setCount(soPlans.size());
        soPlanPage.setList(soPlans.subList(soPlanPage.getFirstResult(),soPlanPage.getLastResult()));
        return soPlanPage;
    }



  public List<SoCourse> findSoCourseListBySoid(String soid){ return soCourseMapper.findBySoid(soid);}



    @Transactional(readOnly = false)
    public void modifyPlan(Plan plan){
        planMapper.updateByPrimaryKeySelective(plan);
        PlanUtils.removeCache();
    }

    @Transactional(readOnly = false)
    public void modifySoPlan(SoPlan soPlan){
        soPlanMapper.updateByPrimaryKeySelective(soPlan);
    }

    @Transactional(readOnly = false)
    public void savePlan(Plan plan){
        planMapper.insert(plan);
        PlanUtils.removeCache();
    }

    @Transactional(readOnly = false)
    public void removeSoAllInfo(String soid){
      SoPlan soPlan = new SoPlan();
        soPlan.setSoid(soid);
        soPlan.setSts(Constants.SO_STS_REMOVE);
        soPlan.setStsDate(new Date());
      soPlanMapper.updateByPrimaryKeySelective(soPlan);
      SoCourse soCourse = new SoCourse();
        soCourse.setSoid(soid);
        soCourse.setSts(Constants.SO_STS_REMOVE);
        soCourse.setStsDate(new Date());
      soCourseMapper.updateByPrimaryKeySelective(soCourse);
      SoInvoice soInvoice = new SoInvoice();
        soInvoice.setSoid(soid);
        soInvoice.setSts(Constants.SO_STS_REMOVE);
        soInvoice.setStsDate(new Date());
      soInvoiceMapper.updateByPrimaryKeySelective(soInvoice);
    }



    @Transactional(readOnly = false)
    public String save(SoPlanEntity soPlanEntity) {
        User user = UserUtils.getUser();
        SoPlan soPlan = soPlanEntity.getSoPlan();
        SoInvoice soInvoice = soPlanEntity.getSoInvoice();
        String soId = SeqUtils.getSequence("SO_SEQ", "471", "AC", "01");
        if(soPlan != null){
            soPlan.setSoid(soId);
            soPlanMapper.insert(soPlan);
        }
        // 如果没填发票抬头，不保存发票信息
        if(soInvoice != null && soInvoice.getTitle() != null && !"".equals(soInvoice.getTitle())){
            soInvoice.setSoid(soId);
            soInvoice.setAuditTag("0");
            soInvoiceMapper.insert(soInvoice);
        }
        return soId;
    }

    public List<SoPlan> findCanReduceHoursPlan(String id) {
        return soPlanMapper.findCanReduceHoursPlan(id);
    }

    public Page<Plan> list(Page<Plan> planPage, Plan plan) {
        List<Plan> plans = planMapper.list(plan);
        planPage.setCount(plans.size());
        planPage.setList(plans.subList(planPage.getFirstResult(),planPage.getLastResult()));
        return planPage;
    }

    public Page<SynJxjyCase> synList(Page<SynJxjyCase> synPage, SynJxjyCase synJxjyCase) {
        List<SynJxjyCase> synJxjyCases = synJxjyCaseMapper.list(synJxjyCase);
        synPage.setCount(synJxjyCases.size());
        synPage.setList(synJxjyCases.subList(synPage.getFirstResult(),synPage.getLastResult()));
        return synPage;
    }

    @Transactional(readOnly = false)
    public void syn(String id) {
       int ret = synJxjyCaseMapper.syn(Integer.valueOf(id));
    }

    @Transactional(readOnly = false)
    public void batchSyn(String[] seqs) {
        for(String id:seqs){
            synJxjyCaseMapper.syn(Integer.valueOf(id));
        }
    }

    public Page<Seal> findLockList(Page<Seal> sealPage, Seal seal) {
        List<Seal> seals = sealMapper.selectBySelective(seal);
        sealPage.setCount(seals.size());
        sealPage.setList(seals.subList(sealPage.getFirstResult(),sealPage.getLastResult()));
        return sealPage;
    }

    public int findLockCount(String ip) {
        return sealMapper.selectCountByName(ip);
    }
    @Transactional(readOnly = false)
    public void removeLockById(String id) {
        sealMapper.deleteByPrimaryKey(Long.valueOf(id));
    }


    @Transactional(readOnly = false)
    public void removeBatchLock(String[] seqs) {
        for(String id:seqs){
            sealMapper.deleteByPrimaryKey(Long.valueOf(id));
        }
    }
    @Transactional(readOnly = false)
    public void savePLan(Plan plan) {
        if (plan.getPlanId() != null) {
            planMapper.updateByPrimaryKey(plan);
        } else {
            planMapper.insert(plan);
        }
    }
}
