package com.zhongxin.cims.modules.common.service;

import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.modules.common.dao.PrintTemplateMapper;
import com.zhongxin.cims.modules.common.entity.PrintTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


@Service
@Transactional(readOnly = true)
public class PrintService extends BaseService {
    @Autowired
    private PrintTemplateMapper printTemplateMapper;
    @Transactional(readOnly = false)
    public void save(PrintTemplate printTemplate){
        //printTemplate.setParaType("ADD_PRINT_TEXT");
        //printTemplate.setParaNum(5);
        printTemplate.setSts("0");
        if (printTemplate.getId() != null) {
            printTemplateMapper.updateByPrimaryKey(printTemplate);
        } else {
            printTemplateMapper.insert(printTemplate);
        }
    }

    @Transactional(readOnly = false)
    public void init(List<PrintTemplate> printTemplates) {
        for (PrintTemplate printTemplate: printTemplates) {
            printTemplate.setSts("0");
            printTemplateMapper.insert(printTemplate);
        }
    }

    public Page<PrintTemplate> find(Page<PrintTemplate> page, PrintTemplate printTemplate){
        List<PrintTemplate> printTemplates = new ArrayList<PrintTemplate>();
        if (printTemplate.getPageNum() != null) {
            printTemplates = printTemplateMapper.findByCertTypeAndSoTypeAndPageNum(printTemplate.getCertType(),printTemplate.getSoType(),printTemplate.getPageNum());
        } else {
            printTemplates = printTemplateMapper.findByCertTypeAndSoType(printTemplate.getCertType(), printTemplate.getSoType());
        }
        page.setCount(printTemplates.size());
        page.setList(printTemplates.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    @Transactional(readOnly = false)
    public void delete(String id) {
        printTemplateMapper.deleteByPrimaryKey(new Long(id));
    }
}
