package com.shiend.apartment.service;

import java.util.List;
import java.util.Map;

import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Room;
import com.shiend.apartment.vo.RoomVo;
import com.shiend.apartment.vo.TmpVo;

/**
 * 
 * @Description:房间管理业务层接口
 * @author ShienD
 * @date 2019年3月20日
 *
 */
public interface RoomService {
	/**
	 * 房间相关查询
	 */
	public Map<String, Object> selectRoomList(RoomVo roomVo, int pageNum, int pageSize, int oparams);
	/**
	 * id信息
	 */
	public Room info(Integer id);
	/**
	 * 通过审批
	 */
	public int pass(Room room);
	/**
	 * 不通过审批
	 * @return 
	 */
	public int dispass(Room room);
	/**
	 * 根据缴费计算租赁月数
	 * @return
	 */
	public Integer monthSum(Integer roomId, Double money);
	/**
	 * 根据实体类进行修改
	 * @return
	 */
	public int update(Room room);
	/**
	 * 上架
	 */
	public int uproom(Room room);
	/**
	 * 下架
	 */
	public int underroom(Room room);
	/**
	 * 房间入住量echarts图表
	 */
	public List<TmpVo> roomEchart();

	
}
