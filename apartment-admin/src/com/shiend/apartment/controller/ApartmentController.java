package com.shiend.apartment.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Room;
import com.shiend.apartment.service.ApartmentService;
import com.shiend.apartment.service.RoomService;
import com.shiend.apartment.util.R;
import com.shiend.apartment.vo.ApartmentVo;
import com.shiend.apartment.vo.RoomVo;

/**
 * 
 * @Description:房源控制层
 * @author ShienD
 * @date 2018年11月29日
 *
 */
@Controller
@RequestMapping("/apartment")
public class ApartmentController {
	@Autowired
	private ApartmentService apartmentService ;
	@Autowired
	private RoomService roomService;
	/**
	 * 条件查询公寓列表,-->query-apartmnetList
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R apartmentList(@RequestParam Map<String, Object > praMap) {
		int pageNum = Integer.valueOf(praMap.get("pageNum").toString()) ;
		int pageSize = Integer.valueOf(praMap.get("pageSize").toString()) ;
		//查询条件
		Integer apartmentId = praMap.get("apartmentId")==null||"".equals(praMap.get("apartmentId"))?null:Integer.valueOf(praMap.get("apartmentId").toString());
		String city = praMap.get("city")==null?null:praMap.get("city").toString();
		String location =  praMap.get("location")==null?null:praMap.get("location").toString();
		Integer rentType = praMap.get("rentType")==null||"".equals(praMap.get("rentType"))?null:Integer.valueOf(praMap.get("rentType").toString());
		String realname = praMap.get("realname")==null?null:praMap.get("realname").toString();
		
		ApartmentVo apartmentVo = new ApartmentVo();
		apartmentVo.setApartmentId(apartmentId);
		apartmentVo.setCity(city);
		apartmentVo.setLocation(location);
		apartmentVo.setRentType(rentType);
		apartmentVo.setRealname(realname);
		Map<String, Object> map = apartmentService.selectApartmentList(apartmentVo, pageNum, pageSize);
		if(((List)map.get("rows")).isEmpty()){
			return R.error(-1,"没有数据");
		}
		return R.ok().put("page", map);  //-->R
	}
	
	
	/**
	 * 通过id查询单表apartment
	 */
	@RequestMapping(value="info/{id}") 
	@ResponseBody
	public R info(@PathVariable String id) {
		if(!"undefined".equals(id)){
			Apartment apartment = apartmentService.info(Integer.valueOf(id));
			return R.ok().put("info", apartment);//{code":0,info:{"":""}}
		}else{
			return R.error();
		}
	}
	/**
	 * detailInfo第一步 通过id查询详情  
	 */
	@RequestMapping(value="detailInfo/{id}")
	@ResponseBody
	public R detailInfo(@PathVariable String id) {
		if(!"undefined".equals(id)){
			ApartmentVo apartmentVo = apartmentService.detailInfo(Integer.valueOf(id));
			return R.ok().put("info", apartmentVo);//{code":0,info:{"":""}}
		}else{
			return R.error();
		}
	}
	
	/**
	 *  第二步 grid请求  通过id查询 房间信息，只需要调用方法即可
	 */
	@RequestMapping(value="/detailInfoGrid",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R rooms(@RequestParam Map<String, Object > praMap) {
		Integer apartmentId = praMap.get("apartmentId")==null||"".equals(praMap.get("apartmentId"))?null:Integer.valueOf(praMap.get("apartmentId").toString());
		if(apartmentId == null){
			return null;
		}else{
			RoomVo roomVo = new RoomVo();
			roomVo.setApartmentId(apartmentId);
			int oparams = 1;
			Map<String, Object> map = roomService.selectRoomList(roomVo, 0, 0, oparams);
			//把map封装到R类(简单封装，为了方便异步框架处理异常)
			if(((List)map.get("rows")).isEmpty()){
				return R.error(-1,"没有数据");
			}
			return R.ok().put("page", map);  //-->R
			
		}
		
	}
	
	/**
	 * 修改公寓信息
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public R update(@RequestBody Map<String, Object> praMap) {
		Integer apartmentId = praMap.get("apartmentId")==null||"".equals(praMap.get("apartmentId"))?null:Integer.valueOf(praMap.get("apartmentId").toString());
		String city = praMap.get("city") == null ? null : praMap.get("city").toString();
		String location = praMap.get("location") == null ? null : praMap.get("location").toString();
		String apartmentType = praMap.get("apartmentType") == null ? null : praMap.get("apartmentType").toString();
		String direction = praMap.get("direction") == null ? null : praMap.get("direction").toString();
		Integer floor = praMap.get("floor")==null||"".equals(praMap.get("floor"))?null:Integer.valueOf(praMap.get("floor").toString());
		Double area = praMap.get("area")==null||"".equals(praMap.get("area"))?null:Double.valueOf(praMap.get("area").toString());
		Apartment apartment = new Apartment();
		apartment.setApartmentId(apartmentId);
		apartment.setCity(city);
		apartment.setLocation(location);
		apartment.setDirection(direction);
		apartment.setApartmentType(apartmentType);
		apartment.setDirection(direction);
		apartment.setFloor(floor);
		apartment.setArea(area);
		try {
			apartmentService.update(apartment);
		} catch (Exception e) {
			return R.error();
		}
		return R.ok(); 
	}
	
}
