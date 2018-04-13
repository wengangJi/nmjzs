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
import com.zhongxin.cims.modules.ac.dao.PlanMapper;
import com.zhongxin.cims.modules.ac.entity.Plan;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * 字典工具类
 * @author ThinkGem
 * @version 2013-5-29
 */
public class PlanUtils {
	
	private static PlanMapper planDao = SpringContextHolder.getBean(PlanMapper.class);

	public static final String CACHE_PLAN_MAP = "planMap";
    public static final String CACHE_YEAR_PLAN_MAP ="yearPlanMap";
	
	public static Plan getPlanById(String planId){
		if (StringUtils.isNotBlank(planId)){
			for (Plan plan : getAllPlan(planId)){
				if (planId.equals(String.valueOf(plan.getPlanId()))){
					return plan;
				}
			}
		}
		return null;
	}

    public static List<Plan> getAllPlanByYear(String year){
        year ="2015";
        //取消年度，系统一律默认为2015
        Map<String, List<Plan>> yearPlanMap = (Map<String, List<Plan>>) CacheUtils.get(CACHE_YEAR_PLAN_MAP);
        if (yearPlanMap==null){
            yearPlanMap = Maps.newHashMap();
            for (Plan plan : planDao.findAll()){
                List<Plan> planList = yearPlanMap.get(plan.getYear());
                if (planList != null){
                    planList.add(plan);
                }else{
                    yearPlanMap.put(plan.getYear(), Lists.newArrayList(plan));
                }
            }
            CacheUtils.put(CACHE_YEAR_PLAN_MAP, yearPlanMap);
        }
        List<Plan> planListList = yearPlanMap.get(year);
        if (planListList == null){
            planListList = Lists.newArrayList();
        }
        return planListList;
    }



	
	public static List<Plan> getAllPlan(String type){
		@SuppressWarnings("unchecked")
		Map<String, List<Plan>> planMap = (Map<String, List<Plan>>) CacheUtils.get(CACHE_PLAN_MAP);
		if (planMap==null){
            planMap = Maps.newHashMap();
			for (Plan plan : planDao.findAll()){
				List<Plan> planList = planMap.get(plan.getPlanId());
				if (planList != null){
                    planList.add(plan);
				}else{
                    planMap.put(String.valueOf(plan.getPlanId()), Lists.newArrayList(plan));
				}
			}
			CacheUtils.put(CACHE_PLAN_MAP, planMap);
		}
		List<Plan> planListList = planMap.get(type);
		if (planListList == null){
            planListList = Lists.newArrayList();
		}
		return planListList;
	}

	public static void removeCache() {
		CacheUtils.remove(CACHE_PLAN_MAP);
		CacheUtils.remove(CACHE_YEAR_PLAN_MAP);
	}
	
}
