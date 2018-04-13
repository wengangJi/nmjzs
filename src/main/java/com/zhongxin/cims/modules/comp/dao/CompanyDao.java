/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.comp.dao;

import org.springframework.stereotype.Repository;

import com.zhongxin.cims.common.persistence.BaseDao;
import com.zhongxin.cims.common.persistence.Parameter;
import com.zhongxin.cims.modules.comp.entity.Company;

/**
 * 企业DAO接口
 * @author liuqy
 * @version 2014-06-10
 */
@Repository
public class CompanyDao extends BaseDao<Company> {
    public Company getCompanyById(Integer companyId) {
        return getByHql("from Company where sts='0' and companyId=:p1", new Parameter(companyId));
    }
	
}
