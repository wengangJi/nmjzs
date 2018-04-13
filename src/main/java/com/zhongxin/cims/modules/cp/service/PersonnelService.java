/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.cp.service;

import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.modules.common.dao.ServAttachmentMapper;
import com.zhongxin.cims.modules.common.dao.SoMapper;
import com.zhongxin.cims.modules.common.entity.Serv;
import com.zhongxin.cims.modules.common.entity.ServAttachment;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoCache;
import com.zhongxin.cims.modules.cp.dao.*;
import com.zhongxin.cims.modules.cp.entity.*;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.activiti.engine.*;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang.ObjectUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.StringUtils;
import net.sf.ehcache.Cache;


import javax.servlet.ServletContext;
import java.util.List;

/**
 * 三类人员Service
 * @author liuqy
 * @version 2014-06-10
 */
@Component
@Transactional(readOnly = true)
public class PersonnelService extends BaseService {
    private static ServletContext context = SpringContextHolder.getBean(ServletContext.class);


    @Autowired
	private PersonnelDao personnelDao;
    @Autowired
    private PersonnelMapper personnelMapper;
    @Autowired
    private ServAttachmentMapper servAttachmentMapper;



	public Personnel get(String id) {
		return personnelDao.get(id);
	}

	public Page<Personnel> find(Page<Personnel> page, Personnel personnel) {

        personnel.setPage(page);
		page.setList(personnelMapper.find(personnel));
		return page;
	}

    public Page<Personnel> findPersonnelForExtend(Page<Personnel> page, Personnel personnel) {

        personnel.setPage(page);
        page.setList(personnelMapper.findPersonnelForExtend(personnel));
        return page;
    }
    public ServCpEntity findCpServInfoByIdNo(Integer companyId,String idNo,String personType) {
      return personnelMapper.findCpServInfoByIdNo(companyId,idNo,personType);
    }
    public ServCpEntity findCpServInfoById(Integer servId) {
        ServCpEntity servCpEntity =   personnelMapper.findCpServInfoById(servId);
        if(servCpEntity.getServCpResumes().size()==0){
            List<ServCpResume> servCpResumes =  personnelMapper.findPersonnelResumes(servId);
            servCpEntity.setServCpResumes(servCpResumes);
        }
        if(servCpEntity.getServCpPerformance()==null){
            ServCpPerformance servCpPerformance =  personnelMapper.findPersonnelPerformance(servId);
            servCpEntity.setServCpPerformance(servCpPerformance);
        }
        if(servCpEntity.getServAttachments()==null){
            List<ServAttachment> servAttachments =  servAttachmentMapper.selectByServid(servId);
            servCpEntity.setServAttachments(servAttachments);
        }
        List<ServAttachment> servAttachments =servAttachmentMapper.selectByServid(servId);
        if(!servAttachments.isEmpty()){
            for(ServAttachment servAttachment : servAttachments) {
                servAttachment.setUrl(context.getContextPath()+ Global.getAdminPath() + "/file/picture/"+servAttachment.getId());
                servAttachment.setThumbnailUrl(context.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + servAttachment.getId());
            }
            servCpEntity.setServAttachments(servAttachments);
        }

       return servCpEntity;
    }


    public List<Personnel> findListByIdNo(String name){
        //增加当前企业限制
        Personnel personnel = new Personnel();
        personnel.setIdNo(name);
        personnel.setCompanyId(UserUtils.getUser().getUserCompany().getCompanyId());
        return personnelMapper.findListByIdNo(personnel);
    }
    public List getDtree() {

       return  personnelMapper.getDtree();
    }
	@Transactional(readOnly = false)
	public void save(Personnel personnel) {
        personnelMapper.insertPersonnel(personnel);
	}
	
	@Transactional(readOnly = false)
	public void delete(String id) {
		personnelDao.deleteById(id);
	}

    public List<ServAttachment> findCpServAttachmentList(Integer servid) {

        return servAttachmentMapper.selectByServid(servid);
    }

}
