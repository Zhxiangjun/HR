package com.shiend.apartment.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shiend.apartment.mapper.ApartmentMapper;
import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.service.ApartmentService;
import com.shiend.apartment.vo.ApartmentVo;
/**
 * 
 * @Description:房源管理业务层
 * @author ShienD
 * @date 2018年11月29日
 *
 */
@Service
public class ApartmentServiceImpl implements ApartmentService{
	@Autowired
	private ApartmentMapper apartmentMapper;

	@Override
	public Map<String, Object> selectApartmentList(ApartmentVo apartmentVo, int pageNum, int pageSize) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (pageNum > 0) {
			// 分页
			PageHelper.startPage(pageNum, pageSize);
			List<ApartmentVo> apartmentVos = this.apartmentMapper.selectApartmentList(apartmentVo);
			PageInfo<ApartmentVo> pageInfo = new PageInfo<ApartmentVo>(apartmentVos);
			// 封装返回数据
			map.put("rows", pageInfo.getList());
			map.put("records", pageInfo.getTotal());
			map.put("pages", pageInfo.getPages());
			map.put("page", pageInfo.getPageNum());
		} else {// 不分页
			List<ApartmentVo> apartmentVos = this.apartmentMapper.selectApartmentList(apartmentVo);
			map.put("rows", apartmentVos);
		}
		return map;
	}

	@Override
	public Apartment info(Integer id) {
		return apartmentMapper.selectByPrimaryKey(id);
	}

	@Override
	public ApartmentVo detailInfo(Integer id) {
		
		return apartmentMapper.detailInfo(id);
	}

	@Override
	public int update(Apartment apartment) {
		return apartmentMapper.updateByPrimaryKeySelective(apartment);
	}

	
	
}
