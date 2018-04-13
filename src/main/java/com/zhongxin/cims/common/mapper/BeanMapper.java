/**
 * Copyright (c) 2005-2012 springside.org.cn
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.zhongxin.cims.common.mapper;

import java.lang.reflect.Field;
import java.util.*;

import com.zhongxin.cims.common.utils.ReflectionUtils;
import org.dozer.DozerBeanMapper;

import com.google.common.collect.Lists;

/**
 * 简单封装Dozer, 实现深度转换Bean<->Bean的Mapper.实现:
 *  
 * 1. 持有Mapper的单例. 
 * 2. 返回值类型转换.
 * 3. 批量转换Collection中的所有对象.
 * 4. 区分创建新的B对象与将对象A值复制到已存在的B对象两种函数.
 * 
 * @author calvin
 * @version 2013-01-15
 */
public class BeanMapper {

	/**
	 * 持有Dozer单例, 避免重复创建DozerMapper消耗资源.
	 */
	private static DozerBeanMapper dozer = new DozerBeanMapper();

	/**
	 * 基于Dozer转换对象的类型.
	 */
	public static <T> T map(Object source, Class<T> destinationClass) {
		return dozer.map(source, destinationClass);
	}

	/**
	 * 基于Dozer转换Collection中对象的类型.
	 */
	@SuppressWarnings("rawtypes")
	public static <T> List<T> mapList(Collection sourceList, Class<T> destinationClass) {
		List<T> destinationList = Lists.newArrayList();
		for (Object sourceObject : sourceList) {
			T destinationObject = dozer.map(sourceObject, destinationClass);
			destinationList.add(destinationObject);
		}
		return destinationList;
	}

	/**
	 * 基于Dozer将对象A的值拷贝到对象B中.
	 */
	public static void copy(Object source, Object destinationObject) {
		dozer.map(source, destinationObject);
	}

	/**
	 * 将目标对象的所有属性转换成Map对象
	 *
	 * @param target 目标对象
	 *
	 * @return Map
	 */
	public static <T> Map<String, T> toMap(Object target) {
		return toMap(target,false);
	}

	/**
	 * 将目标对象列表的所有属性转换成Map对象列表
	 *
	 * @param target 目标对象
	 *
	 * @return Map
	 */
	public static <T> List<Map<String, Object>> toMap(List<T> target) {
		List<Map<String,Object>> maps = new ArrayList<Map<String, Object>>();
		for (T obj:target) {
			maps.add(toMap(obj));
		}
		return maps;
	}

	/**
	 * 将目标对象的所有属性转换成Map对象
	 *
	 * @param target 目标对象
	 * @param ignoreParent 是否忽略父类的属性
	 *
	 * @return Map
	 */
	public static <T> Map<String, T> toMap(Object target,boolean ignoreParent) {
		return toMap(target, ignoreParent, false);
	}

	/**
	 * 将目标对象的所有属性转换成Map对象
	 *
	 * @param target 目标对象
	 * @param ignoreParent 是否忽略父类的属性
	 * @param ignoreEmptyValue 是否不把空值添加到Map中
	 *
	 * @return Map
	 */
	public static <T> Map<String, T> toMap(Object target,boolean ignoreParent,boolean ignoreEmptyValue) {
		return toMap(target,ignoreParent,ignoreEmptyValue,new String[0]);
	}

	/**
	 * 将目标对象的所有属性转换成Map对象
	 *
	 * @param target 目标对象
	 * @param ignoreParent 是否忽略父类的属性
	 * @param ignoreEmptyValue 是否不把空值添加到Map中
	 * @param ignoreProperties 不需要添加到Map的属性名
	 *
	 * @return Map
	 */
	public static <T> Map<String, T> toMap(Object target,boolean ignoreParent,boolean ignoreEmptyValue,String... ignoreProperties) {
		Map<String, T> map = new HashMap<String, T>();

		List<Field> fields = ReflectionUtils.getAccessibleFields(target.getClass(), ignoreParent);

		for (Iterator<Field> it = fields.iterator(); it.hasNext();) {
			Field field = it.next();
			T value = null;

			try {
				value = (T) field.get(target);
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (ignoreEmptyValue
					&& ((value == null || value.toString().equals(""))
					|| (value instanceof Collection && ((Collection<?>) value).isEmpty())
					|| (value instanceof Map && ((Map<?,?>)value).isEmpty()))) {
				continue;
			}

			boolean flag = true;
			String key = field.getName();

			for (String ignoreProperty:ignoreProperties) {
				if (key.equals(ignoreProperty)) {
					flag = false;
					break;
				}
			}

			if (flag) {
				map.put(key, value);
			}
		}

		return map;
	}
}