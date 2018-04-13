package com.zhongxin.cims.common.mapper;

import com.alibaba.tamper.BeanCopy;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by lqyu_773 on 14-7-13.
 */
public class BeanCopierMapper {
    public static Map<String, BeanCopy> beanCopierMap = new HashMap<String, BeanCopy>();


    public static void copyProperties(Object source, Object target) {

        String beanKey = generateKey(source.getClass(), target.getClass());

        BeanCopy copier = null;

        if (!beanCopierMap.containsKey(beanKey)) {

            copier = BeanCopy.create(source.getClass(), target.getClass());

            beanCopierMap.put(beanKey, copier);

        } else {

            copier = beanCopierMap.get(beanKey);

        }

        copier.copy(source, target);

    }

    private static String generateKey(Class<?> class1, Class<?> class2) {

        return class1.toString() + class2.toString();

    }
}
