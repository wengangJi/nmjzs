<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2014/10/8
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.zhongxin.cims.modules.alipay.entity.Ipsorder" %>
<%@ page import="com.zhongxin.cims.modules.ac.entity.SoPlan" %>
<%@ page import="com.zhongxin.cims.common.utils.DateUtils" %>
<%@ page import="com.zhongxin.cims.common.config.Constants" %>
<%@ page import="com.zhongxin.cims.modules.alipay.dao.AlipayDao" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page import="com.zhongxin.cims.modules.ac.dao.SoPlanMapper" %>
<%@ page import="com.zhongxin.cims.modules.alipay.service.AlipayService" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%
    Map<String,String> params = new HashMap<String,String>();
    Map requestParams = request.getParameterMap();
    for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
        String name = (String) iter.next();
        String[] values = (String[]) requestParams.get(name);
        String valueStr = "";
        for (int i = 0; i < values.length; i++) {
            valueStr = (i == values.length - 1) ? valueStr + values[i]
                    : valueStr + values[i] + ",";
        }
        //乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
        //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
     /*   try{
            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "UTF-8");
        }catch (Exception ex){
            ex.printStackTrace();
        }*/
        System.out.println("1=================d===========" + valueStr);
        params.put(name, valueStr);
        valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
        System.out.println("2=================d==========="+valueStr);
    }

    //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
    //商户订单号
    String trade_status = null;
    String out_trade_no=null;
    String trade_no=null;
    String notify_time=null;
    String buyer_email=null;
    try {
        out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

        //支付宝交易号
        trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

        //交易状态
        trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

        //交易时间
        notify_time = new String (request.getParameter("notify_time").getBytes("ISO-8859-1"),"UTF-8");

        //交易账号
        buyer_email = new String (request.getParameter("buyer_email").getBytes("ISO-8859-1"),"UTF-8");

        System.out.println("trade_no=========="+trade_no);
        System.out.println("out_trade_no=========="+out_trade_no);
        System.out.println("trade_status=========="+trade_status);
        System.out.println("notify_time=========="+notify_time);
        System.out.println("buyer_email=========="+buyer_email);
    } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
    }



    //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
    if(com.zhongxin.cims.common.alipay.util.AlipayNotify.verify(params)){//验证成功
        //////////////////////////////////////////////////////////////////////////////////////////
        //请在这里加上商户的业务逻辑程序代码
        System.out.println("----------------000----------------");
        //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——

        if(trade_status.equals("TRADE_FINISHED")){

            //判断该笔订单是否在商户网站中已经做过处理
            //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
            //如果有做过处理，不执行商户的业务程序

            //注意：
            //该种交易状态只在两种情况下出现
            //1、开通了普通即时到账，买家付款成功后。
            //2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
        } else if (trade_status.equals("TRADE_SUCCESS")){
            System.out.println("----------------1`11111111----------------");
            //判断该笔订单是否在商户网站中已经做过处理
            //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
            //如果有做过处理，不执行商户的业务程序

            //注意：
            //该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
            WebApplicationContext wac = (WebApplicationContext)

                    config.getServletContext().getAttribute(WebApplicationContext.

                            ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
            AlipayService alipayService = (AlipayService) wac.getBean("alipayService");


            Ipsorder soPay = alipayService.selectByPrimaryKey(out_trade_no);
            System.out.println("----------------222----------------"+soPay);

            if(soPay==null ){
                System.out.println("商户订单为空！");

            }
            System.out.println("商户订单："+soPay.getSoid());
            System.out.println("交易流水："+soPay.getAlipayId());
            System.out.println("交易金额："+soPay.getFee());
            System.out.println("交易状态：11111" + soPay.getFeeState());


            //更新商户交易记录
            Ipsorder ipsorder = new Ipsorder();
            ipsorder.setAlipayId(out_trade_no);
            ipsorder.setRspCode(trade_status);
            ipsorder.setRspDesc(buyer_email);
            ipsorder.setRspDate(DateUtils.parseDate(notify_time));
            alipayService.updateByPrimaryKeySelective(ipsorder);
            System.out.println("更新SO_PAY："+ipsorder.getAlipayId());

            //更新商户订单为已支付状态
            SoPlan soPlan = new SoPlan();
            soPlan.setSoid(soPay.getSoid());
            soPlan.setFeeState(Constants.IS_PAY_FEE_STATE);
            int soPlanRspCode= alipayService.updateByPrimaryKeySelective(soPlan);
            System.out.println("更新SO_PLAN："+soPlan.getSoid());
            System.out.print("执行结果："+soPlanRspCode);

            System.out.println("交易流水："+out_trade_no+"交易表SO_PAY更新成功。");
            System.out.println("订单流水："+soPay.getSoid()+"交易表SO_PLAN更新成功。");

        }

        //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

        out.println("success");	//请不要修改或删除

    }else{//验证失败
        out.println("fail");
    }

%>
