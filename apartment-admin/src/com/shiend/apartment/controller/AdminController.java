package com.shiend.apartment.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.shiend.apartment.pojo.Admin;
import com.shiend.apartment.service.AdminService;
import com.shiend.apartment.util.CodeUtils;
import com.shiend.apartment.util.R;

/**
 * 
 * @Description:管理员控制层
 * @author ShienD
 * @date 2018年11月16日
 *
 */
@Controller
@RequestMapping("/adminLogin")
public class AdminController {
	static String code;
	@Autowired
	private AdminService adminService;
	
	/**
	 * 登录
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public String login(String account,String password,String vcode) {
		
		JSONObject json = new JSONObject();
		if (code.equals(vcode)) {
			if (!"".equals(account) && account != null && !"".equals(password) && password != null) {
				Admin admin = new Admin();
				admin.setAdminAccount(account);
				// password = new Sha256Hash(password).toHex();
				admin.setAdminPassword(password);
				admin = adminService.selectAdminInfo(admin);
				if (admin != null) {
					json.put("page", admin);

					json.put("code", 200);
				} else {
					json.put("code", 0);// 账号密码错误
				}
			} else {
				json.put("code", -1);// 未填写账号密码
			}
		}else{
			json.put("code", -2);//验证码不正确
		}
		return json.toString();
		
	}
	/**
	 * 获取验证码
	 */
	@RequestMapping(value="imgCode")
	@ResponseBody
	public void imgCode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("image/jpeg");
		code = CodeUtils.generateVerifyCode(4);
		HttpSession seesion = request.getSession();
		seesion.setAttribute("scode", code);
		CodeUtils.outputImage(100, 40, response.getOutputStream(), code);
	}
	/**
	 * 验证码校验
	 */
	@RequestMapping(value="checkImgCode")
	@ResponseBody
	public String checkImgCode(String vcode){
		JSONObject json = new JSONObject();
		if(code.equals(vcode)){
			json.put("imgcode", 1);
		}else {
			json.put("imgcode", 0);
		}
		return json.toString();
	}
	/**
	 * 查询管理员列表
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R adminList(@RequestParam Map<String, Object > praMap) {
		int pageNum = Integer.valueOf(praMap.get("pageNum").toString()) ;
		int pageSize = Integer.valueOf(praMap.get("pageSize").toString()) ;
		Admin ad = new Admin();
		Map<String, Object> map = adminService.selectAdminList(ad, pageNum, pageSize);
		//把map封装到R类(简单封装，为了方便异步框架处理异常)
		if(((List)map.get("rows")).isEmpty()){
			return R.error(-1,"没有数据");
		}
		return R.ok().put("page", map);  //-->R
	}
}
