/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.sys.service;
import  java.util.*;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.modules.cms.entity.Category;
import com.zhongxin.cims.modules.sys.dao.BatchDao;
import com.zhongxin.cims.modules.sys.dao.SysTreeDao;
import com.zhongxin.cims.modules.sys.entity.SysBatch;
import com.zhongxin.cims.modules.sys.entity.SysTreeMenu;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;


import java.util.HashMap;
import java.util.List;
import java.util.Set;

/**
 * 企业Service
 * @author liuqy
 * @version 2014-06-10
 */
@Component
@Transactional(readOnly = false)
public class SysService extends BaseService {

   @Autowired
   private SysTreeDao sysTreeDao;
    @Autowired
    private BatchDao batchDao;

    public SysTreeMenu get(String id){
        return sysTreeDao.get(id);
    }
   public List<SysTreeMenu> findTreeMenuListByApp(boolean isCurrentSite, String appId){

            DetachedCriteria dc = sysTreeDao.createDetachedCriteria();
            dc.add(Restrictions.eq("delFlag", Category.DEL_FLAG_NORMAL));
            dc.add(Restrictions.eq("appId", appId));
            List<SysTreeMenu> list = sysTreeDao.find(dc);
            // 将没有父节点的节点，找到父节点
            Set<String> parentIdSet = Sets.newHashSet();
            for (SysTreeMenu e : list){
                if (e.getParent()!=null && StringUtils.isNotBlank(e.getParent().getId())){
                    boolean isExistParent = false;
                    for (SysTreeMenu e2 : list){
                        if (e.getParent().getId().equals(e2.getId())){
                            isExistParent = true;
                            break;
                        }
                    }
                    if (!isExistParent){
                        parentIdSet.add(e.getParent().getId());
                    }
                }

            if (parentIdSet.size() > 0){
                dc = sysTreeDao.createDetachedCriteria();
                dc.add(Restrictions.in("id", parentIdSet));
                dc.add(Restrictions.eq("delFlag", Category.DEL_FLAG_NORMAL));
                list.addAll(0, sysTreeDao.find(dc));
            }
        }

        if (isCurrentSite){
            List<SysTreeMenu> categoryList = Lists.newArrayList();
            for (SysTreeMenu e : list){
                categoryList.add(e);
            }
            return categoryList;
        }
        return list;
    }


    public Page<SysBatch> getBatchList(Page<SysBatch> page, SysBatch sysBatch) {
        sysBatch.setPage(page);
        page.setList(batchDao.selectBactchList(sysBatch));
        return page;
    }

    public List<SysBatch> getBatchListByCompanyId(Integer companyId) {
        List<SysBatch> list  = batchDao.selectBactchListByCompanyId(companyId);
        return list;
    }

    public List<SysBatch> getBatchSeqList(SysBatch sysBatch) {
        List<SysBatch> list  = batchDao.selectBactchSeq(sysBatch);
        return list;
    }

    @Transactional(readOnly = false)
    public int saveSysBatch(SysBatch sysBatch){

        return batchDao.insert(sysBatch);
    }

   public int batchUpdateStatus(SysBatch sysBatch){

        return  batchDao.updateBatchStsByPk(sysBatch);

   }

   public SysBatch geneSysBatch(String appid,String batchType ){
       SysBatch sysBatch = new SysBatch();
       User user = UserUtils.getUser();
       if (user != null) {
           sysBatch.setBatchYear(Integer.valueOf(DateUtils.getYear()));
           sysBatch.setBatchMonth(Integer.valueOf(DateUtils.getMonth()));
           sysBatch.setCompanyId(user.getUserCompany().getCompanyId());
           List list =this.getBatchSeqList(sysBatch);
           int index = new Integer(Constants.SYS_BATCH_BEGIN_SEQ).intValue();
           if (list != null) {
               index = index +list.size();
           }
           sysBatch.setAppId(appid);
           sysBatch.setBatchType(batchType);
           sysBatch.setBatchSeq(index);
           sysBatch.setCreateDate(new Date());
           sysBatch.setCreateBy(user.getId());
           sysBatch.setSts(Constants.SYS_BATCH_STS_COMMIT);
           sysBatch.setStsDate(new Date());
           sysBatch.setBatchId(sysBatch.geneSysBatchId());
           sysBatch.setBatchName(sysBatch.geneSysBatchName());
       }
       return sysBatch;
   }
}
