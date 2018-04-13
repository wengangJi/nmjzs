package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.SoInvoice;

import java.util.List;

@MyBatisDao
public interface SoInvoiceMapper {
    int deleteByPrimaryKey(String soid);

    int insert(SoInvoice record);

    int insertSelective(SoInvoice record);

    SoInvoice selectByPrimaryKey(String soid);

    int updateByPrimaryKeySelective(SoInvoice record);

    int updateByPrimaryKey(SoInvoice record);

    List<SoInvoice> findList(SoInvoice soInvoice);

}