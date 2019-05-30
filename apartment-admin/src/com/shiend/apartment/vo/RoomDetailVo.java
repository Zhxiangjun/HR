package com.shiend.apartment.vo;

import java.util.List;

import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Furniture;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.pojo.Room;

/**
 * 
 * @Description:房间详细信息vo类
 * @author ShienD
 * @date 2019年3月20日
 *
 */
public class RoomDetailVo extends Room{
	
	private List<Apartment> apartments;
	
	private List<Furniture> furnitures;
	
	private List<Member> members;

	public List<Apartment> getApartments() {
		return apartments;
	}

	public void setApartments(List<Apartment> apartments) {
		this.apartments = apartments;
	}

	public List<Furniture> getFurnitures() {
		return furnitures;
	}

	public void setFurnitures(List<Furniture> furnitures) {
		this.furnitures = furnitures;
	}

	public List<Member> getMembers() {
		return members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
	}
	
	
}
