package com.shiend.apartment.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shiend.apartment.mapper.OrderMapper;
import com.shiend.apartment.pojo.Order;
import com.shiend.apartment.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{
	@Autowired
	private OrderMapper orderMapper;
	/**
	 * 生成订单
	 */
	@Override
	public int save(Order order) {
		return orderMapper.insertSelective(order);
	}
	
	@Override
	public Order selectById(String idString) {
		return orderMapper.selectByPrimaryKey(idString);
	}
	@Override
	public int successDo(Order order) {
		String idString = order.getOderId();
		Order o = this.selectById(idString);
		if(o != null){
			SimpleDateFormat data = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			o.setPayTime(data.format(new Date()));
			//o.setPayStatus("SUCCESS");
			o.setTradeNo(order.getTradeNo());
			o.setMemberId(99999999);
			orderMapper.updateByPrimaryKey(o);
			return 1;
		}
		return 0;
	}

	@Override
	public Order queryYOrNot(Order order) {
		return orderMapper.selectOne(order);
	}

}
