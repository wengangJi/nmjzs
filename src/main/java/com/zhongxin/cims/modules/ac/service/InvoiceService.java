package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.ac.dao.SoInvoiceMapper;
import com.zhongxin.cims.modules.ac.entity.SoInvoice;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by lqyu_773 on 2014/8/30.
 */
@Component
@Transactional(readOnly = true)
public class InvoiceService extends BaseService {
    @Autowired
    private SoInvoiceMapper invoiceMapper;

    public SoInvoice findBySoid(String soid){  return  invoiceMapper.selectByPrimaryKey(soid); }


    public Page<SoInvoice> findList(Page<SoInvoice> page, SoInvoice soInvoice) {
        List<SoInvoice> result = invoiceMapper.findList(soInvoice);
        page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    public List<SoInvoice> exportList(SoInvoice soInvoice) {
        List<SoInvoice> result = invoiceMapper.findList(soInvoice);
        if(result!=null && result.size()>0){
            for(SoInvoice soInvoice1:result){
                if(soInvoice1.getFee()!=null && !"".equals(soInvoice1.getFee())){
                    soInvoice1.setRsrvStr2(soInvoice1.getFee().toString());
                }
                if(soInvoice1.getUserId()!=null && !"".equals(soInvoice1.getUserId())){
                    soInvoice1.setRsrvStr3(UserUtils.getUserById(soInvoice1.getUserId()).getName());
                }
                if(soInvoice1.getRemark()!=null && !"".equals(soInvoice1.getRemark())){
                    soInvoice1.setRsrvStr1(soInvoice1.getRemark());
                }
                if(soInvoice1.getCompanyName()!=null && !"".equals(soInvoice1.getCompanyName())){
                    soInvoice1.setCompanyName("线下支付");
                }else{
                    soInvoice1.setCompanyName("在线支付");
                }

            }
        }
     /*   page.setCount(result.size());
        page.setList(result.subList(page.getFirstResult(),page.getLastResult()));*/
        return result;
    }

    @Transactional(readOnly = false)
    public void audit(String soid, String auditTag,String auditInfo, String expressCode) {
        SoInvoice soInvoice = invoiceMapper.selectByPrimaryKey(soid);
        soInvoice.setAuditTag(auditTag);
        soInvoice.setAuditDate(new Date());
        soInvoice.setAuditBy(UserUtils.getUser().getId());
        soInvoice.setAuditInfo(auditInfo);
        soInvoice.setRsrvStr1(expressCode);
        invoiceMapper.updateByPrimaryKey(soInvoice);
    }
}
