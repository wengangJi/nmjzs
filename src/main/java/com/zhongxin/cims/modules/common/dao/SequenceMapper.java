package com.zhongxin.cims.modules.common.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.Sequence;

/**
 * Created by lqyu_773 on 14-6-21.
 */
@MyBatisDao
public interface SequenceMapper {
    int getNextValue(String sequenceName);
    int getCurrValue(String sequenceName);
    int initSequence(Sequence sequence);
}
