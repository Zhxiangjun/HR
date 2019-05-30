package com.shiend.apartment.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shiend.apartment.pojo.Furniture;
import com.shiend.apartment.service.FurnitureService;
import com.shiend.apartment.util.R;
import com.shiend.apartment.vo.FurnitureVo;

/**
 * 
 * @Description:房屋配置控制层
 * @author ShienD
 * @date 2019年2月22日
 *
 */
@Controller
@RequestMapping("/furniture")
public class FurnitureController {
	@Autowired
	private FurnitureService furnitureService;
	
	
	/**
	 * 通过房间id和公寓id查询房间配置信息,-->query
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R furnitureList(@RequestParam Map<String, Object > praMap) {
		//查询的属性
		Integer roomId = praMap.get("roomId")==null||"".equals(praMap.get("roomId"))?null:Integer.valueOf(praMap.get("roomId").toString());
		Integer apartmentId = praMap.get("apartmentId")==null||"".equals(praMap.get("apartmentId"))?null:Integer.valueOf(praMap.get("apartmentId").toString());
		FurnitureVo f = new FurnitureVo();
		f.setRoomId(roomId);
		f.setApartmentId(apartmentId);
		Map<String, Object> map = furnitureService.selectFurnitureList(f);
		//把map封装到R类(简单封装，为了方便异步框架处理异常)
		if(((List)map.get("rows")).isEmpty()){
			return R.error(-1,"没有数据");
		}
		return R.ok().put("page", map);  //-->R
	}

	
	/**
	 * 选择id
	 */
	@RequestMapping(value="info/{id}") 
	@ResponseBody
	public R info(@PathVariable String id) {
		if(!"undefined".equals(id)){
			Furniture fur = furnitureService.info(Integer.valueOf(id));
			return R.ok().put("info", fur);//{code":0,info:{"":""}}
		}else{
			return R.error();
		}
	}
	
	
	
	
}
