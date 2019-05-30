package com.shiend.apartment.pojo;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * @Description:管理员实体类
 * @author ShienD
 * @date 2018年11月16日
 *
 */
@Table(name="admin")
public class Admin {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer adminId;//管理员id
	
	private String adminAccount;//账号
	
	private String adminPassword; //密码
	
	private String adminName;//姓名
	
	private String adminJobId;//工号
	
	private Integer power;//权限
	
	
	public Integer getAdminId() {
		return adminId;
	}

	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	public String getAdminAccount() {
		return adminAccount;
	}

	public void setAdminAccount(String adminAccount) {
		this.adminAccount = adminAccount;
	}

	public String getAdminPassword() {
		return adminPassword;
	}

	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getAdminJobId() {
		return adminJobId;
	}

	public void setAdminJobId(String adminJobId) {
		this.adminJobId = adminJobId;
	}

	public Integer getPower() {
		return power;
	}

	public void setPower(Integer power) {
		this.power = power;
	}

	
	
	
	
}
