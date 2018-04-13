package com.zhongxin.cims.modules.cp.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.CacheUtils;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.common.dao.SoMapper;
import com.zhongxin.cims.modules.common.entity.*;
import com.zhongxin.cims.modules.common.service.CheckService;
import com.zhongxin.cims.modules.cp.entity.*;
import com.zhongxin.cims.modules.cp.service.PersonnelService;
import com.zhongxin.cims.modules.cp.service.SoCpService;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.service.SysService;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;
import org.apache.commons.lang.ObjectUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by jiwg on 14-6-25.
 */
@Controller
@RequestMapping(value = "${adminPath}/cp/soCp")
public class SoCpController extends BaseController {
    @Autowired
    private SysService sysService;
    @Autowired
    private SoCpService soCpService;
    @Autowired
    private PersonnelService personnelService;
    @Autowired
    private CheckService checkService;
    private String getCacheName(String sessionId,String userId, String appId, String soType) {
        return  sessionId+"-"+userId + "-" + appId + "-" + soType;
    }

    ;

    /**
     * 导航菜单首页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    // @RequiresPermissions("cp:soCp:view")
 /*   @RequestMapping(value = "index")
    public String index() {
        return "modules/cp/cpMain";
    }
*/
    @RequestMapping(value = "index")
    public String index(Model model) {
        model.addAttribute("soCpEntity",new SoCpEntity());
        return "modules/cp/cpSoForm";
    }

    /**
     * 导航菜单树
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "tree")
    public String tree(String appId, Model model) {
        model.addAttribute("cpTreeList", sysService.findTreeMenuListByApp(true, appId));
        return "modules/cp/cpTree";
    }

    /**
     * 导航菜单展示区域
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "none")
    public String none() {
        return "modules/cp/cpNone";
    }


    /**
     * 导航基本信息页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "cpBaseForm")
    public String cpBaseForm(String appId,String soType,String pageModule,SoCpBase soCpBase, Model model) {
        soCpBase.setAppId(appId);
        soCpBase.setSoType(soType);
        soCpBase.setPageModule(pageModule);
        model.addAttribute("soCpBase", soCpBase);
        return "modules/cp/cpBaseForm";
    }


    /**
     * 导航简历信息页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "cpResumeForm")
    public String cpResumeForm(String appId,String soType,String pageModule,SoCpResume soCpResume, Model model) {
        soCpResume.setAppId(appId);
        soCpResume.setSoType(soType);
        soCpResume.setPageModule(pageModule);
        model.addAttribute("soCpResume", soCpResume);
        model.addAttribute("soCpPerfonmance",new SoCpPerformance());
        return "modules/cp/cpResumeForm";
    }


    /**
     * 导航首页信息页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "cpTitleForm")
    public String cpTitleForm(String appId,String soType,String pageModule,So so, Model model) {

        so.setAppId(appId);
        so.setPageModule(pageModule);
        model.addAttribute("so", so);
        return "modules/cp/cpTitleForm";
    }

    /**
     * 导航填写说明页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "cpDescForm")
    public String cpDescForm(Model model) {

        return "modules/cp/cpDescForm";
    }


    /**
     * 导航审核信息页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "cpApprForm")
    public String cpApprForm(String appId,String soType,String pageModule,SoCpApprove soCpApprove, Model model) {
        soCpApprove.setAppId(appId);
        soCpApprove.setSoType(soType);
        soCpApprove.setPageModule(pageModule);
        model.addAttribute("soCpApprove", soCpApprove);
        return "modules/cp/cpApprForm";
    }

    /**
     * 导航附件上传页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "cpAttachment")
    public String cpAttachment(String soid,String appId,String soType,String pageModule,SoAttachment soAttachment, HttpServletRequest request,Model model) {
        soAttachment.setSoid(soid);
        soAttachment.setAppId(appId);
        soAttachment.setSoType(soType);
        soAttachment.setPageModule(pageModule);
        model.addAttribute("soAttachment",soAttachment) ;
        return "modules/file/upload";
    }

    /**
     * 变更补办页面加载
     * param index
     * aram request
     * param response
     * param model
     * return
     */
   // @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "cpModifyForm")
    public String cpModifyForm( HttpServletRequest request,Model model) {
        model.addAttribute("soCpEntity",new SoCpEntity()) ;
        return "modules/cp/cpModifyForm";
    }

    /**
     * 证书注销页面加载
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "cpRemoveForm")
    public String cpRemoveForm(ServCpEntity servCpEntity, HttpServletRequest request,Model model) {
      //  model.addAttribute("soCpEntity",new SoCpEntity()) ;
        return "modules/cp/cpRemoveForm";
    }

    /**
     * 证书注销页面查询
     * @param servCpEntity
     * @param model
     * @param request
     * @param response
     * @param redirectAttributes
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "findRemovePerson")
    public String findRemovePerson(ServCpEntity servCpEntity,Model model,  HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
         ServCpEntity servCpInfo = new ServCpEntity();
         servCpInfo = personnelService.findCpServInfoByIdNo(user.getUserCompany().getCompanyId(),servCpEntity.getPersonnel().getIdNo(),servCpEntity.getPersonnel().getPersonType());
        if(servCpInfo == null) {
            addMessage(redirectAttributes, "温馨提示：您要注销的证书没有找到!");
            model.addAttribute("servCpEntity",new ServCpEntity());
        }else{
            model.addAttribute("servCpEntity",servCpInfo);
        }
        return "modules/cp/cpRemoveForm";

    }


    /**
     * 三类人员首页信息缓存
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "cacheTitle")
    public String cacheTitle(So so, Model model, String param, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        String soid ="";

        //从sysconfig获取保存方式。0 存数据  1缓存
        if(true) {
            So saveSo = soCpService.findSoidByPara(so.getAppId(),so.getSoType(),user.getId(),user.getUserCompany().getCompanyId(),user.getUserCompany().getLocalId());
            if(saveSo!=null){
                addMessage(redirectAttributes, "温馨提示：存在未提交申报，请提交后再申报。");
                return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpTitleForm?repage";
            }else {
                soid = SeqUtils.getSequence("SO_SEQ", ObjectUtils.toString(user.getUserCompany().getLocalId()), so.getAppId(), so.getSoType());
            }
                so.setSoid(soid);
                so.setUserId(user.getId());
                so.setProvinceId(user.getUserCompany().getProvinceId());
                so.setLocalId(user.getUserCompany().getLocalId());
                so.setSts("8");
                so.setStsDate(new Date());
                so.setCreateDate(new Date());
                so.setBatchFlag(so.getBatchId()==null?"0":"1");
                so.setProcessSts("未启动");
                soCpService.saveSo(so);
        }else {
            String sessionId = request.getSession().getId();
            if (so == null) {
                addMessage(redirectAttributes, "温馨提示：首页申请信息未正确填写，不能保存。");
                return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpTitleForm?repage";
            }
            String cacheName = this.getCacheName(sessionId, user.getId(), so.getAppId(), so.getSoType());
            Cache cache = CacheUtils.getCacheManager().getCache(cacheName);
            if (cache != null) {
                So cacheSo = (So) CacheUtils.get(cacheName, so.getPageModule());
                if (cacheSo != null && so.getPageModule().equals(cacheSo.getPageModule())) {
                    addMessage(redirectAttributes, "温馨提示：您存在未提交的申报，请对该申报提交或作废后再次申请。");
                    return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpTitleForm?repage";
                }
            }
            System.out.println("cacheTitle:" + cacheName);
            CacheUtils.put(cacheName, so.getPageModule(), so);

        }
        //return "modules/cp/cpDescForm";
        SoCpBase soCpBase = new SoCpBase();
        soCpBase.setSoid(soid);
        soCpBase.setIdNo(so.getApplIdNo());
        soCpBase.setName(so.getApplPerson());
        soCpBase.setSex(so.getSex());
        soCpBase.setBirthDate(so.getBirthDate());
        soCpBase.setIdType(so.getIdType());
        model.addAttribute("soCpBase", soCpBase);
       return "modules/cp/cpBaseForm";
    }


    /**
     * 三类人员描述页跳转
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "cacheDesc")
    public String cacheDesc(SoCpBase soCpBase, Model model, String param, HttpServletRequest request, HttpServletResponse response) {
        model.addAttribute("soCpBase", soCpBase);
        return "modules/cp/cpBaseForm";

    }


    /**
     * 三类人员基本信息缓存
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "cacheBase")
    public String cacheBase(SoCpBase soCpBase, Model model, String param, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        //从sysconfig获取保存方式。0 存数据  1缓存
        String soid ="";
        if(true) {
            if(soCpBase.getSoid()==null ||"".equals(soCpBase.getSoid())){
                So saveSo = soCpService.findSoidByPara(soCpBase.getAppId(),soCpBase.getSoType(),user.getId(),user.getUserCompany().getCompanyId(),user.getUserCompany().getLocalId());
                if(saveSo ==null){
                    addMessage(redirectAttributes, "温馨提示：首页申报未提交，请先填写首页申报信息。");
                    return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpBaseForm?repage";
                }else{
                    soCpBase.setSoid(soid);
                    SoCpBase checkSoCpBase = soCpService.findSoCpBaseBySoid(saveSo.getSoid());
                    if(checkSoCpBase!=null){
                        addMessage(redirectAttributes, "温馨提示：存在未提交申报，请提交后再申报。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpBaseForm?repage";
                    }
                }

            }
            soCpService.saveSoCpBase(soCpBase);
        }else {
            String sessionId = request.getSession().getId();
            if (soCpBase != null) {
                String cacheName = this.getCacheName(sessionId, user.getId(), soCpBase.getAppId(), soCpBase.getSoType());
                Cache cache = CacheUtils.getCacheManager().getCache(cacheName);
                if (cache != null) {
                    SoCpBase cacheBase = (SoCpBase) CacheUtils.get(cacheName, soCpBase.getPageModule());
                    if (cacheBase != null && soCpBase.getPageModule().equals(cacheBase.getPageModule())) {
                        addMessage(redirectAttributes, "温馨提示：您存在未提交的申报，请对该申报提交或作废后再次申请。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpBaseForm?repage";
                    }
                }
                System.out.println("cacheBase:" + cacheName);
                CacheUtils.put(cacheName, soCpBase.getPageModule(), soCpBase);
            }
        }
        SoCpResume   soCpResume = new SoCpResume();
        SoCpPerformance soCpPerformance = new SoCpPerformance();
        soCpResume.setSoid(soCpBase.getSoid());
        soCpPerformance.setSoid(soCpBase.getSoid());
        model.addAttribute("soCpResume", soCpResume);
        model.addAttribute("soCpPerfonmance",soCpPerformance);
        return "modules/cp/cpResumeForm";

    }
    /**
     * 三类人员简历信息缓存
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "cacheResume")
    public String cacheResume(SoCpResume soCpResume, Model model, String param, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

        User user = UserUtils.getUser();
        if(true){
           /* if(soCpResumeList!=null){
                for (SoCpResume soCpResume :soCpResumeList)   {
                    soCpResume.setSoid(soId);
                    soCpResumeDao.insert(soCpResume);

                }
            }*/

            // if()
        }else {

            String sessionId = request.getSession().getId();

            if (soCpResume != null) {
                String cacheName = this.getCacheName(sessionId, user.getId(), soCpResume.getAppId(), soCpResume.getSoType());
                System.out.println("cacheResume:" + cacheName);
                Cache cache = CacheUtils.getCacheManager().getCache(cacheName);
                if (cache != null) {
                    List<SoCpResume> cacheResumeList = (ArrayList<SoCpResume>) CacheUtils.get(cacheName, soCpResume.getPageModule());
                    if (cacheResumeList != null) {
                        for (SoCpResume soCpResumeCache : cacheResumeList) {
                            soCpResume.getPageModule().equals(soCpResumeCache.getPageModule());
                            addMessage(redirectAttributes, "温馨提示：您存在未提交的申报，请对该申报提交或作废后再次申请。");
                            return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpResumeForm?repage";
                        }
                    }
                }
                List<SoCpResume> soCpResumeList = new ArrayList<SoCpResume>();
                if (soCpResume != null && soCpResume.getCompany() != null) {
                    String companyArrey[] = soCpResume.getCompany().split(",");
                    for (int i = 0; i < companyArrey.length; i++) {
                        SoCpResume soCpResumeElement = new SoCpResume();
                        soCpResumeElement.setAppId(soCpResume.getAppId());
                        soCpResumeElement.setSeq(i);
                        soCpResumeElement.setPosition(soCpResume.getPosition().split(",")[i]);
                        soCpResumeElement.setEffDate(DateUtils.parseDate(soCpResume.getEffDate().toString().split(",")[i]));
                        soCpResumeElement.setExpDate(DateUtils.parseDate(soCpResume.getExpDate().toString().split(",")[i]));
                        soCpResumeElement.setCompany(companyArrey[i]);
                        soCpResumeList.add(soCpResumeElement);
                    }
                }
                CacheUtils.put(cacheName, soCpResume.getPageModule(), soCpResumeList);
             }
        }
        //  model.addAttribute("soCpResume",soCpResume);
        SoCpPerformance soCpPerformance = new SoCpPerformance();
        soCpPerformance.setSoid(soCpResume.getSoid());
        model.addAttribute("soCpPerfonmance",soCpPerformance);
        return "modules/cp/cpResumeForm";
    }


    /**
     * 三类人员工程业绩信息保存
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "cachePerfonmance")
    public String cachePerfonmance(SoCpPerformance soCpPerformance, Model model, String param, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        String soid ="";
        User user = UserUtils.getUser();
        if(true){
            if(soCpPerformance!=null){
                if(soCpPerformance.getSoid()==null ||"".equals(soCpPerformance.getSoid())){
                    So saveSo = soCpService.findSoidByPara(soCpPerformance.getAppId(),soCpPerformance.getSoType(),user.getId(),user.getUserCompany().getCompanyId(),user.getUserCompany().getLocalId());
                    if(saveSo ==null){
                        addMessage(redirectAttributes, "温馨提示：首页申报未提交，请先填写首页申报信息。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpResumeForm?repage";
                    }else{
                        soCpPerformance.setSoid(saveSo.getSoid());
                        SoCpPerformance checkSoCpPerformance = soCpService.findSoCpPerformanceBySoid(saveSo.getSoid());
                        if(checkSoCpPerformance!=null){
                            addMessage(redirectAttributes, "温馨提示：存在未提交申报，请提交后再申报。");
                            return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpResumeForm?repage";
                        }
                    }

                }
                soCpService.saveSoCpPerformance(soCpPerformance);
            }
        }else {

            String sessionId = request.getSession().getId();
            String cacheName = this.getCacheName(sessionId, user.getId(), soCpPerformance.getAppId(), soCpPerformance.getSoType());
            if (soCpPerformance != null) {
                soCpPerformance.setPageModule("cpPerformanceForm");
                SoCpPerformance cachePerformance = (SoCpPerformance) CacheUtils.get(cacheName, soCpPerformance.getPageModule());
                if (cachePerformance != null && soCpPerformance.getPageModule().equals(cachePerformance.getPageModule())) {
                    addMessage(redirectAttributes, "温馨提示：您存在未提交的申报，请对该申报提交或作废后再次申请。");
                    return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpResumeForm?repage";
                }
                CacheUtils.put(cacheName, soCpPerformance.getPageModule(), soCpPerformance);
            }
        }
        SoCpApprove soCpApprove = new SoCpApprove();
        soCpApprove.setSoid(soCpPerformance.getSoid());
        model.addAttribute("soCpApprove",soCpApprove);
        return "modules/cp/cpApprForm";
    }

    /**
     * 三类人员审核信息缓存
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "cacheAppr")
    public String cacheAppr(SoCpApprove soCpApprove, Model model, String param, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        String soid = "";

        User user = UserUtils.getUser();

        if(true){
            if(soCpApprove!=null) {
                if (soCpApprove.getSoid() == null || "".equals(soCpApprove.getSoid())) {
                    So saveSo = soCpService.findSoidByPara(soCpApprove.getAppId(), soCpApprove.getSoType(), user.getId(), user.getUserCompany().getCompanyId(), user.getUserCompany().getLocalId());
                    if (saveSo == null) {
                        addMessage(redirectAttributes, "温馨提示：首页申报未提交，请先填写首页申报信息。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpApprForm?repage";
                    } else {
                        soCpApprove.setSoid(saveSo.getSoid());

                        List<SoCpApprove> checkSoCpApprove = soCpService.findSoCpApproveBySoid(saveSo.getSoid());
                        for (SoCpApprove soCpApproveComp : checkSoCpApprove) {
                            if ("02".equals(soCpApproveComp.getApprType())) {
                                addMessage(redirectAttributes, "温馨提示：您存在未提交的申报，请对该申报提交或作废后再次申请。");
                                return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpApprForm?repage";
                            }

                        }
                    }

                }
                soCpApprove.setApprId("0");
                soCpApprove.setApprType(Constants.SO_APPR_ASS_STS_COMP);
                soCpApprove.setApprOfficeId(user.getOffice().getId());
                soCpApprove.setApprDate(new Date());
                soCpApprove.setApprUserId(user.getId());
                soCpApprove.setSts(Constants.GLOBAL_SO_COMMIT_STS);
                soCpApprove.setStsDate(new Date());
                soCpApprove.setTaskName("企业申报");
                soCpService.saveSoCpApprove(soCpApprove);
            }
        }else {


            String sessionId = request.getSession().getId();

            if (soCpApprove != null) {
                String cacheName = this.getCacheName(sessionId, user.getId(), soCpApprove.getAppId(), soCpApprove.getSoType());
                Cache cache = CacheUtils.getCacheManager().getCache(cacheName);
                if (cache != null) {
                    SoCpApprove cacheAppr = (SoCpApprove) CacheUtils.get(cacheName, soCpApprove.getPageModule());
                    if (cacheAppr != null && cacheAppr.getPageModule().equals(cacheAppr.getPageModule())) {
                        addMessage(redirectAttributes, "温馨提示：您存在未提交的申报，请对该申报提交或作废后再次申请。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpApprForm?repage";
                    }
                }
                System.out.println("cacheAppr:" + cacheName);
                CacheUtils.put(cacheName, soCpApprove.getPageModule(), soCpApprove);
            }
        }
        if(soCpApprove.getSoid()!=null){
            soid = soCpApprove.getSoid();
        }
       return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpAttachment?soid="+soid+"&appId=CP&soType=01&pageModule=cpAttachment?repage";
    }


    /**
     * 三类人员缓存信息统一提交页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "cpSaveForm")
    public String cpSaveForm(So so, Model model ,HttpServletRequest request, HttpServletResponse response) {
        User user = UserUtils.getUser();
        SoCache soCache = new SoCache();
        if(true){
            So saveSo = soCpService.findSoidByPara(so.getAppId(), so.getSoType(), user.getId(), user.getUserCompany().getCompanyId(), user.getUserCompany().getLocalId());
            SoCpBase soCpBase = new SoCpBase();
            if(saveSo!=null){
                 soCpBase =soCpService.findSoCpBaseBySoid(saveSo.getSoid());

            }
            soCache.setSo(saveSo);
            soCache.setSoCpBase(soCpBase);
         }else {
            String sessionId = request.getSession().getId();
            String cacheName = this.getCacheName(sessionId, user.getId(), so.getAppId(), so.getSoType());
            Cache cache = CacheUtils.getCacheManager().getCache(cacheName);
             soCache = new SoCache();
            if (cache != null) {
                List list = cache.getKeys();
                for (int i = 0; i < list.size(); i++) {
                    Element element = cache.get(list.get(i));
                    Object obj = element.getObjectValue();
                    if (obj instanceof So) {
                        soCache.setSo((So) obj);
                    }
                    if (obj instanceof SoCpBase) {
                        soCache.setSoCpBase((SoCpBase) obj);
                    }
                    if (obj instanceof ArrayList) {
                        soCache.setSoCpResumeList((ArrayList) obj);
                    }
                    if (obj instanceof SoCpPerformance) {
                        soCache.setSoCpPerformance((SoCpPerformance) obj);
                    }
                    if (obj instanceof SoCpApprove) {
                        soCache.setSoCpApprove((SoCpApprove) obj);
                    }

                }
            }
        }
        model.addAttribute("soCache", soCache);
        return "modules/cp/cpSaveForm";
    }



    /**
     * 三类人员缓存信息统一提交页
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "cpCommitForm")
    public String cpCommitForm(SoCpEntity soCpEntity, Model model ,HttpServletRequest request, HttpServletResponse response) {
            Page<SoCpEntity> page = new Page<SoCpEntity>();
            if (soCpEntity.getSo() == null) {
                So so = new So();
                so.setUserId(UserUtils.getUser().getId());
                so.setSts(Constants.SO_STS_SAVE);
                soCpEntity.setSo(so);
            } else {
                soCpEntity.getSo().setUserId(UserUtils.getUser().getId());
                soCpEntity.getSo().setSts(Constants.SO_STS_SAVE);
            }
            page = soCpService.findSoCpList(new Page<SoCpEntity>(request, response), soCpEntity);
            model.addAttribute("page", page);
        return "modules/cp/cpCommitForm";
    }

    /**
     * 三类人员缓存信息统一提交方法
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "save")
    public String save(So soReq, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        if(true){
            So saveSo = soCpService.findSoidByPara(soReq.getAppId(), soReq.getSoType(), user.getId(), user.getUserCompany().getCompanyId(), user.getUserCompany().getLocalId());
            saveSo.setSts(Constants.SO_STS_SAVE);
            soCpService.updateByPrimaryKey(saveSo);
        }else {
            String sessionId = request.getSession().getId();
            String cacheName = this.getCacheName(sessionId, user.getId(), soReq.getAppId(), soReq.getSoType());
            Cache cache = CacheUtils.getCacheManager().getCache(cacheName);
            SoCache soCache = null;
            if (cache != null) {
                List list = cache.getKeys();
                if (!list.isEmpty()) soCache = new SoCache();
                for (int i = 0; i < list.size(); i++) {
                    Element element = cache.get(list.get(i));
                    Object obj = element.getObjectValue();
                    if (obj instanceof So) {
                        So so = (So) obj;
                        so.setUserId(user.getId());
                        so.setProvinceId(user.getUserCompany().getProvinceId());
                        so.setLocalId(user.getUserCompany().getLocalId());
                        so.setSts(Constants.SO_STS_SAVE);
                        so.setStsDate(new Date());
                        so.setCreateDate(new Date());
                        //临时处理
                        so.setBatchFlag(so.getBatchId() == null ? "0" : "1");
                        so.setProcessSts("未启动");
                        soCache.setSo(so);
                    }
                    if (obj instanceof SoCpBase) {
                        soCache.setSoCpBase((SoCpBase) obj);
                    }
                    if (obj instanceof ArrayList) {

                        soCache.setSoCpResumeList((ArrayList) obj);
                    }
               /* if (obj instanceof SoCpResume) {
                    soCache.setSoCpResume((SoCpResume) obj);
                }*/
                    if (obj instanceof SoCpPerformance) {
                        soCache.setSoCpPerformance((SoCpPerformance) obj);
                    }
                    if (obj instanceof SoCpApprove) {
                        SoCpApprove soCpApprove = (SoCpApprove) obj;
                        soCpApprove.setApprId("0");
                        soCpApprove.setApprType(Constants.SO_APPR_ASS_STS_COMP);
                        soCpApprove.setApprOfficeId(user.getOffice().getId());
                        soCpApprove.setApprDate(new Date());
                        soCpApprove.setApprUserId(user.getId());
                        soCpApprove.setSts(Constants.GLOBAL_SO_COMMIT_STS);
                        soCpApprove.setStsDate(new Date());
                        soCpApprove.setTaskName("企业申报");
                        soCache.setSoCpApprove(soCpApprove);
                        //  personnelService.saveAppr(soCpApprove);
                    }

                }
                if (soCache != null) {
                    //校验
                    if (soCache.getSo() == null) {
                        addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。首页申请未保存，请保存后进行申报单提交。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpSaveForm/?appId=" + soReq.getAppId() + "&soType=" + soReq.getSoType() + "&pageModule=cpSaveForm&repage";
                    }
                    if (soCache.getSoCpBase() == null) {
                        addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。基本信息页未保存，请保存后进行申报单提交。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpSaveForm/?appId=" + soReq.getAppId() + "&soType=" + soReq.getSoType() + "&pageModule=cpSaveForm&repage";
                    }
                    if (soCache.getSoCpResumeList() == null) {
                        addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。简历信息页未保存，请并保存后进行申报单提交。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpSaveForm/?appId=" + soReq.getAppId() + "&soType=" + soReq.getSoType() + "&pageModule=cpSaveForm&repage";
                    }
               /* if (soCache.getSoCpPerformance() == null) {
                    addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。简历信息页未保存，请并保存后进行申报单提交。");
                }*/
                    if (soCache.getSoCpApprove() == null) {
                        addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。审核信息页未保存，请正确填写保存后提交。");
                        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpSaveForm/?appId=" + soReq.getAppId() + "&soType=" + soReq.getSoType() + "&pageModule=cpSaveForm&repage";


                    }
                    soCache.setSessionId(request.getSession().getId());
                    //提交
                    int flag = soCpService.save(soCache);
                    if (flag == 0) {
                        addMessage(redirectAttributes, "温馨提示：您的申报已成功保存。");
                        logger.debug("申报单：(" + soCache.getSo().getSoid() + ")已成功入库。");
                        if (cache != null) for (Object key : cache.getKeys()) {
                            cache.remove(key);
                            logger.debug("缓存：(" + cacheName + ")健值：(" + key + ")已成功释放。");
                        }
                    } else {
                        addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。");

                    }
                }
            }
        }
        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpCommitForm/?repage";
    }


    /**
     * 三类人员流程启动
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "startProcess")
    public String startProcess(String soid, Model model, RedirectAttributes redirectAttributes) {
        So so = new So();
        so.setSoid(soid);
        so.setUserId(UserUtils.getUser().getId());
        int flag = soCpService.startProcess(so);
        if (flag == 0) {
            addMessage(redirectAttributes, "温馨提示：您的申报已成功提交，申报已上报审核。");
            System.out.println("申报单：(" + soid + ")已提交成功，流程已启动。");

        }else{
            addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。");
        }
        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpCommitForm/?repage";

    }


    /**
     * 三类人员批量流程启动
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "batchStartProcess")
    public String batchStartProcess(String[] seqs, Model model, RedirectAttributes redirectAttributes) {
        for(String soid:seqs) {
            logger.debug("soid:" + soid);

            So so = new So();
            so.setSoid(soid);
            so.setUserId(UserUtils.getUser().getId());
            int flag = soCpService.startProcess(so);

            if (flag == 0) {
                addMessage(redirectAttributes, "温馨提示：您的申报已成功提交，申报已上报审核。");
                System.out.println("申报单：(" + soid + ")已提交成功，流程已启动。");

            } else {
                addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。");
            }
        }
        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpCommitForm/?repage";

    }


    /**
     * 三类人员缓存信息统一释放方法
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "remove")
    public String remove(String appId,String soType, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String sessionId = request.getSession().getId();
        String cacheName = this.getCacheName(sessionId,UserUtils.getUser().getId(),appId, soType);
        System.out.println("remove cacheName:"+cacheName);
        CacheUtils.removeByCacheName(cacheName);
        return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpSaveForm";

    }

    /**
     * 三类人员申报信息
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    // @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = {"soCpChgForm"})
    public String soCpChgForm(String soid,String actType, HttpServletRequest request, HttpServletResponse response, Model model) {
        SoCpEntity soCpEntity = new SoCpEntity();
        soCpEntity=soCpService.findSoAllBySoid(soid);
        soCpEntity.setSoid(soid);
        soCpEntity.setActType(actType);
        model.addAttribute("soCpEntity", soCpEntity);
        return "modules/cp/cpSoChgForm";
    }

    /**
     * 三类人员申报信息展示
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    // @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = {"soCpInfo"})
    public String soCpInfo(String soid,String soType, HttpServletRequest request, HttpServletResponse response, Model model) {
        if(Constants.GLOBAL_SO_TYPE_REMOVE.equals(soType)){
           SoCpEntity soCpEntity  = soCpService.findSoAllBySoid(soid);
            model.addAttribute("soCpEntity",soCpEntity);
            return "modules/cp/cpRemovePage";
        } else{
            So so = soCpService.findSoBySoid(soid);
            model.addAttribute("so", so);
            return "modules/cp/cpSoInfo";
        }
    }


    /**
     * 三类人员申报基本信息展示
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    //@RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"cpBasePage"})
    public String cpBasePage(String soid, HttpServletRequest request, HttpServletResponse response, Model model) {
        SoCpBase soCpBase = new SoCpBase();
        if (soid != null && !"".equals(soid)) {
            soCpBase = soCpService.findSoCpBaseBySoid(soid);
            model.addAttribute("soCpBase", soCpBase);
            model.addAttribute("page", soCpBase);
        } else {
            model.addAttribute("page", new Page<SoCpBase>());
        }
        return "modules/cp/cpSoBasePage";
    }


    /**
     * 三类人员简历信息展示
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    //@RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"cpResumePage"})
    public String cpResumePage(String soid, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<SoCpResume> soCpResumeList = null;
        if (soid != null && !"".equals(soid)) {
            soCpResumeList = soCpService.findSoCpResumeBySoid(soid);
            if (soCpResumeList.size() == 0) {
                soCpResumeList.add(new SoCpResume());
            }
            SoCpPerformance soCpPerformance = soCpService.findSoCpPerformanceBySoid(soid);
            if (soCpPerformance == null) {
                soCpPerformance = new SoCpPerformance();
            } else
                model.addAttribute("soCpResumeList", soCpResumeList);
            model.addAttribute("soCpPerformance", soCpPerformance);
        } else {
            model.addAttribute("page", new Page<SoCpResume>());
        }
        return "modules/cp/cpSoResumePage";
    }


    /**
     * 三类人员审批信息展示
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    //@RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"cpApprPage"})
    public String cpApprPage(String soid, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<SoCpApprove> soCpApproveList = new ArrayList<SoCpApprove>();
        if (soid != null && !"".equals(soid)) {
            soCpApproveList = soCpService.findSoCpApproveBySoid(soid);
            /*if (soCpApproveList.size() > 0) {
                for (SoCpApprove soCpApprove : soCpApproveList) {
                    if ("02".equals(soCpApprove.getApprType())) model.addAttribute("soCpApprove", soCpApprove);
                }
            } else {
                model.addAttribute("soCpApprove", new SoCpApprove());
            }*/

            model.addAttribute("soCpApproveList",soCpApproveList);

        } else {
            model.addAttribute("page", new Page<SoCpApprove>());
        }
        return "modules/cp/cpSoApprPage";
    }



    /**
     * 三类人员附件信息展示
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    //@RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"cpUploadPage"})
    public String cpUploadPage(String soid, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<SoAttachment> attachments =soCpService.findSoCpUploadBySoid(soid);
        if(!attachments.isEmpty()){
            for(SoAttachment attachment : attachments) {
                attachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+attachment.getId());
                attachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + attachment.getId());
            }
            model.addAttribute("files",attachments);
        }
        return "modules/cp/cpSoUploadPage";
    }

    /**
     * 获取当前申报列表
     *
     * @param soCpEntity
     * @param request
     * @param response
     * @param model
     * @return
     */
    // @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = {"query"})
    public String querySoCpList(SoCpEntity soCpEntity, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        Page<SoCpEntity> page = new Page<SoCpEntity>();
        if (soCpEntity.getSo() == null) {
            So so = new So();
            so.setUserId(UserUtils.getUser().getId());
            soCpEntity.setSo(so);
        } else {
            soCpEntity.getSo().setUserId(UserUtils.getUser().getId());
        }
        page = soCpService.findSoCpProcessList(new Page<SoCpEntity>(request, response), soCpEntity);
        model.addAttribute("page", page);
        return "modules/cp/cpSoList";
    }


    /**
     * 三类人员申报列表审核历史信息
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    // @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = "queryDetail")
    public String queryDetail(String soid, Model model) {
        List<SoCpApprove> soCpApproves = soCpService.findSoCpApproveBySoid(soid);
        model.addAttribute("soCpApproves",soCpApproves);
        return "modules/cp/cpSoListDetail";
    }


    /**
     * 三类人员申报列表删除
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    //@RequiresPermissions("cp:soCp:edit")
    @RequestMapping(value = "removeSoByPrimaryKey")
    public String removeSoByPrimaryKey(String soid,String actType, Model model, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        So so = soCpService.findSoBySoid(soid);
        boolean checkCommitFlag =true;
        boolean checkUserFlag =true;
        boolean checkCompFlag =true;
        if (so != null) {
            if (!"1".equals(so.getSts()) &&!"9".equals(so.getSts())&&!"8".equals(so.getSts())) {
                checkCommitFlag = false;
            } else if (!user.getId().equals(so.getUserId())) {
                checkUserFlag = false;
            } else if(!user.getUserCompany().getCompanyId().equals(so.getCompanyId())) {
                checkCompFlag = false;
            }
        }
        if(!checkCommitFlag){
            addMessage(redirectAttributes, "温馨提示：申报单已提交上报审核，不能删除申报单。");
        }
        if(!checkUserFlag)  {
            addMessage(redirectAttributes, "温馨提示：您不能删除非本人提交申报单。");
        }
        if(!checkCompFlag)  {
            addMessage(redirectAttributes, "温馨提示：您不能删除非本企业申报单。");
        }
        if(checkCommitFlag&&checkUserFlag&&checkCompFlag) {
            soCpService.removeSoByPrimaryKey(soid);
            addMessage(redirectAttributes, "温馨提示：申报单（"+soid+"）已删除成功。");
        }
        if(!"".equals(actType) && actType !=null){
            return "redirect:" + Global.getAdminPath() + "/cp/soCp/query/?repage";
        } else{
            return "redirect:" + Global.getAdminPath() + "/cp/soCp/queryCommitList/?repage";
        }
    }

    /**
     * 三类人员申报列表批量
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    //@RequiresPermissions("cp:soCp:edit")
    @RequestMapping(value = "removeSoBatchByPrimaryKey")
    public String removeSoBatchByPrimaryKey(String[] seqs,String removeTag, Model model, RedirectAttributes redirectAttributes) {
        boolean checkCommitFlag =true;
        boolean checkUserFlag =true;
        boolean checkCompFlag =true;
        for (String soid:seqs) {
            logger.debug("soid:" + soid);
            So so = soCpService.findSoBySoid(soid);

            if (so != null) {
                if (/*!"1".equals(so.getSts()) || */!"9".equals(so.getSts())) {
                    checkCommitFlag = false;
                } else if (!UserUtils.getUser().getId().equals(so.getUserId())) {
                    checkUserFlag = false;
                } else if (!UserUtils.getUser().getUserCompany().getCompanyId().equals(so.getCompanyId())) {
                    checkCompFlag = false;
                }
            }
            if(!checkCommitFlag){
                addMessage(redirectAttributes, "温馨提示：申报单（"+soid+"）已提交上报审核，不能删除申报单。");
                break;
            }
            if(!checkUserFlag)  {
                addMessage(redirectAttributes, "温馨提示：申报单（"+soid+"）非本人受理申报，不能删除申报单。");
                break;
            }
            if(!checkCompFlag)  {
                addMessage(redirectAttributes, "温馨提示：申报单（"+soid+"）非当前公司受理申报，不能删除申报单。");
                break;
            }
        }


        for(String soid:seqs){
            if(checkCommitFlag&&checkUserFlag&&checkCompFlag) {
                soCpService.removeSoByPrimaryKey(soid);
                addMessage(redirectAttributes, "温馨提示：申报单批量删除成功。");
            }
        }
        if(!"".equals(removeTag) && removeTag !=null){
            return "redirect:" + Global.getAdminPath() + "/cp/soCp/query/?repage";
        } else{
            return "redirect:" + Global.getAdminPath() + "/cp/soCp/queryCommitList/?repage";
        }
    }

    /**
     * 三类人员延续申报
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    @RequestMapping(value = "extendList")
    public String extendList(Personnel personnel,Model model,  HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        personnel.setCompanyId(user.getUserCompany().getCompanyId());
        Page<Personnel> page = personnelService.findPersonnelForExtend(new Page<Personnel>(request, response), personnel);
        model.addAttribute("page", page);
        return "modules/cp/cpSoExtendList";

    }



    /**
     * 三类人员缓存信息统一提交方法
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "saveForm")
    public String saveForm(SoCpEntity soCpEntity, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();

         CheckSo checkSo= checkService.checkSoBeforeSave(soCpEntity);
        if(checkSo!=null){
            if(checkSo.isFlag()){
                addMessage(redirectAttributes, checkSo.getMsg());
                if(Constants.GLOBAL_SO_TYPE_EXTEND.equals(soCpEntity.getSo().getSoType())) {
                    return "redirect:" + Global.getAdminPath() + "/cp/soCp/extendList";
                }
                if(Constants.GLOBAL_SO_TYPE_SO.equals(soCpEntity.getSo().getSoType())) {
                    return "redirect:" + Global.getAdminPath() + "/cp/soCp/index";
                }
            }
        }
        So so = soCpEntity.getSo();
        so.setUserId(user.getId());
            so.setProvinceId(user.getUserCompany().getProvinceId());
            so.setLocalId(user.getUserCompany().getLocalId());
            so.setSts(Constants.SO_STS_SAVE);
            so.setStsDate(new Date());
            so.setCreateDate(new Date());
            so.setBatchFlag(so.getBatchId()==null?"0":"1");
            so.setProcessSts("未启动");

        List<SoCpApprove> soCpApproveList = soCpEntity.getSoCpApprove();
        if(soCpApproveList!=null){
            for (SoCpApprove soCpApprove :soCpApproveList)   {

                soCpApprove.setApprId("0");
                soCpApprove.setApprType(Constants.SO_APPR_ASS_STS_COMP);
                soCpApprove.setApprOfficeId(user.getOffice().getId());
                soCpApprove.setApprDate(new Date());
                soCpApprove.setApprUserId(user.getId());
                soCpApprove.setSts("1");
                soCpApprove.setStsDate(new Date());
                soCpApprove.setTaskName("企业申报");
            }
        }
         soCpEntity.setSessionId(request.getSession().getId());
        String soid = soCpService.saveForm(soCpEntity);
        if (!"".equals(soid)&&soid!=null) {
            addMessage(redirectAttributes, "温馨提示：您的申报("+soid+")已成功提交。");
            System.out.println("订单：(" + soCpEntity.getSo().getSoid() + ")已成功入库。");
        }else{
            addMessage(redirectAttributes, "温馨提示：您的申报未提交成功。");

        }
        // return Global.getAdminPath()+"/cp/assess/query";

        return "redirect:" + Global.getAdminPath()+"/cp/soCp/cpCommitForm/?repage";
    }



    /**
     * 三类人员缓存信息统一提交方法
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "saveChgForm")
    public String saveChgForm(SoCpEntity soCpEntity, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();
        soCpEntity.setSessionId(request.getSession().getId());
        So so = soCpEntity.getSo();
            so.setCreateDate(new Date());
            so.setRemarks("申报修改");
        String soid = soCpService.saveChgForm(soCpEntity);
        if (soid!=null && !"".equals(soid)) {
            addMessage(redirectAttributes, "温馨提示：您的申报("+soid+")已成功修改。");
            System.out.println("订单：(" + soCpEntity.getSo().getSoid() + ")已成功修改入库。");
        }else{
            addMessage(redirectAttributes, "温馨提示：您的申报未修改成功。");

        }
        if(!"".equals(soCpEntity.getActType()) && soCpEntity.getActType() !=null){
            return "redirect:" + Global.getAdminPath() + "/cp/soCp/query/?repage";
        } else{
            return "redirect:" + Global.getAdminPath() + "/cp/soCp/queryCommitList/?repage";
        }
    }


    /**
     * 三类人员缓存信息统一提交方法
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    @RequestMapping(value = "saveRemoveForm")
    public String saveRemoveForm(ServCpEntity servCpEntity, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        User user = UserUtils.getUser();

         //时间仓促，都暂时写死，后续修改
        SoCpEntity soCpEntity = new SoCpEntity();
        So so = new So();
            so.setSoType(Constants.GLOBAL_SO_TYPE_REMOVE);
            so.setAppId(Constants.GLOBAL_CP_APP_ID);
            so.setUserId(user.getId());
            so.setProvinceId(user.getUserCompany().getProvinceId());
            so.setLocalId(user.getUserCompany().getLocalId());
            so.setCompanyId(servCpEntity.getPersonnel().getCompanyId());
            so.setSts(Constants.SO_STS_SAVE);
            so.setStsDate(new Date());
            so.setCreateDate(new Date());
            so.setBatchFlag(so.getBatchId()==null?"1":"0");
            so.setProcessSts("未启动");
            so.setRsrvStr1(servCpEntity.getPersonnel().getRsrvStr1());
            so.setRsrvStr2(servCpEntity.getPersonnel().getRsrvStr2());
            so.setRemarks(servCpEntity.getPersonnel().getRemarks());
            so.setApplPerson(servCpEntity.getPersonnel().getName());
            so.setApplIdNo(servCpEntity.getPersonnel().getIdNo());
            so.setApplDate(new Date());
            so.setServid(servCpEntity.getServid());
        soCpEntity.setSo(so);
        SoCpBase soCpBase = new SoCpBase();
            soCpBase.setName(servCpEntity.getPersonnel().getName());
            soCpBase.setBirthDate(servCpEntity.getPersonnel().getBirthDate());
            soCpBase.setSex(servCpEntity.getPersonnel().getSex());
            soCpBase.setIdNo(servCpEntity.getPersonnel().getIdNo());
            soCpBase.setPersonType(servCpEntity.getPersonnel().getPersonType());
            soCpBase.setCompanyId(servCpEntity.getPersonnel().getCompanyId());
            soCpBase.setIdType(servCpEntity.getPersonnel().getIdType());
            soCpBase.setMajor(servCpEntity.getPersonnel().getMajor());
        soCpEntity.setSoCpBase(soCpBase);

        List<SoCpApprove> soCpApproveList = new ArrayList<SoCpApprove>();
                SoCpApprove soCpApprove = new SoCpApprove();
                soCpApprove.setApprId("0");
                soCpApprove.setApprType(Constants.SO_APPR_ASS_STS_COMP);
                soCpApprove.setApprOfficeId(user.getOffice().getId());
                soCpApprove.setApprDate(new Date());
                soCpApprove.setApprUserId(user.getId());
                soCpApprove.setSts("1");
                soCpApprove.setContent(servCpEntity.getPersonnel().getRsrvStr3());
                soCpApprove.setStsDate(new Date());
                soCpApprove.setTaskName("企业申报");
        soCpApproveList.add(soCpApprove);
        soCpEntity.setSoCpApprove(soCpApproveList);

        SoMainCert soMainCert = new SoMainCert();
        soMainCert.setServid(servCpEntity.getServid());
        soMainCert.setCompanyId(servCpEntity.getPersonnel().getCompanyId());
        soMainCert.setCertNo(servCpEntity.getCert().getCertNo());
        soMainCert.setCertType(servCpEntity.getCert().getCertType());
        soMainCert.setCertDate(new Date());
        soMainCert.setCertSts("3");
        soMainCert.setSts("1");
        soMainCert.setStsDate(new Date());
        soMainCert.setIssueBy(servCpEntity.getCert().getIssueBy());
        soMainCert.setIssueDate(new Date());
        soMainCert.setEffDate(servCpEntity.getCert().getEffDate());
        soMainCert.setExpDate(servCpEntity.getCert().getExpDate());
        soCpEntity.setSoMainCert(soMainCert);


        CheckSo checkSo = checkService.checkSoBeforeSave(soCpEntity);
        if(checkSo!=null){
            if(checkSo.isFlag()){
                addMessage(redirectAttributes, checkSo.getMsg());
                if(Constants.GLOBAL_SO_TYPE_EXTEND.equals(soCpEntity.getSo().getSoType())) {
                    return "redirect:" + Global.getAdminPath() + "/cp/soCp/extendList";
                }
                if(Constants.GLOBAL_SO_TYPE_SO.equals(soCpEntity.getSo().getSoType())) {
                    return "redirect:" + Global.getAdminPath() + "/cp/soCp/index";
                }
                if(Constants.GLOBAL_SO_TYPE_REMOVE.equals(soCpEntity.getSo().getSoType())) {
                    return "redirect:" + Global.getAdminPath() + "/cp/soCp/cpRemoveForm";
                }
            }
        }


        String soid = soCpService.saveForm(soCpEntity);
        if (soid!=null && !"".equals(soid)) {
            addMessage(redirectAttributes, "温馨提示：您的申报("+soid+")已成功保存。");
            System.out.println("订单：(" + soCpEntity.getSo().getSoid() + ")已成功提交（注销）入库。");
        }else{
            addMessage(redirectAttributes, "温馨提示：您的申报未保存成功。");

        }
        if(!"".equals(soCpEntity.getActType()) && soCpEntity.getActType() !=null){
            return "redirect:" + Global.getAdminPath() + "/cp/soCp/query/?repage";
        } else{
            return "redirect:" + Global.getAdminPath() + "/cp/soCp/queryCommitList/?repage";
        }
    }

    /**
     * 三类人员退回企业重新上报
     * param index
     * aram request
     * param response
     * param model
     * return
     */
    // @RequiresPermissions("cp:soCp:view")
 /*   @RequestMapping(value = {"soCpReCommit"})
    public String soCpReCommit(String soid, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        So so = soCpService.findSoBySoid(soid);
        so.setSts(Constants.SO_STS_COMMIT);
        soCpService.updateStsByPrimaryKey(so);
        addMessage(redirectAttributes, "温馨提示：您的申报单("+soid+")重新上报成功。");

        return "redirect:" + Global.getAdminPath() + "/cp/soCp/query/?repage";

    }*/

    /**
     * 获取当前待提交列表
     *
     * @param soCpEntity
     * @param request
     * @param response
     * @param model
     * @return
     */
    // @RequiresPermissions("cp:soCp:view")
    @RequestMapping(value = {"queryCommitList"})
    public String queryCommitList(SoCpEntity soCpEntity, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        Page<SoCpEntity> page = new Page<SoCpEntity>();
        if (soCpEntity.getSo() == null) {
            So so = new So();
            so.setUserId(UserUtils.getUser().getId());
            so.setSts(Constants.SO_STS_SAVE);
            soCpEntity.setSo(so);
        } else {
            soCpEntity.getSo().setUserId(UserUtils.getUser().getId());
            soCpEntity.getSo().setSts(Constants.SO_STS_SAVE);
        }
        page = soCpService.findSoCpList(new Page<SoCpEntity>(request, response), soCpEntity);
        model.addAttribute("page", page);
        return "modules/cp/cpCommitForm";
    }
    /**
     * 在审核、已审核汇总
     */
    @RequestMapping(value = {"onCheckSumView"})
    public String onCheckSumView(So so,HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        Map map = new HashMap();
        map.put("LOCAL_ID",so.getLocalId());
        map.put("BATCH_ID",so.getBatchId());
        map.put("COMPANY_ID",so.getCompanyId());
        Page page=soCpService.getCpCheckedList(new Page(request, response),map);
        model.addAttribute("page", page);
        return "modules/cp/onCheckSumView";
    }

    /**
     * 导出审核数据
     * @param user
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "export", method= RequestMethod.POST)
    public String exportFile(So so,User user, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            Map map = new HashMap();
            map.put("LOCAL_ID",so.getLocalId());
            map.put("BATCH_ID",so.getBatchId());
            map.put("COMPANY_ID",so.getCompanyId());
            soCpService.uploadListIntoExcel(map,response);
        } catch (Exception e) {
            addMessage(redirectAttributes, "已审核数据导出！失败信息："+e.getMessage());
        }
        return "modules/cp/onCheckSumView";
    }
}