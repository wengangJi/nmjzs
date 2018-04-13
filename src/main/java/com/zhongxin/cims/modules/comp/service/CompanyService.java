/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.comp.service;

import com.zhongxin.cims.modules.common.entity.Serv;
import com.zhongxin.cims.modules.common.service.ServService;
import com.zhongxin.cims.modules.comp.dao.CompanyMapper;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.modules.comp.entity.Company;
import com.zhongxin.cims.modules.comp.dao.CompanyDao;

import java.util.List;

/**
 * 企业Service
 * @author liuqy
 * @version 2014-06-10
 */
@Component
@Transactional(readOnly = true)
public class CompanyService extends BaseService {

	@Autowired
	private CompanyDao companyDao;

    @Autowired
    private CompanyMapper companyMapper;

	
	public Company get(Integer id) {
		//return companyDao.get(id);
        return companyMapper.selectByPrimaryKey(id);
	}

    public Company getByNameOrOrgCode(Company company) {
        return companyMapper.selectByNameOrOrgCode(company);
    }

    public List<Company> findByName(String name){
        return  companyMapper.selectByName(name);
    }
	
	@Transactional(readOnly = false)
	public void save(Company company) {
		companyDao.save(company);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
        companyMapper.deleteByPrimaryKey(new Integer(id));
	}

    public Page<Company> getList(Page<Company> page, Company company) {
        company.setPage(page);
        page.setList(companyMapper.selectList(company));
        return page;
    }

    @Transactional(readOnly = false)
    public void edit(Company company) {
        companyMapper.updateByPrimaryKey(company);
    }

    @Transactional(readOnly = false)
    public void updateCompanyNameById(Company company) {
        companyMapper.updateByPrimaryKeySelective(company);
    }

}
