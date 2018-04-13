/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.ac.dao.ServAssociateConstructorMapper;
import com.zhongxin.cims.modules.ac.entity.ServAssociateConstructor;
import com.zhongxin.cims.modules.comp.entity.Company;
import com.zhongxin.cims.modules.comp.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 二级建造师Service
 * @author liuqy
 * @version 2014-06-12
 */
@Component
@Transactional(readOnly = true)
public class ServAssociateConstructorService extends BaseService {

	@Autowired
	private ServAssociateConstructorMapper servAssociateConstructorMapper;
    @Autowired
    private CompanyService companyService;

	@Transactional(readOnly = true)
     public ServAssociateConstructor findByUserId(String userId){
        return   servAssociateConstructorMapper.findByUserId(userId);

    }

    @Transactional(readOnly = true)
    public Page<ServAssociateConstructor> qryServAcInfo(Page<ServAssociateConstructor> page, ServAssociateConstructor servAcInfo) {
        List<ServAssociateConstructor> servAssociateConstructorList = servAssociateConstructorMapper.findByServAcInfo(servAcInfo);
        page.setCount(servAssociateConstructorList.size());
        page.setList(servAssociateConstructorList.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    @Transactional(readOnly = true)
    public boolean checkServExist(ServAssociateConstructor servAcForm){
       ServAssociateConstructor servAssociateConstructor = servAssociateConstructorMapper.checkServExist(servAcForm.getIdNo(),servAcForm.getCertNo());
        if(servAssociateConstructor==null){
            return true;
        }
        return false;

    }

    @Transactional(readOnly = false)
    public void saveForm(ServAssociateConstructor servAssociateConstructor){
        servAssociateConstructorMapper.insert(servAssociateConstructor);

    }

    @Transactional(readOnly = false)
    public void modifyForm(ServAssociateConstructor servAssociateConstructor){
        if(servAssociateConstructor!=null){
            if(servAssociateConstructor.getRsrvStr1()!=null && !"".equals(servAssociateConstructor.getRsrvStr1())){
                Company company = new Company();
                company.setCompanyId(servAssociateConstructor.getCompanyId());
                company.setCompanyName(servAssociateConstructor.getRsrvStr1());
                companyService.updateCompanyNameById(company);
            }
            servAssociateConstructorMapper.updateByPrimaryKeySelective(servAssociateConstructor);
        }


    }
	
}
