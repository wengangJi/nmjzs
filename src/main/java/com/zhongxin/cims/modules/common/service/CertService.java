package com.zhongxin.cims.modules.common.service;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.mapper.BeanCopierMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;
import com.zhongxin.cims.modules.common.dao.CertMapper;
import com.zhongxin.cims.modules.common.dao.SoMainCertMapper;
import com.zhongxin.cims.modules.common.dao.SoMapper;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoMainCert;
import com.zhongxin.cims.modules.cp.dao.SoCpBaseMapper;
import com.zhongxin.cims.modules.cp.entity.Personnel;
import com.zhongxin.cims.modules.cp.entity.ServCpEntity;
import com.zhongxin.cims.modules.eq.entity.QualifyCert;
import com.zhongxin.cims.modules.se.entity.SafetyEngineering;
import com.zhongxin.cims.modules.sys.entity.Tag;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.TagUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by lqyu_773 on 14-6-12.
 */
@Component
@Transactional(readOnly = true)
public class CertService {
    @Autowired
    private CertMapper certMapper;

    @Autowired
    private SoMainCertMapper soMainCertMapper;

    @Autowired
    private CertMapper servMainCertMapper;

    @Autowired
    private SoMapper soMapper;

    @Autowired
    private CompleteService completeService;


    /**
     * 分页查询
     * @param page
     * @param cert
     * @return
     */
    public Page<Cert> find(Page<Cert> page, Cert cert) {

        cert.setPage(page);
        page.setList(certMapper.find(cert));
        return page;
    }

    /**
     * 企业资质分页查询
     * @param page
     * @param cert
     * @return
     */
    public Page<QualifyCert> findeq(Page<QualifyCert> page, QualifyCert cert) {
        cert.setPage(page);
        page.setList(certMapper.findeq(cert));
        return page;
    }

    /**
     * 二级建造师人员信息
     * @param page
     * @param cert
     * @return
     */
    public Page<AssociateConstructor> findacPerson(Page<AssociateConstructor> page, AssociateConstructor cert) {
        cert.setPage(page);
        page.setList(certMapper.findacPerson(cert));
        return page;
    }

    /**
     * 二级建造师人员信息
     * @param page
     * @param cert
     * @return
     */
    public Page<AssociateConstructor> findacMajor(Page<AssociateConstructor> page, AssociateConstructor cert) {
        cert.setPage(page);
        page.setList(certMapper.findacMajor(cert));
        return page;
    }

    /**
     * 二级建造师人员信息
     * @param page
     * @param cert
     * @return
     */
    public Page<SafetyEngineering> findse(Page<SafetyEngineering> page, SafetyEngineering cert) {
        cert.setPage(page);
        page.setList(certMapper.findse(cert));
        return page;
    }

    /**
     * 待办证书查询
     * @param page
     * @param servCpEntity
     * @return
     */
    public Page<ServCpEntity> findCpAssignCert(Page<ServCpEntity> page, ServCpEntity servCpEntity) {
        servCpEntity.setPage(page);
        page.setList(certMapper.findCPAssignCert(servCpEntity));
        return page;
    }

    /**
     * 已制证书查询
     * @param page
     * @param servCpEntity
     * @return
     */
    public Page<ServCpEntity> findCpManagerCert(Page<ServCpEntity> page, ServCpEntity servCpEntity) {
        servCpEntity.setPage(page);
        page.setList(certMapper.findCpManagerCert(servCpEntity));
        return page;
    }

    /**
     * 待办证书查询企业
     * @param page
     * @param companyId
     * @return
     */
    public Page<ServCpEntity> findCPAssCertByCompanyId(Page<ServCpEntity> page, Integer companyId) {
        List<ServCpEntity>   servCpEntityList = certMapper.findCPAssCertByCompanyId(companyId);
        page.setCount(servCpEntityList.size());
        page.setList(servCpEntityList.subList(page.getFirstResult(),page.getLastResult()));
        return  page;
    }

    /**
     * 已制证书查询企业
     * @param page
     * @param companyId
     * @return
     */
    public Page<ServCpEntity> findCPManCertByCompanyId(Page<ServCpEntity> page,Integer companyId) {
        List<ServCpEntity> servCpEntityList = certMapper.findCPManCertByCompanyId(companyId);
        page.setCount(servCpEntityList.size());
        page.setList(servCpEntityList.subList(page.getFirstResult(),page.getLastResult()));
        return  page;
    }

    /**
     * 生成证书编号
     * @param soid
     */
    @Transactional(readOnly = false)
    public void geneCert(String soid,String personType){
        User user = UserUtils.getUser();

        String certNo = SeqUtils.getSequence("CP_CERT_NO_SEQ",personType,TagUtils.getProviceCode(),user.getUserCompany().getLocalId(),user.getUserCompany().getAreaId());
        SoMainCert soMainCert = new SoMainCert();
        soMainCert.setSoid(soid);
        //STS=0 待同步  STS=1表示同步完成
        //CERT_STS =0 表示待分配 CERT_STS =1 表示待发布 CERT_STS =2 已发布 CERT_STS =3 作废
        soMainCert.setCertSts("1");
        soMainCert.setCertDate(new Date());
        soMainCert.setCertNo(certNo);
        soMainCertMapper.updateBySoid(soMainCert);
    }

    /**
     * 取消生成证书编号,清空certNo,修改cert_sts状态
     * @param soid
     */
    @Transactional(readOnly = false)
    public void cancelGeneCert(String soid){

        SoMainCert soMainCert = new SoMainCert();
        soMainCert.setSoid(soid);
        soMainCert.setCertSts("0");
        soMainCert.setCertDate(new Date());
        soMainCert.setCertNo("");
        soMainCertMapper.updateBySoid(soMainCert);
    }

    @Transactional(readOnly = false)
    public void publishCert(String soid){
        Date effDate = new Date();
        String amount = TagUtils.getTagInfo("CP_CERT_EXP_DATE_OFFSET");
        String issueBy = TagUtils.getTagInfo("CP_CERT_ISSUE_BY");
        Date expDate = DateUtils.addYears(effDate,new Integer(amount));
        So so =  soMapper.selectByPrimaryKey(soid);
        if(so!=null && so.getSoType().equals(Constants.GLOBAL_SO_TYPE_EXTEND) && so.getServid()!=null){
           Cert servMainCert = servMainCertMapper.selectByServid(so.getServid());
            Cert extendServMainCert = new Cert();
            extendServMainCert.setServid(so.getServid());
            extendServMainCert.setStsDate(new Date());
            extendServMainCert.setExpDate(DateUtils.addYears(servMainCert.getExpDate(),new Integer(amount)));
            certMapper.updateByPrimaryKeySelective(extendServMainCert);

            SoMainCert soMainCert = new SoMainCert();
            soMainCert.setSoid(soid);
            soMainCert.setCertSts("2");
            soMainCert.setIssueBy(issueBy);
            soMainCert.setIssueDate(servMainCert.getEffDate());
            soMainCert.setCertDate(effDate);
            soMainCert.setStsDate(new Date());
            soMainCertMapper.updateBySoid(soMainCert);

        }else {
            SoMainCert soMainCert = new SoMainCert();
            soMainCert.setSoid(soid);
            soMainCert.setEffDate(effDate);
            soMainCert.setExpDate(expDate);
            soMainCert.setIssueBy(issueBy);
            soMainCert.setIssueDate(effDate);
            soMainCert.setCertSts("2");
            soMainCert.setCertDate(effDate);
            soMainCertMapper.updateBySoid(soMainCert);

            // 同步serv_main_cert表
            Cert cert = new Cert();
            soMainCert = soMainCertMapper.findBySoid(soid);
            BeanCopierMapper.copyProperties(soMainCert, cert);
            certMapper.insert(cert);
        }
       /* //调用竣工服务将原用户信息作废   目前是即时作废，从当前日期顺延 需要确认是否从到期日期顺延。若从到期日期顺延，那么允许存在两个证书信息。证书发布怎么处理？
        if(so!=null &&so.getServid()!=null){
            completeService.syncServRemove(so);
        }*/

    }

    @Transactional(readOnly = false)
    public void cancelCert(String soid){

        SoMainCert soMainCert = new SoMainCert();
        soMainCert.setSoid(soid);
        soMainCert.setCertSts("3");
        soMainCert.setCertDate(new Date());
        soMainCert.setSts("1");
        soMainCert.setStsDate(new Date());
        soMainCertMapper.updateBySoid(soMainCert);

        // 如果已经发布了，作废特殊处理,终止serv_main_cert
        soMainCert = soMainCertMapper.findBySoid(soid);
        if(soMainCert.getCertSts().equals("2")){
            Cert cert = new Cert();
            cert.setServid(soMainCert.getServid());
            cert.setCertSts(soMainCert.getCertSts());
            cert.setCertDate(soMainCert.getCertDate());
            cert.setSts(soMainCert.getSts());
            cert.setStsDate(soMainCert.getStsDate());
            certMapper.updateByServid(cert);
        }
    }
}
