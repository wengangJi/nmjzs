package com.zhongxin.cims.modules.alipay.service;


import com.zhongxin.cims.common.alipay.util.AlipayNotify;
import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.modules.ac.dao.SoPlanMapper;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.alipay.dao.AlipayDao;
import com.zhongxin.cims.modules.alipay.entity.Ipsorder;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.sys.entity.SysBatch;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.DictUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/9/12
 * Time: 8:55
 * To change this template use File | Settings | File Templates.
 */
@Service
@Transactional(readOnly = true)
public class AlipayService extends BaseService {
    @Autowired
    AlipayDao alipayDao;
    @Autowired
    SoPlanMapper soPlanMapper;


    /**
     * 查询支付记录
     *
     * @param alipayId
     */
    public Ipsorder findByPrimaryKey(String alipayId) {
        return   alipayDao.selectByPrimaryKey(alipayId);
    }

    /**
     * 提交支付宝前生成支付流水 status 0  为 待支付，1 为已支付，2 支付失败
     *
     * @param soId
     * @param alipayId
     */
    @Transactional(readOnly = false)
    public String makeDataIntoAlipayTable(String soId, String alipayId, String fee) {
        User currentUser = UserUtils.getUser();
        Ipsorder ipsorder = new Ipsorder();
        ipsorder.setUserId(currentUser.getId());
        ipsorder.setAlipayId(alipayId);
        ipsorder.setCreateTime(new Date());
        ipsorder.setModifyTime(new Date());
        ipsorder.setStatus("0");
        ipsorder.setSoid(soId);
        ipsorder.setFee(fee);
        try {
            alipayDao.makeDataIntoAlipayTable(ipsorder);
        } catch (Exception e) {
            return "1";
        }
        return "0";
    }

    public String getS(){
        return "adfafd";
    }
    /**
     * 查讯支付流水
     *
     * @param page
     * @param soPlan
     * @return
     */
    public Page<Ipsorder> getIpsorderList(Page<Ipsorder> page, SoPlan soPlan) {
        List<Ipsorder> ipsorders = alipayDao.getIpsorderList(soPlan);
        page.setCount(ipsorders.size());
        page.setList(ipsorders.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 查讯支付流水
     *
     * @param soPlan
     * @param soPlan
     * @return
     */
    public List<Ipsorder> exportIpsorderList (SoPlan soPlan) {
        List<Ipsorder> ipsorders = alipayDao.getIpsorderList(soPlan);
        if(ipsorders!=null && ipsorders.size()>0){
            for(Ipsorder ipsorder:ipsorders){

                if(ipsorder.getUserId()!=null && !"".equals(ipsorder.getUserId())){
                    ipsorder.setRsrvStr3(UserUtils.getUserById(ipsorder.getUserId()).getName());
                }
                if(ipsorder.getStatus()!=null && !"".equals(ipsorder.getStatus())){
                    ipsorder.setRsrvStr2(DictUtils.getDictLabel(ipsorder.getStatus(),"STS",""));
                }


            }
        }
      /*  page.setCount(ipsorders.size());
        page.setList(ipsorders.subList(page.getFirstResult(),page.getLastResult()));*/
        return ipsorders;
    }


    /**
     * 查讯未支付流水
     *
     * @param page
     * @param soPlan
     * @return
     */
    public Page<Ipsorder> getNoIpsorderList(Page<Ipsorder> page, SoPlan soPlan) {
        List<Ipsorder> ipsorders = alipayDao.getNoIpsorderList(soPlan);
        page.setCount(ipsorders.size());
        page.setList(ipsorders.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 根据用户编号查询支付流水
     *
     * @param page
     * @param userId
     * @return
     */
    public Page<Ipsorder> getIpsorderListByUser(Page<Ipsorder> page,String userId) {
        List<Ipsorder> ipsorders = alipayDao.getIpsorderListByUser(userId);
        page.setCount(ipsorders.size());
        page.setList(ipsorders.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }


    /**
     * 根据用户编号查询支付流水
     *
     * @param page
     * @param userId
     * @return
     */
    public Page<Ipsorder> getIpsorderTotleByUser(Page<Ipsorder> page,String userId) {
        List<Ipsorder> ipsorders = alipayDao.getIpsorderTotleByUser(userId);
        page.setCount(ipsorders.size());
        page.setList(ipsorders.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 根据用户编号查询支付流水
     *
     * @param page
     * @param soPlan
     * @return
     */
    public Page<Ipsorder> getIpsorderTotle(Page<Ipsorder> page,SoPlan soPlan) {
        List<Ipsorder> ipsorders = alipayDao.getIpsorderTotle(soPlan);
        page.setCount(ipsorders.size());
        page.setList(ipsorders.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 根据用户编号查询未支付流水
     *
     * @param page
     * @param userId
     * @return
     */
    public Page<Ipsorder> getNoIpsorderListByUser(Page<Ipsorder> page,String userId) {
        List<Ipsorder> ipsorders = alipayDao.getNoIpsorderListByUser(userId);
        page.setCount(ipsorders.size());
        page.setList(ipsorders.subList(page.getFirstResult(),page.getLastResult()));
        return page;
    }

    /**
     * 支付结果
     *
     * @param request
     * @param response
     * @return
     */
    @Transactional(readOnly = false)
    public String alipayResult(HttpServletRequest request, HttpServletResponse response) {
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
            try{
            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "UTF-8");
            }catch (Exception ex){
                ex.printStackTrace();
            }
            params.put(name, valueStr);
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
System.out.println("---------------0---------------------------------");
        if(AlipayNotify.verify(params)){//验证成功
            //////////////////////////////////////////////////////////////////////////////////////////
            //请在这里加上商户的业务逻辑程序代码
            System.out.println("---------------1---------------------------------");

            //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——

            if(trade_status.equals("TRADE_FINISHED")){
                System.out.println("---------------2---------------------------------");

                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序

                //注意：
                //该种交易状态只在两种情况下出现
                //1、开通了普通即时到账，买家付款成功后。
                //2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
            } else if (trade_status.equals("TRADE_SUCCESS")){
                System.out.println("---------------3---------------------------------");

                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序

                //注意：
                //该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。

              Ipsorder soPay = alipayDao.selectByPrimaryKey(out_trade_no);

                if(soPay==null ){
                    System.out.println("商户订单为空！");
                   return  "";
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
                int soPayRspCode =alipayDao.updateByPrimaryKeySelective(ipsorder);
                 System.out.println("更新SO_PAY："+ipsorder.getAlipayId());
                 System.out.print("执行结果："+soPayRspCode);

              //更新商户订单为已支付状态
              SoPlan soPlan = new SoPlan();
                soPlan.setSoid(soPay.getSoid());
                soPlan.setFeeState(Constants.IS_PAY_FEE_STATE);
               int soPlanRspCode= soPlanMapper.updateByPrimaryKeySelective(soPlan);
                System.out.println("更新SO_PLAN："+soPlan.getSoid());
                System.out.print("执行结果："+soPlanRspCode);

                System.out.println("交易流水："+out_trade_no+"交易表SO_PAY更新成功。");
                System.out.println("订单流水："+soPay.getSoid()+"交易表SO_PLAN更新成功。");

     }

            //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

            System.out.println("success");	//请不要修改或删除

        }else{//验证失败
            System.out.println("fail");
        }
        return "";
    }

    public  Ipsorder selectByPrimaryKey(String out_trade_no){
        return  alipayDao.selectByPrimaryKey(out_trade_no);
    }
    @Transactional(readOnly = false)
    public int updateByPrimaryKeySelective( SoPlan soPlan){

        return soPlanMapper.updateByPrimaryKeySelective(soPlan);
    }
    @Transactional(readOnly = false)
    public void  updateByPrimaryKeySelective( Ipsorder ipsorder){

        alipayDao.updateByPrimaryKeySelective(ipsorder);
    }

    private Map getAlipayRequestParams(Map requestParams)
            throws UnsupportedEncodingException {

        Map params = new HashMap();

        for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext(); ) {

            String name = (String) iter.next();

            String[] values = (String[]) requestParams.get(name);

            String valueStr = "";

            for (int i = 0; i < values.length; i++) {

                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";

            }

// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化

//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "UTF-8");

            params.put(name, valueStr);

        }

        return params;


    }
}
