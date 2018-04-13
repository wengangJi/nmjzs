package com.zhongxin.cims.modules.common.web;

import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.CacheUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.entity.AssociateConstructor;
import com.zhongxin.cims.modules.ac.service.AssociateConstructorService;
import com.zhongxin.cims.modules.common.entity.ServPub;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoCache;
import com.zhongxin.cims.modules.common.service.CertService;
import com.zhongxin.cims.modules.common.service.ServService;
import com.zhongxin.cims.modules.comp.entity.Company;
import com.zhongxin.cims.modules.cp.entity.*;
import com.zhongxin.cims.modules.cp.service.PersonnelService;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.service.SysService;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 三类人员Controller
 * @author liuqy
 * @version 2014-06-10
 */

@Controller
@RequestMapping(value = "${adminPath}/serv/pub")
public class ServPubController extends BaseController {
    public  static String  lockCp="lockedCp";
    public  static String  GLOBAL_APP_ID_CP ="CP";
    public  static String  GLOBAL_SO_TYPE_CP ="01";

    @Autowired
    private ServService servService;
    @Autowired
	private PersonnelService personnelService;
    @Autowired
    private SysService sysService;

    @Autowired
    private AssociateConstructorService associateConstructorService;

    private  String getCacheName(String userId,String appId,String soType){
         return userId+"-"+appId+"-"+soType;
    };


	//@RequiresPermissions("serv:pub:view")
    @ResponseBody
	@RequestMapping(value = {"findPersonListById", ""})
    public String list(String name, HttpServletRequest request, HttpServletResponse response, Model model) {

            List<Personnel> personList =personnelService.findListByIdNo(name);
            List<AssociateConstructor> acList =  associateConstructorService.findListByIdNo(name);


            List<ServPub> list = servService.findPersonListById(name);
            return JsonMapper.nonDefaultMapper().toJson(list);
    }
}
