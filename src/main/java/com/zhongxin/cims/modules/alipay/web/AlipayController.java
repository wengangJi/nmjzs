package com.zhongxin.cims.modules.alipay.web;
import com.zhongxin.cims.common.alipay.config.AlipayConfig;
import com.zhongxin.cims.common.alipay.util.AlipaySubmit;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.config.PropertiesUtil;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.common.utils.excel.ExportExcel;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.ServAssociateConstructor;
import com.zhongxin.cims.modules.ac.entity.SoInvoice;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.ac.service.PlanService;
import com.zhongxin.cims.modules.ac.service.ServAssociateConstructorService;
import com.zhongxin.cims.modules.alipay.entity.Ipsorder;
import com.zhongxin.cims.modules.alipay.service.AlipayService;
import com.zhongxin.cims.modules.exam.web.ExamController;
import com.zhongxin.cims.modules.sys.entity.SysBatch;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/9/12
 * Time: 8:54
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "${adminPath}/alipay/alipay")
public class AlipayController extends BaseController {

    @Autowired
    AlipayService alipayService;
    @Autowired
    PlanService planService;
    @Autowired
    ServAssociateConstructorService servAssociateConstructorService;
    @RequestMapping(value = "payPer")
    public String payPer(){


        return "modules/ac/payPer";
    }
    @RequestMapping(value = "alipySubmit")
    public String alipySubmit(@ModelAttribute("fee") String fee ,String soid,HttpServletRequest request,RedirectAttributes redirectAttributes){
        User currentUser = UserUtils.getUser();
        if (currentUser==null) {
            addMessage(redirectAttributes, "请先登录再进行该操作");
            payPer();
        }
        if(fee==null || fee.equals(0)){
            addMessage(redirectAttributes, "交易金额不能为0");
            payPer();
        }
        String paymethod = "directPay";

       String out_trade_no =  SeqUtils.getPaySequence("ALIPAY_SEQ",String.valueOf(currentUser.getLocalId()));

        //提交给支付宝前生成流水 校验
        if(StringUtils.isBlank(fee)||StringUtils.isBlank(soid)||StringUtils.isBlank(out_trade_no)){
            addMessage(redirectAttributes, "校验数据有误");
            payPer();
        }

       String flag= alipayService.makeDataIntoAlipayTable(soid,out_trade_no,fee);
        //提交给支付宝前生成流水
        if("0".equals(flag)) {
            //支付类型
            String payment_type = "1";
            //必填，不能修改
            //服务器异步通知页面路径
           // String notify_url = "http://www.nmcia.org:8004/nmjzs/return_url.jsp";
            String notify_url = PropertiesUtil.readData(Global.getUrlAliconfig(),"notify_url") ;//"http://www.nmcia.org:8004/nmjzs/return_url.jsp";
            System.out.println("本次支付支付读取配置文件notify_url路径为："+Global.getUrlAliconfig());
            System.out.println("本次支付支付主机地址为："+request.getLocalPort());
            System.out.println("本次支付支付主机端口为："+request.getLocalPort());
            System.out.println("本次支付支付读取主机地址为："+notify_url);
            if(notify_url ==null || "".equals(notify_url)){
                addMessage(redirectAttributes, "没获取到alipayconfig配置文件地址，不能支付，请联系管理员。");
                return "redirect:"+Global.getAdminPath()+"/plan/acNoPayListByUser/?repage";
               // return "redirect:"+Global.getAdminPath()+"/error/500";
            }
            //需http://格式的完整路径，不能加?id=123这类自定义参数
            //页面跳转同步通知页面路径
            String return_url = "";
            //需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
            //卖家支付宝帐户
            String seller_email = null;
           // String out_trade_no = null;
            String subject = null;
            String total_fee = null;
            String body = null;
            String show_url = null;
            try {

                //
                SoPlan soPlan = planService.findBySoid(soid);
                if(soPlan!=null){
                    if(soPlan.getUserId()!=null && !"".equals(soPlan.getUserId())){
                        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(soPlan.getUserId());
                        if(servAcInfo!=null){
                            if(servAcInfo.getName()!=null && !"".equals(servAcInfo.getName()) && servAcInfo.getIdNo()!=null && !"".equals(servAcInfo.getIdNo())){
                                body =servAcInfo.getName()+servAcInfo.getIdNo();
                            }
                        }else{
                            body = "内蒙古自治区二级建造师继续教育培训费用";
                        }
                    }
                }
                seller_email = "nmgjzyxh@qq.com";
                //必填
                //商户订单号
                out_trade_no =out_trade_no;
                //商户网站订单系统中唯一订单号，必填
                //订单名称
                subject = "课程费";
                //必填
                //付款金额
                total_fee = fee;
                //必填
                //订单描述
               // body = "内蒙古自治区二级建造师继续教育培训费用";
                //商品展示地址
                //show_url = "http://www.nmcia.org:8004/nmjzs/a";
                show_url = PropertiesUtil.readData(Global.getUrlAliconfig(),"show_url") ; //"http://www.nmcia.org:8004/nmjzs/a";
                System.out.println("本次支付的showUrl地址为："+show_url);
                if(show_url ==null || "".equals(show_url)){
                    addMessage(redirectAttributes, "没获取到alipayconfig配置文件地址，不能支付，请联系管理员。");
                    return "redirect:"+Global.getAdminPath()+"/plan/acNoPayListByUser/?repage";
                    // return "redirect:"+Global.getAdminPath()+"/error/500";
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            //需以http://开头的完整路径，例如：http://www.xxx.com/myorder.html
            //防钓鱼时间戳
            String anti_phishing_key = "";
            //若要使用请调用类文件submit中的query_timestamp函数
            //客户端的IP地址
            String exter_invoke_ip = "";
            //非局域网的外网IP地址，如：221.0.0.1


            //////////////////////////////////////////////////////////////////////////////////

            //把请求参数打包成数组
            Map<String, String> sParaTemp = new HashMap<String, String>();
            sParaTemp.put("service", "create_direct_pay_by_user");
            sParaTemp.put("partner", AlipayConfig.partner);
            sParaTemp.put("_input_charset", AlipayConfig.input_charset);
            sParaTemp.put("payment_type", payment_type);
            sParaTemp.put("notify_url", notify_url);
            sParaTemp.put("return_url", return_url);
            sParaTemp.put("seller_email", seller_email);
            sParaTemp.put("out_trade_no", out_trade_no);
            sParaTemp.put("subject", subject);
            sParaTemp.put("total_fee", total_fee);
            sParaTemp.put("body", body);
            sParaTemp.put("show_url", show_url);
            sParaTemp.put("anti_phishing_key", anti_phishing_key);
            sParaTemp.put("exter_invoke_ip", exter_invoke_ip);

            //建立请求
            String sHtmlText = AlipaySubmit.buildRequest(sParaTemp, "get", "确认");
            request.setAttribute("sHtmlText",sHtmlText);
        }

        return "modules/ac/to_pay";

    }


    @RequestMapping(value = "alipayReSubmit")
    public String alipayReSubmit(@ModelAttribute("fee") String fee ,String soid,String alipayId,HttpServletRequest request,RedirectAttributes redirectAttributes){
        User currentUser = UserUtils.getUser();
        if (currentUser==null) {
            addMessage(redirectAttributes, "请先登录再进行该操作");
            payPer();
        }
        if(fee==null || fee.equals(0)){
            addMessage(redirectAttributes, "交易金额不能为0");
            payPer();
        }
        String paymethod = "directPay";

        //String out_trade_no =  SeqUtils.getPaySequence("ALIPAY_SEQ",currentUser.getUserCompany().getLocalId().toString());
        Ipsorder ipsorder = alipayService.findByPrimaryKey(alipayId);
        String flag = "0";
        if(ipsorder ==null ){
            flag ="1";
            addMessage(redirectAttributes, "未查到历史记忆记录，不能重新支付。");
            payPer();
        }
        String out_trade_no = ipsorder.getAlipayId();
        //提交给支付宝前生成流水 校验
        if(StringUtils.isBlank(fee)||StringUtils.isBlank(soid)||StringUtils.isBlank(out_trade_no)||StringUtils.isBlank(alipayId)){
            addMessage(redirectAttributes, "校验数据有误");
            payPer();
        }

      //  String flag= alipayService.makeDataIntoAlipayTable(soid,out_trade_no,fee);
        //提交给支付宝前生成流水
        if("0".equals(flag)) {
            //支付类型
            String payment_type = "1";
            //必填，不能修改
            //服务器异步通知页面路径
            String notify_url = PropertiesUtil.readData(Global.getUrlAliconfig(),"notify_url") ;//"http://www.nmcia.org:8004/nmjzs/return_url.jsp";
            System.out.println("本次支付支付读取配置文件notify_url路径为："+Global.getUrlAliconfig());
            System.out.println("本次支付支付主机地址为："+request.getLocalPort());
            System.out.println("本次支付支付主机端口为："+request.getLocalPort());
            System.out.println("本次支付支付读取主机地址为："+notify_url);
            //需http://格式的完整路径，不能加?id=123这类自定义参数
            //页面跳转同步通知页面路径
            //String return_url = "http://www.nmgjzaqgl.com/nmjzs/a/alipay/alipay/alipayResult";
            //需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
            //卖家支付宝帐户
            String seller_email = null;
            // String out_trade_no = null;
            String subject = null;
            String total_fee = null;
            String body = null;
            String show_url = null;
            try {
                seller_email = "nmgjzyxh@qq.com";
                //必填
                //商户订单号
                out_trade_no =out_trade_no;
                //商户网站订单系统中唯一订单号，必填
                //订单名称
                subject = "课程费";
                //必填
                //付款金额
                total_fee = fee;
                //必填
                //订单描述
                body = "内蒙古自治区二级建造师继续教育培训费用";
                //商品展示地址
                show_url = PropertiesUtil.readData(Global.getUrlAliconfig(),"show_url") ;// show_url = "http://www.nmcia.org:8004/nmjzs/a";
                System.out.println("本次支付的showUrl地址为："+show_url);
            } catch (Exception e) {
                e.printStackTrace();
            }
            //需以http://开头的完整路径，例如：http://www.xxx.com/myorder.html
            //防钓鱼时间戳
            String anti_phishing_key = "";
            //若要使用请调用类文件submit中的query_timestamp函数
            //客户端的IP地址
            String exter_invoke_ip = "";
            //非局域网的外网IP地址，如：221.0.0.1


            //////////////////////////////////////////////////////////////////////////////////

            //把请求参数打包成数组
            Map<String, String> sParaTemp = new HashMap<String, String>();
            sParaTemp.put("service", "create_direct_pay_by_user");
            sParaTemp.put("partner", AlipayConfig.partner);
            sParaTemp.put("_input_charset", AlipayConfig.input_charset);
            sParaTemp.put("payment_type", payment_type);
            sParaTemp.put("notify_url", notify_url);
            sParaTemp.put("return_url", "");
            sParaTemp.put("seller_email", seller_email);
            sParaTemp.put("out_trade_no", out_trade_no);
            sParaTemp.put("subject", subject);
            sParaTemp.put("total_fee", total_fee);
            sParaTemp.put("body", body);
            sParaTemp.put("show_url", show_url);
            sParaTemp.put("anti_phishing_key", anti_phishing_key);
            sParaTemp.put("exter_invoke_ip", exter_invoke_ip);

            //建立请求
            String sHtmlText = AlipaySubmit.buildRequest(sParaTemp, "get", "确认");
            request.setAttribute("sHtmlText",sHtmlText);
        }

        return "modules/ac/to_pay";

    }


    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "initGetNoIpsorder")
    public String initGetNoIpsorder(SoPlan soPlan, HttpServletRequest request, HttpServletResponse response, Model model){
        model.addAttribute("soPlan",new SoPlan());
        return "modules/alipay/acSoNoPayQuery";
    }

    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "initGetIpsorder")
    public String initGetIpsorder(SoPlan soPlan, HttpServletRequest request, HttpServletResponse response, Model model){
        model.addAttribute("soPlan",new SoPlan());
        return "modules/alipay/acSoPayQuery";
    }

    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "getNoIpsorderList")
    public String getNoIpsorderList(SoPlan soPlan, HttpServletRequest request, HttpServletResponse response, Model model){
        Page<Ipsorder> page = new Page<Ipsorder>();
        page = alipayService.getNoIpsorderList(new Page<Ipsorder>(request, response), soPlan);
        model.addAttribute("page", page);
        return "modules/alipay/acSoNoPayQuery";
    }

    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，

     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "getIpsorderList")
    public String getIpsorderList(SoPlan soPlan, HttpServletRequest request, HttpServletResponse response, Model model){
        Page<Ipsorder> page = new Page<Ipsorder>();
        page = alipayService.getIpsorderList(new Page<Ipsorder>(request, response), soPlan);
        model.addAttribute("page", page);
        return "modules/alipay/acSoPayQuery";
    }

    @RequestMapping(value = "export", method= RequestMethod.POST)
    public String exportFile(SoPlan soPlan, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "支付数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            /*Page<Ipsorder> page*/ List<Ipsorder> list = alipayService.exportIpsorderList(soPlan);
            new ExportExcel("支付数据", Ipsorder.class).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
        }
        return "redirect:"+Global.getAdminPath()+"/alipay/alipay/getIpsorderList/?repage";
    }

    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "getCompanyNoIpsorderList")
    public String getCompanyNoIpsorderList(SoPlan soPlan, HttpServletRequest request, HttpServletResponse response, Model model){
        Page<Ipsorder> page = new Page<Ipsorder>();
        soPlan.setCompanyId(UserUtils.getUser().getUserCompany().getCompanyId());
        page = alipayService.getNoIpsorderList(new Page<Ipsorder>(request, response), soPlan);
        model.addAttribute("page", page);
        return "modules/alipay/acCompanySoNoPayQuery";
    }

    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，

     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "getCompanyIpsorderList")
    public String getCompanyIpsorderList(SoPlan soPlan, HttpServletRequest request, HttpServletResponse response, Model model){
        Page<Ipsorder> page = new Page<Ipsorder>();
        soPlan.setCompanyId(UserUtils.getUser().getUserCompany().getCompanyId());
        page = alipayService.getIpsorderList(new Page<Ipsorder>(request, response), soPlan);
        model.addAttribute("page", page);
        return "modules/alipay/acCompanySoPayQuery";
    }


    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "getIpsorderListByUser")
    public String getIpsorderListByUser( HttpServletRequest request, HttpServletResponse response, Model model){
        User user = UserUtils.getUser();
        Page<Ipsorder> page = alipayService.getIpsorderListByUser(new Page<Ipsorder>(request, response),user.getId());
        model.addAttribute("page", page);
        return "modules/alipay/acSoPayItem";
    }


    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，

     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "getNoIpsorderListByUser")
    public String getNoIpsorderListByUser( HttpServletRequest request, HttpServletResponse response, Model model){
        User user = UserUtils.getUser();
        Page<Ipsorder> page = alipayService.getNoIpsorderListByUser(new Page<Ipsorder>(request, response),user.getId());
        model.addAttribute("page", page);
        return "modules/alipay/acSoPayItem";
    }


    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "getIpsorderTotleByUser")
    public String getIpsorderTotleByUser( HttpServletRequest request, HttpServletResponse response, Model model){
        User user = UserUtils.getUser();
        Page<Ipsorder> page = alipayService.getIpsorderTotleByUser(new Page<Ipsorder>(request, response),user.getId());
        model.addAttribute("page", page);
        model.addAttribute("soPlan",new SoPlan());
        return "modules/alipay/acSoPayTotleUser";
    }

    /**
     * 根据 用户id ，支付状态，时间查询，查看支付流水，
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "getIpsorderTotle")
    public String getIpsorderTotle(SoPlan soPlan, HttpServletRequest request, HttpServletResponse response, Model model){
        Page<Ipsorder> page = alipayService.getIpsorderTotle(new Page<Ipsorder>(request, response),soPlan);
        model.addAttribute("page", page);
        model.addAttribute("soPlan",new SoPlan());
        return "modules/alipay/acSoPayTotle";
    }




    @RequestMapping(value = "alipayResult")
    public String alipayResult(HttpServletRequest request, HttpServletResponse response){
        alipayService.alipayResult(request,response);
        return "modules/alipay/alipayResult";
    }
}
