package com.zhongxin.cims.modules.sys.dao;

import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.sys.entity.Tag;

import java.util.List;

@MyBatisDao
public interface TagMapper {
    Tag find(Tag tag);
    List<Tag> findAll();
}