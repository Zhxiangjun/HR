package com.shiend.apartment.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shiend.apartment.pojo.Apartment;
import com.shiend.apartment.pojo.Intake;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.pojo.Room;
import com.shiend.apartment.service.ApartmentService;
import com.shiend.apartment.service.IntakeService;
import com.shiend.apartment.service.MemberService;
import com.shiend.apartment.service.RoomService;
import com.shiend.apartment.util.R;
import com.shiend.apartment.vo.IntakeVo;
import com.shiend.apartment.vo.TmpVo;

/**
 * 
 * @Description:入住管理控制层
 * @author ShienD
 * @date 2019年3月20日
 *
 */

@Controller
@RequestMapping("/intake")
public class IntakeController {
	@Autowired
	private IntakeService intakeService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private RoomService roomService;
	@Autowired
	private ApartmentService apartmentService;
	/**
	 * 模糊条件查询所有用户,intakeInfo-->query
	 */
	@RequestMapping(value="/infolist",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R intakeInfoList(@RequestParam Map<String, Object > praMap) {
		int pageNum = Integer.valueOf(praMap.get("pageNum").toString()) ;
		int pageSize = Integer.valueOf(praMap.get("pageSize").toString()) ;
		//模糊查询的属性
		String realname = praMap.get("realname")==null?null:praMap.get("realname").toString();
		String cardId = praMap.get("cardId")==null?null:praMap.get("cardId").toString();
		
		IntakeVo intakeVo = new IntakeVo();
		intakeVo.setRealname(realname);
		intakeVo.setCardId(cardId);
		Map<String, Object> map = intakeService.selectIntakeInfoList(intakeVo,pageNum,pageSize);
		//把map封装到R类(简单封装，为了方便异步框架处理异常)
		if(((List)map.get("rows")).isEmpty()){
			return R.error(-1,"没有数据");
		}
		return R.ok().put("page", map);
	}
	
	/**
	 * 缴费查询,-->query
	 */
	@RequestMapping(value="/paylist",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R intakePayList(@RequestParam Map<String, Object > praMap) {
		int pageNum = Integer.valueOf(praMap.get("pageNum").toString()) ;
		int pageSize = Integer.valueOf(praMap.get("pageSize").toString()) ;
		//模糊查询的属性
		String realname = praMap.get("realname")==null?null:praMap.get("realname").toString();
		String cardId = praMap.get("cardId")==null?null:praMap.get("cardId").toString();
		
		IntakeVo intakeVo = new IntakeVo();
		intakeVo.setRealname(realname);
		intakeVo.setCardId(cardId);
		Map<String, Object> map = intakeService.selectIntakePayList(intakeVo,pageNum,pageSize);
		//把map封装到R类(简单封装，为了方便异步框架处理异常)
		if(((List)map.get("rows")).isEmpty()){
			return R.error(-1,"没有数据");
		}
		return R.ok().put("page", map);
	}
	
	/**
	 * 选择id
	 */
	@RequestMapping(value="info/{id}") 
	@ResponseBody
	public R info(@PathVariable String id) {
		if(!"undefined".equals(id)){
			Intake in = intakeService.info(Integer.valueOf(id));
			return R.ok().put("info", in);//{code":0,info:{"":""}}
		}else{
			return R.error();
		}
	}
	
	
	/**
	 * 生成合同
	 */
	@RequestMapping(value = "/addpact", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public R addpact(@RequestBody Map<String, Object> praMap) {
		Integer id = praMap.get("id")==null||"".equals(praMap.get("id"))?null:Integer.valueOf(praMap.get("id").toString());
		String SCpayMoney = praMap.get("crpayMoney") == null ? null : praMap.get("crpayMoney").toString();
		String SCcashMoney = praMap.get("crcashMoney") == null ? null : praMap.get("crcashMoney").toString();
		String SCwaterNum = praMap.get("crwaterNum") == null ? null : praMap.get("crwaterNum").toString();
		String SCpowerNum = praMap.get("crpowerNum") == null ? null : praMap.get("crpowerNum").toString();
		
		Intake in = intakeService.info(Integer.valueOf(id));
		if(in==null){
			return R.error();
		}
		String SCrenter =  memberService.info(in.getRentId()).getRealname();
		String SChouseholder = memberService.info(in.getHouseholderId()).getRealname();
		Room room = roomService.info(in.getRoomId());
		Apartment ap = apartmentService.info(room.getApartmentId());
		String SCaddr = ap.getCity()+ap.getLocation()+room.getRoomName()+"("+ap.getFloor()+"层)";
		
		Intake intake = new Intake();
		intake.setIntakeId(in.getIntakeId());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date nowdt = new Date();
		String now = sdf.format(nowdt);
		intake.setIntakeTime(now);//入住时间=合同生成时间
		Integer number = roomService.monthSum(in.getRoomId(), Double.valueOf(SCpayMoney));
		//计算离开时间
		Calendar c = Calendar.getInstance();  
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");   
        
        c.setTime(nowdt);//设置日历时间   
        
        c.add(Calendar.MONTH,number);//在日历的月份上增加n个月
        String strDate = sdf.format(c.getTime());
        intake.setLeaveTime(strDate);
        intake.setNextPayTime(now);
        SimpleDateFormat sdf3 = new SimpleDateFormat("yyyyMMdd");
        String pactdate = sdf3.format(nowdt);
        String SCcompactId = pactdate+in.getIntakeId();
        intake.setCompactId(SCcompactId);
        intake.setCashMoney(SCcashMoney);
        intake.setWaterNum(SCwaterNum);
        intake.setPowerNum(SCpowerNum);
        
        String SCstartTime = sdf2.format(nowdt);
        String SCendTime = sdf2.format(c.getTime());
        Map<String,Object> pactVo = new HashMap<String,Object>();
        pactVo.put("SCrenter", SCrenter);
		pactVo.put("SChouseholder", SChouseholder);
		pactVo.put("SCaddr", SCaddr);
		pactVo.put("SCpayMoney", SCpayMoney);
		pactVo.put("SCcashMoney",SCcashMoney);
		pactVo.put("SCwaterNum", SCwaterNum);
		pactVo.put("SCpowerNum", SCpowerNum);
		pactVo.put("SCstartTime", SCstartTime);
		pactVo.put("SCendTime", SCendTime);
		pactVo.put("SCcompactId", SCcompactId);
		//修改intake表数据
		intakeService.updateInfo(intake);
		return R.ok().put("info", pactVo); 
	}
	
	
	/**
	 * 查看合同
	 */
	
	@RequestMapping(value = "/checkpact", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public R checkpact(@RequestBody Map<String, Object> praMap){
		Integer id = praMap.get("id")==null||"".equals(praMap.get("id"))?null:Integer.valueOf(praMap.get("id").toString());
		if(id==null){
			return R.error();
		}

		Intake in = intakeService.info(Integer.valueOf(id));
		Map<String, Object> pactVo = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date date1 = sd.parse(in.getIntakeTime());
			Date date2 = sd.parse(in.getLeaveTime());
			String SCstartTime = sdf.format(date1);
			String SCendTime = sdf.format(date2);
			pactVo.put("SCstartTime", SCstartTime);
			pactVo.put("SCendTime", SCendTime);
		} catch (Exception e) {
			return R.error();
		}
		String SCrenter = memberService.info(in.getRentId()).getRealname();
		String SChouseholder = memberService.info(in.getHouseholderId()).getRealname();

		Room room = roomService.info(in.getRoomId());
		Apartment ap = apartmentService.info(room.getApartmentId());
		String SCaddr = ap.getCity() + ap.getLocation() + room.getRoomName() + "(" + ap.getFloor() + "层)";

		String SCpayMoney = in.getMoney().toString();
		String SCcashMoney = in.getCashMoney();
		String SCwaterNum = in.getWaterNum();
		String SCpowerNum = in.getPowerNum();
		String SCcompactId = in.getCompactId();

		pactVo.put("SCrenter", SCrenter);
		pactVo.put("SChouseholder", SChouseholder);
		pactVo.put("SCaddr", SCaddr);
		pactVo.put("SCpayMoney", SCpayMoney);
		pactVo.put("SCcashMoney", SCcashMoney);
		pactVo.put("SCwaterNum", SCwaterNum);
		pactVo.put("SCpowerNum", SCpowerNum);
		pactVo.put("SCcompactId", SCcompactId);
		return R.ok().put("info", pactVo);// {code":0,info:{"":""}}

	}
	
	/**
	 * 登记
	 */
	@RequestMapping(value="login/{id}") 
	@ResponseBody
	public R login(@PathVariable String id) {
		if(!"undefined".equals(id)){
			Intake in = intakeService.info(Integer.valueOf(id));
			if(in == null){
				return R.error();
			}
			Member member = memberService.info(in.getRentId());
			if(member == null){
				return R.error();
			}
			return R.ok().put("info", member);//{code":0,info:{"":""}}
		}else{
			return R.error();
		}
	}
	/**
	 * 租房缴费量echarts图表
	 */
	@RequestMapping(value="payEchart",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R payEchart(){
		List<Integer> yuqi =  intakeService.YQEchart();
		List<Integer> djf = intakeService.DJFEchart();
		List<Integer> yjf = intakeService.YJFEchart();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("yuqi", yuqi.get(0));
		map.put("djf", djf.get(0));
		map.put("yjf", yjf.get(0));
	    return R.ok().put("info", map);
	}
}
