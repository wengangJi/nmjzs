package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.SoCpApprove;

import java.util.List;

@MyBatisDao

public interface SoCpApproveMapper {
    int insert(SoCpApprove record);

    int insertSelective(SoCpApprove record);

    int updateByPrimaryKey(SoCpApprove record);

    List<SoCpApprove> findSoCpApproveBySoid(String soid);
}