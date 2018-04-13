/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.ac.web;

import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.service.AssociateConstructorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 二级建造师Controller
 * @author liuqy
 * @version 2014-06-12
 */
@Controller
@RequestMapping(value = "${adminPath}/ac/associateConstructor")
public class AssociateConstructorController extends BaseController {

	@Autowired
	private AssociateConstructorService associateConstructorService;




}
