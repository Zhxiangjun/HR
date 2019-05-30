package com.shiend.apartment.mapper;

import java.util.List;

import com.github.abel533.mapper.Mapper;
import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.vo.ApartmentVo;
/**
 * 
 * @Description:房源管理持久层接口
 * @author ShienD
 * @date 2018年11月29日
 *
 */
public interface ApartmentMapper extends Mapper<Apartment>{

	public List<ApartmentVo> selectApartmentList(ApartmentVo apartmentVo);

	public ApartmentVo detailInfo(Integer id);
	

}

