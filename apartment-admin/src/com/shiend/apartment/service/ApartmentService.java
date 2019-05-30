package com.shiend.apartment.service;

import java.util.Map;

import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.vo.ApartmentVo;

/**
 * 
 * @Description:房源业务层接口
 * @author ShienD
 * @date 2018年11月29日
 *
 */
public interface ApartmentService {
	/**
	 * 公寓列表查询
	 */
	public Map<String, Object> selectApartmentList(ApartmentVo apartmentVo, int pageNum, int pageSize);

	public Apartment info(Integer id);

	public ApartmentVo detailInfo(Integer id);

	public int update(Apartment apartment);
	
	
	
}
