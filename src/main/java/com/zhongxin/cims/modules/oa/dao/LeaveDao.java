/**
 * There are <a href="https://github.com/zhongxin/cims">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.oa.dao;

import org.springframework.stereotype.Repository;

import com.zhongxin.cims.common.persistence.BaseDao;
import com.zhongxin.cims.common.persistence.Parameter;
import com.zhongxin.cims.modules.oa.entity.Leave;

/**
 * 请假DAO接口
 * @author liuj
 * @version 2013-8-23
 */
@Repository
public class LeaveDao extends BaseDao<Leave> {
	
	public int updateProcessInstanceId(String id,String processInstanceId){
		return update("update Leave set processInstanceId=:p1 where id = :p2", new Parameter(processInstanceId, id));
	}
	
}
