/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.se.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.validator.constraints.Length;

import com.zhongxin.cims.common.persistence.DataEntity;
import com.zhongxin.cims.modules.sys.entity.User;

/**
 * 安全许可Entity
 * @author liuqy
 * @version 2014-06-06
 */
@Entity
@Table(name = "se_safe")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Safe extends DataEntity {
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private String name; 	// 名称

	public Safe() {
		super();
	}

	public Safe(String id){
		this();
		this.id = id;
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	//@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_se_safe")
	//@SequenceGenerator(name = "seq_se_safe", sequenceName = "seq_se_safe")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Length(min=1, max=200)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}


