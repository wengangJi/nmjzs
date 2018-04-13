/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/zhongxin/cims">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.zhongxin.cims.modules.sys.utils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.zhongxin.cims.common.utils.CacheUtils;
import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.modules.sys.dao.BatchDao;
import com.zhongxin.cims.modules.sys.entity.SysBatch;

import java.util.List;
import java.util.Map;

/**
 * 字典工具类
 * @author ThinkGem
 * @version 2013-5-29
 */
public class BatchUtils {
	
	private static BatchDao batchDao = SpringContextHolder.getBean(BatchDao.class);

	public static final String CACHE_BATCH_MAP = "CACHE_BATCH_MAP";
	

	
	public static List<SysBatch> getBatchListByCompanyId(Integer companyId){
		Map<String, List<SysBatch>> batchMap =  null ;//(Map<String, List<SysBatch>>)CacheUtils.get(CACHE_BATCH_MAP);
		if (batchMap==null){
            batchMap = Maps.newHashMap();
           for (SysBatch batch : batchDao.selectBactchListByCompanyId(companyId)){
				List<SysBatch> batchList = batchMap.get(batch.getCompanyId().toString());
				if (batchList != null){
                    batchList.add(batch);
				}else{
                    batchMap.put(batch.getCompanyId().toString(), Lists.newArrayList(batch));
				}
			}
			//CacheUtils.put(CACHE_BATCH_MAP, batchMap);
		}
		List<SysBatch> batchList = batchMap.get(companyId.toString());
		if (batchList == null){
            batchList = Lists.newArrayList();
		}


		return batchList;
	}

    public static List<SysBatch> getBatchListByAppId(String appId){
        Map<String, List<SysBatch>> batchMap =  null ;//(Map<String, List<SysBatch>>)CacheUtils.get(CACHE_BATCH_MAP);
        if (batchMap==null){
            batchMap = Maps.newHashMap();
            for (SysBatch batch : batchDao.selectBactchListByAppId(appId)){
                List<SysBatch> batchList = batchMap.get(batch.getAppId());
                if (batchList != null){
                    batchList.add(batch);
                }else{
                    batchMap.put(batch.getAppId(), Lists.newArrayList(batch));
                }
            }
            //CacheUtils.put(CACHE_BATCH_MAP, batchMap);
        }
        List<SysBatch> batchList = batchMap.get(appId);
        if (batchList == null){
            batchList = Lists.newArrayList();
        }


        return batchList;
    }

    public static List<SysBatch> getBactchAllByAppId(String appId){
        Map<String, List<SysBatch>> batchMap =  null ;//(Map<String, List<SysBatch>>)CacheUtils.get(CACHE_BATCH_MAP);
        if (batchMap==null){
            batchMap = Maps.newHashMap();
            for (SysBatch batch : batchDao.selectBactchAllByAppId(appId)){
                List<SysBatch> batchList = batchMap.get(batch.getAppId());
                if (batchList != null){
                    batchList.add(batch);
                }else{
                    batchMap.put(batch.getAppId(), Lists.newArrayList(batch));
                }
            }
            //CacheUtils.put(CACHE_BATCH_MAP, batchMap);
        }
        List<SysBatch> batchList = batchMap.get(appId);
        if (batchList == null){
            batchList = Lists.newArrayList();
        }


        return batchList;
    }

    public static SysBatch getBatchInfoByBatchId(String batchId){
        return batchDao.getBatchInfoByBatchId(batchId);
    }


}
