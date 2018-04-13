package com.zhongxin.cims.modules.alipay.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.alipay.entity.Ipsorder;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/9/12
 * Time: 8:56
 * To change this template use File | Settings | File Templates.
 */
@MyBatisDao
public interface AlipayDao  {

    void makeDataIntoAlipayTable(Ipsorder ipsorder);

    List<Ipsorder> getIpsorderList(SoPlan soPlan);

    List<Ipsorder> getNoIpsorderList(SoPlan soPlan);

    List<Ipsorder> getIpsorderListByUser(String userId);

    List<Ipsorder> getIpsorderTotleByUser(String userId);

    List<Ipsorder> getIpsorderTotle(SoPlan soPlan);

    List<Ipsorder> getNoIpsorderListByUser(String userId);

    void updateAlipayStatus(Ipsorder ipsorder);

    Ipsorder   selectByPrimaryKey(String alipayId);

    int updateByPrimaryKeySelective(Ipsorder ipsorder);
}
