package com.shiend.apartment.pojo;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * @Description:房间实体类
 * @author ShienD
 * @date 2019年3月20日
 *
 */
@Table(name="room")
public class Room {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer roomId;
	
	private String roomName;
	
	private Integer apartmentId;
	
	private Double roomArea;//房间面积
	
	private Double monthPrice;//月租
	
	private Double seasonPrice;//季租
	
	private Double halfYearPrice;//半年租
	
	private Double yearPrice;//年租
	
	private String createTime;//申请时间
	
	private String status;//申请状态
	
	private String passTime;//处理时间
	
	private String upStatus;//上架状态
	
	private String upTime;//上架时间
	
	private String underTime;//下架时间
	
	public Integer getRoomId() {
		return roomId;
	}
	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public Integer getApartmentId() {
		return apartmentId;
	}
	public void setApartmentId(Integer apartmentId) {
		this.apartmentId = apartmentId;
	}
	
	
	public Double getMonthPrice() {
		return monthPrice;
	}
	public void setMonthPrice(Double monthPrice) {
		this.monthPrice = monthPrice;
	}
	public Double getSeasonPrice() {
		return seasonPrice;
	}
	public void setSeasonPrice(Double seasonPrice) {
		this.seasonPrice = seasonPrice;
	}
	public Double getHalfYearPrice() {
		return halfYearPrice;
	}
	public void setHalfYearPrice(Double halfYearPrice) {
		this.halfYearPrice = halfYearPrice;
	}
	public Double getYearPrice() {
		return yearPrice;
	}
	public void setYearPrice(Double yearPrice) {
		this.yearPrice = yearPrice;
	}
	
	public Double getRoomArea() {
		return roomArea;
	}
	public void setRoomArea(Double roomArea) {
		this.roomArea = roomArea;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPassTime() {
		return passTime;
	}
	public void setPassTime(String passTime) {
		this.passTime = passTime;
	}
	public String getUpStatus() {
		return upStatus;
	}
	public void setUpStatus(String upStatus) {
		this.upStatus = upStatus;
	}
	public String getUpTime() {
		return upTime;
	}
	public void setUpTime(String upTime) {
		this.upTime = upTime;
	}
	public String getUnderTime() {
		return underTime;
	}
	public void setUnderTime(String underTime) {
		this.underTime = underTime;
	}
	
	
}
