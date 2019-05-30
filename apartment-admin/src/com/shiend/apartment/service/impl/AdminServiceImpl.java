package com.shiend.apartment.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shiend.apartment.mapper.AdminMapper;
import com.shiend.apartment.pojo.Admin;
import com.shiend.apartment.service.AdminService;
/**
 * 
 * @Description:管理员业务层
 * @author ShienD
 * @date 2018年11月16日
 *
 */
@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	private AdminMapper adminMapper;
	/**
	 * 登录(查询信息)
	 */
	@Override
	public Admin selectAdminInfo(Admin admin) throws RuntimeException {
		return adminMapper.selectOne(admin);
	}
	/**
	 *查询管理员列表
	 */
	@Override
	public Map<String, Object> selectAdminList(Admin ad, int pageNum, int pageSize) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Admin> admins = null;
		Example example = new Example(Admin.class);
		if (pageNum > 0) {
			// 分页
			PageHelper.startPage(pageNum, pageSize);
			admins = adminMapper.selectByExample(example);
			PageInfo<Admin> pageInfo = new PageInfo<Admin>(admins);
			// 封装返回数据
			map.put("rows", pageInfo.getList());
			map.put("records", pageInfo.getTotal());
			map.put("pages", pageInfo.getPages());
			map.put("page", pageInfo.getPageNum());
		} else {// 不分页
			admins = adminMapper.selectByExample(example);
			map.put("rows", admins);
		}
		return map;
	}
	
	
}
