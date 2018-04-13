/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/zhongxin/cims">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.zhongxin.cims.modules.sys.web;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.common.collect.Lists;
import com.zhongxin.cims.common.config.PropertiesUtil;
import com.zhongxin.cims.common.utils.SpringContextHolder;
import com.zhongxin.cims.modules.ac.service.PlanService;
import com.zhongxin.cims.modules.comp.service.CompanyService;
import com.zhongxin.cims.modules.sys.entity.Office;
import com.zhongxin.cims.modules.sys.entity.Role;
import com.zhongxin.cims.modules.sys.service.OfficeService;
import com.zhongxin.cims.modules.sys.service.SystemService;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.TagUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.google.common.collect.Maps;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.utils.CacheUtils;
import com.zhongxin.cims.common.utils.CookieUtils;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 登录Controller
 * @author ThinkGem
 * @version 2013-5-31
 */
@Controller
public class LoginController extends BaseController{

    @Autowired
    private SystemService systemService;

    @Autowired
    private OfficeService officeService;

    @Autowired
    private PlanService planService;

    @ModelAttribute
    public User get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return systemService.getUser(id);
        }else{
            return new User();
        }
    }
	/**
	 * 管理登录
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		// 如果已经登录，则跳转到管理首页
		if(user.getId() != null){
			return "redirect:"+Global.getAdminPath();
		}
		return "modules/sys/sysLogin";
	}

	/**
	 * 登录失败，真正登录的POST请求由Filter完成
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.POST)
	public String login(@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String username, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		// 如果已经登录，则跳转到管理首页
		if(user.getId() != null){
			return "redirect:"+Global.getAdminPath();
		}
        //model.addAttribute("isValidateLockLogin",isValidateLocakLogin());
		model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
		model.addAttribute("isValidateCodeLogin", isValidateCodeLogin(username, true, false));
		return "modules/sys/sysLogin";
	}

	/**
	 * 登录成功，进入管理首页
	 */
	@RequiresUser
	@RequestMapping(value = "${adminPath}")
	public String index(HttpServletRequest request, HttpServletResponse response) {
		User user = UserUtils.getUser();
		// 未登录，则跳转到登录页
		if(user.getId() == null){
			return "redirect:"+Global.getAdminPath()+"/login";
		}
        if(isValidateLocakLogin()){
            Subject subject = SecurityUtils.getSubject();
            subject.logout();
           // return "redirect:"+Global.getAdminPath()+"/login";
            String color1 = "blue";
            String color2 = "blue";
            String color3 = "blue";
            String color4 = "blue";
            int count1 = planService.findLockCount("10.15.16.155");
            int count2 = planService.findLockCount("10.15.16.159");
            int count3 = planService.findLockCount("10.15.16.163");
            int count4 = planService.findLockCount("10.15.16.167");
            if(count1>350){
                color1 = "red";
            }else if(count1>250){
                color1 ="yellow";
            }
            if(count2>350){
                color2 = "red";
            }else if(count2>250){
                color2 ="yellow";
            }
            if(count3>350){
                color3 = "red";
            }else if(count3>250){
                color3 ="yellow";
            }
            if(count4>350){
                color4 = "red";
            }else if(count4>250){
                color4 ="yellow";
            }
            request.setAttribute("color1",color1);
            request.setAttribute("color2",color2);
            request.setAttribute("color3",color3);
            request.setAttribute("color4",color4);
            request.setAttribute("isValidateLockLogin","本服务器同时在线学习人数已经超出规定人数，不允许登陆，请更换其他服务器学习。");
            return "modules/sys/sysLogin2";
        }
		// 登录成功后，验证码计算器清零
		isValidateCodeLogin(user.getLoginName(), false, true);
		// 登录成功后，获取上次登录的当前站点ID
		UserUtils.putCache("siteId", CookieUtils.getCookie(request, "siteId"));
		return "modules/sys/sysIndex";
	}
	
	/**
	 * 获取主题方案
	 */
	@RequestMapping(value = "/theme/{theme}")
	public String getThemeInCookie(@PathVariable String theme, HttpServletRequest request, HttpServletResponse response){
		if (StringUtils.isNotBlank(theme)){
			CookieUtils.setCookie(response, "theme", theme);
		}else{
			theme = CookieUtils.getCookie(request, "theme");
		}
		return "redirect:"+request.getParameter("url");
	}
	
	/**
	 * 是否是验证码登录
	 * @param useruame 用户名
	 * @param isFail 计数加1
	 * @param clean 计数清零
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean){
		Map<String, Integer> loginFailMap = (Map<String, Integer>)CacheUtils.get("loginFailMap");
		if (loginFailMap==null){
			loginFailMap = Maps.newHashMap();
			CacheUtils.put("loginFailMap", loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(useruame);
		if (loginFailNum==null){
			loginFailNum = 0;
		}
		if (isFail){
			loginFailNum++;
			loginFailMap.put(useruame, loginFailNum);
		}
		if (clean){
			loginFailMap.remove(useruame);
		}
		return loginFailNum >= 3;
	}
	

	@RequestMapping("${adminPath}/download")
	public String download(@RequestParam String filePath,HttpServletResponse response) {
		File file = new File(filePath);
		InputStream inputStream;
		try {
			inputStream = new FileInputStream(filePath);
			response.reset();
			response.setContentType("application/octet-stream;charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");
			OutputStream outputStream = new BufferedOutputStream(
					response.getOutputStream());
			byte data[] = new byte[1024];
			while (inputStream.read(data, 0, 1024) >= 0) {
				outputStream.write(data);
			}
			outputStream.flush();
			outputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

    /**
     * 注册页面
     */
    @RequestMapping(value = "${adminPath}/signup", method = RequestMethod.GET)
    public String signup(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/sys/signUpForm";
    }

    /**
     * 注册提交
     */
    @RequestMapping(value = "${adminPath}/signup/save", method = RequestMethod.POST)
    public String save(User user,String newPassword,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        // 如果新密码为空，则不更换密码
        if (StringUtils.isNotBlank(newPassword)) {
            user.setPassword(SystemService.entryptPassword(newPassword));
        }
        Office office = officeService.get("1");
        user.setCompany(office);
        user.setOffice(office);
        List<Role> roleList = Lists.newArrayList();
        Role role = systemService.getRole("6"); // 普通用户角色
        roleList.add(role);
        user.setRoleList(roleList);
        // 保存用户信息
        systemService.saveUser(user);
        // 清除当前用户缓存
        if (user.getLoginName().equals(UserUtils.getUser().getLoginName())){
            UserUtils.getCacheMap().clear();
        }
        addMessage(redirectAttributes, "用户'" + user.getLoginName() + "'注册成功! 请登录！");
        return "redirect:"+Global.getAdminPath()+"/login";
    }

    /**
     * 注册提交
     */
    @RequestMapping(value = "${adminPath}/signup/saveCompany", method = RequestMethod.POST)
    public String saveCompany(User user,String newPassword,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        // 如果新密码为空，则不更换密码
        if (StringUtils.isNotBlank(newPassword)) {
            user.setPassword(SystemService.entryptPassword(newPassword));
        }
        Office office = officeService.get("1");
        user.setCompany(office);
        user.setOffice(office);
        List<Role> roleList = Lists.newArrayList();
        Role role = systemService.getRole("412eefc4b6e74ab3897ed68b0f0c3d63"); // 企业用户角色
        roleList.add(role);
        user.setRoleList(roleList);

        user.setLocalId(user.getUserCompany().getLocalId());
        user.setName(user.getUserCompany().getCompanyName());
        user.getUserCompany().setCompanyId(SeqUtils.getNextValue("COMPANY_SEQ"));
        user.getUserCompany().setProvinceId("nm");

        // 保存用户信息
        systemService.saveCompanyUser(user);

        // 清除当前用户缓存
        if (user.getLoginName().equals(UserUtils.getUser().getLoginName())){
            UserUtils.getCacheMap().clear();
        }
        addMessage(redirectAttributes, "用户'" + user.getLoginName() + "'注册成功! 请登录！");
        return "redirect:"+Global.getAdminPath()+"/login";
    }

    @ResponseBody
    @RequestMapping(value = "${adminPath}/signup/checkLoginName")
    public String checkLoginName(String oldLoginName, String loginName) {
        if (loginName !=null && loginName.equals(oldLoginName)) {
            return "true";
        } else if (loginName !=null && systemService.getUserByLoginName(loginName) == null) {
            return "true";
        }
        return "false";
    }

	@RequestMapping("${adminPath}/softkey/driver")
	public String downloadDriver(HttpServletRequest request,HttpServletResponse response) {

		String filePath = SpringContextHolder.getRootRealPath() + "/driver/SetUp.exe";
		File file = new File(filePath);

		InputStream inputStream;
		try {
			inputStream = new FileInputStream(filePath);
			response.reset();
			response.setContentType("application/octet-stream;charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");
			OutputStream outputStream = new BufferedOutputStream(
					response.getOutputStream());
			byte data[] = new byte[1024];
			while (inputStream.read(data, 0, 1024) >= 0) {
				outputStream.write(data);
			}
			outputStream.flush();
			outputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 设置密码
	 */
	@RequestMapping(value = "${adminPath}/softkey/setting", method = RequestMethod.GET)
	public String setting(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/sys/initSoftkey";
	}

    private boolean isValidateLocakLogin(){
        String remoteServerIp = "";
        String notify_url = PropertiesUtil.readData(Global.getUrlAliconfig(), "notify_url") ;
        if(notify_url !=null && !"".equals(notify_url)){
            if("http://www.nmcia.org:8001/nmjzs/return_url.jsp".equals(notify_url)){
                remoteServerIp = "10.15.16.155";
            }else if("http://www.nmcia.org:8002/nmjzs/return_url.jsp".equals(notify_url)){
                remoteServerIp = "10.15.16.159";
            }else if("http://www.nmcia.org:8003/nmjzs/return_url.jsp".equals(notify_url)){
                remoteServerIp = "10.15.16.163";
            }else if("http://www.nmcia.org:8004/nmjzs/return_url.jsp".equals(notify_url)){
                remoteServerIp = "10.15.16.167";
            }
        }
        if(remoteServerIp!=null && !"".equals(remoteServerIp)){
            int count = planService.findLockCount(remoteServerIp);
           String tagInfo = TagUtils.getTagInfo("LOCAL_COUNT");
            if(tagInfo==null || "".equals(tagInfo)){
                return false;
            }
            if( count >Integer.valueOf(tagInfo).intValue()){
                return true;
            }
        }
        return false;
    }
}
