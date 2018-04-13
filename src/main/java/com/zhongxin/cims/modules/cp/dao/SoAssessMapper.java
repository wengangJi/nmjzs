package com.zhongxin.cims.modules.cp.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.cp.entity.SoAssess;

import java.util.List;

/**
 * Created by lqyu_773 on 14-6-22.
 */
@MyBatisDao
public interface SoAssessMapper {
    public List<SoAssess> findTodoTasks(SoAssess assess);
    public SoAssess findBySoid(String soid);
    public List<SoAssess> findAssessList(SoAssess assess);
    public List<SoAssess> findDoneTasks(SoAssess assess);

}
