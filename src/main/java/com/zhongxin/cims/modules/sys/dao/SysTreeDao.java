/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/zhongxin/cims">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.zhongxin.cims.modules.sys.dao;

import com.zhongxin.cims.common.persistence.BaseDao;
import com.zhongxin.cims.common.persistence.Parameter;
import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.sys.entity.SysTreeMenu;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 栏目DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@Repository
@MyBatisDao
public class SysTreeDao extends BaseDao<SysTreeMenu> {
	
	public List<SysTreeMenu> findByParentIdsLike(String parentIds){
		return find("from SysTreeMenu where parentIds like :p1", new Parameter(parentIds));
	}

	public List<SysTreeMenu> findByModule(String module){
		return find("from SysTreeMenu where delFlag=:p1 and (module='' or module=:p2) order by site.id, sort",
				new Parameter(SysTreeMenu.DEL_FLAG_NORMAL, module));
	}
	
	public List<SysTreeMenu> findByParentId(String parentId, String isMenu){
		return find("from SysTreeMenu where delFlag=:p1 and parent.id=:p2 and inMenu=:p3 order by site.id, sort",
				new Parameter(SysTreeMenu.DEL_FLAG_NORMAL, parentId, isMenu));
	}

	public List<SysTreeMenu> findByParentIdAndSiteId(String parentId, String siteId){
		return find("from SysTreeMenu where delFlag=:p1 and parent.id=:p2 and site.id=:p3 order by site.id, sort",
				new Parameter(SysTreeMenu.DEL_FLAG_NORMAL, parentId, siteId));
	}
	
	public List<SysTreeMenu> findByIdIn(String[] ids){
		return find("from SysTreeMenu where id in (:p1)", new Parameter(new Object[]{ids}));
	}

	
}
