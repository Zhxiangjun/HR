package com.shiend.apartment.pojo;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * @Description:公寓实体类
 * @author ShienD
 * @date 2018年11月29日
 *
 */
@Table(name="apartment")
public class Apartment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer apartmentId;//公寓id
	
	private String city;//所在城市
	
	private String location;//详细地址
	
	private String apartmentType;//户型
	
	private Double area;//面积
	
	private Integer floor;//层
	
	private String direction;//朝向
	
	private Integer rentType;//出租类型
	
	private Integer memberId;//房东id（会员id）
	
	private String picture;
	
	
	
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public Integer getApartmentId() {
		return apartmentId;
	}
	public void setApartmentId(Integer apartmentId) {
		this.apartmentId = apartmentId;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getApartmentType() {
		return apartmentType;
	}
	public void setApartmentType(String apartmentType) {
		this.apartmentType = apartmentType;
	}
	public Double getArea() {
		return area;
	}
	public void setArea(Double area) {
		this.area = area;
	}
	public Integer getFloor() {
		return floor;
	}
	public void setFloor(Integer floor) {
		this.floor = floor;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	public Integer getRentType() {
		return rentType;
	}
	public void setRentType(Integer rentType) {
		this.rentType = rentType;
	}
	
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	
	
	
}
