package com.zhongxin.cims.common.listener;


import com.zhongxin.cims.common.config.Constants;
import org.springframework.util.StringUtils;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.HashMap;

public class JspConstants extends HashMap<String, String> {

        public JspConstants() {
            Class c = Constants.class;
            Field[] fields = c.getDeclaredFields();
            for(Field field : fields) {
                int modifier = field.getModifiers();
                if(Modifier.isPublic(modifier) && Modifier.isStatic(modifier) && Modifier.isFinal(modifier)) {
                    try {
                        put(field.getName(), (String)field.get(null));
                    } catch(IllegalAccessException ignored) {
                    }
                }
            }
        }

        @Override
        public String get(Object key) {
            String result = super.get(key);
            if(StringUtils.isEmpty(result)) {
                throw new IllegalArgumentException("Check key! The key is wrong, no such constant!");
            }
            return result;
        }
    }
