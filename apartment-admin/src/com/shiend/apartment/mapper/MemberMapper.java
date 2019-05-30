package com.shiend.apartment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.abel533.mapper.Mapper;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.vo.TmpVo;

/**
 * 
 * @Description:用户持久层接口
 * @author ShienD
 * @date 2018年11月22日
 *
 */
public interface MemberMapper extends Mapper<Member>{
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	int del(Integer[] ids);
	/**
	 * 会员注册量统计
	 */
	List<TmpVo> memberEchart(@Param("xString")String xString);
	
	

}
