package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.Serv;
import com.zhongxin.cims.modules.common.entity.ServPub;
import com.zhongxin.cims.modules.cp.entity.Personnel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface ServMapper {
    int insert(Serv record);

    int insertSelective(Serv record);

    Serv selectByPrimaryKey(Integer servId);

    int updateByPrimaryKeySelective(Serv record);

    List<Serv> findeq(Serv record);

    List<ServPub> findPersonListById(String name);

    List<Serv> findServInfoBeforeSave(@Param("appId") String appid,@Param("idNo") String idNo,@Param("personType") String soType);

}