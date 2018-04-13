/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.dao.SoPlanMapper;
import com.zhongxin.cims.modules.ac.entity.ServAssociateConstructor;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.ac.service.ServAssociateConstructorService;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.activiti.spring.annotations.UserId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * 二级建造师Controller
 * @author jiwg
 * @version 2014-06-12
 */
@Controller
@RequestMapping(value = "${adminPath}/ac/servAc")
public class ServAssociateConstructorController extends BaseController {

	@Autowired
	private ServAssociateConstructorService servAssociateConstructorService;
    @Autowired
    private SoPlanMapper soPlanMapper;



    /**
     * 根据用户编号查询建造师信息
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    //@RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "queryServAcInfo")
    public String findByUserId(String userId,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
       User user = UserUtils.getUser();
        if(userId==null || "".equals(userId)){
            userId = user.getId();
        }
        ServAssociateConstructor servAcInfo = servAssociateConstructorService.findByUserId(userId);
        model.addAttribute("servAcInfo", servAcInfo);
        return "modules/ac/servAcInfo";
    }

    /**
     * 测试视频页面
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "query")
    public String query(Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();

        return "modules/ac/onlineStudy";
    }

    /**
     * 初始化二建信息录入页面
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "initAcForm")
    public String initServAcForm(Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        ServAssociateConstructor servAcInfo = new ServAssociateConstructor();
        servAcInfo.setIdType("0");
        servAcInfo.setIdNo(user.getLoginName());
        servAcInfo.setName(user.getName());
        model.addAttribute("servAcInfo", servAcInfo);

        return "modules/ac/servAcForm";
    }


    /**
     * 二建录入信息提交
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "saveAcForm")
    public String saveAcForm(ServAssociateConstructor servAcForm,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        ServAssociateConstructor servAssociateConstructor = servAssociateConstructorService.findByUserId(user.getId());
        if(servAssociateConstructor!=null)  {
            addMessage(redirectAttributes, "温馨提示：用户(" + user.getName() + "),已在系统注册二级建造师，不能重复注册。");
            return "redirect:" + Global.getAdminPath() + "/ac/servAc/initAcForm/?repage";
        }
       boolean checkNoFlag= servAssociateConstructorService.checkServExist(servAcForm);
        if(!checkNoFlag){
            addMessage(redirectAttributes, "温馨提示：证件号码(" + servAcForm.getIdNo() + "),资格证书编号(" + servAcForm.getCertNo() + "),已在系统注册，不能重复注册。");
            return "redirect:" + Global.getAdminPath() + "/ac/servAc/initAcForm/?repage";

        }

        servAcForm.setAppId(Constants.GLOBAL_AC_APP_ID);
        //servAcForm.setLocalId(user.getUserCompany().getLocalId());
        servAcForm.setUserId(user.getId());
        servAcForm.setStsDate(new Date());
        servAcForm.setProvinceId("nm");
        servAcForm.setCertType("4");
        servAcForm.setSts("0");
        servAssociateConstructorService.saveForm(servAcForm);

        return "redirect:" + Global.getAdminPath() + "/ac/servAc/queryServAcInfo/?repage";
    }


    /**
     * 初始化二建信息修改页面
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "initModifyAcForm")
    public String initModifyAcForm(String userId,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        if(userId==null || "".equals(userId)){
            userId = user.getId();
        }
        ServAssociateConstructor servAcInfo =  servAssociateConstructorService.findByUserId(userId);
        if(servAcInfo ==null ){
            servAcInfo = new ServAssociateConstructor();
            servAcInfo.setRsrvStr2("温馨提示：用户(" + user.getName() + "),不存在二级建造师注册信息，不允许修改。");
            model.addAttribute("servAcInfo", servAcInfo);
            return "modules/ac/servAcInfo";


        }
        //如果已缴费，则不允许修改

        List<SoPlan> soPlans = soPlanMapper.findPayListByUserId(userId,"1");
        if(soPlans!=null && soPlans.size()>0 && !"2".equals(UserUtils.getUser().getId())){
            servAcInfo.setRsrvStr2("温馨提示：用户(" + user.getName() + "),存在已缴费申报，不允许修改二级建造师信息。");
            model.addAttribute("servAcInfo", servAcInfo);
            return "modules/ac/servAcInfo";

        }

        model.addAttribute("servAcInfo", servAcInfo);

        return "modules/ac/servAcModifyForm";
    }



    @RequestMapping(value = "initRegiAcForm")
    public String initRegiAcForm(String userId,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        if(userId==null || "".equals(userId)){
            userId = user.getId();
        }
        ServAssociateConstructor servAcInfo =  servAssociateConstructorService.findByUserId(userId);
        if(servAcInfo ==null ){
            servAcInfo = new ServAssociateConstructor();
            servAcInfo.setRsrvStr2("温馨提示：用户(" + user.getName() + "),不存在二级建造师注册信息，不允许修改。");
            model.addAttribute("servAcInfo", servAcInfo);
            return "modules/ac/servAcInfo";


        }


        model.addAttribute("servAcInfo", servAcInfo);

        return "modules/ac/servAcRegiForm";
    }


    @RequestMapping(value = "initCompAcForm")
    public String initCompAcForm(String userId,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        if(userId==null || "".equals(userId)){
            userId = user.getId();
        }
        ServAssociateConstructor servAcInfo =  servAssociateConstructorService.findByUserId(userId);
        if(servAcInfo ==null ){
            servAcInfo = new ServAssociateConstructor();
            servAcInfo.setRsrvStr2("温馨提示：用户(" + user.getName() + "),不存在二级建造师注册信息，不允许修改。");
            model.addAttribute("servAcInfo", servAcInfo);
            return "modules/ac/servAcInfo";


        }


        model.addAttribute("servAcInfo", servAcInfo);

        return "modules/ac/servAcCompForm";
    }
    /**
     * 二建录入信息修改
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "modifyAcForm")
    public String modifyAcForm(ServAssociateConstructor servAcForm,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        servAcForm.setStsDate(new Date());
        servAssociateConstructorService.modifyForm(servAcForm);
        return "redirect:" + Global.getAdminPath() + "/ac/servAc/queryServAcInfo?userId="+servAcForm.getUserId()+"&repage";
    }



    /**
     * 二建录入信息修改
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "modifyAcRegiForm")
    public String modifyAcRegiForm(ServAssociateConstructor servAcForm,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        servAcForm.setStsDate(new Date());

      /*  if(servAcForm!=null){
            if(servAcForm.getCompanyId()!=null && "2".equals(String.valueOf(servAcForm.getCompanyId()))){
                if(servAcForm.getRsrvStr1()!=null && !"".equals(servAcForm.getRsrvStr1())) {
                    addMessage(redirectAttributes, "温馨提示：用户为内蒙古未注册企业，不允许修改企业名称。");

                    return "redirect:" + Global.getAdminPath() + "/ac/servAc/queryServAcInfo?userId=" + UserUtils.getUser().getId() + "&repage";
                }
            }
        }*/
        servAssociateConstructorService.modifyForm(servAcForm);
        return "redirect:" + Global.getAdminPath() + "/ac/servAc/queryServAcInfo?userId="+UserUtils.getUser().getId()+"&repage";
    }


    /**
     * 二建录入信息修改
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "modifyAcCompForm")
    public String modifyAcCompForm(ServAssociateConstructor servAcForm,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        servAcForm.setStsDate(new Date());

        if(servAcForm!=null){
            if(servAcForm.getCompanyId()!=null && !"".equals(servAcForm.getCompanyId())){
                servAssociateConstructorService.modifyForm(servAcForm);

            }
        }
        return "redirect:" + Global.getAdminPath() + "/ac/servAc/queryServAcInfo?userId="+UserUtils.getUser().getId()+"&repage";
    }




    /**
     * 初始化二建信息注销页面
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "initRemoveAcForm")
    public String initRemoveAcForm(String userId,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        if(userId==null || "".equals(userId)){
            userId = user.getId();
        }
        ServAssociateConstructor servAcInfo =  servAssociateConstructorService.findByUserId(userId);
        if(servAcInfo ==null ){
            servAcInfo = new ServAssociateConstructor();
            addMessage(redirectAttributes, "温馨提示：用户(" + user.getName() + "),二级建造师注册信息不存在，不能注销。");
            return "redirect:" + Global.getAdminPath() + "/ac/servAc/queryServAcInfo?repage";

        }
        model.addAttribute("servAcInfo", servAcInfo);

        return "modules/ac/servAcRemoveForm";
    }


    /**
     * 二建录入信息注销
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "removeAcForm")
    public String removeAcForm(ServAssociateConstructor servAcForm,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        ServAssociateConstructor  revomeAcForm  = new ServAssociateConstructor();
        revomeAcForm.setStsDate(new Date());
        revomeAcForm.setSts("1");
        revomeAcForm.setRsrvStr1(servAcForm.getRsrvStr1());
        revomeAcForm.setServid(servAcForm.getServid());
        servAssociateConstructorService.modifyForm(revomeAcForm);
        addMessage(redirectAttributes, "温馨提示：用户(" + UserUtils.getUser().getName() + "),二级建造师注册信息注销成功。");
        model.addAttribute("servAcInfo",servAcForm);
        return "redirect:" + Global.getAdminPath() + "/ac/servAc/queryServAcInfo?userId="+revomeAcForm.getUserId()+"&repage";
    }



    /**
     * 二建录入信息修改
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "initServAcInfo")
    public String initServAcInfo(Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        model.addAttribute("servAcInfo", new ServAssociateConstructor());
        return "modules/ac/acServInfoQuery";
    }




    @RequestMapping(value = "initCompanyServAcInfo")
    public String initCompanyServAcInfo(ServAssociateConstructor  servAssociateConstructor,Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        Page<ServAssociateConstructor> page = new Page<ServAssociateConstructor>();
        servAssociateConstructor.setCompanyId(UserUtils.getUser().getUserCompany().getCompanyId());
        page = servAssociateConstructorService.qryServAcInfo(new Page<ServAssociateConstructor>(request, response), servAssociateConstructor);
        model.addAttribute("page", page);
        model.addAttribute("servAcInfo", servAssociateConstructor);
        return "modules/ac/acCompanyServInfoQuery";
    }

    /**
     * 二建录入信息修改
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "qryServAcInfo")
    public String qryServAcInfo(ServAssociateConstructor servAssociateConstructor, HttpServletRequest request, HttpServletResponse response, Model model){
        Page<ServAssociateConstructor> page = new Page<ServAssociateConstructor>();
        page = servAssociateConstructorService.qryServAcInfo(new Page<ServAssociateConstructor>(request, response), servAssociateConstructor);
        model.addAttribute("page", page);
        model.addAttribute("servAcInfo",servAssociateConstructor);
        return "modules/ac/acServInfoQuery";
    }

    /**
     * 二建录入信息修改
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "initManServAcInfo")
    public String initManServAcInfo(Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        model.addAttribute("servAcInfo", new ServAssociateConstructor());
        return "modules/ac/acServInfoManager";
    }

    /**
     * 二建录入信息修改
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "qryManServAcInfo")
    public String qryManServAcInfo(ServAssociateConstructor servAssociateConstructor, HttpServletRequest request, HttpServletResponse response, Model model){
        Page<ServAssociateConstructor> page = new Page<ServAssociateConstructor>();
        page = servAssociateConstructorService.qryServAcInfo(new Page<ServAssociateConstructor>(request, response), servAssociateConstructor);
        model.addAttribute("page", page);
        model.addAttribute("servAcInfo",servAssociateConstructor);
        return "modules/ac/acServInfoManager";
    }


}
