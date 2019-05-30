package com.shiend.apartment.controller;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.pojo.Room;
import com.shiend.apartment.service.ApartmentService;
import com.shiend.apartment.service.MemberService;
import com.shiend.apartment.service.RoomService;
import com.shiend.apartment.util.R;
import com.shiend.apartment.vo.RoomVo;
import com.shiend.apartment.vo.TmpVo;

/**
 * 
 * @Description:房间管理控制层
 * @author ShienD
 * @date 2019年3月20日
 *
 */
@Controller
@RequestMapping("/room")
public class RoomController {
	@Autowired
	private RoomService roomService;
	@Autowired
	private ApartmentService apartmentService ;
	@Autowired
	private MemberService memberService ;
	/**
	 * 条件查询房间处理列表,-->query-roomList
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R roomList(@RequestParam Map<String, Object > praMap) {
		int pageNum = Integer.valueOf(praMap.get("pageNum").toString()) ;
		int pageSize = Integer.valueOf(praMap.get("pageSize").toString()) ;
		//查询条件
		Integer roomId = praMap.get("roomId")==null||"".equals(praMap.get("roomId"))?null:Integer.valueOf(praMap.get("roomId").toString());
		Integer apartmentId = praMap.get("apartmentId")==null||"".equals(praMap.get("apartmentId"))?null:Integer.valueOf(praMap.get("apartmentId").toString());
		String city = praMap.get("city")==null?null:praMap.get("city").toString();
		String location =  praMap.get("location")==null?null:praMap.get("location").toString();
		String status = praMap.get("status")==null?null:praMap.get("status").toString();
		String createTime = praMap.get("createTime")==null?null:praMap.get("createTime").toString();
		RoomVo roomVo = new RoomVo();
		roomVo.setApartmentId(apartmentId);
		roomVo.setRoomId(roomId);
		roomVo.setStatus(status);
		roomVo.setCreateTime(createTime);
		roomVo.setCity(city);
		roomVo.setLocation(location);
		int oparams = 1;
		Map<String, Object> map = roomService.selectRoomList(roomVo, pageNum, pageSize, oparams);
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
			Room room = roomService.info(Integer.valueOf(id));
			return R.ok().put("info", room);//{code":0,info:{"":""}}
		}else{
			return R.error();
		}
	}
	/**
	 * 通过审批
	 */
	@RequestMapping(value="pass")
	@ResponseBody
	public R pass(@RequestBody Room room){
		this.roomService.pass(room);
		return R.ok();
	}
	/**
	 * 不通过审批
	 */
	@RequestMapping(value="dispass")
	@ResponseBody
	public R dispass(@RequestBody Room room){
		this.roomService.dispass(room);
		return R.ok();
	}
	/**
	 * 上架房间
	 */
	@RequestMapping(value="uproom")
	@ResponseBody
	public R uproom(@RequestBody Room room){
		this.roomService.uproom(room);
		return R.ok();
	}
	/**
	 * 下架房间
	 */
	@RequestMapping(value="underroom")
	@ResponseBody
	public R underroom(@RequestBody Room room){
		this.roomService.underroom(room);
		return R.ok();
	}
	/**
	 * 查询详细信息
	 * 调用info方法 获取apartmentid，roomid (审核上架直接用rooid调取furniture中信息)
	 * 然后调取apartment中info方法 获取member信息，调取furniture中的info方法获取furniture信息
	 * 再用memberid调用 member中的info方法，可以代替在jsp用ajax嵌套ajax
	 */
	@RequestMapping(value="detailInfo/{id}") 
	@ResponseBody
	public R detailInfo(@PathVariable String id) {
		if(!"undefined".equals(id)){
			Room room = roomService.info(Integer.valueOf(id));
			Apartment a = apartmentService.info(room.getApartmentId());
			int memberId = a.getMemberId();
			Member m = memberService.info(memberId);
			String rjsonstr = JSON.toJSONString(room);
			String ajsonstr = JSON.toJSONString(a);
			String mjsonstr = JSON.toJSONString(m);
			String jsonstr = ajsonstr.substring(0, ajsonstr.length()-1)+","+mjsonstr.substring(1, mjsonstr.length()-1)+","+rjsonstr.substring(1, rjsonstr.length());
			Object obj = JSON.parse(jsonstr);
			return R.ok().put("info", obj);//{code":0,info:{"":""}}
		}else{
			return R.error();
		}
	}
	
	/**
	 * 查询价格
	 */
	@RequestMapping(value="/pricelist",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R priceList(@RequestParam Map<String, Object > praMap) {
		int pageNum = Integer.valueOf(praMap.get("pageNum").toString()) ;
		int pageSize = Integer.valueOf(praMap.get("pageSize").toString()) ;
		//查询条件
		Integer roomId = praMap.get("roomId")==null||"".equals(praMap.get("roomId"))?null:Integer.valueOf(praMap.get("roomId").toString());
		Integer apartmentId = praMap.get("apartmentId")==null||"".equals(praMap.get("apartmentId"))?null:Integer.valueOf(praMap.get("apartmentId").toString());
		String city = praMap.get("city")==null?null:praMap.get("city").toString();
		String location =  praMap.get("location")==null?null:praMap.get("location").toString();
		Integer rentType = praMap.get("rentType")==null||"".equals(praMap.get("rentType"))?null:Integer.valueOf(praMap.get("rentType").toString());
		String status = "1";
		int oparams = 2;
		
		RoomVo roomVo = new RoomVo();
		roomVo.setApartmentId(apartmentId);
		roomVo.setRoomId(roomId);
		roomVo.setStatus(status);
		roomVo.setRentType(rentType);
		roomVo.setCity(city);
		roomVo.setLocation(location);
		Map<String, Object> map = roomService.selectRoomList(roomVo, pageNum, pageSize,oparams);
		//把map封装到R类(简单封装，为了方便异步框架处理异常)
		if(((List)map.get("rows")).isEmpty()){
			return R.error(-1,"没有数据");
		}
		return R.ok().put("page", map);  //-->R
	}
	
	/**
	 * 修改房间信息
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public R update(@RequestBody Map<String, Object> praMap) {
		Integer roomId = praMap.get("roomId")==null||"".equals(praMap.get("roomId"))?null:Integer.valueOf(praMap.get("roomId").toString());
		String roomName = praMap.get("roomName") == null ? null : praMap.get("roomName").toString();
		Double roomArea = praMap.get("roomArea")==null||"".equals(praMap.get("roomArea"))?null:Double.valueOf(praMap.get("roomArea").toString());
		Room room = new Room();
		room.setRoomId(roomId);
		room.setRoomArea(roomArea);
		room.setRoomName(roomName);
		room.setStatus("-1");//修改房间信息后重新审核
		try {
			roomService.update(room);
		} catch (Exception e) {
			return R.error();
		}
		return R.ok(); 
	}
	
	/**
	 * 条件查询房间处理列表,-->query-roomList
	 */
	@RequestMapping(value="/uplist",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R upList(@RequestParam Map<String, Object > praMap) {
		int pageNum = Integer.valueOf(praMap.get("pageNum").toString()) ;
		int pageSize = Integer.valueOf(praMap.get("pageSize").toString()) ;
		//查询条件
		Integer roomId = praMap.get("roomId")==null||"".equals(praMap.get("roomId"))?null:Integer.valueOf(praMap.get("roomId").toString());
		Integer apartmentId = praMap.get("apartmentId")==null||"".equals(praMap.get("apartmentId"))?null:Integer.valueOf(praMap.get("apartmentId").toString());
		
		RoomVo roomVo = new RoomVo();
		roomVo.setApartmentId(apartmentId);
		roomVo.setRoomId(roomId);
		int oparams = 3;
		Map<String, Object> map = roomService.selectRoomList(roomVo, pageNum, pageSize, oparams);
		//把map封装到R类(简单封装，为了方便异步框架处理异常)
		if(((List)map.get("rows")).isEmpty()){
			return R.error(-1,"没有数据");
		}
		return R.ok().put("page", map);  //-->R
	}
	/**
	 * 房间入住量echarts图表
	 */
	@RequestMapping(value="roomEchart",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R roomEchart(){
		List<TmpVo> list =  roomService.roomEchart();
		Map<String, Object> map = new HashMap<String, Object>();
		if(list.size()!=0){
			for (TmpVo tmpVo : list) {
				if("-1".equals(tmpVo.getxString())){
					map.put("ywh", tmpVo.getyInteger());
				}else if("0".equals(tmpVo.getxString())){
					map.put("yxj", tmpVo.getyInteger());
				}else if ("1".equals(tmpVo.getxString())) {
					map.put("ysj", tmpVo.getyInteger());
				}else {
					map.put("yrz", tmpVo.getyInteger());
				}
			}
		}
	    return R.ok().put("info", map);
	}
	
}
