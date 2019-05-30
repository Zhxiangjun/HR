package com.shiend.apartment.vo;

import java.util.List;

import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.pojo.Room;

/**
 * 
 * @Description:公寓-会员-房间 /用于增改查
 * @author ShienD
 * @date 2019年3月28日
 *
 */
public class ApartmentVo extends Apartment{
	
	private String realname;
	
	private Member member;
	
	
	private List<Room> rooms;

	

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public List<Room> getRooms() {
		return rooms;
	}

	public void setRooms(List<Room> rooms) {
		this.rooms = rooms;
	}
	
	
	
}
