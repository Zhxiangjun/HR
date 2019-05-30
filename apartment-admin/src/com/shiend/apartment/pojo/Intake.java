package com.shiend.apartment.pojo;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * @Description:入住表实体类
 * @author ShienD
 * @date 2019年3月20日
 *
 */
@Table(name="intake")
public class Intake {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer intakeId;
	
	private Integer roomId;
	private Integer householderId;//房主id
	private String rentStatus;//租赁状态
	private String rentTime;//办理租赁时间
	private String payStatus;//缴费状态
	private Double money;//缴费金额
	private String intakeTime;//入住开始时间
	private String leaveTime;//入住结束时间
	private String compactId;//合同id
	private Integer rentId;//租客id
	private String nextPayTime;//下次缴费日期
	private String waterNum;//shuibiao
	private String powerNum;//dianbiao
	private String cashMoney;//yajin
	
	
	public String getNextPayTime() {
		return nextPayTime;
	}
	public void setNextPayTime(String nextPayTime) {
		this.nextPayTime = nextPayTime;
	}
	public Integer getIntakeId() {
		return intakeId;
	}
	public void setIntakeId(Integer intakeId) {
		this.intakeId = intakeId;
	}
	public Integer getRoomId() {
		return roomId;
	}
	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}
	public Integer getHouseholderId() {
		return householderId;
	}
	public void setHouseholderId(Integer householderId) {
		this.householderId = householderId;
	}
	public String getRentStatus() {
		return rentStatus;
	}
	public void setRentStatus(String rentStatus) {
		this.rentStatus = rentStatus;
	}
	public String getRentTime() {
		return rentTime;
	}
	public void setRentTime(String rentTime) {
		this.rentTime = rentTime;
	}
	public String getPayStatus() {
		return payStatus;
	}
	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public String getIntakeTime() {
		return intakeTime;
	}
	public void setIntakeTime(String intakeTime) {
		this.intakeTime = intakeTime;
	}
	public String getLeaveTime() {
		return leaveTime;
	}
	public void setLeaveTime(String leaveTime) {
		this.leaveTime = leaveTime;
	}
	public String getCompactId() {
		return compactId;
	}
	public void setCompactId(String compactId) {
		this.compactId = compactId;
	}
	public Integer getRentId() {
		return rentId;
	}
	public void setRentId(Integer rentId) {
		this.rentId = rentId;
	}
	public String getWaterNum() {
		return waterNum;
	}
	public void setWaterNum(String waterNum) {
		this.waterNum = waterNum;
	}
	public String getPowerNum() {
		return powerNum;
	}
	public void setPowerNum(String powerNum) {
		this.powerNum = powerNum;
	}
	public String getCashMoney() {
		return cashMoney;
	}
	public void setCashMoney(String cashMoney) {
		this.cashMoney = cashMoney;
	}
	
	
}
