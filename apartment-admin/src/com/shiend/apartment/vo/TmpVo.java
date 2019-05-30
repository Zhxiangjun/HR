package com.shiend.apartment.vo;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * 
 * @Description:会员注册量echarts图用类
 * @author ShienD
 * @date 2018年11月16日
 *
 */

@Table(name="member")
public class TmpVo {
	@Column(name="create_time")
	private String xString;
	
	private Integer yInteger;
	
	public String getxString() {
		return xString;
	}
	public void setxString(String xString) {
		this.xString = xString;
	}
	public Integer getyInteger() {
		return yInteger;
	}
	public void setyInteger(Integer yInteger) {
		this.yInteger = yInteger;
	}
	
}
