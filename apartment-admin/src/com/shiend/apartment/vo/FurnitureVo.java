package com.shiend.apartment.vo;

import java.util.List;

import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Furniture;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.pojo.Room;

public class FurnitureVo extends Furniture{
	private List<Apartment> apartments;
	
	private List<Member> members;
	
	private List<Room> rooms;
	
	public List<Apartment> getApartments() {
		return apartments;
	}

	public void setApartments(List<Apartment> apartments) {
		this.apartments = apartments;
	}

	public List<Member> getMembers() {
		return members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
	}

	public List<Room> getRooms() {
		return rooms;
	}

	public void setRooms(List<Room> rooms) {
		this.rooms = rooms;
	}

	
	
	
}
