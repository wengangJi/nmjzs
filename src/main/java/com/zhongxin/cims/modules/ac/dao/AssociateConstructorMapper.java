package com.zhongxin.cims.modules.ac.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;

import java.util.List;

/**
 * Created by lqyu_773 on 14-6-12.
 */

@MyBatisDao
public interface AssociateConstructorMapper {
    //List<AssociateConstructor> find(AssociateConstructor associateConstructor);
    List<AssociateConstructor> findListByIdNo(String name);
}
