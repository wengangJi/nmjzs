package com.zhongxin.cims.modules.sys.utils;

import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.modules.common.dao.SequenceMapper;
import com.zhongxin.cims.modules.sys.entity.Tag;
import org.apache.commons.lang3.ObjectUtils;

import java.util.List;

/**
 * Created by lqyu_773 on 14-6-29.
 */
public class SeqUtils {

    private static SequenceMapper sequenceMapper = SpringContextHolder.getBean(SequenceMapper.class);

    /**
     * 根据序列名称获取序列的下一个值
     * @param seqName
     * @return
     */
    public static int getNextValue(String seqName){
        return sequenceMapper.getNextValue(seqName);
    }

    /**
     * 根据序列名称获取序列当前值
     * @param seqName
     * @return
     */
    public static int getCurrValue(String seqName){
        return sequenceMapper.getCurrValue(seqName);
    }

    /**
     * 获取申请单号
     * @param seqName
     * @param localId
     * @param appId
     * @param soType
     * @return
     */
    public static String getSequence(String seqName, String localId, String appId, String soType) {
        return localId + appId + soType + DateUtils.getYear() + DateUtils.getMonth() + DateUtils.getDay() + StringUtils.leftPad(ObjectUtils.toString(getNextValue(seqName)), 8, '0');
    }

    /**
     * 获取申请单号
     * @param seqName
     * @param localId
     * @return
     */
    public static String getPaySequence(String seqName, String localId) {
        return localId  + DateUtils.getYear() + DateUtils.getMonth() + DateUtils.getDay() + StringUtils.leftPad(ObjectUtils.toString(getNextValue(seqName)), 8, '0');
    }

    public static String getSequence(String seqName,String personType,String provinceId,Integer localId,Integer areaId){
        String seqNo = "";
        if("CP_CERT_NO_SEQ".equals(seqName)){
            Tag tag = TagUtils.getTag("CP_CERT_NO_RULE", provinceId, localId, areaId);
            List<Tag> tags = TagUtils.getTagList("PERSON_TYPE");
            String type = "";
            for(Tag ta1:tags){
                if(personType.equals(ta1.getTagInfo())){
                    type = ta1.getRsrvStr1();
                    break;
                }
            }
            String year = "（" + DateUtils.getYear() + "）";
            seqNo =  tag.getTagInfo()+type+year +StringUtils.leftPad(ObjectUtils.toString(getNextValue(seqName)), new Integer(tag.getRsrvStr1()), '0');
        }
        return seqNo;
    }

    /**
     * 获取证书号

     * @return
     */
    public static String getCertNo() {
        return "NMG"+StringUtils.leftPad(ObjectUtils.toString(getNextValue("AC_CERT_NO_SEQ")), 7, '0');
        //return localId  + DateUtils.getYear() + DateUtils.getMonth() + DateUtils.getDay() + StringUtils.leftPad(ObjectUtils.toString(getNextValue(seqName)), 8, '0');
    }

}
