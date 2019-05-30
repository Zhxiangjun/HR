package com.shiend.apartment.service;

import java.util.List;
import java.util.Map;

import com.shiend.apartment.pojo.Intake;
import com.shiend.apartment.vo.IntakeVo;

/**
 * 
 * @Description:入住表业务层接口
 * @author ShienD
 * @date 2019年3月20日
 *
 */
public interface IntakeService {

	Map<String, Object> selectIntakeInfoList(IntakeVo intakeVo, int pageNum, int pageSize);

	Map<String, Object> selectIntakePayList(IntakeVo intakeVo, int pageNum, int pageSize);

	Intake info(Integer id);

	int updateInfo(Intake intake);

	List<Integer> YQEchart();

	List<Integer> DJFEchart();

	List<Integer> YJFEchart();

}
