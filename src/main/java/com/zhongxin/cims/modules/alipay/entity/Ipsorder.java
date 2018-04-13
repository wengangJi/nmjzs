package com.zhongxin.cims.modules.alipay.entity;

import com.zhongxin.cims.common.persistence.BaseEntity;
import com.zhongxin.cims.common.utils.excel.annotation.ExcelField;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/9/12
 * Time: 8:56
 * To change this template use File | Settings | File Templates.
 */

public class Ipsorder extends BaseEntity<Ipsorder> {
    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid;
    }

    //so表id
    @ExcelField(title="申报单号", align=2, sort=2)
    private String soid;
    //支付宝流水id

    @ExcelField(title="支付流水号", align=2, sort=1)
    private String alipayId;
    //用户id

    private String userId;
    //支付流水创建时间
    @ExcelField(title="交易时间", align=2, sort=4)
    private Date createTime;
    //支付状态

    private String status;
    //支付状态修改时间
    private Date modifyTime;
    //该笔交易金额
    @ExcelField(title="交易金额(元)", align=2, sort=5)
    private  String fee;

    public String getLocalId() {
        return localId;
    }

    public void setLocalId(String localId) {
        this.localId = localId;
    }

    private  String localId;

    public String getFeeType() {
        return feeType;
    }

    public void setFeeType(String feeType) {
        this.feeType = feeType;
    }

    private  String feeType;

    private String id;

    private String feeState;

    private String rsrvStr1;
    @ExcelField(title="交易状态", align=2, sort=6)
    private String rsrvStr2;
    @ExcelField(title="支付人", align=2, sort=3)
    private String rsrvStr3;

    private String rspCode;

    private String rspDesc;
    private Date rspDate;

    private String auditTag;
    private String auditBy;
    private Date  auditDate;

    public String getRspCode() {
        return rspCode;
    }

    public void setRspCode(String rspCode) {
        this.rspCode = rspCode;
    }

    public String getRspDesc() {
        return rspDesc;
    }

    public void setRspDesc(String rspDesc) {
        this.rspDesc = rspDesc;
    }

    public Date getRspDate() {
        return rspDate;
    }

    public void setRspDate(Date rspDate) {
        this.rspDate = rspDate;
    }

    public String getAuditTag() {
        return auditTag;
    }

    public void setAuditTag(String auditTag) {
        this.auditTag = auditTag;
    }

    public String getAuditBy() {
        return auditBy;
    }

    public void setAuditBy(String auditBy) {
        this.auditBy = auditBy;
    }

    public Date getAuditDate() {
        return auditDate;
    }

    public void setAuditDate(Date auditDate) {
        this.auditDate = auditDate;
    }



    public String getRsrvStr1() {
        return rsrvStr1;
    }

    public void setRsrvStr1(String rsrvStr1) {
        this.rsrvStr1 = rsrvStr1;
    }

    public String getRsrvStr2() {
        return rsrvStr2;
    }

    public void setRsrvStr2(String rsrvStr2) {
        this.rsrvStr2 = rsrvStr2;
    }

    public String getRsrvStr3() {
        return rsrvStr3;
    }

    public void setRsrvStr3(String rsrvStr3) {
        this.rsrvStr3 = rsrvStr3;
    }



    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getFeeState() {
        return feeState;
    }

    public void setFeeState(String feeState) {
        this.feeState = feeState;
    }

    private String planId;

    public String getFee() {
        return fee;
    }

    public void setFee(String fee) {
        this.fee = fee;
    }



    public String getAlipayId() {
        return alipayId;
    }

    public void setAlipayId(String alipayId) {
        this.alipayId = alipayId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }



    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
