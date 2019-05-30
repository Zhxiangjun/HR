package com.shiend.apartment.mapper;

import java.util.List;

import com.github.abel533.mapper.Mapper;
import com.shiend.apartment.pojo.Furniture;
import com.shiend.apartment.vo.FurnitureVo;
/**
 * 
 * @Description:房屋配置持久层接口
 * @author ShienD
 * @date 2019年3月11日
 *
 */
public interface FurnitureMapper extends Mapper<Furniture>{

	List<FurnitureVo> selectById(FurnitureVo f);
	
	List<FurnitureVo> selectPubById(FurnitureVo f);
}
