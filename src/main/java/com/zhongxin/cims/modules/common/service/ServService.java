package com.zhongxin.cims.modules.common.service;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.common.dao.ServMapper;
import com.zhongxin.cims.modules.common.entity.Serv;
import com.zhongxin.cims.modules.common.entity.ServPub;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by lqyu_773 on 14-6-12.
 */
@Component
@Transactional(readOnly = true)
public class ServService extends BaseService {
    @Autowired
    private ServMapper servMapper;

    public Page<Serv> find(Page<Serv> page, Serv serv) {

        serv.setPage(page);
        page.setList(servMapper.findeq(serv));
        return page;
    }

    public List<ServPub> findPersonListById(String name) {
     return servMapper.findPersonListById(name);
    }


}
