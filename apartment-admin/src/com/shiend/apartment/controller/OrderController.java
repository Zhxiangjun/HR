package com.shiend.apartment.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shiend.apartment.pojo.Intake;
import com.shiend.apartment.pojo.Order;
import com.shiend.apartment.pojo.Room;
import com.shiend.apartment.service.IntakeService;
import com.shiend.apartment.service.OrderService;
import com.shiend.apartment.service.RoomService;
import com.shiend.apartment.util.R;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private IntakeService intakeService;
	@Autowired
	private RoomService roomService;
	/**
	 * 付款 -->生成訂單
	 */
	@RequestMapping(value = "/savaorder", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public R savaOrder(@RequestBody Map<String, Object> praMap) {
		String out_trade_no = praMap.get("WIDout_trade_no") == null ? null : praMap.get("WIDout_trade_no").toString();
		String subject = praMap.get("WIDsubject") == null ? null : praMap.get("WIDsubject").toString();
		Double total_amount = praMap.get("WIDtotal_amount") == null ? null :Double.valueOf(praMap.get("WIDtotal_amount").toString()) ;
		Integer roomId = praMap.get("roomId")==null||"".equals(praMap.get("roomId"))?null:Integer.valueOf(praMap.get("roomId").toString());
		Integer intakeId = praMap.get("intakeId")==null||"".equals(praMap.get("intakeId"))?null:Integer.valueOf(praMap.get("intakeId").toString());
		
		Order order = new Order();
		order.setIntakeId(intakeId);
		order.setRoomId(roomId);
		Order ordercheck = orderService.queryYOrNot(order);//检验订单是否存在*************************
		if((ordercheck == null)||("".equals(ordercheck))){
			order.setOderId(out_trade_no);
			order.setOderName(subject);
			order.setPayMoney(total_amount);
			order.setPayWay(1);
			order.setPayStatus("WAIT_BUYER_PAY");
			SimpleDateFormat data = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			order.setOderTime(data.format(new Date()));
			orderService.save(order);
			order.setOderId(out_trade_no);
		}else{
			order.setOderId(ordercheck.getOderId());
			order.setOderName(ordercheck.getOderName());
			order.setPayMoney(ordercheck.getPayMoney());
			order.setPayStatus(ordercheck.getPayStatus());
		}
		return R.ok().put("info", order); 
		
	}
	/**
	 * 返回页面
	 */
	@RequestMapping(value = "/fanhui", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public R fanhui(@RequestBody Map<String, Object> praMap) {
		String out_trade_no = praMap.get("orderId") == null ? null : praMap.get("orderId").toString();
		Integer roomId = praMap.get("roomId")==null||"".equals(praMap.get("roomId"))?null:Integer.valueOf(praMap.get("roomId").toString());
		Integer intakeId = praMap.get("intakeId")==null||"".equals(praMap.get("intakeId"))?null:Integer.valueOf(praMap.get("intakeId").toString());
		if(out_trade_no == null){
			return R.error("获取订单号失败！");
		}
		Order order = orderService.selectById(out_trade_no);
		if(!"".equals(order.getTradeNo())&&order.getTradeNo() != null){
			
			Intake intake = new Intake();
			intake.setIntakeId(intakeId);
	        intake.setPayStatus("1");
	       
	        Room room = new Room();
	        room.setRoomId(roomId);
	        room.setUpStatus("9");
	        try {
	        	intakeService.updateInfo(intake);
	        	roomService.update(room);
			} catch (Exception e) {
				return R.error("更新数据失败！请联系管理员");
			}
		}
		return R.ok().put("info", order); 
		
	}

	
	
	
}
