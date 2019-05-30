package com.shiend.apartment.mapper;

import java.util.List;

import com.github.abel533.mapper.Mapper;
import com.shiend.apartment.pojo.Intake;
import com.shiend.apartment.vo.IntakeVo;

public interface IntakeMapper extends Mapper<Intake>{

	List<IntakeVo> selectIntakeInfoList(IntakeVo intakeVo);

	List<IntakeVo> selectPayList(IntakeVo intakeVo);

	List<Integer> YQEchart();

	List<Integer> DJFEchart();

	List<Integer> YJFEchart();

}
