package com.zhongxin.cims.modules.common.service;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.mapper.BeanCopierMapper;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.modules.common.dao.*;
import com.zhongxin.cims.modules.common.entity.*;
import com.zhongxin.cims.modules.comp.dao.CompanyMapper;
import com.zhongxin.cims.modules.cp.dao.*;
import com.zhongxin.cims.modules.cp.entity.*;
import com.zhongxin.cims.modules.sys.utils.TagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by lqyu_773 on 14-7-5.
 */
@Service
@Transactional(readOnly = true)
public class CompleteService extends BaseService {
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
    private CertMapper servMainCertMapper;

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

    @Autowired
    private CompanyMapper companyMapper;

    @Transactional(readOnly = false)
    public void complete(){
        logger.debug("竣工程序开始执行：");
        // 扫描未完工工单
        List<So> soList = soMapper.findBySts(Constants.SO_STS_AUDITED);
        // 完工处理
        for(So so:soList){
            logger.debug("处理第一条数据-soid= " + so.getSoid());
            if(so.getSoType().equals(Constants.GLOBAL_SO_TYPE_SO))   //新增申报
            {
                this.syncServInsert(so);
            }
            if(so.getSoType().equals(Constants.GLOBAL_SO_TYPE_EXTEND))//延期申报
            {
                //this.syncServInsert(so);
                //扫描SERV_MAIN_CERT 表证书到期日期，若为超过了当前日期，进行作废处理
                //this.syncServRemove(so);
                this.syncServExtend(so);
            }
            if(so.getSoType().equals(Constants.GLOBAL_SO_TYPE_REMOVE)) //注销申报
            {
               this.syncServRemove(so);
            }
            if(so.getSoType().equals(Constants.GLOBAL_SO_TYPE_CHANGE)) //变更申报
            {
                //this.syncServUpdate(so);
            }

        }

    }

    public void syncServInsert(So so){
        // 生成序列
        Integer servId = sequenceMapper.getNextValue("SERV_SEQ");
        // 生成状态时间
        Date stsDate = new Date();
        Date complDate = new Date();
        logger.debug("服务实例编码： " + servId);
        //t_serv
        Serv serv = new Serv();
        // 主表拷贝
        BeanCopierMapper.copyProperties(so,serv);

        serv.setServid(servId);
        serv.setSts(Constants.SERV_STS_NOMAL);
        serv.setStsDate(stsDate);
        serv.setComplDate(complDate);
        servMapper.insert(serv);

        //serv_cp_base
        SoCpBase soCpBase = soCpBaseMapper.findSoCpBaseBySoid(so.getSoid());
        if(soCpBase != null && soCpBase.getSoid() != null){
            ServCpBase servCpBase = new ServCpBase();
            BeanCopierMapper.copyProperties(soCpBase,servCpBase);
            servCpBase.setServid(servId);
            servCpBase.setSts(Constants.SERV_STS_NOMAL);
            servCpBase.setStsDate(stsDate);
            servCpBaseMapper.insert(servCpBase);
        }


        //serv_cp_resume
        List<SoCpResume> soCpResumeList = soCpResumeMapper.findSoCpResumeBySoid(so.getSoid());
        for(SoCpResume soCpResume:soCpResumeList){
            ServCpResume servCpResume = new ServCpResume();
            BeanCopierMapper.copyProperties(soCpResume,servCpResume);
            servCpResume.setServid(servId);
            servCpResume.setSts(Constants.SERV_STS_NOMAL);
            servCpResume.setStsDate(stsDate);
            servCpResumeMapper.insert(servCpResume);
        }

        //serv_cp_performance
        SoCpPerformance soCpPerformance = soCpPerformanceMapper.findSoCpPerformanceBySoid(so.getSoid());
        if(soCpPerformance != null && soCpPerformance.getSoid() != null){
            ServCpPerformance servCpPerformance = new ServCpPerformance();
            BeanCopierMapper.copyProperties(soCpPerformance,servCpPerformance);
            servCpPerformance.setServid(servId);
            servCpPerformance.setSts(Constants.SERV_STS_NOMAL);
            servCpPerformance.setStsDate(stsDate);
            servCpPerformanceMapper.insert(servCpPerformance);
        }


        //serv_attrachment
        List<SoAttachment> soAttachments = soAttachmentMapper.selectBySoid(so.getSoid());
        for(SoAttachment soAttachment:soAttachments){
            ServAttachment servAttachment = new ServAttachment();
            BeanCopierMapper.copyProperties(soAttachment,servAttachment);
            servAttachment.setServid(servId);
            servAttachment.setSts(Constants.SERV_STS_NOMAL);
            servAttachment.setStsDate(stsDate);
            servAttachmentMapper.insert(servAttachment);
        }

        // so_main_cert
        SoMainCert soMainCert = new SoMainCert();
        soMainCert.setSoid(so.getSoid());
        soMainCert.setServid(servId);
        soMainCert.setCompanyId(so.getCompanyId());
        soMainCert.setRsrvStr1(companyMapper.selectByPrimaryKey(so.getCompanyId()).getCompanyName());//公司名称
        soMainCert.setSts("0"); //0待同步  1同步完成
        soMainCert.setStsDate(stsDate);
        soMainCert.setCertDate(stsDate);
        soMainCert.setCertSts("0"); //CERT_STS =0 表示待分配 CERT_STS =1 表示待发布 CERT_STS =2 已发布 CERT_STS =3 作废
        //'1 安全合格证 2 安全许可证 3 一级建造师 4 二级建造师 5 一级临时建造师 6 二级临时建造师 7 企业资质证书'
        if(Constants.GLOBAL_CP_APP_ID.equals(so.getAppId())){
            soMainCert.setCertType("1");
        } else if(Constants.GLOBAL_AC_APP_ID.equals(so.getAppId())) {
            soMainCert.setCertType("4");
        } else if(Constants.GLOBAL_EQ_APP_ID.equals(so.getAppId())) {
            soMainCert.setCertType("7");
        } else if(Constants.GLOBAL_SE_APP_ID.equals(so.getAppId())) {
            soMainCert.setCertType("2");
        }

        soMainCertMapper.insert(soMainCert);

        // 更改订单主表为竣工状态
        so.setSts(Constants.SO_STS_FINISH);
        so.setCompDate(complDate);
        so.setServid(servId);
        soMapper.updateByPrimaryKey(so);
    }

    public void syncServRemove(So so){
        // 生成序列
        Integer servId = so.getServid();
        // 生成状态时间
        Date stsDate = new Date();
        Date complDate = new Date();
        logger.debug("服务实例编码： " + servId);

         //serv
        Serv serv =  servMapper.selectByPrimaryKey(servId);
        if(serv != null && serv.getServid() != null){
            Serv removeServ = new Serv();
            removeServ.setServid(servId);
            removeServ.setSts(Constants.SERV_STS_REMOVE);
            removeServ.setStsDate(stsDate);
           servMapper.updateByPrimaryKeySelective(removeServ);
        }
        //serv_cp_base
        ServCpBase servCpBase = servCpBaseMapper.selectByPrimaryKey(servId);
        if(servCpBase != null && servCpBase.getServid() != null){
            ServCpBase removeServCpBase = new ServCpBase();
            removeServCpBase.setServid(servId);
            removeServCpBase.setSts(Constants.SERV_STS_REMOVE);
            removeServCpBase.setStsDate(stsDate);
            servCpBaseMapper.updateByPrimaryKeySelective(removeServCpBase);
        }

        //serv_cp_resume
        List<ServCpResume> servCpResumeList = servCpResumeMapper.selectByPrimaryKey(servId);
        for(ServCpResume servCpResume:servCpResumeList){
            ServCpResume removeServCpResume = new ServCpResume();
            removeServCpResume.setServid(servId);
            removeServCpResume.setSts(Constants.SERV_STS_REMOVE);
            removeServCpResume.setStsDate(stsDate);
            servCpResumeMapper.updateByPrimaryKeySelective(removeServCpResume);
        }

        //serv_cp_performance
        ServCpPerformance servCpPerformance = servCpPerformanceMapper.selectByPrimaryKey(servId);
        if(servCpPerformance != null && servCpPerformance.getServid()!= null){
            ServCpPerformance removeServCpPerformance = new ServCpPerformance();
            removeServCpPerformance.setServid(servId);
            removeServCpPerformance.setSts(Constants.SERV_STS_REMOVE);
            removeServCpPerformance.setStsDate(stsDate);
            servCpPerformanceMapper.updateByPrimaryKeySelective(removeServCpPerformance);
        }


        //serv_attrachment
        List<ServAttachment> servAttachmentList = servAttachmentMapper.selectByServid(servId);
        for(ServAttachment servAttachment:servAttachmentList){
            ServAttachment removeServAttachment = new ServAttachment();
            removeServAttachment.setServid(servId);
            removeServAttachment.setSts(Constants.SERV_STS_REMOVE);
            removeServAttachment.setStsDate(stsDate);
            servAttachmentMapper.updateByServidSelective(removeServAttachment);
        }

        // serv_main_cert
        Cert servMainCert =   servMainCertMapper.selectByServid(servId);
        if(servMainCert!=null && servMainCert.getServid()!=null){
            Cert removeServMainCert   = new Cert();
            removeServMainCert.setServid(servId);
            removeServMainCert.setCertSts("3"); //CERT_STS =0 表示待分配 CERT_STS =1 表示待发布 CERT_STS =2 已发布 CERT_STS =3 作废
            removeServMainCert.setCertDate(stsDate);
            removeServMainCert.setSts(Constants.SERV_STS_REMOVE);
            removeServMainCert.setStsDate(stsDate);

            servMainCertMapper.updateByPrimaryKeySelective(removeServMainCert);
        }

        // 更改订单主表为竣工状态
        so.setSts(Constants.SO_STS_FINISH);
        so.setCompDate(complDate);
        soMapper.updateByPrimaryKey(so);
    }

    public void syncServExtend(So so){
        // 生成序列
        Integer servId = so.getServid();
        // 生成状态时间
        Date stsDate = new Date();
        Date complDate = new Date();
        logger.debug("服务实例编码： " + servId);


        //serv_attrachment
        List<SoAttachment> soAttachments = soAttachmentMapper.selectBySoid(so.getSoid());
        for(SoAttachment soAttachment:soAttachments){
            ServAttachment servAttachment = new ServAttachment();
            BeanCopierMapper.copyProperties(soAttachment,servAttachment);
            servAttachment.setServid(servId);
            servAttachment.setSts(Constants.SERV_STS_NOMAL);
            servAttachment.setStsDate(stsDate);
            servAttachmentMapper.insert(servAttachment);
        }

        // so_main_cert
        SoMainCert soMainCert = new SoMainCert();
        Cert servMainCert = servMainCertMapper.selectByServid(so.getServid());
        if(servMainCert!=null && servMainCert.getExpDate()!=null){
          soMainCert.setEffDate(servMainCert.getExpDate());
          soMainCert.setExpDate(DateUtils.addYears(servMainCert.getExpDate(), new Integer(TagUtils.getTagInfo("CP_CERT_EXP_DATE_OFFSET"))));
        }
        if(servMainCert!=null && servMainCert.getCertNo()!=null){
            soMainCert.setCertNo(servMainCert.getCertNo());
        }
        soMainCert.setSoid(so.getSoid());
        soMainCert.setServid(servId);
        soMainCert.setCompanyId(so.getCompanyId());
        soMainCert.setRsrvStr1(companyMapper.selectByPrimaryKey(so.getCompanyId()).getCompanyName());//公司名称
        soMainCert.setSts("0"); //0待同步  1同步完成
        soMainCert.setStsDate(stsDate);
        soMainCert.setCertDate(stsDate);
        soMainCert.setCertSts("1"); //CERT_STS =0 表示待分配 CERT_STS =1 表示待发布 CERT_STS =2 已发布 CERT_STS =3 作废
        //'1 安全合格证 2 安全许可证 3 一级建造师 4 二级建造师 5 一级临时建造师 6 二级临时建造师 7 企业资质证书'
        if(Constants.GLOBAL_CP_APP_ID.equals(so.getAppId())){
            soMainCert.setCertType("1");
        } else if(Constants.GLOBAL_AC_APP_ID.equals(so.getAppId())) {
            soMainCert.setCertType("4");
        } else if(Constants.GLOBAL_EQ_APP_ID.equals(so.getAppId())) {
            soMainCert.setCertType("7");
        } else if(Constants.GLOBAL_SE_APP_ID.equals(so.getAppId())) {
            soMainCert.setCertType("2");
        }

        soMainCertMapper.insert(soMainCert);

        // 更改订单主表为竣工状态
        so.setSts(Constants.SO_STS_FINISH);
        so.setCompDate(complDate);
        //if(!so.getSoType().equals(Constants.GLOBAL_SO_TYPE_SO))so.setServid(servId);
        soMapper.updateByPrimaryKey(so);
    }


}
