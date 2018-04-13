package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface SoAttachmentMapper {
    int deleteByPrimaryKey(Long id);

    int insert(SoAttachment record);

    int insertSelective(SoAttachment record);

    SoAttachment selectByPrimaryKey(Long id);

    SoAttachment selectComByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(SoAttachment record);

    int removeImage(@Param("soid") String soid,@Param("appId")String appId,@Param("soType") String soType);

    int confirmImage(SoAttachment record);

    int updateImage(SoAttachment record);

    int updateByPrimaryKey(SoAttachment record);

    int removeByPrimaryKey(SoAttachment record);

    List<SoAttachment> selectBySoid(String soid);
    List<SoAttachment> selectAuditBySoid(@Param("soid") String soid,@Param("appId")String appId,@Param("soType") String soType);
    int selectMaxBySoid(@Param("soid") String soid,@Param("appId")String appId,@Param("soType") String soType);

    List<SoAttachment> selectConfirmBySoid(@Param("soid") String soid,@Param("appId")String appId,@Param("soType") String soType);
    List<SoAttachment> selectBySessionId(@Param("sessionid") String sessionid,@Param("appId")String appId,@Param("soType") String soType);
    int updateBySoid(@Param("soid") String soid, @Param("path") String path, @Param("sessionid") String sessionid,@Param("appId") String appId,@Param("soType") String soType);
    int selectByVideo(@Param("soid") String soid,@Param("appId")String appId,@Param("soType") String soType);
    List<SoAttachment> selectMaxConfirmBySoid(@Param("soid") String soid);

    List<SoAttachment> findBySelective(SoAttachment soAttachment);
    List<SoAttachment> findHisBySelective(SoAttachment soAttachment);
}