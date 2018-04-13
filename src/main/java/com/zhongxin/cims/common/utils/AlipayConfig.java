package com.zhongxin.cims.common.utils;

/**
 * Created by User on 2014/8/27.
 */
public class AlipayConfig {

        public static String partnerID; // 合作身份者ID

        public static String key; // 安全检验码

        public static String sellerEmail; // 签约支付宝账号或卖家收款支付宝帐户

        public static String notify_url;

        public static String return_url;

        public static String show_url; // 网站商品的展示地址，不允许加?id=123这类自定义参数

        public static String antiphishing;//防钓鱼功能开关，'0'表示该功能关闭，'1'表示该功能开启。默认为关闭

        public static String charSet; // 页面编码

        public static String sign_type; // 加密方式 不需修改

        public static String transport;//访问模式,根据自己的服务器是否支持ssl访问，若支持请选择https；若不支持请选择http

        public static String mainname;//收款方名称，如：公司名称、网站名称、收款人姓名等

        public static String paygateway;//支付接口（不可以修改）

        public static String service;

        public static String payment_type;

        public static String qr_pay_mode;



        public  void setQr_pay_mode(String qr_pay_mode) {

            AlipayConfig.qr_pay_mode = qr_pay_mode;

        }

        public  void setPayment_type(String payment_type) {

            AlipayConfig.payment_type = payment_type;

        }

        public  void setService(String service) {

            AlipayConfig.service = service;

        }

        public  void setPartnerID(String partnerID) {

            AlipayConfig.partnerID = partnerID;

        }

        public  void setKey(String key) {

            AlipayConfig.key = key;

        }

        public  void setSellerEmail(String sellerEmail) {

            AlipayConfig.sellerEmail = sellerEmail;

        }

        public  void setNotify_url(String notify_url) {

            AlipayConfig.notify_url = notify_url;

        }

        public  void setReturn_url(String return_url) {

            AlipayConfig.return_url = return_url;

        }

        public  void setShow_url(String show_url) {

            AlipayConfig.show_url = show_url;

        }

        public  void setAntiphishing(String antiphishing) {

            AlipayConfig.antiphishing = antiphishing;

        }

        public  void setCharSet(String charSet) {

            AlipayConfig.charSet = charSet;

        }

        public  void setSign_type(String sign_type) {

            AlipayConfig.sign_type = sign_type;

        }

        public  void setTransport(String transport) {

            AlipayConfig.transport = transport;

        }

        public  void setMainname(String mainname) {

            AlipayConfig.mainname = mainname;

        }

        public  void setPaygateway(String paygateway) {

            AlipayConfig.paygateway = paygateway;

        }





    }


