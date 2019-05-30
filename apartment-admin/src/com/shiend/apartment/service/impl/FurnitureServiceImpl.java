package com.shiend.apartment.service.impl;

import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.tools.Tool;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shiend.apartment.mapper.FurnitureMapper;
import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Furniture;
import com.shiend.apartment.pojo.Room;
import com.shiend.apartment.service.FurnitureService;
import com.shiend.apartment.util.ToolUtil;
import com.shiend.apartment.vo.FurnitureVo;
/**
 * 
 * @Description:房间配置业务层
 * @author ShienD
 * @date 2019年3月18日
 *
 */
@Service
public class FurnitureServiceImpl implements FurnitureService {
	
	@Autowired
	private FurnitureMapper furnitureMapper;
	
	
	@Override
	public Map<String, Object> selectFurnitureList(FurnitureVo f) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<FurnitureVo> furnitureVos = null;
		List<FurnitureVo> pubfurnitureVos = null;
		furnitureVos = this.furnitureMapper.selectById(f);
		pubfurnitureVos = this.furnitureMapper.selectPubById(f);
		if(ToolUtil.isNotNull(pubfurnitureVos)){
			for(FurnitureVo tmp:pubfurnitureVos){
				tmp.getRooms().get(0).setRoomArea(tmp.getApartments().get(0).getArea());
				tmp.getRooms().get(0).setRoomName("公用设施");
				furnitureVos.add(tmp);
			}
		}
		map.put("rows", furnitureVos);
		return map;
	}


	@Override
	public Furniture info(Integer valueOf) {
		return furnitureMapper.selectByPrimaryKey(valueOf);
	}

}
