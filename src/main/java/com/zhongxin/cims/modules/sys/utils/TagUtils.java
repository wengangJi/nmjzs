package com.zhongxin.cims.modules.sys.utils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.zhongxin.cims.common.utils.CacheUtils;
import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.modules.sys.dao.TagMapper;
import com.zhongxin.cims.modules.sys.entity.Tag;

import java.util.List;
import java.util.Map;

/**
 * Created by lqyu_773 on 14-8-3.
 */
public class TagUtils {
    private static TagMapper tagMapper = SpringContextHolder.getBean(TagMapper.class);

    public static final String CACHE_TAG_MAP = "tagMap";

    /**
     * 获取TAG，当未找到记录时，返回null
     * @param tagCode
     * @param provinceId
     * @param localId
     * @param areaId
     * @return
     */
    public static Tag getTag(String tagCode,String provinceId,Integer localId,Integer areaId){
        if(StringUtils.isNotBlank(tagCode)){
            for(Tag tag:getTagList(tagCode)){
                if(tagCode.equals(tag.getTagCode())){
                    if((provinceId.equals(tag.getProvinceId())||tag.getProvinceId().equals("ZZ"))&&(localId==tag.getLocalId()||tag.getLocalId()==-1)&&(areaId==tag.getAreaId()||tag.getAreaId()==-1)){
                        return tag;
                    }
                }
            }
        }
        return null;
    }

        /**
         * 获取tag_char值,未找到纪录时，返回默认值
         * @param tagCode
         * @param provinceId
         * @param localId
         * @param areaId
         * @param defaultValue
         * @return
         */
    public static String getTagChar(String tagCode,String provinceId,Integer localId,Integer areaId, String defaultValue){
        if(StringUtils.isNotBlank(tagCode)){
            for(Tag tag:getTagList(tagCode)){
                if(tagCode.equals(tag.getTagCode())){
                    if((provinceId.equals(tag.getProvinceId())||tag.getProvinceId().equals("ZZ"))&&(localId==tag.getLocalId()||tag.getLocalId()==-1)&&(areaId==tag.getAreaId()||tag.getAreaId()==-1)){
                        return tag.getTagChar();
                    }
                }
            }
        }
        return defaultValue;
    }

    /**
     * 获取tag_info的值
     * @param tagCode
     * @param provinceId
     * @param localId
     * @param areaId
     * @param defaultValue
     * @return
     */
    public static String getTagInfo(String tagCode,String provinceId,Integer localId,Integer areaId, String defaultValue){
        if(StringUtils.isNotBlank(tagCode)){
            for(Tag tag:getTagList(tagCode)){
                if(tagCode.equals(tag.getTagCode())){
                    if((provinceId.equals(tag.getProvinceId())||tag.getProvinceId().equals("ZZ"))&&(localId==tag.getLocalId()||tag.getLocalId()==-1)&&(areaId==tag.getAreaId()||tag.getAreaId()==-1)){
                        return tag.getTagInfo();
                    }
                }
            }
        }
        return defaultValue;
    }

    /**
     * 获取tag_info的值
     * @param tagCode
     * @return
     */
    public static String getTagInfo(String tagCode){
        String tagInfo = "";
        if(StringUtils.isNotBlank(tagCode)){
            for(Tag tag:getTagList(tagCode)){
                if(tagCode.equals(tag.getTagCode())){
                    tagInfo = tag.getTagInfo();
                }
            }
        }
        return tagInfo;
    }

    public static List<Tag> getTagList(String tagCode){
        @SuppressWarnings("unchecked")
        Map<String, List<Tag>> tagMap = (Map<String, List<Tag>>) CacheUtils.get(CACHE_TAG_MAP);
        if (tagMap==null || tagMap !=null){//始终从数据库提取
            tagMap = Maps.newHashMap();
            for (Tag tag : tagMapper.findAll()){
                List<Tag> tagList = tagMap.get(tag.getTagCode());
                if (tagList != null){
                    tagList.add(tag);
                }else{
                    tagMap.put(tag.getTagCode(), Lists.newArrayList(tag));
                }
            }
            CacheUtils.put(CACHE_TAG_MAP, tagMap);
        }
        List<Tag> dictList = tagMap.get(tagCode);
        if (dictList == null){
            dictList = Lists.newArrayList();
        }
        return dictList;
    }

    public static String getProviceCode(){
        return getTagInfo("PUBLIC_CURRENT_PROVINCE_CODE");
    }
}
