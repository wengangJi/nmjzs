package com.zhongxin.cims.modules.cp.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.mapper.BeanCopierMapper;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.ServAttachment;
import com.zhongxin.cims.modules.common.service.CertService;
import com.zhongxin.cims.modules.cp.dao.SoCpBaseMapper;
import com.zhongxin.cims.modules.cp.entity.*;
import com.zhongxin.cims.modules.sys.entity.Tag;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.service.SysService;
import com.zhongxin.cims.modules.sys.utils.TagUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.cp.service.PersonnelService;
import com.zhongxin.cims.common.mapper.JsonMapper;

import java.util.ArrayList;
import java.util.List;


/**
 * 三类人员Controller
 * @author liuqy
 * @version 2014-06-10
 */

@Controller
@RequestMapping(value = "${adminPath}/cp/personnel")
public class PersonnelController extends BaseController {


	@Autowired
	private PersonnelService personnelService;
    @Autowired
    private SysService sysService;
    @Autowired
    private CertService certService;
    @Autowired
    private SoCpBaseMapper soCpBaseMapper;


    @ModelAttribute
	public Personnel get(@RequestParam(required=false) String id) {
		if (id != null){
			return personnelService.get(id);
		}else{
			return new Personnel();
		}
	}
	
	@RequiresPermissions("cp:personnel:view")
	@RequestMapping(value = {"list", ""})
	public String list(Personnel personnel,Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (companyId != null){
            personnel.setCompanyId(companyId);
            Page<Personnel> page = personnelService.find(new Page<Personnel>(request, response), personnel);
            model.addAttribute("page", page);
        } else {
            model.addAttribute("page", new Page<Personnel>());
        }
		return "modules/cp/personnelList";
	}


    @RequiresPermissions("cp:personnel:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		personnelService.delete(id);
		addMessage(redirectAttributes, "删除三类人员成功");
		return "redirect:"+Global.getAdminPath()+"/cp/personnel/?repage";
	}

    @ResponseBody
    @RequestMapping(value = {"findListByIdNo"})
    public String findListByIdNo(String name, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<Personnel> list = personnelService.findListByIdNo(name);
        return JsonMapper.nonDefaultMapper().toJson(list);
    }

    /**
     * 三类人员证书分配页加载
     * param index
     * aram request
     *param response
     *param model
     *return
     */
   // @RequiresPermissions("cp:personnel:view")
    @RequestMapping(value = {"findCpAssignCert"})
    public String findCpAssignCert(ServCpEntity servCpEntity,HttpServletRequest request, HttpServletResponse response, Model model) {
        if(servCpEntity.getCert() == null){
            Cert cert = new Cert();
            //cert.setCertSts("0");
            servCpEntity.setCert(cert);
        }
        Page<ServCpEntity>   page = certService.findCpAssignCert(new Page<ServCpEntity>(request, response) ,servCpEntity);
        model.addAttribute("page", page);
        return "modules/cp/cpCertPage";
    }


    /**
     * 三类人员证书管理加载
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    // @RequiresPermissions("cp:personnel:view")
    @RequestMapping(value = {"cpCertManagerForm"})
    public String cpManagerCertForm(ServCpEntity servCpEntity,HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<ServCpEntity>   page = new Page<ServCpEntity>(request, response);
        model.addAttribute("page", page);
        return "modules/cp/cpCertManager";
    }

    /**
     * 三类人员证书管理查询
     * param index
     * aram request
     *param response
     *param model
     *return
     */
   // @RequiresPermissions("cp:personnel:view")
    @RequestMapping(value = {"findCpManagerCert"})
    public String findCpManagerCert(ServCpEntity servCpEntity,HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<ServCpEntity>   page = certService.findCpManagerCert(new Page<ServCpEntity>(request, response) ,servCpEntity);
        model.addAttribute("page", page);
        return "modules/cp/cpCertManager";
    }

    /**
     * 三类人员服务信息
     * param index
     * aram request
     *param response
     *param model
     *return
     */
   // @RequiresPermissions("cp:personnel:view")
    @RequestMapping(value = {"findCpServInfoById"})
    public String findCpServInfoById( Integer servid,String soType,HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        ServCpEntity servCpEntity = personnelService.findCpServInfoById(servid);
        SoCpEntity soCpEntity = new SoCpEntity();
        if(servCpEntity==null && Constants.GLOBAL_SO_TYPE_EXTEND.equals(soType)){
             addMessage(redirectAttributes, "温馨提示：没有找到相关服务信息,不能进行延期业务办理。");
             return "redirect:" + Global.getAdminPath() + "/cp/soCp/extendList/?repage";
         }
        SoCpBase soCpBase = new SoCpBase();
        if(servCpEntity.getPersonnel()!=null){
           BeanCopierMapper.copyProperties(servCpEntity.getPersonnel(),soCpBase);
            soCpEntity.setSoCpBase(soCpBase);
        }
        List<SoCpResume> soCpResumes = new ArrayList<SoCpResume>();
        SoCpResume soCpResume = new SoCpResume();
        for(ServCpResume servCpResume:servCpEntity.getServCpResumes()){
            BeanCopierMapper.copyProperties(servCpResume,soCpResume);
            soCpResumes.add(soCpResume);
        }
        soCpEntity.setSoCpResume(soCpResumes);

        if(servCpEntity.getServCpPerformance()!=null) {
            SoCpPerformance soCpPerformance = new SoCpPerformance();
            BeanCopierMapper.copyProperties(servCpEntity.getServCpPerformance(), soCpPerformance);
            soCpEntity.setSoCpPerformance(soCpPerformance);
        }
        model.addAttribute("servCpEntity", servCpEntity);
        model.addAttribute("soCpEntity",soCpEntity);
        if(Constants.GLOBAL_SO_TYPE_EXTEND.equals(soType)) {
            return "modules/cp/cpSoExtendForm";

        }else{
            return "modules/cp/cpServInfo";

        }

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
    @RequestMapping(value = {"findCpServAttachmentList"})
    public String findCpServAttachmentList(Integer servid, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<ServAttachment> servAttachments =personnelService.findCpServAttachmentList(servid);
        if(!servAttachments.isEmpty()){
            for(ServAttachment servAttachment : servAttachments) {
                servAttachment.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+servAttachment.getId());
                servAttachment.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/" + servAttachment.getId());
            }
            model.addAttribute("files",servAttachments);
        }
        return "modules/cp/cpServUploadPage";
    }


    /**
     * 三类人员证书分配页加载
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    // @RequiresPermissions("cp:personnel:view")
    @RequestMapping(value = {"findCpAssCertByCompanyId"})
    public String findCpAssCertByCompanyId(Integer companyId,HttpServletRequest request, HttpServletResponse response, Model model) {
        if("".equals(companyId) || companyId==null){
            companyId=UserUtils.getUser().getUserCompany().getCompanyId();
        }
        Page <ServCpEntity> page = certService.findCPAssCertByCompanyId(new Page<ServCpEntity>(request, response) ,companyId);
        model.addAttribute("page", page);
        return "modules/cp/cpCompAssCertPage";
    }

    /**
     * 三类人员证书管理加载
     * param index
     * aram request
     *param response
     *param model
     *return
     */
    // @RequiresPermissions("cp:personnel:view")
    @RequestMapping(value = {"findCpManCertByCompanyId"})
    public String findCpManCertByCompanyId(Integer companyId,HttpServletRequest request, HttpServletResponse response, Model model) {
        if("".equals(companyId) || companyId==null){
            companyId=UserUtils.getUser().getUserCompany().getCompanyId();
        }
        Page <ServCpEntity> page= certService.findCPManCertByCompanyId(new Page<ServCpEntity>(request, response) ,companyId);
        model.addAttribute("page", page);
        return "modules/cp/cpCompManCertPage";
    }


    @RequestMapping(value = "geneCert")
    public String geneCert(String soid,String personType, RedirectAttributes redirectAttributes){
        certService.geneCert(soid,personType);
        addMessage(redirectAttributes, "证书生成成功");
        return "redirect:"+Global.getAdminPath()+"/cp/personnel/findCpAssignCert?repage";
    }

    @RequestMapping(value = "cancelGeneCert")
    public String cancelGeneCert(String soid, RedirectAttributes redirectAttributes){
        certService.cancelGeneCert(soid);
        addMessage(redirectAttributes, "证书生成取消成功");
        return "redirect:"+Global.getAdminPath()+"/cp/personnel/findCpAssignCert?repage";
    }

    @RequestMapping(value = "publishCert")
    public String publishCert(String soid, RedirectAttributes redirectAttributes){
        certService.publishCert(soid);
        addMessage(redirectAttributes, "证书发布成功");
        return "redirect:"+Global.getAdminPath()+"/cp/personnel/findCpAssignCert?repage";
    }

    @RequestMapping(value = "cancelCert")
    public String cancelCert(String soid, RedirectAttributes redirectAttributes){
        certService.cancelCert(soid);
        addMessage(redirectAttributes, "证书作废成功");
        return "redirect:"+Global.getAdminPath()+"/cp/personnel/findCpAssignCert?repage";
    }

    @RequestMapping(value = "batchGene")
    public String batchGene(String[] seqs, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        for(String soid:seqs){
            String personType = soCpBaseMapper.findSoCpBaseBySoid(soid).getPersonType();
            certService.geneCert(soid, personType);
        }
        addMessage(redirectAttributes,"证书批量生成成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/personnel/findCpAssignCert?repage";
    }

    @RequestMapping(value = "batchCancelGene")
    public String batchCancelGene(String[] seqs, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        for(String soid:seqs){
            certService.cancelGeneCert(soid);
        }
        addMessage(redirectAttributes,"证书批量生成取消成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/personnel/findCpAssignCert?repage";
    }

    @RequestMapping(value = "batchPublish")
    public String batchPublish(String[] seqs, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        for(String soid:seqs){
            certService.publishCert(soid);
        }
        addMessage(redirectAttributes,"证书批量发布成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/personnel/findCpAssignCert?repage";
    }

    @RequestMapping(value = "batchCancel")
    public String batchCancel(String[] seqs, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        for(String soid:seqs){
            certService.cancelCert(soid);
        }
        addMessage(redirectAttributes,"证书批量作废成功");
        return "redirect:"+ Global.getAdminPath()+"/cp/personnel/findCpAssignCert?repage";
    }
}
