package com.zhongxin.cims.modules.job;

import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.modules.common.service.CompleteService;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by lqyu_773 on 14-7-6.
 */
public class CompleteJob {
    @Autowired
    public CompleteService completeService;
    public void work(){
       //completeService.complete();
    }
}
