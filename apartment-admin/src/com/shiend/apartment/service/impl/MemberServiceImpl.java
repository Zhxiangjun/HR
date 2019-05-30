package com.shiend.apartment.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shiend.apartment.mapper.MemberMapper;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.service.MemberService;
import com.shiend.apartment.vo.TmpVo;
/**
 * 
 * @Description:用户业务层
 * @author ShienD
 * @date 2018年11月22日
 *
 */
@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper memberMapper;
	
	/**
	 * 模糊查询
	 */
	@Override
	public Map<String, Object> selectMemberList(Member member, int pageNum, int pageSize) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Member> members = null;
		Example example = new Example(Member.class);
		Criteria criteria = example.createCriteria();
		if (member.getMemberAccount() != null && !member.getMemberAccount().equals("")) {
			criteria.andLike("memberAccount", "%" + member.getMemberAccount() + "%");
		}
		if (member.getUsername() != null && !member.getUsername().equals("")) {
			criteria.andLike("username", "%" + member.getUsername() + "%");
		}
		if (member.getMemberSex() != null && !member.getMemberSex().equals("")) {
			criteria.andEqualTo("memberSex", member.getMemberSex());
		}
		if (member.getCardId() != null && !member.getCardId().equals("")) {
			criteria.andLike("cardId", "%" + member.getCardId() + "%");
		}
		if (pageNum > 0) {
			// 分页
			PageHelper.startPage(pageNum, pageSize);
			members = memberMapper.selectByExample(example);
			PageInfo<Member> pageInfo = new PageInfo<Member>(members);
			// 封装返回数据
			map.put("rows", pageInfo.getList());
			map.put("records", pageInfo.getTotal());
			map.put("pages", pageInfo.getPages());
			map.put("page", pageInfo.getPageNum());
		} else {// 不分页
			members = memberMapper.selectByExample(example);
			map.put("rows", members);
		}
		return map;
	}
	/**
	 * 保存
	 */
	@Override
	public int save(Member member) throws RuntimeException {
		return memberMapper.insertSelective(member);
	}
	/**
	 * 修改
	 */
	@Override
	public int update(Member member) throws RuntimeException {
		return memberMapper.updateByPrimaryKeySelective(member);
	}
	/**
	 * id
	 */
	@Override
	public Member info(int id) throws RuntimeException {
		return memberMapper.selectByPrimaryKey(id);
	}
	/**
	 * 删除
	 */
	@Override
	public int del(Integer[] ids) throws RuntimeException {
		return memberMapper.del(ids);
	}
	
	/**
	 * 会员注册量echarts图表
	 */
	@Override
	public List<TmpVo> memberEchart(String xString) {
			return memberMapper.memberEchart(xString);
		
	}
	

}
