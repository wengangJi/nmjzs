package com.zhongxin.cims.modules.common.service;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;
import com.zhongxin.cims.modules.common.dao.*;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.CheckSo;
import com.zhongxin.cims.modules.common.entity.Serv;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.cp.dao.*;
import com.zhongxin.cims.modules.cp.entity.*;
import com.zhongxin.cims.modules.eq.entity.QualifyCert;
import com.zhongxin.cims.modules.se.entity.SafetyEngineering;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lqyu_773 on 14-6-12.
 */
@Component
@Transactional(readOnly = true)
public class CheckService {
    @Autowired
    private ServMapper servMapper;

    @Autowired
    private ServCpBaseMapper servCpBaseMapper;

    @Autowired
    private ServCpResumeMapper servCpResumeMapper;

    @Autowired
    private ServCpPerformanceMapper servCpPerformanceMapper;

    @Autowired
    private ServAttachmentMapper servAttachmentMapper;

    @Autowired
    private SoMapper soMapper;

    @Autowired
    private SoCpBaseMapper soCpBaseMapper;

    @Autowired
    private SoCpResumeMapper soCpResumeMapper;

    @Autowired
    private SoCpPerformanceMapper soCpPerformanceMapper;

    @Autowired
    private SoMainCertMapper soMainCertMapper;

    @Autowired
    private SoAttachmentMapper soAttachmentMapper;

    @Autowired
    private SequenceMapper sequenceMapper;


    /**
     * 申报总校验
     * @param soCpEntity
     * @return msg
     */
    public CheckSo checkSoBeforeSave(SoCpEntity soCpEntity) {
        CheckSo checkSo = new CheckSo();
        boolean  checkFlag = false;
        So so  = new So();
        SoCpBase soCpBase = new SoCpBase();
        List<SoCpResume> soCpResumes = new ArrayList<SoCpResume>();
        SoCpPerformance soCpPerformance = new SoCpPerformance();
        List<SoCpApprove> soCpApproves = new ArrayList<SoCpApprove>();
        if(soCpEntity.getSo()!=null) { so = soCpEntity.getSo();}
        if(soCpEntity.getSoCpBase()!=null){  soCpBase=soCpEntity.getSoCpBase();}
        if(soCpEntity.getSoCpResume()!=null){ soCpResumes =soCpEntity.getSoCpResume();}
        if(soCpEntity.getSoCpPerformance()!=null){ soCpPerformance = soCpEntity.getSoCpPerformance();}
        if(soCpEntity.getSoCpApprove()!=null){ soCpApproves=soCpEntity.getSoCpApprove();}

        //在途申报校验
        if(!checkFlag){
            checkFlag  = this.checkCompleteSoBeforeSave(so.getAppId(), so.getApplIdNo(), so.getSoType());
            if(checkFlag){
                checkSo.setMsg(Constants.CHECK_MSG_SO_COMPLETE_BEFORE);
            }
        }
        //在用用户校验
        if(!checkFlag&&!so.getSoType().equals(Constants.GLOBAL_SO_TYPE_EXTEND)&&!so.getSoType().equals(Constants.GLOBAL_SO_TYPE_REMOVE)){
            checkFlag  = this.checkServInfoBeforeSave(so.getAppId(), so.getApplIdNo(), soCpBase.getPersonType());
            if(checkFlag){
                checkSo.setMsg(Constants.CHECK_MSG_SERV_SAME_BEFORE);
            }

        }
        checkSo.setFlag(checkFlag);
        return checkSo;
    }

    /**
     * 在途申报校验
     * @param appId
     * @param idNo
     * @return
     */
    public boolean checkCompleteSoBeforeSave(String appId ,String idNo ,String soType) {
         boolean  checkFlag = false;
            List<So> soList = soMapper.findSoForCheckBefore(appId,idNo,soType);
           if(soList!=null&&soList.size()>0){
               checkFlag =true;
           }
        return checkFlag;
  }


    /**
     * 在用用户校验
     * @param appId
     * @param idNo
     * @return
     */
    public boolean checkServInfoBeforeSave(String appId ,String idNo ,String personType) {
        boolean  checkFlag = false;
        List<Serv> servList = servMapper.findServInfoBeforeSave(appId,idNo,personType);
        if(servList!=null && servList.size()>0){
            checkFlag =true;
        }
        return checkFlag;
    }


}
