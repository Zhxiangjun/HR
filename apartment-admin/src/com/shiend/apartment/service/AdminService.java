package com.shiend.apartment.service;

import java.util.Map;

import com.shiend.apartment.pojo.Admin;
/**
 * 
 * @Description:管理员业务层接口
 * @author ShienD
 * @date 2018年11月16日
 *
 */
public interface AdminService {
	/**
	 * 登录(查询信息)
	 */
	public Admin selectAdminInfo (Admin admin) throws RuntimeException;
	/**
	 *查询管理员列表
	 */
	public Map<String, Object> selectAdminList(Admin ad, int pageNum, int pageSize);
	
}
