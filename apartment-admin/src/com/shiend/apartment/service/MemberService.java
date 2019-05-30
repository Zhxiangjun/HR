package com.shiend.apartment.service;

import java.util.List;
import java.util.Map;


import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.vo.TmpVo;
/**
 * 
 * @Description:用户业务层接口
 * @author ShienD
 * @date 2018年11月22日
 *
 */
public interface MemberService {
	/**
	 * 模糊条件查询所有用户
	 */
	Map<String, Object> selectMemberList(Member m, int pageNum, int pageSize);
	/**
	 * 新增 用户
	 */
	int save(Member member) throws RuntimeException;
	/**
	 * 修改 用户
	 */
	int update(Member member) throws RuntimeException;
	/**
	 * id信息
	 */
	Member info(int id) throws RuntimeException;
	/**
	 * 用户批量删除
	 */
	int del(Integer[] ids) throws RuntimeException;
	/**
	 * 会员注册量echarts图表
	 */
	List<TmpVo> memberEchart(String xString);
	

}
