package com.shiend.apartment.pojo;

/**
 * 
 * @Description:房屋配置实体类
 * @author ShienD
 * @date 2019年2月21日
 *
 */

import javax.persistence.GeneratedValue; 
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="furniture")
public class Furniture {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer furnitureId;//配置id 主键
	private Integer apartmentId;//房源id
	private Integer roomId;
	private String publicFlag;//公用标志
	private Integer a01;//床
	private Integer a02;//沙发
	private Integer a03;//衣柜
	private Integer a04;//空调
	private Integer a05;//冰箱
	private Integer a06;//电视
	private Integer a07;//洗衣机
	private Integer a08;//热水器
	private Integer a09;//燃气灶
	private Integer a10;//阳台
	private Integer a11;//WiFi
	private Integer a12;//卫生间
	
	
	public Integer getFurnitureId() {
		return furnitureId;
	}
	public void setFurnitureId(Integer furnitureId) {
		this.furnitureId = furnitureId;
	}
	public Integer getRoomId() {
		return roomId;
	}
	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}
	public Integer getApartmentId() {
		return apartmentId;
	}
	public void setApartmentId(Integer apartmentId) {
		this.apartmentId = apartmentId;
	}
	
	public String getPublicFlag() {
		return publicFlag;
	}
	public void setPublicFlag(String publicFlag) {
		this.publicFlag = publicFlag;
	}
	public Integer getA01() {
		return a01;
	}
	public void setA01(Integer a01) {
		this.a01 = a01;
	}
	public Integer getA02() {
		return a02;
	}
	public void setA02(Integer a02) {
		this.a02 = a02;
	}
	public Integer getA03() {
		return a03;
	}
	public void setA03(Integer a03) {
		this.a03 = a03;
	}
	public Integer getA04() {
		return a04;
	}
	public void setA04(Integer a04) {
		this.a04 = a04;
	}
	public Integer getA05() {
		return a05;
	}
	public void setA05(Integer a05) {
		this.a05 = a05;
	}
	public Integer getA06() {
		return a06;
	}
	public void setA06(Integer a06) {
		this.a06 = a06;
	}
	public Integer getA07() {
		return a07;
	}
	public void setA07(Integer a07) {
		this.a07 = a07;
	}
	public Integer getA08() {
		return a08;
	}
	public void setA08(Integer a08) {
		this.a08 = a08;
	}
	public Integer getA09() {
		return a09;
	}
	public void setA09(Integer a09) {
		this.a09 = a09;
	}
	public Integer getA10() {
		return a10;
	}
	public void setA10(Integer a10) {
		this.a10 = a10;
	}
	public Integer getA11() {
		return a11;
	}
	public void setA11(Integer a11) {
		this.a11 = a11;
	}
	public Integer getA12() {
		return a12;
	}
	public void setA12(Integer a12) {
		this.a12 = a12;
	}
	
	
}
