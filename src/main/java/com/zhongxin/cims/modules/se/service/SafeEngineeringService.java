/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.se.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.modules.se.entity.Safe;
import com.zhongxin.cims.modules.se.dao.SafeDao;

/**
 * 安全许可Service
 * @author liuqy
 * @version 2014-06-06
 */
@Component
@Transactional(readOnly = true)
public class SafeEngineeringService extends BaseService {

	@Autowired
	private SafeDao safeDao;
	
	public Safe get(String id) {
		return safeDao.get(id);
	}
	
	public Page<Safe> find(Page<Safe> page, Safe safe) {
		DetachedCriteria dc = safeDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(safe.getName())){
			dc.add(Restrictions.like("name", "%"+safe.getName()+"%"));
		}
		dc.add(Restrictions.eq(Safe.FIELD_DEL_FLAG, Safe.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return safeDao.find(page, dc);
	}
	
	@Transactional(readOnly = false)
	public void save(Safe safe) {
		safeDao.save(safe);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		safeDao.deleteById(id);
	}
	
}
