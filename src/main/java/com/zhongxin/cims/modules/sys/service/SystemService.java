/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/zhongxin/cims">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.zhongxin.cims.modules.sys.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.zhongxin.cims.modules.comp.service.CompanyService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.shiro.SecurityUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.security.Digests;
import com.zhongxin.cims.common.service.BaseService;
import com.zhongxin.cims.common.utils.Collections3;
import com.zhongxin.cims.common.utils.Encodes;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.modules.sys.dao.MenuDao;
import com.zhongxin.cims.modules.sys.dao.RoleDao;
import com.zhongxin.cims.modules.sys.dao.UserDao;
import com.zhongxin.cims.modules.sys.entity.Menu;
import com.zhongxin.cims.modules.sys.entity.Role;
import com.zhongxin.cims.modules.sys.entity.User;
import com.zhongxin.cims.modules.sys.security.SystemAuthorizingRealm;
import com.zhongxin.cims.modules.sys.utils.UserUtils;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * @author ThinkGem
 * @version 2013-5-15
 */
@Service
@Transactional(readOnly = true)
public class SystemService extends BaseService  {
	
	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	public static final int SALT_SIZE = 8;
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private SystemAuthorizingRealm systemRealm;
	
	@Autowired
	private IdentityService identityService;

    @Autowired
    private CompanyService companyService;

	//-- User Service --//
	
	public User getUser(String id) {
		return userDao.get(id);
	}
	
	public Page<User> findUser(Page<User> page, User user) {
		DetachedCriteria dc = userDao.createDetachedCriteria();
		User currentUser = UserUtils.getUser();
		dc.createAlias("company", "company");
		if (user.getCompany()!=null && StringUtils.isNotBlank(user.getCompany().getId())){
			dc.add(Restrictions.or(
					Restrictions.eq("company.id", user.getCompany().getId()),
					Restrictions.like("company.parentIds", "%,"+user.getCompany().getId()+",%")
					));
		}
		dc.createAlias("office", "office");
		if (user.getOffice()!=null && StringUtils.isNotBlank(user.getOffice().getId())){
			dc.add(Restrictions.or(
					Restrictions.eq("office.id", user.getOffice().getId()),
					Restrictions.like("office.parentIds", "%,"+user.getOffice().getId()+",%")
					));
		}
		// 如果不是超级管理员，则不显示超级管理员用户
		if (!currentUser.isAdmin()){
			dc.add(Restrictions.ne("id", "1")); 
		}
		dc.add(dataScopeFilter(currentUser, "office", ""));
		//System.out.println(dataScopeFilterString(currentUser, "office", ""));
		if (StringUtils.isNotEmpty(user.getLoginName())){
			dc.add(Restrictions.like("loginName", "%"+user.getLoginName()+"%"));
		}
		if (StringUtils.isNotEmpty(user.getName())){
			dc.add(Restrictions.like("name", "%"+user.getName()+"%"));
		}
		dc.add(Restrictions.eq(User.FIELD_DEL_FLAG, User.DEL_FLAG_NORMAL));
		if (!StringUtils.isNotEmpty(page.getOrderBy())){
			dc.addOrder(Order.asc("company.code")).addOrder(Order.asc("office.code")).addOrder(Order.desc("name"));
		}
		return userDao.find(page, dc);
	}

	//取用户的数据范围
	public String getDataScope(User user){
		return dataScopeFilterString(user, "office", "");
	}
	
	public User getUserByLoginName(String loginName) {
		return userDao.findByLoginName(loginName);
	}

	@Transactional(readOnly = false)
	public void saveUser(User user) {
		userDao.clear();
		userDao.save(user);
		systemRealm.clearAllCachedAuthorizationInfo();
		// 同步到Activiti
		//saveActiviti(user);
	}

	@Transactional(readOnly = false)
	public void deleteUser(String id) {
		userDao.deleteById(id);
		// 同步到Activiti
		deleteActiviti(userDao.get(id));
	}
	
	@Transactional(readOnly = false)
	public void updatePasswordById(String id, String loginName, String newPassword) {
		userDao.updatePasswordById(entryptPassword(newPassword), id);
		systemRealm.clearCachedAuthorizationInfo(loginName);
	}
	
	@Transactional(readOnly = false)
	public void updateUserLoginInfo(String id) {
		userDao.updateLoginInfo(SecurityUtils.getSubject().getSession().getHost(), new Date(), id);
	}
	
	/**
	 * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
	 */
	public static String entryptPassword(String plainPassword) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
		return Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword);
	}
	
	/**
	 * 验证密码
	 * @param plainPassword 明文密码
	 * @param password 密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String password) {
		byte[] salt = Encodes.decodeHex(password.substring(0,16));
		byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
		return password.equals(Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword));
	}
	
	//-- Role Service --//
	
	public Role getRole(String id) {
		return roleDao.get(id);
	}

	public Role findRoleByName(String name) {
		return roleDao.findByName(name);
	}
	
	public List<Role> findAllRole(){
		return UserUtils.getRoleList();
	}
	
	@Transactional(readOnly = false)
	public void saveRole(Role role) {
		roleDao.clear();
		roleDao.save(role);
		systemRealm.clearAllCachedAuthorizationInfo();
		// 同步到Activiti
		//saveActiviti(role);
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
	}

	@Transactional(readOnly = false)
	public void deleteRole(String id) {
		roleDao.deleteById(id);
		systemRealm.clearAllCachedAuthorizationInfo();
		// 同步到Activiti
		deleteActiviti(roleDao.get(id));
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
	}
	
	@Transactional(readOnly = false)
	public Boolean outUserInRole(Role role, String userId) {
		User user = userDao.get(userId);
		List<String> roleIds = user.getRoleIdList();
		List<Role> roles = user.getRoleList();
		// 
		if (roleIds.contains(role.getId())) {
			roles.remove(role);
			saveUser(user);
			return true;
		}
		return false;
	}
	
	@Transactional(readOnly = false)
	public User assignUserToRole(Role role, String userId) {
		User user = userDao.get(userId);
		List<String> roleIds = user.getRoleIdList();
		if (roleIds.contains(role.getId())) {
			return null;
		}
		user.getRoleList().add(role);
		saveUser(user);		
		return user;
	}

	//-- Menu Service --//
	
	public Menu getMenu(String id) {
		return menuDao.get(id);
	}

	public List<Menu> findAllMenu(){
		return UserUtils.getMenuList();
	}

    public List<Menu> findTreeMenu(String parentId){
        List<Menu> topList = menuDao.findByParent(parentId);
        List<Menu> allChildren = new ArrayList<Menu>();
        this.getAllChildren(topList, allChildren);
        return allChildren;
    }

    /**
     * 根据提供的节点集合递归查询集合里每个节点的子节点，最终统一返回所有的子节点
     * topChildren  是当前节点的直接子节点集合
     * resultTrees  是最终返回的所有子节点集合
     */
    public List<Menu> getAllChildren(List<Menu> topChildren,List<Menu> resultTrees){
        for(Menu tree:topChildren){
            resultTrees.add(tree);
            //如果当前节点是叶子节点，跳过不进行递归查询子节点
            if(isLeaf(tree.getId())){
                continue;
            }
            List<Menu> children = findChildrens(tree.getId());
            getAllChildren(children,resultTrees);
        }
        return resultTrees;
    }

    private boolean isLeaf(String id) {
        //return menuDao.findByParent(id).isEmpty();
        return findChildrens(id).isEmpty();
    }

    private List<Menu> findChildrens(String parentId){
        List<Menu> all = UserUtils.getMenuList();
        List<Menu> childrens = new ArrayList<Menu>();
        for (Menu e : all) {
            if(e.getParent() != null && parentId.equals(e.getParent().getId())){
                childrens.add(e);
            }
        }
        return childrens;
    }

    @Transactional(readOnly = false)
	public void saveMenu(Menu menu) {
		menu.setParent(this.getMenu(menu.getParent().getId()));
		String oldParentIds = menu.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
		menu.setParentIds(menu.getParent().getParentIds()+menu.getParent().getId()+",");
		menuDao.clear();
		menuDao.save(menu);
		// 更新子节点 parentIds
		List<Menu> list = menuDao.findByParentIdsLike("%,"+menu.getId()+",%");
		for (Menu e : list){
			e.setParentIds(e.getParentIds().replace(oldParentIds, menu.getParentIds()));
		}
		menuDao.save(list);
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
		saveActiviti(menu);
	}

	@Transactional(readOnly = false)
	public void deleteMenu(String id) {
		menuDao.deleteById(id, "%,"+id+",%");
		systemRealm.clearAllCachedAuthorizationInfo();
		UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
		deleteActiviti(id);
	}

	///////////////// Synchronized to the Activiti //////////////////

	/**
	 * 手工同步所有Activiti数据
	 */
	@Transactional(readOnly = false)
	public void synToActiviti()  {
		menuDao.updateBySql("delete from ACT_ID_MEMBERSHIP",null);
		menuDao.updateBySql("delete from ACT_ID_GROUP", null);
		menuDao.updateBySql("delete from ACT_ID_USER", null);
		
		List<Group> activitiGroupList = identityService.createGroupQuery().list();
		List<org.activiti.engine.identity.User> activitiUserList = identityService.createUserQuery().list();
		if (activitiGroupList.size() == 0 &&activitiUserList.size() == 0){
		 	//同步时候添加所有用户，所有组，以及关联关系，之后增删改用户，增删改角色时不需要判断用户，组是否存在。
		 	List<User> userList = userDao.findAllList();
		 	for(User user:userList){
		 		org.activiti.engine.identity.User activitiUesr = identityService.newUser(ObjectUtils.toString(user.getId()));
		 		identityService.saveUser(activitiUesr);
		 	}
		 	for(Menu menu:menuDao.findAllActivitiList()){
		 		if (StringUtils.isNotEmpty(menu.getActivitiGroupId())){
			 		Group group = identityService.newGroup(menu.getActivitiGroupId());
			 		identityService.saveGroup(group);
		 		}
		 	}
		 	//创建关联关系
		 	for(User user:userList) {
		 		List<Menu> menuList = menuDao.findAllActivitiList(user.getId());
		 		if(!Collections3.isEmpty(menuList)){
		 			for(Menu menu:menuList) {
		 				if (StringUtils.isNotEmpty(menu.getActivitiGroupId())){
		 					identityService.createMembership(ObjectUtils.toString(user.getId()), menu.getActivitiGroupId());
		 				}
		 			}
		 		}
		 	}
		}
	}
	
	private void saveActiviti(Role role) {
		if(role!=null) {
			List<User> userList = roleDao.get(role.getId()).getUserList();
			if(!Collections3.isEmpty(userList)) {
			 	for(User user:userList) {
			 		String userId = ObjectUtils.toString(user.getId());
					org.activiti.engine.identity.User activitiUser = identityService.createUserQuery().userId(userId).singleResult();
					// 是新增用户
					if (activitiUser == null) {
						activitiUser = identityService.newUser(userId);
						identityService.saveUser(activitiUser);
					} 
					// 同步用户角色关联数据
			 		List<Menu> menuList = menuDao.findAllActivitiList(user.getId());
			 		merge(user, menuList);
			 	}
			}
		}
	}
	

	private void deleteActiviti(Role role) {
		if(role!=null) {
			List<User> userList = roleDao.get(role.getId()).getUserList();
			if(!Collections3.isEmpty(userList)) {
			 	for(User user:userList) {
			 		List<Menu> menuList = menuDao.findAllActivitiList(user.getId());
			 		merge(user, menuList);
			 	}
			}
		}
	}

	private void saveActiviti(User user) {
		if(user!=null) {
			String userId = ObjectUtils.toString(user.getId());
			org.activiti.engine.identity.User activitiUser = identityService.createUserQuery().userId(userId).singleResult();
			// 是新增用户
			if (activitiUser == null) {
				activitiUser = identityService.newUser(userId);
				identityService.saveUser(activitiUser);
			} 
			// 同步用户角色关联数据
	 		List<Menu> menuList = menuDao.findAllActivitiList(user.getId());
	 		merge(user, menuList);
		}
	}

	private void deleteActiviti(User user) {
		if(user!=null) {
			String userId = ObjectUtils.toString(user.getId());
			identityService.deleteUser(userId);
		}
	}

	private void saveActiviti(Menu menu) {
		if(menu!=null){
			Group group = identityService.createGroupQuery().groupId(menu.getActivitiGroupId()).singleResult();
			if(group!=null) {
				identityService.deleteGroup(group.getId());
			}
			if(Menu.YES.equals(menu.getIsActiviti()) && StringUtils.isNotBlank(menu.getActivitiGroupId())){
				group = identityService.newGroup(menu.getActivitiGroupId());
				group.setName(menu.getActivitiGroupName());
				identityService.saveGroup(group);
				List<Role> roleList = menuDao.get(menu.getId()).getRoleList();
				if(!Collections3.isEmpty(roleList)) {
					for(Role role:roleList) {
						List<User> userList = role.getUserList();
						if(!Collections3.isEmpty(userList)) {
							for(User user:userList) {
								identityService.createMembership(ObjectUtils.toString(user.getId()), menu.getActivitiGroupId());
							}
						}
					}
				}
			}
		}
	}
	private void deleteActiviti(String id) {
		if(id!=null) {
			Menu menu = menuDao.get(id);
			if(Menu.YES.equals(menu.getIsActiviti()) && StringUtils.isNotBlank(menu.getActivitiGroupId())){
				identityService.deleteGroup(menu.getActivitiGroupId());
			}
			if(menu!=null) {
				List<Menu> menuList = menuDao.findByParentIdsLike("%,"+menu.getId()+",%");
				for(Menu m:menuList) {
					if(Menu.YES.equals(menu.getIsActiviti()) && StringUtils.isNotBlank(m.getActivitiGroupId())){
						identityService.deleteGroup(m.getActivitiGroupId());
					}
				}
			}
		}
	}

	@SuppressWarnings("unchecked")
	private void merge(User user,List<Menu> menuList) {
		String userId = ObjectUtils.toString(user.getId());
		List<Group> activitiGroupList = identityService.createGroupQuery().groupMember(userId).list();
		if(Collections3.isEmpty(menuList)) {
			for(Group group:activitiGroupList) {
				identityService.deleteMembership(userId, group.getId());
			}
		} else {
			Map<String,String> groupMap =Maps.newHashMap();
			for(Menu menu:menuList) {
				groupMap.put(menu.getActivitiGroupId(), menu.getActivitiGroupName());
			}
			Map<String,String> activitiGroupMap = Collections3.extractToMap(activitiGroupList, "id", "name");
			for(String groupId:activitiGroupMap.keySet()) {
				if(StringUtils.isNotBlank(groupId) && !groupMap.containsKey(groupId)) {
					identityService.deleteMembership(userId, groupId);
				}
			}
			for(String groupId:groupMap.keySet()) {
				if(StringUtils.isNotBlank(groupId) && !activitiGroupMap.containsKey(groupId)) {
					identityService.createMembership(userId, groupId);
				}
			}
		}
	}

    @Transactional(readOnly = false)
    public void saveCompanyUser(User user) {
        userDao.clear();
        userDao.save(user);
        systemRealm.clearAllCachedAuthorizationInfo();

        // 保存企业信息
        companyService.save(user.getUserCompany());
    }

    ///////////////// Synchronized to the Activiti end //////////////////

	
}
