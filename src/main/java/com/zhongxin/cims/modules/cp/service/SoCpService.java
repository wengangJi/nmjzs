package com.zhongxin.cims.modules.cp.service;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.modules.common.dao.SoMainCertMapper;
import com.zhongxin.cims.modules.common.entity.SoMainCert;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.utils.FileUtils;
import com.zhongxin.cims.common.utils.excel.ExportExcel;
import com.zhongxin.cims.common.workflow.WorkflowUtils;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.dao.SoMapper;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import com.zhongxin.cims.modules.common.entity.SoCache;
import com.zhongxin.cims.modules.cp.dao.SoCpApproveMapper;
import com.zhongxin.cims.modules.cp.dao.SoCpBaseMapper;
import com.zhongxin.cims.modules.cp.dao.SoCpMapper;
import com.zhongxin.cims.modules.cp.dao.SoCpPerformanceMapper;
import com.zhongxin.cims.modules.cp.dao.SoCpResumeMapper;
import com.zhongxin.cims.modules.cp.entity.SoCpApprove;
import com.zhongxin.cims.modules.cp.entity.SoCpBase;
import com.zhongxin.cims.modules.cp.entity.SoCpEntity;
import com.zhongxin.cims.modules.cp.entity.SoCpPerformance;
import com.zhongxin.cims.modules.cp.entity.SoCpResume;
import com.zhongxin.cims.modules.sys.service.SysService;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;


/**
 * Created by jiwg on 14-6-29.
 */
@Component
@Transactional(readOnly = true)
public class SoCpService extends BaseService {
    private static ServletContext context = SpringContextHolder.getBean(ServletContext.class);


    @Autowired
    private SoCpMapper soCpMapper;
    @Autowired
    private SoMapper soDao;
    @Autowired
    private SoCpBaseMapper soCpBaseDao;
    @Autowired
    private SoCpResumeMapper soCpResumeDao;
    @Autowired
    private SoCpPerformanceMapper soCpPerformanceDao;
    @Autowired
    private SoCpApproveMapper soCpApproveDao;
    @Autowired
    private SoMainCertMapper soMainCertMapper;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private SysService sysService;
    @Autowired
    protected TaskService taskService;
    @Autowired
    protected HistoryService historyService;
    @Autowired
    protected RepositoryService repositoryService;
    @Autowired
    private IdentityService identityService;

    @Autowired
    private SoAttachmentMapper soAttachmentMapper;

    private String processDefinitionKey = "cpAssess";

    private String fileBaseDir = Global.getCkBaseDir();

    private String fileTmpDir = Global.getTmpDir();

    /**
     * 三类人员首页保存
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public int saveSo(So so){ return soDao.insert(so); }

    /**
     * 三类人员首页保存
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public int updateByPrimaryKey(So so){ return soDao.updateByPrimaryKey(so); }

    /**
     * 三类人员基本信息页保存
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public int saveSoCpBase(SoCpBase soCpBase){ return soCpBaseDao.insert(soCpBase); }

    /**
     * 三类人员简历信息页保存
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public int saveSoCpResume(SoCpResume soCpResume){ return soCpResumeDao.insert(soCpResume); }

    /**
     * 三类人员工程业绩页保存
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public int saveSoCpPerformance(SoCpPerformance soCpPerformance){ return soCpPerformanceDao.insert(soCpPerformance); }

    /**
     * 三类人员工程审核页保存
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public int saveSoCpApprove(SoCpApprove soCpApprove){ return soCpApproveDao.insert(soCpApprove); }


    /**
     * 根据申报单号修改申报状态
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public int updateStsByPrimaryKey(So so){  return soDao.updateStsByPrimaryKey(so); }

    /**
     * 根据申报单号获取
     * 三类人员全部信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public SoCpEntity findSoAllBySoid(String soid){

        SoCpEntity soCpEntity = new SoCpEntity();
            So so = soCpMapper.findSoBySoid(soid);
            SoCpBase soCpBase = soCpBaseDao.findSoCpBaseBySoid(soid);
            List<SoCpResume> soCpResumes = soCpResumeDao.findSoCpResumeBySoid(soid);
            SoCpPerformance soCpPerformance = soCpPerformanceDao.findSoCpPerformanceBySoid(soid);
            List<SoCpApprove> soCpApproves = soCpApproveDao.findSoCpApproveBySoid(soid);
            List<SoAttachment> soAttachments= soAttachmentMapper.selectBySoid(soid);
            SoMainCert soMainCert = soMainCertMapper.findBySoid(soid);

          if(!soAttachments.isEmpty()){
                    for(SoAttachment attachment : soAttachments) {
                        attachment.setUrl(context.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                        attachment.setThumbnailUrl(context.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
                    }
             }
            soCpEntity.setSo(so);
            soCpEntity.setSoCpBase(soCpBase);
            soCpEntity.setSoCpResume(soCpResumes);
            soCpEntity.setSoCpPerformance(soCpPerformance);
            soCpEntity.setSoCpApprove(soCpApproves);
            soCpEntity.setSoAttachments(soAttachments);
            soCpEntity.setSoMainCert(soMainCert);
        return soCpEntity;
    }

    /**
     * 根据申报单号获取
     * 三类人员申报信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public So findSoBySoid(String soid){
        return soCpMapper.findSoBySoid(soid);
    }


    /**
     * 根据申报单号获取
     * 三类人员基本信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public SoCpBase findSoCpBaseBySoid(String soid){
        return soCpBaseDao.findSoCpBaseBySoid(soid);
    }

    /**
     * 根据申报单号获取
     * 三类人员简历信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public List<SoCpResume> findSoCpResumeBySoid(String soid){
        return soCpResumeDao.findSoCpResumeBySoid(soid);
    }

    /**
     * 根据申报单号获取
     * 三类人员审批信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public List<SoCpApprove> findSoCpApproveBySoid(String soid){ return soCpApproveDao.findSoCpApproveBySoid(soid);  }

    /**
     * 根据申报单号获取
     * 三类人员业绩信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public SoCpPerformance findSoCpPerformanceBySoid(String soid){ return soCpPerformanceDao.findSoCpPerformanceBySoid(soid);  }

    /**
     * 根据申报单号获取
     * 三类人员附件信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public List<SoAttachment> findSoCpUploadBySoid(String soid){ return   soAttachmentMapper.selectBySoid(soid); }


    /**
     * 根据相关参数获取订单号
     * 三类人员附件信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public So findSoidByPara(String appId,String soType,String userId,Integer companyId,Integer localId){ return   soDao.findSoidByPara(appId,soType,userId,companyId,localId); }

    /**
     * 根据申报单号获取
     * 三类人员申报信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public SoCpEntity findBySoid(String soid){
        return soCpMapper.findBySoid(soid);
    }

    /**
     * 根据申报编号获取三类人员详细信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public SoCpEntity findSoCpInfo(SoCpEntity soCpEntity,String soid){
        if(soCpEntity!=null){
           soCpEntity.setSo(this.findSoBySoid(soid));
           soCpEntity.setSoCpBase(this.findSoCpBaseBySoid(soid));
           soCpEntity.setSoCpResume(this.findSoCpResumeBySoid(soid));
           soCpEntity.setSoCpPerformance(this.findSoCpPerformanceBySoid(soid));
           soCpEntity.setSoCpApprove(this.findSoCpApproveBySoid(soid));
        }
        return soCpEntity;
    }


    /**
     * 获取三类人员申报单列表信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public Page<SoCpEntity> findSoCpList(Page<SoCpEntity> page, SoCpEntity soCpEntity){
        List<SoCpEntity> soCpEntities = soCpMapper.findSoCpList(soCpEntity);
        page.setCount(soCpEntities.size());
        page.setList(soCpEntities.subList(page.getFirstResult(),page.getLastResult()));

        return page;
    }

    /**
     * 获取三类人员已提交申报列表
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    public Page<SoCpEntity> findSoCpProcessList(Page<SoCpEntity> page, SoCpEntity soCpEntity){
        List<SoCpEntity> soCpEntities = soCpMapper.findSoCpProcessList(soCpEntity);
        page.setCount(soCpEntities.size());
        page.setList(soCpEntities.subList(page.getFirstResult(),page.getLastResult()));

        return page;
    }



    /**
     * 删除三类人员申报单
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public void removeSoByPrimaryKey(String soid){
       soCpMapper.removeSoByPrimaryKey(soid);
    }


    /**
     * 三类人员申报提交方法
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public Integer save(SoCache soCache) {

        So so = soCache.getSo();
        SoCpBase soCpBase = soCache.getSoCpBase();
        List <SoCpResume> soCpResumeList = soCache.getSoCpResumeList();
        SoCpPerformance soCpPerformance = soCache.getSoCpPerformance();
        SoCpApprove soCpApprove = soCache.getSoCpApprove();

        String soId = SeqUtils.getSequence("SO_SEQ", ObjectUtils.toString(so.getLocalId()), so.getAppId(), so.getSoType());
        if(so!=null){
            so.setSoid(soId);
            soDao.insert(so);
        }
        if(soCpBase!=null){
            soCpBase.setSoid(soId);
            soCpBaseDao.insert(soCpBase);
        }
        if(soCpResumeList!=null){
            for (SoCpResume soCpResume :soCpResumeList)   {
                soCpResume.setSoid(soId);
                soCpResumeDao.insert(soCpResume);

            }
        }
        if(soCpPerformance!=null){
            soCpPerformance.setSoid(soId);
            soCpPerformanceDao.insert(soCpPerformance);
        }
        if(soCpApprove!=null){
            soCpApprove.setSoid(soId);
            soCpApproveDao.insert(soCpApprove);
        }

         /* SysBatch sysBatch = new SysBatch();
           sysBatch.setBatchId(so.getBatchId());
           sysBatch.setSts(Constants.SYS_BATCH_STS_USED);
           sysBatch.setStsDate(new Date());
          int ret = sysService.batchUpdateStatus(sysBatch);*/

        // 处理上传附件
        logger.debug("fileBaseDir = " + fileBaseDir);
        logger.debug("fileTmpDir = " + fileTmpDir);
        String path = fileBaseDir + so.getAppId()+"/"+so.getCompanyId()+"/"+soId+"/";
      /*  List<SoAttachment> soAttachments =soAttachmentMapper.selectBySessionId(soCache.getSessionId(),so.getAppId(),so.getSoType());
        if(!soAttachments.isEmpty()){*/
            soAttachmentMapper.updateBySoid(soId, path, soCache.getSessionId(),so.getAppId(),so.getSoType());
            //添加新上传的附件
       // }
        List<SoAttachment> attachments = soAttachmentMapper.selectBySoid(soId);
        for(SoAttachment attachment:attachments){
            String newFileName = attachment.getNewFilename();
            String thumbnailFileName = attachment.getThumbnailFilename();
            FileUtils.copyFile(fileTmpDir+newFileName,path + newFileName);
            FileUtils.copyFile(fileTmpDir+thumbnailFileName,path + thumbnailFileName);
        }

        return 0;

    }

    /**
     * 三类人员申报提交方法
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public String saveForm(SoCpEntity soCpEntity) {

        So so = soCpEntity.getSo();
        SoCpBase soCpBase = soCpEntity.getSoCpBase();
        List <SoCpResume> soCpResumeList = soCpEntity.getSoCpResume();
        SoCpPerformance soCpPerformance = soCpEntity.getSoCpPerformance();
        List <SoCpApprove> soCpApprove = soCpEntity.getSoCpApprove();
        SoMainCert soMainCert  = soCpEntity.getSoMainCert();

        String soId = SeqUtils.getSequence("SO_SEQ", ObjectUtils.toString(so.getLocalId()), so.getAppId(), so.getSoType());
        if(so!=null){
            so.setSoid(soId);
            soDao.insert(so);
        }
        if(soCpBase!=null){
            soCpBase.setSoid(soId);
            soCpBaseDao.insert(soCpBase);
        }
        if(soCpResumeList!=null){
            for (SoCpResume soCpResume :soCpResumeList)   {
                if(soCpResume.getEffDate()!=null){
                    soCpResume.setSoid(soId);
                    soCpResumeDao.insert(soCpResume);
                }
            }
        }
        if(soCpPerformance!=null){
            soCpPerformance.setSoid(soId);
            soCpPerformanceDao.insert(soCpPerformance);
        }

        if(soCpApprove!=null){
            for (SoCpApprove soCpAppr :soCpApprove)   {
                soCpAppr.setSoid(soId);
                soCpApproveDao.insert(soCpAppr);

            }
        }


       if(soMainCert!=null){
            soMainCert.setSoid(soId);
            soMainCertMapper.insert(soMainCert);
       }

        // 处理上传附件
        logger.debug("fileBaseDir = " + fileBaseDir);
        logger.debug("fileTmpDir = " + fileTmpDir);
        String path = fileBaseDir + so.getAppId()+"/"+so.getCompanyId()+"/"+soId+"/";
      /*  List<SoAttachment> soAttachments =soAttachmentMapper.selectBySessionId(soCache.getSessionId(),so.getAppId(),so.getSoType());
        if(!soAttachments.isEmpty()){*/
        soAttachmentMapper.updateBySoid(soId, path,soCpEntity.getSessionId(),so.getAppId(),so.getSoType());
        // }
        List<SoAttachment> attachments = soAttachmentMapper.selectBySoid(soId);
        for(SoAttachment attachment:attachments){
            String newFileName = attachment.getNewFilename();
            String thumbnailFileName = attachment.getThumbnailFilename();
            FileUtils.copyFile(fileTmpDir+newFileName,path + newFileName);
            FileUtils.copyFile(fileTmpDir+thumbnailFileName,path + thumbnailFileName);
        }

        return soId;

    }


    /**
     * 三类人员申报修改方法
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public String saveChgForm(SoCpEntity soCpEntity) {

        So so = soCpEntity.getSo();
        SoCpBase soCpBase = soCpEntity.getSoCpBase();
        List <SoCpResume> soCpResumeList = soCpEntity.getSoCpResume();
        SoCpPerformance soCpPerformance = soCpEntity.getSoCpPerformance();
        List <SoCpApprove> soCpApprove = soCpEntity.getSoCpApprove();
        List <SoAttachment> soAttachmentList = soCpEntity.getSoAttachments();

        if(so!=null){
            so.setSoid(soCpEntity.getSoid());
            soDao.updateByPrimaryKey(so);
        }
        if(soCpBase!=null){
            soCpBase.setSoid(soCpEntity.getSoid());
            soCpBaseDao.updateByPrimaryKey(soCpBase);
        }
        if(soCpResumeList!=null){
            for (SoCpResume soCpResume :soCpResumeList){
                soCpResume.setSoid(soCpEntity.getSoid());
                soCpResumeDao.updateByPrimaryKey(soCpResume);
            }
        }
        if(soCpPerformance!=null){
            soCpPerformance.setSoid(soCpEntity.getSoid());
            soCpPerformanceDao.updateByPrimaryKey(soCpPerformance);
        }

        if(soCpApprove!=null){
            for (SoCpApprove soCpAppr :soCpApprove)   {
                soCpAppr.setSoid(soCpEntity.getSoid());
                if(Constants.SO_APPR_ASS_STS_COMP.equals(soCpAppr.getApprType())){
                    soCpApproveDao.updateByPrimaryKey(soCpAppr);
              }
            }

         }

        if(soAttachmentList!=null){
            for (SoAttachment soAttachment :soAttachmentList){
                soAttachment.setSoid(soCpEntity.getSoid());
                if(soAttachment.getId()!=null){
                    if(soAttachment.getDeleteType().equals(Constants.GLOBAL_DELETE_TYPE))  {
                        soAttachment.setSts(Constants.GLOBAL_DELETE_TYPE);
                        soAttachmentMapper.removeByPrimaryKey(soAttachment);
                    }
                }
            }
        }


        // 处理上传附件
        logger.debug("fileBaseDir = " + fileBaseDir);
        logger.debug("fileTmpDir = " + fileTmpDir);
        String path = fileBaseDir + so.getAppId()+"/"+so.getCompanyId()+"/"+soCpEntity.getSoid()+"/";
      /*  List<SoAttachment> soAttachments =soAttachmentMapper.selectBySessionId(soCache.getSessionId(),so.getAppId(),so.getSoType());
        if(!soAttachments.isEmpty()){*/
        soAttachmentMapper.updateBySoid(soCpEntity.getSoid(), path,soCpEntity.getSessionId(),so.getAppId(),so.getSoType());
        // }
        List<SoAttachment> attachments = soAttachmentMapper.selectBySoid(soCpEntity.getSoid());
        for(SoAttachment attachment:attachments){
            String newFileName = attachment.getNewFilename();
            String thumbnailFileName = attachment.getThumbnailFilename();
            FileUtils.copyFile(fileTmpDir+newFileName,path + newFileName);
            FileUtils.copyFile(fileTmpDir+thumbnailFileName,path + thumbnailFileName);
        }

        return soCpEntity.getSoid();

    }
    /**
     * 三类人员申报提交方法
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @Transactional(readOnly = false)
    public Integer startProcess(So so) {

            //启动流程
            String businessKey = ObjectUtils.toString(so.getSoid());
            identityService.setAuthenticatedUserId(ObjectUtils.toString(so.getUserId()));
            Map<String,Object> variables = new HashMap<String, Object>();
            variables.put("initiator",so.getUserId());
            ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(processDefinitionKey,businessKey,variables);
            String processInstanceId = processInstance.getId();
            WorkflowUtils.claim(processInstanceId);
            Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();
            taskService.complete(task.getId());
            so.setBpmId(processInstanceId);
            so.setSts(Constants.SO_STS_COMMIT);
            so.setStsDate(new Date());
            so.setProcessSts(taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult().getName());
            soDao.updateByPrimaryKeySelective(so);
           return 0;
    }
    public  Page getCpCheckedList(Page page,Map map){
        List list = soCpMapper.getCpCheckedList(map);
        page.setCount(list.size());
        page.setList(list.subList(page.getFirstResult(),page.getLastResult()));
        return page;

    }
    public List uploadListIntoExcel(Map map,HttpServletResponse response){
        List list = soCpMapper.getCpCheckedList(map);
        List headerList= new ArrayList();
        headerList.add("姓名");
        headerList.add("性别");
        headerList.add("年龄");
        headerList.add("职务");
        headerList.add("人员类别");
        headerList.add("证件类型");
        headerList.add("证件号");
        headerList.add("有效期限");
        String fileName = "已审核数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
try {
    new ExportExcel("已审核数据", headerList).setDataList(list).write(response, fileName).dispose();
}
catch (Exception e) {
}
        return null;

    }



}
