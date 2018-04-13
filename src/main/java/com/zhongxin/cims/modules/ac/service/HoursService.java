package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.ac.dao.SoHoursMapper;
import com.zhongxin.cims.modules.ac.dao.SoPlanMapper;
import com.zhongxin.cims.modules.ac.entity.SoHours;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Component
@Transactional(readOnly = true)
public class HoursService extends BaseService {
    @Autowired
    private SoHoursMapper soHoursMapper;

    @Autowired
    private SoPlanMapper soPlanMapper;

    @Transactional(readOnly = false)
    public void save(SoHours soHours){
        soHoursMapper.insert(soHours);
    }

    public List<SoHours> findByUserId(String id) {
        return soHoursMapper.findByUserId(id);
    }

    public List<SoHours> findReduceByUserId(String id) {
        return soHoursMapper.findReduceByUserId(id);
    }

    public SoHours get(String id) {
        return soHoursMapper.selectByPrimaryKey(new Long(id));
    }

   public List<SoHours> findBySoid(String soid){return soHoursMapper.selectBySoid(soid);}

   public List<SoHours> selectReduceBySoid(String soid){return soHoursMapper.selectReduceBySoid(soid);}




    @Transactional(readOnly = false)
    public void delete(String id) {
        soHoursMapper.deleteByPrimaryKey(new Long(id));
    }
    @Transactional(readOnly = false)
    public void modify(SoHours soHours) {
        soHoursMapper.updateByPrimaryKeySelective(soHours);
    }

    @Transactional(readOnly = false)
    public void auditReduceHours(SoHours soHours) {
        soHoursMapper.updateByPrimaryKey(soHours);
        if(!"1".equals(soHours.getAuditTag())){
            // 审核通过，更新主表，减免状态
            SoPlan soPlan = soPlanMapper.selectByPrimaryKey(soHours.getSoid());
            soPlan.setReduceFlag("1");
            soPlanMapper.updateByPrimaryKey(soPlan);
        }
    }

    public Page<SoHours> findAuditList(Page<SoHours> page, SoHours soHours) {
        List<SoHours> result = soHoursMapper.findAuditList(soHours);
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }


    public Page<SoHours> findAuditedList(Page<SoHours> page, SoHours soHours) {
       /* if(soHours!=null){
            if(soHours.getAuditLevel()!=null && !"".equals(soHours.getAuditLevel())){
                if(soHours.getAuditLevel().equals("0")){
                    soHours.setQryStr4("2");
                }
            }
        }*/
        List<SoHours> result = soHoursMapper.findAuditedList(soHours);
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    public Page<SoHours> findAuditedNoPassList(Page<SoHours> page, SoHours soHours) {
        List<SoHours> result = soHoursMapper.findAuditedNoPassList(soHours);
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    public Page<SoHours> findOwnAuditList(Page<SoHours> page, SoHours soHours) {
        List<SoHours> result = soHoursMapper.findOwnAuditList(soHours);
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    @Transactional(readOnly = false)
    public void audit(Long id, String auditTag, String auditRemark) {
        SoHours soHours = soHoursMapper.selectByPrimaryKey(id);
        soHours.setAuditTag(auditTag);
        soHours.setAuditBy(UserUtils.getUser().getId());
        soHours.setAuditDate(new Date());
        soHours.setRsrvStr1(auditRemark); // 审核信息
        soHoursMapper.updateByPrimaryKey(soHours);
    }
}
