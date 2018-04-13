/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.comp.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.Serv;
import com.zhongxin.cims.modules.common.service.CertService;
import com.zhongxin.cims.modules.common.service.ServService;
import com.zhongxin.cims.modules.comp.dao.CompanyMapper;
import com.zhongxin.cims.modules.cp.entity.Personnel;
import com.zhongxin.cims.modules.cp.service.PersonnelService;
import com.zhongxin.cims.modules.eq.entity.QualifyCert;
import com.zhongxin.cims.modules.se.entity.SafetyEngineering;
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
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import com.zhongxin.cims.modules.comp.entity.Company;
import com.zhongxin.cims.modules.comp.service.CompanyService;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

/**
 * 企业Controller
 * @author liuqy
 * @version 2014-06-10
 */
@Controller
@RequestMapping(value = "${adminPath}/comp/company")
public class CompanyController extends BaseController {

	@Autowired
	private CompanyService companyService;

    @Autowired
    private PersonnelService personnelService;

    @Autowired
    private ServService servService;

    @Autowired
    private CertService certService;

	@ModelAttribute
	public Company get(@RequestParam(required=false) Integer id) {
		if (id != null){
			return companyService.get(id);
		}else{
			return new Company();
		}
	}
	
	@RequiresPermissions("comp:company:view")
	@RequestMapping(value = {"list"})
	public String list(Company company,String param, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Company> page = new Page<Company>();
        if ("0".equals(company.getCompanyType())){
           company.setCompanyType("");
        }
        if(!"".equals(param)){
            company.setCompanyName(param);
        }
        page = companyService.getList(new Page<Company>(request, response), company);
        model.addAttribute("page", page);
        HashMap params = new HashMap();
        params.put("param",param);
        model.addAttribute("params",params);
        return "modules/comp/companyList";

	}
    @ResponseBody
    @RequestMapping(value = {"findByName"})
    public String findByName(String name, HttpServletRequest request, HttpServletResponse response, Model model) {
        try {
            name= URLDecoder.decode(request.getParameter("name"), "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        List<Company> list = companyService.findByName(name);
        return JsonMapper.nonDefaultMapper().toJson(list);
   }

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"info", ""})
    public String info(String queryType,String param, HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = UserUtils.getUser();
        Company comp = user.getUserCompany();
        if(comp ==null ){
        Company company = new Company();
        if ("1".equals(queryType)) {
            if ("".equals(param)) {
                model.addAttribute("message", "请输入企业名称！");
                return "modules/comp/companyInfo";
            }
            company.setCompanyName(param);
        } else if ("2".equals(queryType)) {
            if ("".equals(param)) {
                model.addAttribute("message", "请输入组织机构等级号！");
                return "modules/comp/companyInfo";
            }
            company.setOrgCode(param);
        }
         comp = companyService.getByNameOrOrgCode(company);
     }

        Page<Personnel> page = new Page<Personnel>();
        if (comp != null && comp.getCompanyId() != null) {
            Personnel personnel = new Personnel();
            personnel.setCompanyId(comp.getCompanyId());
            page = personnelService.find(new Page<Personnel>(request, response), personnel);
        } else {
            comp = new Company();
        }
        comp.setQueryType(queryType);
        model.addAttribute("page", page);
        model.addAttribute("company", comp);
        HashMap params = new HashMap();
        params.put("param",param);
        model.addAttribute("params",params);

        return "modules/comp/companyInfo";
    }

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"listInfo"})
    public String listInfo(String param, HttpServletRequest request, HttpServletResponse response, Model model) {
        Company company = new Company();
        if ("".equals(param)) {
              model.addAttribute("message", "未找到该企业！");
              return "modules/comp/companyList";

        }
        Integer companyId = new Integer(param);
        Company comp = companyService.get(companyId);


        Page<Personnel> page = new Page<Personnel>();
        if (comp != null && comp.getCompanyId() != null) {
            Personnel personnel = new Personnel();
            personnel.setCompanyId(comp.getCompanyId());
            page = personnelService.find(new Page<Personnel>(request, response), personnel);
        } else {
            comp = new Company();
        }
        model.addAttribute("page", page);
        model.addAttribute("company", comp);
        HashMap params = new HashMap();
        params.put("param",param);
        model.addAttribute("params",params);

        return "modules/comp/companyListInfo";
    }

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"cppage"})
    public String cpPage(Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Personnel> page = new Page<Personnel>();
        if (companyId != null && !"".equals(companyId)) {
            Personnel personnel = new Personnel();
            personnel.setCompanyId(companyId);
            page = personnelService.find(new Page<Personnel>(request, response), personnel);
            Company comp = new Company();
            comp.setCompanyId(companyId);
            model.addAttribute("company",comp);
        }
        model.addAttribute("page", page);

        return "modules/comp/cpList";
    }

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"eqpage"})
    public String eqPage(Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<QualifyCert> page = new Page<QualifyCert>();
        if (companyId != null && !"".equals(companyId)) {
            QualifyCert qualifyCert = new QualifyCert();

            Serv serv = new Serv();
            Company company = new Company();
            company.setCompanyId(companyId);
            serv.setCompany(company);
            qualifyCert.setServ(serv);
            page = certService.findeq(new Page<QualifyCert>(request, response), qualifyCert);
            Company comp = new Company();
            comp.setCompanyId(companyId);
            model.addAttribute("company",comp);
        }
        model.addAttribute("page", page);

        return "modules/comp/eqList";
    }

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"acpersonpage"})
    public String acPersonPage(Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<AssociateConstructor> page = new Page<AssociateConstructor>();
        if (companyId != null && !"".equals(companyId)) {
            Serv serv = new Serv();
            Company company = new Company();
            company.setCompanyId(companyId);
            serv.setCompany(company);
            AssociateConstructor associateConstructor = new AssociateConstructor();
            associateConstructor.setServ(serv);
            page = certService.findacPerson(new Page<AssociateConstructor>(request, response), associateConstructor);
            Company comp = new Company();
            comp.setCompanyId(companyId);
            model.addAttribute("company",comp);
        }
        model.addAttribute("page", page);

        return "modules/comp/acPersonList";
    }

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"acmajorpage"})
    public String acMajorPage(Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<AssociateConstructor> page = new Page<AssociateConstructor>();
        if (companyId != null && !"".equals(companyId)) {
            Serv serv = new Serv();
            Company company = new Company();
            company.setCompanyId(companyId);
            serv.setCompany(company);
            AssociateConstructor associateConstructor = new AssociateConstructor();
            associateConstructor.setServ(serv);
            page = certService.findacMajor(new Page<AssociateConstructor>(request, response), associateConstructor);
            Company comp = new Company();
            comp.setCompanyId(companyId);
            model.addAttribute("company",comp);
        }
        model.addAttribute("page", page);

        return "modules/comp/acMajorList";
    }

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = {"sepage"})
    public String sePage(Integer companyId, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<SafetyEngineering> page = new Page<SafetyEngineering>();
        if (companyId != null && !"".equals(companyId)) {
            Serv serv = new Serv();
            Company company = new Company();
            company.setCompanyId(companyId);
            serv.setCompany(company);
            SafetyEngineering safetyEngineering = new SafetyEngineering();
            safetyEngineering.setServ(serv);
            page = certService.findse(new Page<SafetyEngineering>(request, response), safetyEngineering);
            Company comp = new Company();
            comp.setCompanyId(companyId);
            model.addAttribute("company",comp);
        }
        model.addAttribute("page", page);

        return "modules/comp/seList";
    }

	@RequiresPermissions("comp:company:view")
	@RequestMapping(value = "form")
	public String form(Company company, Model model) {
        if(company == null || company.getCompanyId() == null) {
            company = companyService.get(UserUtils.getUser().getUserCompany().getCompanyId());
        }
		model.addAttribute("company", company);
		return "modules/comp/companyForm";
	}

	@RequiresPermissions("comp:company:edit")
	@RequestMapping(value = "save")
	public String save(Company company, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, company)){
			return form(company, model);
		}
		companyService.save(company);
		addMessage(redirectAttributes, "保存企业'" + company.getCompanyName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/comp/company/form?repage";
	}
	
	@RequiresPermissions("comp:company:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		companyService.delete(id);
		addMessage(redirectAttributes, "删除企业成功");
		return "redirect:"+Global.getAdminPath()+"/comp/company/list?repage";
	}

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = "edit")
    public String edit(Company company, Model model) {
        model.addAttribute("company", company);
        return "modules/comp/companyEdit";
    }

    @RequiresPermissions("comp:company:edit")
    @RequestMapping(value = "editSave")
    public String editSave(Company company, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, company)){
            return form(company, model);
        }
        companyService.save(company);
        addMessage(redirectAttributes, "保存企业'" + company.getCompanyName() + "'成功");
        return "redirect:"+Global.getAdminPath()+"/comp/company/list?repage";
    }

    @RequiresPermissions("comp:company:view")
    @RequestMapping(value = "detail")
    public String detail(Company company, Model model) {
        model.addAttribute("company", company);
        return "modules/comp/companyDetail";
    }
}
