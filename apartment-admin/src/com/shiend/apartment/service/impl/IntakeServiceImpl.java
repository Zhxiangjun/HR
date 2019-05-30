package com.shiend.apartment.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shiend.apartment.mapper.IntakeMapper;
import com.shiend.apartment.pojo.Intake;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.service.IntakeService;
import com.shiend.apartment.vo.IntakeVo;

/**
 * 
 * @Description:入住管理业务层
 * @author ShienD
 * @date 2019年3月20日
 *
 */
@Service
public class IntakeServiceImpl implements IntakeService{
	@Autowired
	private IntakeMapper intakeMapper;

	@Override
	public Map<String, Object> selectIntakeInfoList(IntakeVo intakeVo, int pageNum, int pageSize) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (pageNum > 0) {
			// 分页
			PageHelper.startPage(pageNum, pageSize);
			List<IntakeVo> intakeVos = this.intakeMapper.selectIntakeInfoList(intakeVo);
			PageInfo<IntakeVo> pageInfo = new PageInfo<IntakeVo>(intakeVos);
			// 封装返回数据
			map.put("rows", pageInfo.getList());
			map.put("records", pageInfo.getTotal());
			map.put("pages", pageInfo.getPages());
			map.put("page", pageInfo.getPageNum());
		} else {// 不分页
			List<IntakeVo> intakeVos = this.intakeMapper.selectIntakeInfoList(intakeVo);
			map.put("rows", intakeVos);
		}
		return map;
	}

	@Override
	public Map<String, Object> selectIntakePayList(IntakeVo intakeVo, int pageNum, int pageSize) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (pageNum > 0) {
			// 分页
			PageHelper.startPage(pageNum, pageSize);
			List<IntakeVo> intakeVos = this.intakeMapper.selectPayList(intakeVo);
			PageInfo<IntakeVo> pageInfo = new PageInfo<IntakeVo>(intakeVos);
			// 封装返回数据
			map.put("rows", pageInfo.getList());
			map.put("records", pageInfo.getTotal());
			map.put("pages", pageInfo.getPages());
			map.put("page", pageInfo.getPageNum());
		} else {// 不分页
			List<IntakeVo> intakeVos = this.intakeMapper.selectPayList(intakeVo);
			map.put("rows", intakeVos);
		}
		return map;
	}

	@Override
	public Intake info(Integer id) {
		return intakeMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateInfo(Intake intake) {
		return intakeMapper.updateByPrimaryKeySelective(intake);
	}

	//--------------
	/**
	 * 租房缴费量echarts图表
	 */
	@Override
	public List<Integer> YQEchart() {
		return intakeMapper.YQEchart();
	}
	@Override
	public List<Integer> DJFEchart() {
		return intakeMapper.DJFEchart();
	}
	@Override
	public List<Integer> YJFEchart() {
		return intakeMapper.YJFEchart();
	}
	//--------------
	
	
	
}
