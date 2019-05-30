package com.shiend.apartment.pojo;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * @Description:订单实体类
 * @author ShienD
 * @date 2019年5月23日
 *
 */
@Table(name="oder")
public class Order {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String oderId;
	
	private Integer intakeId;
	
	private String oderName;
	
	private String tradeNo;
	
	private  Integer roomId;
	
	private Double payMoney;
	
	private String payDesc;
	
	private Integer payWay;
	
	private String oderTime;
	
	private String payTime;
	
	private String payStatus;
	
	private Integer memberId;

	

	public Integer getIntakeId() {
		return intakeId;
	}

	public void setIntakeId(Integer intakeId) {
		this.intakeId = intakeId;
	}

	

	public String getOderTime() {
		return oderTime;
	}

	public void setOderTime(String oderTime) {
		this.oderTime = oderTime;
	}

	public String getTradeNo() {
		return tradeNo;
	}

	public void setTradeNo(String tradeNo) {
		this.tradeNo = tradeNo;
	}

	public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}

	public Double getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(Double payMoney) {
		this.payMoney = payMoney;
	}

	public String getPayDesc() {
		return payDesc;
	}

	public void setPayDesc(String payDesc) {
		this.payDesc = payDesc;
	}

	public Integer getPayWay() {
		return payWay;
	}

	public void setPayWay(Integer payWay) {
		this.payWay = payWay;
	}

	

	public String getOderId() {
		return oderId;
	}

	public void setOderId(String oderId) {
		this.oderId = oderId;
	}

	public String getOderName() {
		return oderName;
	}

	public void setOderName(String oderName) {
		this.oderName = oderName;
	}

	
	public String getPayTime() {
		return payTime;
	}

	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	
	
	
}
