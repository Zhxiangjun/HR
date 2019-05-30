package com.shiend.apartment.service;

import java.util.Map;

import com.shiend.apartment.pojo.Furniture;
import com.shiend.apartment.vo.FurnitureVo;

public interface FurnitureService {

	Map<String, Object> selectFurnitureList(FurnitureVo f);

	Furniture info(Integer valueOf);

}
