/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.ac.service;

import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.ac.dao.AssociateConstructorMapper;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;
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
public class AssociateConstructorService extends BaseService {

	@Autowired
	private AssociateConstructorMapper associateConstructorMapper;

	/*public Page<AssociateConstructor> find(Page<AssociateConstructor> page, AssociateConstructor associateConstructor) {
        associateConstructor.setPage(page);
        page.setList(associateConstructorMapper.find(associateConstructor));
        return page;
	}*/

    public List<AssociateConstructor>  findListByIdNo(String name){
        return   associateConstructorMapper.findListByIdNo(name);

    }
	
}
