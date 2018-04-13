package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.utils.excel.ExportExcel;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.common.workflow.Variable;
import com.zhongxin.cims.common.workflow.WorkflowEntity;
import com.zhongxin.cims.common.workflow.WorkflowUtils;
import com.zhongxin.cims.modules.ac.entity.SoInvoice;
import com.zhongxin.cims.modules.ac.service.InvoiceService;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * Created by lqyu_773 on 14-9-20.
 */
@Controller
@RequestMapping(value = "${adminPath}/invoice")
public class InvoiceController extends BaseController {
    @Autowired
    private InvoiceService invoiceService;

    @ModelAttribute
    public SoInvoice get(@RequestParam(required=false) String soid) {
        if (soid != null && !"".equals(soid)){
            SoInvoice soInvoice = invoiceService.findBySoid(soid);
            return soInvoice;
        }else{
            return new SoInvoice();
        }
    }

   // @RequiresPermissions("ac:invoice:view")
    @RequestMapping(value = "list")
    public String list(SoInvoice soInvoice,HttpServletRequest request,HttpServletResponse response,Model model) {
        Page<SoInvoice> page = invoiceService.findList(new Page<SoInvoice>(request,response),soInvoice);
        model.addAttribute("page",page);
        return "modules/ac/invoiceList";
    }


    @RequestMapping(value = "export", method= RequestMethod.POST)
    public String exportFile(SoInvoice soInvoice, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "发票数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            /*Page<SoInvoice> page =*/List<SoInvoice>  list =invoiceService.exportList(soInvoice);
            new ExportExcel("发票数据", SoInvoice.class).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
        }
        return "redirect:"+Global.getAdminPath()+"/invoice/list/?repage";
    }

    @RequiresPermissions("ac:invoice:audit")
    @RequestMapping(value = "audit")
    public String audit(String soid,String auditTag,String auditInfo,String rsrvStr1,HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) {
        // rsrvStr1 存放物流单号
        invoiceService.audit(soid,auditTag,auditInfo,rsrvStr1);
        addMessage(redirectAttributes, "发票审核成功！");
        return "redirect:"+ Global.getAdminPath()+"/invoice/list/?repage";
    }

    @RequiresPermissions("ac:invoice:audit")
    @RequestMapping(value = "batchInvoiceAudit")
    public String batchAssess(String[] seqs,String auditRemark,String expressCode, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        for(String soid:seqs){
            invoiceService.audit(soid,"1",auditRemark,expressCode);
        }
        addMessage(redirectAttributes,"审核成功");
        return "redirect:"+ Global.getAdminPath()+"/invoice/list?repage";
    }
}
