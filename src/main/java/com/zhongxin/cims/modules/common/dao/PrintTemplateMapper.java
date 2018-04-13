package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.PrintTemplate;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface PrintTemplateMapper {
    int deleteByPrimaryKey(Long id);

    int insert(PrintTemplate record);

    int insertSelective(PrintTemplate record);

    PrintTemplate selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(PrintTemplate record);

    int updateByPrimaryKey(PrintTemplate record);

    // 单页方式
    List<PrintTemplate> findByCertTypeAndSoTypeAndPageNum(@Param(value = "certType") String certType, @Param(value = "soType") String soType, @Param(value = "pageNum") int pageNum);
    // 多页方式
    List<PrintTemplate> findByCertTypeAndSoType(@Param(value = "certType") String certType, @Param(value = "soType") String soType);

}