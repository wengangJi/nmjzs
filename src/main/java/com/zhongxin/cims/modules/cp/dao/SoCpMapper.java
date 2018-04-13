package com.zhongxin.cims.modules.cp.dao;

import java.util.List;
import java.util.Map;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.cp.entity.SoCpApprove;
import com.zhongxin.cims.modules.cp.entity.SoCpEntity;

/**
 * Created by lqyu_773 on 14-6-22.
 */
@MyBatisDao
public interface SoCpMapper {
    int insert(So record);
    public So findSoBySoid(String soid);
    public SoCpEntity findBySoid(String soid);
    public List<SoCpEntity> findSoCpList(SoCpEntity soCpEntity);
    public void removeSoByPrimaryKey(String soid);
    public List getCpCheckedList(Map map);
    public List<SoCpEntity> findSoCpProcessList(SoCpEntity soCpEntity);

}
