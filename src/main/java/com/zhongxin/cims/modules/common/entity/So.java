package com.zhongxin.cims.modules.common.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.modules.cp.entity.SoCpBase;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

import java.util.Date;
import java.util.Map;

public class So extends BaseEntity<So> {
    private String soid;

    private String qrId;

    private String appId;

    private String soType;

    private String flowId;

    private String bpmId;

    private String batchId;

    private Integer companyId;

    private String userId;

    private String provinceId;

    private Integer localId;

    private Integer areaId;

    private String applPerson;

    private Date applDate;

    private String applIdNo;

    private String audiFlag;

    private Date audiDate;

    private String repoFlag;

    private Date repoDate;

    private String notiFlag;

    private Date notiDate;

    private String appeFlag;

    private Date appeDate;

    private String warnFlag;

    private Date warnDate;

    private String batchFlag;

    private Date batchDate;

    private String processSts;

    private Date processDate;

    private Integer servid;

    private Date compDate;

    private String rsrvStr1;

    private String rsrvStr2;

    private String rsrvStr3;

    private String remarks;

    private String sts;

    private Date stsDate;

    // 临时属性
    private String pass;
    private boolean audit;
    private String consistentOriginal;//是否与原件一致
    private String backActivity;// 驳回环节
    private String auditRemarks;
    private String pageModule;

    public String getSeal() {
        return seal;
    }

    public void setSeal(String seal) {
        this.seal = seal;
    }

    private String seal;

    //临时属性
    private String sex;

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    private String idType;
    private Date birthDate;

    //-- 临时属性 --//

    // 流程任务
    private Task task;

    private Map<String, Object> variables;

    // 运行中的流程实例
    private ProcessInstance processInstance;

    // 历史的流程实例
    private HistoricProcessInstance historicProcessInstance;

    // 流程定义
    private ProcessDefinition processDefinition;

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    private Date createDate;



    public String getPageModule() {
        return pageModule;
    }

    public void setPageModule(String pageModule) {
        this.pageModule = pageModule;
    }


    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public boolean isAudit() {
        return audit;
    }

    public void setAudit(boolean audit) {
        this.audit = audit;
    }

    public String getAuditRemarks() {
        return auditRemarks;
    }

    public void setAuditRemarks(String auditRemarks) {
        this.auditRemarks = auditRemarks;
    }

    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid;
    }

    public String getQrId() {
        return qrId;
    }

    public void setQrId(String qrId) {
        this.qrId = qrId == null ? null : qrId.trim();
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId == null ? null : appId.trim();
    }

    public String getSoType() {
        return soType;
    }

    public void setSoType(String soType) {
        this.soType = soType == null ? null : soType.trim();
    }

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId == null ? null : flowId.trim();
    }

    public String getBpmId() {
        return bpmId;
    }

    public void setBpmId(String bpmId) {
        this.bpmId = bpmId == null ? null : bpmId.trim();
    }

    public String getBatchId() {
        return batchId;
    }

    public void setBatchId(String batchId) {
        this.batchId = batchId == null ? null : batchId.trim();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId == null ? null : provinceId.trim();
    }

    public Integer getLocalId() {
        return localId;
    }

    public void setLocalId(Integer localId) {
        this.localId = localId;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public String getApplPerson() {
        return applPerson;
    }

    public void setApplPerson(String applPerson) {
        this.applPerson = applPerson == null ? null : applPerson.trim();
    }

    public Date getApplDate() {
        return applDate;
    }

    public void setApplDate(Date applDate) {
        this.applDate = applDate;
    }

    public String getApplIdNo() {
        return applIdNo;
    }

    public void setApplIdNo(String applIdNo) {
        this.applIdNo = applIdNo == null ? null : applIdNo.trim();
    }

    public String getAudiFlag() {
        return audiFlag;
    }

    public void setAudiFlag(String audiFlag) {
        this.audiFlag = audiFlag == null ? null : audiFlag.trim();
    }

    public Date getAudiDate() {
        return audiDate;
    }

    public void setAudiDate(Date audiDate) {
        this.audiDate = audiDate;
    }

    public String getRepoFlag() {
        return repoFlag;
    }

    public void setRepoFlag(String repoFlag) {
        this.repoFlag = repoFlag == null ? null : repoFlag.trim();
    }

    public Date getRepoDate() {
        return repoDate;
    }

    public void setRepoDate(Date repoDate) {
        this.repoDate = repoDate;
    }

    public String getNotiFlag() {
        return notiFlag;
    }

    public void setNotiFlag(String notiFlag) {
        this.notiFlag = notiFlag == null ? null : notiFlag.trim();
    }

    public Date getNotiDate() {
        return notiDate;
    }

    public void setNotiDate(Date notiDate) {
        this.notiDate = notiDate;
    }

    public String getAppeFlag() {
        return appeFlag;
    }

    public void setAppeFlag(String appeFlag) {
        this.appeFlag = appeFlag == null ? null : appeFlag.trim();
    }

    public Date getAppeDate() {
        return appeDate;
    }

    public void setAppeDate(Date appeDate) {
        this.appeDate = appeDate;
    }

    public String getWarnFlag() {
        return warnFlag;
    }

    public void setWarnFlag(String warnFlag) {
        this.warnFlag = warnFlag == null ? null : warnFlag.trim();
    }

    public Date getWarnDate() {
        return warnDate;
    }

    public void setWarnDate(Date warnDate) {
        this.warnDate = warnDate;
    }

    public String getBatchFlag() {
        return batchFlag;
    }

    public void setBatchFlag(String batchFlag) {
        this.batchFlag = batchFlag == null ? null : batchFlag.trim();
    }

    public Date getBatchDate() {
        return batchDate;
    }

    public void setBatchDate(Date batchDate) {
        this.batchDate = batchDate;
    }

    public String getProcessSts() {
        return processSts;
    }

    public void setProcessSts(String processSts) {
        this.processSts = processSts;
    }

    public Date getProcessDate() {
        return processDate;
    }

    public void setProcessDate(Date processDate) {
        this.processDate = processDate;
    }

    public Integer getServid() {
        return servid;
    }

    public void setServid(Integer servid) {
        this.servid = servid;
    }

    public Date getCompDate() {
        return compDate;
    }

    public void setCompDate(Date compDate) {
        this.compDate = compDate;
    }

    public String getRsrvStr1() {
        return rsrvStr1;
    }

    public void setRsrvStr1(String rsrvStr1) {
        this.rsrvStr1 = rsrvStr1 == null ? null : rsrvStr1.trim();
    }

    public String getRsrvStr2() {
        return rsrvStr2;
    }

    public void setRsrvStr2(String rsrvStr2) {
        this.rsrvStr2 = rsrvStr2 == null ? null : rsrvStr2.trim();
    }

    public String getRsrvStr3() {
        return rsrvStr3;
    }

    public void setRsrvStr3(String rsrvStr3) {
        this.rsrvStr3 = rsrvStr3 == null ? null : rsrvStr3.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getSts() {
        return sts;
    }

    public void setSts(String sts) {
        this.sts = sts == null ? null : sts.trim();
    }

    public Date getStsDate() {
        return stsDate;
    }

    public void setStsDate(Date stsDate) {
        this.stsDate = stsDate;
    }


    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public Map<String, Object> getVariables() {
        return variables;
    }

    public void setVariables(Map<String, Object> variables) {
        this.variables = variables;
    }

    public ProcessInstance getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(ProcessInstance processInstance) {
        this.processInstance = processInstance;
    }

    public HistoricProcessInstance getHistoricProcessInstance() {
        return historicProcessInstance;
    }

    public void setHistoricProcessInstance(HistoricProcessInstance historicProcessInstance) {
        this.historicProcessInstance = historicProcessInstance;
    }

    public ProcessDefinition getProcessDefinition() {
        return processDefinition;
    }

    public void setProcessDefinition(ProcessDefinition processDefinition) {
        this.processDefinition = processDefinition;
    }

    public String getConsistentOriginal() {
        return consistentOriginal;
    }

    public void setConsistentOriginal(String consistentOriginal) {
        this.consistentOriginal = consistentOriginal;
    }

    public String getBackActivity() {
        return backActivity;
    }

    public void setBackActivity(String backActivity) {
        this.backActivity = backActivity;
    }
}