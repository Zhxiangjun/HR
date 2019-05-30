package com.shiend.apartment.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shiend.apartment.mapper.RoomMapper;
import com.shiend.apartment.pojo.Room;
import com.shiend.apartment.service.RoomService;
import com.shiend.apartment.vo.RoomVo;
import com.shiend.apartment.vo.TmpVo;


/**
 * 
 * @Description:房间管理业务层
 * @author ShienD
 * @date 2019年3月20日
 *
 */
@Service
public class RoomServiceImpl implements RoomService{
	@Autowired
	private RoomMapper roomMapper;
	
	//查询房间相关
	@Override
	public Map<String, Object> selectRoomList(RoomVo roomVo, int pageNum, int pageSize, int oparams) {
		Map<String, Object> map = new HashMap<String, Object>();
		//roomList查询
		if( oparams == 1){
			if (pageNum > 0) {
				// 分页
				PageHelper.startPage(pageNum, pageSize);
				List<RoomVo> roomVos = this.roomMapper.selectRoomList(roomVo);
				PageInfo<RoomVo> pageInfo = new PageInfo<RoomVo>(roomVos);
				// 封装返回数据
				map.put("rows", pageInfo.getList());
				map.put("records", pageInfo.getTotal());
				map.put("pages", pageInfo.getPages());
				map.put("page", pageInfo.getPageNum());
			} else {// 不分页
				List<RoomVo> roomVos = this.roomMapper.selectRoomList(roomVo);
				map.put("rows", roomVos);
			}
		}
		//priceList查询
		if(oparams == 2){
			if (pageNum > 0) {
				PageHelper.startPage(pageNum, pageSize);
				List<RoomVo> roomVos = this.roomMapper.selectPriceList(roomVo);
				PageInfo<RoomVo> pageInfo = new PageInfo<RoomVo>(roomVos);
				map.put("rows", pageInfo.getList());
				map.put("records", pageInfo.getTotal());
				map.put("pages", pageInfo.getPages());
				map.put("page", pageInfo.getPageNum());
			} else {// 不分页
				List<RoomVo> roomVos = this.roomMapper.selectPriceList(roomVo);
				map.put("rows", roomVos);
			}
		}
		if(oparams == 3){
			if (pageNum > 0) {
				PageHelper.startPage(pageNum, pageSize);
				List<RoomVo> roomVos = this.roomMapper.selectUpList(roomVo);
				PageInfo<RoomVo> pageInfo = new PageInfo<RoomVo>(roomVos);
				map.put("rows", pageInfo.getList());
				map.put("records", pageInfo.getTotal());
				map.put("pages", pageInfo.getPages());
				map.put("page", pageInfo.getPageNum());
			} else {// 不分页
				List<RoomVo> roomVos = this.roomMapper.selectUpList(roomVo);
				map.put("rows", roomVos);
			}
		}
		return map;
	}
	/**
	 * 获取id
	 */
	@Override
	public Room info(Integer id) {
		return roomMapper.selectByPrimaryKey(id);
	}
	/**
	 * 通过审批
	 * @return 
	 */
	@Override
	public int pass(Room room) {
		room.setStatus("1");
		SimpleDateFormat data = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		room.setPassTime(data.format(new Date()));
		//room.setUnderTime("暂未下架");
		return roomMapper.updateByPrimaryKeySelective(room);
		
	}
	/**
	 * 不通过审批
	 * @return 
	 */
	@Override
	public int dispass(Room room) {
		room.setStatus("0");
		SimpleDateFormat data = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		room.setPassTime(data.format(new Date()));
		//room.setUnderTime("未通过×");
		return roomMapper.updateByPrimaryKeySelective(room);
		
	}
	/**
	 * 上架
	 * @return 
	 * @return 
	 */
	@Override
	public int uproom(Room room) {
		room.setUpStatus("1");
		SimpleDateFormat data = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		room.setUpTime(data.format(new Date()));
		room.setUnderTime("");
		return roomMapper.updateByPrimaryKeySelective(room);
		
	}
	/**
	 * 下架
	 * @return 
	 */
	@Override
	public int underroom(Room room) {
		room.setUpStatus("0");
		SimpleDateFormat data = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		room.setUnderTime(data.format(new Date()));
		room.setUpTime("");
		return roomMapper.updateByPrimaryKeySelective(room);
	}
	/**
	 * 根据缴费计算租赁月数
	 */
	@Override
	public Integer monthSum(Integer roomId,Double money) {
		Integer month = 0;
		Room room = roomMapper.selectByPrimaryKey(roomId);
		if(room != null){
			if(money.equals(room.getMonthPrice())){
				month = 1;
			}else if(money.equals(room.getHalfYearPrice())){
				month = 6;
			}else if(money.equals(room.getSeasonPrice())){
				month = 3;
			}else if(money.equals(room.getYearPrice())){
				month = 12;
			}
			
		}
		return month;
	}
	/**
	 * room  update
	 */
	@Override
	public int update(Room room) {
		return roomMapper.updateByPrimaryKeySelective(room);
	}
	/**
	 * 房间入住量echarts图表
	 */
	@Override
	public List<TmpVo> roomEchart() {
		return roomMapper.roomEchart();
	}
	
}
