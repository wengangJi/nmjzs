/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/zhongxin/cims">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.zhongxin.cims.common.config;

import java.util.Map;

import com.zhongxin.cims.common.utils.FileUtils;
import org.springframework.util.Assert;

import com.google.common.collect.Maps;
import com.zhongxin.cims.common.utils.PropertiesLoader;

/**
 * 全局配置类
 * @author ThinkGem
 * @version 2013-03-23
 */
public class Global {
	
	/**
	 * 保存全局属性值
	 */
	private static Map<String, String> map = Maps.newHashMap();
	
	/**
	 * 属性文件加载对象
	 */
	private static PropertiesLoader propertiesLoader = new PropertiesLoader("nmjzs.properties");
	
	/**
	 * 获取配置
	 */
	public static String getConfig(String key) {
		String value = map.get(key);
		if (value == null){
			value = propertiesLoader.getProperty(key);
			map.put(key, value);
		}
		return value;
	}

	/////////////////////////////////////////////////////////
	
	/**
	 * 获取管理端根路径
	 */
	public static String getAdminPath() {
		return getConfig("adminPath");
	}
	
	/**
	 * 获取前端根路径
	 */
	public static String getFrontPath() {
		return getConfig("frontPath");
	}
	
	/**
	 * 获取URL后缀
	 */
	public static String getUrlSuffix() {
		return getConfig("urlSuffix");
	}

    /**
     * 获取URL后缀
     */
    public static String getUrlAliconfig() {
        return getConfig("aliconfig");
    }
	
	/**
	 * 是否是演示模式，演示模式下不能修改用户、角色、密码、菜单、授权
	 */
	public static Boolean isDemoMode() {
		String dm = getConfig("demoMode");
		return "true".equals(dm) || "1".equals(dm);
	}

	/**
	 * 获取CKFinder上传文件的根目录
	 * @return
	 */
	public static String getCkBaseDir() {
		String dir = getConfig("userfiles.basedir");
		Assert.hasText(dir, "配置文件里没有配置userfiles.basedir属性");
		if(!dir.endsWith("/")) {
			dir += "/";
		}
		return dir;
	}

    public static String getTmpDir(){
        String dir = getConfig("userfiles.tmpdir");
		FileUtils.createDirectory(dir);
        Assert.hasText(dir, "配置文件里没有配置userfiles.tmpdir属性");
        if(!dir.endsWith("/")) {
            dir += "/";
        }
        return dir;
    }

    public static String getVideoDir(){
        String dir = getConfig("userfiles.videodir");
		FileUtils.createDirectory(dir);
        Assert.hasText(dir, "配置文件里没有配置userfiles.videodir");
        if(!dir.endsWith("/")) {
            dir += "/";
        }
        return dir;
    }

    public static String getSoImageDir(){
        String dir = getConfig("userfiles.soImage");
        FileUtils.createDirectory(dir);
        Assert.hasText(dir, "配置文件里没有配置userfiles.soImage");
        if(!dir.endsWith("/")) {
            dir += "/";
        }
        return dir;
    }

    public static String getPrintDir(){
        String dir = getConfig("userfiles.print");
        FileUtils.createDirectory(dir);
        Assert.hasText(dir, "配置文件里没有配置userfiles.print");
        if(!dir.endsWith("/")) {
            dir += "/";
        }
        return dir;
    }

    public static String getConfigDir(){
        String dir = getConfig("userfiles.config");
        FileUtils.createDirectory(dir);
        Assert.hasText(dir, "配置文件里没有配置userfiles.config");
        if(!dir.endsWith("/")) {
            dir += "/";
        }
        return dir;
    }


	public static String getHeadPhotoBaseDir(){
		String dir = getConfig("headphoto.basedir");
		FileUtils.createDirectory(dir);
		Assert.hasText(dir, "配置文件里没有配置headphoto.basedir属性");
		if(!dir.endsWith("/")) {
			dir += "/";
		}
		return dir;
	}

	public static String getHeadPhotoTmpDir(){
		String dir = getConfig("headphoto.tmpdir");
		FileUtils.createDirectory(dir);
		Assert.hasText(dir, "配置文件里没有配置headphoto.tmpdir属性");
		if(!dir.endsWith("/")) {
			dir += "/";
		}
		return dir;
	}
}
