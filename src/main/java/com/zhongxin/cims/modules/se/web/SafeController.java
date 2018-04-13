/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.se.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import com.zhongxin.cims.modules.se.entity.Safe;
import com.zhongxin.cims.modules.se.service.SafeEngineeringService;

/**
 * 安全许可Controller
 * @author liuqy
 * @version 2014-06-06
 */
@Controller
@RequestMapping(value = "${adminPath}/se/safe")
public class SafeController extends BaseController {

	@Autowired
	private SafeEngineeringService safeEngineeringService;
	
	@ModelAttribute
	public Safe get(@RequestParam(required=false) String id) {
		if (id != null){
			return safeEngineeringService.get(id);
		}else{
			return new Safe();
		}
	}
	
	//@RequiresPermissions("se:safe:view")
	@RequestMapping(value = {"list", ""})
	public String list(Safe safe, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			safe.setCreateBy(user);
		}
        Page<Safe> page = safeEngineeringService.find(new Page<Safe>(request, response), safe);
        model.addAttribute("page", page);
		return "modules/se/safeList";
	}

	//@RequiresPermissions("se:safe:view")
	@RequestMapping(value = "form")
	public String form(Safe safe, Model model) {
		model.addAttribute("safe", safe);
		return "modules/se/safeForm";
	}

	//@RequiresPermissions("se:safe:edit")
	@RequestMapping(value = "save")
	public String save(Safe safe, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, safe)){
			return form(safe, model);
		}
		safeEngineeringService.save(safe);
		addMessage(redirectAttributes, "保存安全许可'" + safe.getName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/se/safe/?repage";
	}
	
	//@RequiresPermissions("se:safe:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		safeEngineeringService.delete(id);
		addMessage(redirectAttributes, "删除安全许可成功");
		return "redirect:"+Global.getAdminPath()+"/se/safe/?repage";
	}

}
