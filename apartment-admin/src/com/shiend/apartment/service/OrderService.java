package com.shiend.apartment.service;

import com.shiend.apartment.pojo.Order;

public interface OrderService {
	//生产订单
	int save(Order order);
	//根据订单号查询订单信息
	Order selectById(String idString);
	
	int successDo(Order o);
	//检验订购单是否存在
	Order queryYOrNot(Order order);
	
	

}
