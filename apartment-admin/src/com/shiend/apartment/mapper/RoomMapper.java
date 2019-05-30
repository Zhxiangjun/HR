package com.shiend.apartment.mapper;

import java.util.List;

import com.github.abel533.mapper.Mapper;
import com.shiend.apartment.pojo.Room;
import com.shiend.apartment.vo.RoomVo;
import com.shiend.apartment.vo.TmpVo;

/**
 * 
 * @Description:房间管理持久层接口
 * @author ShienD
 * @date 2019年3月20日
 *
 */
public interface RoomMapper extends Mapper<Room>{

	public List<RoomVo> selectRoomList(RoomVo roomVo);

	public List<RoomVo> selectPriceList(RoomVo roomVo);

	public List<RoomVo> selectUpList(RoomVo roomVo);

	public List<TmpVo> roomEchart();
}
