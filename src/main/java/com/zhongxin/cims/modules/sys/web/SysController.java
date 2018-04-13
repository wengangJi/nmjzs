/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.sys.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.cp.entity.Personnel;
import com.zhongxin.cims.modules.eq.entity.QualifyCert;
import com.zhongxin.cims.modules.se.entity.SafetyEngineering;
import com.zhongxin.cims.modules.sys.entity.SysBatch;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.service.SysService;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

/**
 * 企业Controller
 * @author liuqy
 * @version 2014-06-10
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sys")
public class SysController extends BaseController {

	@Autowired
	private SysService sysService;




	
	@RequiresPermissions("sys:sys:view")
	@RequestMapping(value = {"batchList"})
	public String batchList(SysBatch sysBatch,String param, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysBatch> page = new Page<SysBatch>();
        if("0".equals(sysBatch.getAppId())){
            sysBatch.setAppId("");
        }
        if("0".equals(sysBatch.getBatchType())){
            sysBatch.setBatchType("");
        }
        page = sysService.getBatchList(new Page<SysBatch>(request, response), sysBatch);
        model.addAttribute("page", page);
        HashMap params = new HashMap();
        params.put("param",param);
        model.addAttribute("params",params);
        return "modules/sys/sysBatch";

	}

    @RequiresPermissions("sys:sys:edit")
    @RequestMapping(value = {"batchEdit"})
    public String batchEdit(SysBatch sysBatch,String param, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<SysBatch> page = new Page<SysBatch>();
        if("0".equals(sysBatch.getAppId())){
            sysBatch.setAppId("");
        }
        if("0".equals(sysBatch.getBatchType())){
            sysBatch.setBatchType("");
        }
        page = sysService.getBatchList(new Page<SysBatch>(request, response), sysBatch);
        model.addAttribute("page", page);
        HashMap params = new HashMap();
        params.put("param",param);
        model.addAttribute("params",params);
        return "modules/sys/sysBatchEdit";

    }

    @RequestMapping(value = "initBatch")
    public String initBatch( Model mode,SysBatch sysBatch) {

        return "modules/sys/batchManager";
    }

    //@RequiresPermissions("sys:sys:edit")
    @RequestMapping(value = "saveBatch")
    public String saveBatch( Model mode,SysBatch sysBatch,String param,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes) {
        sysBatch = sysService.geneSysBatch(sysBatch.getAppId(),sysBatch.getBatchType());
        if(sysBatch!=null){
            sysService.saveSysBatch(sysBatch);
            addMessage(redirectAttributes, "温馨提示：批次"+sysBatch.getBatchName()+"已经生成!");
        }
        sysService.saveSysBatch(sysBatch);
        return "redirect:"+Global.getAdminPath()+"/sys/sys/batchList?repage";

    }


    /**
     * 生成批次快捷方式
     */
    //  @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = {"geneBacthPickFast"})
    //需要修改为ajax的方式
    public String geneBacthPickFast(Integer servid,String appId,String soType,RedirectAttributes redirectAttributes,Model model) {
        SysBatch sysBatch = sysService.geneSysBatch( appId, soType);
        if(sysBatch!=null){
          sysService.saveSysBatch(sysBatch);
          addMessage(redirectAttributes, "温馨提示：批次"+sysBatch.getBatchName()+"已经生成!");
        }
        So so = new So();
        so.setBatchFlag("1");
        model.addAttribute("so",so) ;
        if(Constants.GLOBAL_SO_TYPE_SO.equals(soType))    {
             return "redirect:" + Global.getAdminPath() + "/cp/soCp/index/?repage";
        }else if(Constants.GLOBAL_SO_TYPE_EXTEND.equals(soType)){
            return "redirect:" + Global.getAdminPath() + "/cp/personnel/findCpServInfoById?servId="+servid+"&repage";
        } else{
            return null;
        }


    }

/**
 * 修改批次信息
*    
* 项目名称：cims   
* 类/方法描述：   
* 创建人：User   
* 创建时间：2014-8-4 上午11:40:49   
* 修改人：User   
* 修改时间：2014-8-4 上午11:40:49   
* 修改备注：   
* @version    
*
 */

    @RequestMapping(value = "batchUpdateStatus")
   public String batchUpdateStatus( SysBatch sysBatch,Model model,String status,String batchId,String appId,String companyId,String batchType, HttpServletRequest request, HttpServletResponse response) {
       User user = UserUtils.getUser();
       sysBatch.setSts(status);
       sysBatch.setBatchId(batchId);
       if(status.equals("8")){//跳转到 修改页面
           sysBatch.setBatchType(batchType);
           sysBatch.setAppId(appId);
           sysBatch.setCompanyId(Integer.valueOf(companyId));
           model.addAttribute("batchId",batchId);
           return "modules/sys/modifyBatch";
       }
       if(status.equals("16")){//修改操作
           sysBatch = sysService.geneSysBatch(sysBatch.getAppId(),sysBatch.getBatchType());
           sysBatch.setRsrvStr1(sysBatch.getBatchId());
           sysBatch.setSts("0");
           sysBatch.setCompanyId(Integer.valueOf(companyId));
           sysBatch.setBatchId(batchId);
           model.addAttribute("batchId", batchId);
           model.addAttribute("batchType", batchType);
           model.addAttribute("appId", appId);
           sysService.batchUpdateStatus(sysBatch);
           return "modules/sys/modifyBatch";
       }
       else{
          sysService.batchUpdateStatus(sysBatch);
           batchList(sysBatch,null,request,response,model);
       }
       return "modules/sys/sysBatch";
   }
    @RequiresPermissions("sys:sys:view")
    @RequestMapping(value = {"cppage"})
    public String cpPage(Integer batchId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Personnel> page = new Page<Personnel>();
//        if (batchId != null && !"".equals(batchId)) {
//            Personnel personnel = new Personnel();
//            personnel.setCompanyId(companyId);
//            page = personnelService.find(new Page<Personnel>(request, response), personnel);
//            Company comp = new Company();
//            comp.setCompanyId(companyId);
//            model.addAttribute("company",comp);
//        }
//        model.addAttribute("page", page);

        return "modules/sys/sysList";
    }

    @RequiresPermissions("sys:sys:view")
    @RequestMapping(value = {"eqpage"})
    public String eqPage(Integer batchId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<QualifyCert> page = new Page<QualifyCert>();
//        if (companyId != null && !"".equals(companyId)) {
//            QualifyCert qualifyCert = new QualifyCert();
//
//            Serv serv = new Serv();
//            Company company = new Company();
//            company.setCompanyId(companyId);
//            serv.setCompany(company);
//            qualifyCert.setServ(serv);
//            page = certService.findeq(new Page<QualifyCert>(request, response), qualifyCert);
//            Company comp = new Company();
//            comp.setCompanyId(companyId);
//            model.addAttribute("company",comp);
//        }
        model.addAttribute("page", page);

        return "modules/sys/eqList";
    }

    @RequiresPermissions("sys:sys:view")
    @RequestMapping(value = {"acpersonpage"})
    public String acPersonPage(Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<AssociateConstructor> page = new Page<AssociateConstructor>();
//        if (companyId != null && !"".equals(companyId)) {
//            Serv serv = new Serv();
//            Company company = new Company();
//            company.setCompanyId(companyId);
//            serv.setCompany(company);
//            AssociateConstructor associateConstructor = new AssociateConstructor();
//            associateConstructor.setServ(serv);
//            page = certService.findacPerson(new Page<AssociateConstructor>(request, response), associateConstructor);
//            Company comp = new Company();
//            comp.setCompanyId(companyId);
//            model.addAttribute("company",comp);
//        }
        model.addAttribute("page", page);

        return "modules/comp/acPersonList";
    }

    @RequiresPermissions("sys:sys:view")
    @RequestMapping(value = {"acmajorpage"})
    public String acMajorPage(Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<AssociateConstructor> page = new Page<AssociateConstructor>();
//        if (companyId != null && !"".equals(companyId)) {
//            Serv serv = new Serv();
//            Company company = new Company();
//            company.setCompanyId(companyId);
//            serv.setCompany(company);
//            AssociateConstructor associateConstructor = new AssociateConstructor();
//            associateConstructor.setServ(serv);
//            page = certService.findacMajor(new Page<AssociateConstructor>(request, response), associateConstructor);
//            Company comp = new Company();
//            comp.setCompanyId(companyId);
//            model.addAttribute("company",comp);
//        }
        model.addAttribute("page", page);

        return "modules/comp/acMajorList";
    }

    @RequiresPermissions("sys:sys:view")
    @RequestMapping(value = {"sepage"})
    public String sePage(Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<SafetyEngineering> page = new Page<SafetyEngineering>();
//        if (companyId != null && !"".equals(companyId)) {
//            Serv serv = new Serv();
//            Company company = new Company();
//            company.setCompanyId(companyId);
//            serv.setCompany(company);
//            SafetyEngineering safetyEngineering = new SafetyEngineering();
//            safetyEngineering.setServ(serv);
//            page = certService.findse(new Page<SafetyEngineering>(request, response), safetyEngineering);
//            Company comp = new Company();
//            comp.setCompanyId(companyId);
//            model.addAttribute("company",comp);
//        }
        model.addAttribute("page", page);

        return "modules/sys/seList";
    }

	@RequiresPermissions("sys:sys:view")
	@RequestMapping(value = "form")
	public String form(SysBatch company, Model model) {
		model.addAttribute("company", company);
		return "modules/sys/sysForm";
	}

	@RequiresPermissions("sys:sys:edit")
	@RequestMapping(value = "save")
	public String save(SysBatch company, Model model, RedirectAttributes redirectAttributes) {
//		if (!beanValidator(model, company)){
//			return form(company, model);
//		}
//		companyService.save(company);
//		addMessage(redirectAttributes, "保存企业'" + company.getCompanyName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sys/?repage";
	}

    @RequestMapping(value = "payPer")
    public String payPer(){


        return "modules/ac/payPer";
    }
  /*  @RequestMapping(value = "alipySubmit")
    public String alipySubmit(@ModelAttribute("fee") String fee ,HttpServletRequest request){
        String paymethod = "directPay";
        String  notify_url = AliConfiguration.getInstance().getValue("notify_url"); // 通知接收URL(本地测试时，服务器返回无法测试)
        String  return_url = AliConfiguration.getInstance().getValue("return_url"); // 支付完成后跳转返回的网址URL
        String  partnerID = AliConfiguration.getInstance().getValue("partnerID");
        String  key = AliConfiguration.getInstance().getValue("key");
        String sellerEmail = AliConfiguration.getInstance().getValue("sellerEmail");
        String out_trade_no = "11111111111111";// 商户网站订单（也就是外部订单号，是通过客户网站传给支付宝，不可以重复）
        String body = "课程费"; // 商品阿描述，推荐格式：商品名称（订单编号：订单编号）Order(OrderId：OrderId)
        String total_fee = "0.1";
        String subject = "课程费"; // 商品名称
        String anti_phishing_key = null;
        String qr_pay_mode = null;
        String param = Payment.CreateUrlParamAlipay(AlipayConfig.paygateway,
                AlipayConfig.service, AlipayConfig.sign_type,
                out_trade_no, AlipayConfig.charSet, partnerID
                        .toString(), key,
                AlipayConfig.show_url, body, total_fee,
                AlipayConfig.payment_type, sellerEmail, subject,
                notify_url, return_url, paymethod, null, qr_pay_mode
        );
        request.setAttribute("param", param);
        //,AlipayFunction.query_timestamp()
        return "modules/ac/to_pay";
    }*/
}
