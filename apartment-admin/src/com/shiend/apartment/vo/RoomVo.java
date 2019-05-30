package com.shiend.apartment.vo;

import java.util.List;

import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Room;


/**
 * 
 * @Description:房间-公寓vo类 /查询
 * @author ShienD
 * @date 2019年3月20日
 *
 */
public class RoomVo extends Room{
	private String city;
	private String location;
	private String status;
	private String createTime;
	private Integer rentType;
	private List<Apartment> apartments;

	
	
	

	public Integer getRentType() {
		return rentType;
	}

	public void setRentType(Integer rentType) {
		this.rentType = rentType;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public List<Apartment> getApartments() {
		return apartments;
	}

	public void setApartments(List<Apartment> apartments) {
		this.apartments = apartments;
	}
	
	
}
