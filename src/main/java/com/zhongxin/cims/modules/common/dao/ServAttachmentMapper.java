package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.ServAttachment;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface ServAttachmentMapper {
    int deleteByPrimaryKey(Long id);

    int insert(ServAttachment record);

    int insertSelective(ServAttachment record);

    ServAttachment selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(ServAttachment record);

    int updateByServidSelective(ServAttachment record);

    int updateByPrimaryKey(ServAttachment record);

    List<ServAttachment> selectByServid(Integer servid);
    //List<SoAttachment> selectBySessionId(@Param("sessionid") String sessionid, @Param("appId") String appId, @Param("soType") String soType);
   // int updateBySoid(@Param("soid") String soid, @Param("path") String path, @Param("sessionid") String sessionid, @Param("appId") String appId, @Param("soType") String soType);
}