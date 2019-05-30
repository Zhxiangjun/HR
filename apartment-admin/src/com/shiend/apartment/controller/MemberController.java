package com.shiend.apartment.controller;

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

import com.alibaba.fastjson.JSONObject;
import com.shiend.apartment.pojo.Member;
import com.shiend.apartment.service.MemberService;
import com.shiend.apartment.util.R;
import com.shiend.apartment.vo.TmpVo;

/**
 * 
 * @Description:用户控制层
 * @author ShienD
 * @date 2018年11月16日
 *
 */
@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	/**
	 * 模糊条件查询所有用户,-->query
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public R memberList(@RequestParam Map<String, Object > praMap) {
		int pageNum = Integer.valueOf(praMap.get("pageNum").toString()) ;
		int pageSize = Integer.valueOf(praMap.get("pageSize").toString()) ;
		//模糊查询的属性
		String account = praMap.get("memberAccount")==null?null:praMap.get("memberAccount").toString();
		String username = praMap.get("username")==null?null:praMap.get("username").toString();
		String sex = praMap.get("memberSex")==null?null:praMap.get("memberSex").toString();
		String cardId = praMap.get("cardId")==null?null:praMap.get("cardId").toString();
		
		Member m = new Member();
		m.setMemberAccount(account);
		m.setUsername(username);
		m.setMemberSex(sex);
		m.setCardId(cardId);
	
		
		Map<String, Object> map = memberService.selectMemberList(m, pageNum, pageSize);
		//把map封装到R类(简单封装，为了方便异步框架处理异常)
		if(((List)map.get("rows")).isEmpty()){
			return R.error(-1,"没有数据");
		}
		return R.ok().put("page", map);  //-->R
	}
	/**
	 * 保存用户对象
	 */
	@RequestMapping(value="save")
	@ResponseBody
	public R save(@RequestBody Member member){
		memberService.save(member);
		return R.ok();
	}
	/**
	 * 修改用户对象
	 */
	@RequestMapping(value="update")
	@ResponseBody
	public R update(@RequestBody Member member){
		memberService.update(member);
		return R.ok();
	}
	/**
	 * 选择id
	 */
	@RequestMapping(value="info/{id}") 
	@ResponseBody
	public R info(@PathVariable String id) {
		if(!"undefined".equals(id)){
			Member m = memberService.info(Integer.valueOf(id));
			return R.ok().put("info", m);//{code":0,info:{"":""}}
		}else{
			return R.error();
		}
	}
	
	/**
	 * 批量删除用户列表
	 */
	@RequestMapping(value="del")
	@ResponseBody
	public R del(@RequestBody Integer[] ids) {
		try {
			int res = memberService.del(ids);
		} catch (Exception e) {
			return R.error();
		}
		return R.ok();
	}
	/**
	 * 会员注册量echarts图表
	 */
	@RequestMapping(value="memberEchart",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	@ResponseBody
	public String memberEchart(@RequestBody String xString){
		List<TmpVo> list = null;
		if(xString!=null){
			xString=xString.substring(8, 12);
			list = memberService.memberEchart(xString);//获取数据库中月份以及count
		}
		JSONObject json = new JSONObject();
		String[] fxarr = new String[12];
		Integer[] fyarr = new Integer[12];
		//获取表中查询结果(已排序)，将无数据的月份生成，并将count设置为0
		//else年份无数据，生成所有月份count全为0的json
		if (list.size()!=0) {
			int flag= 0;//用来提前结束for循环的标志，减少不必要的循环
			int num = 0;//记录list中的月份 与i做对比
			for(int i=1;i<13;i++){
				for(int j=0+flag;j<list.size();j++){
					num = Integer.parseInt(list.get(j).getxString().substring(5,7));
					if(num==i){
						fxarr[i-1] = list.get(j).getxString();
						fyarr[i-1] = list.get(j).getyInteger();
						j=list.size();
						flag++;
					}else{
						if(i<10){
							fxarr[i-1] = xString+"-0"+i;
							fyarr[i-1] = 0;
							j=list.size();
						}else{
							fxarr[i-1] = xString+"-"+i;
							fyarr[i-1] = 0;
							j=list.size();
						}
					}
				}
			}
			if(num<10){
				for(int i=num+1;i<10;i++){
					  fxarr[i-1] = xString+"-0"+i;
					  fyarr[i-1] = 0;
				  }
				  for(int i=10;i<13;i++){
					  fxarr[i-1] = xString+"-"+i;
					  fyarr[i-1] = 0;
				  }
			}else if(num < 12){
				for(int i=num+1;i<13;i++){
					  fxarr[i-1] = xString+"-"+i;
					  fyarr[i-1] = 0;
				  }
			}
		  }else{
			  for(int i=1;i<10;i++){
				  fxarr[i-1] = xString+"-0"+i;
				  fyarr[i-1] = 0;
			  }
			  for(int i=10;i<13;i++){
				  fxarr[i-1] = xString+"-"+i;
				  fyarr[i-1] = 0;
			  }
		  }
		json.put("xString", fxarr);
	    json.put("yInteger", fyarr);
	    return json.toJSONString();
	}
	
	
	/**
	 * 登记保存
	 */
	@RequestMapping(value = "/loginSave", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public R loginSave(@RequestBody Map<String, Object> praMap){
		Integer memberId = praMap.get("DJmemberId")==null||"".equals(praMap.get("DJmemberId"))?null:Integer.valueOf(praMap.get("DJmemberId").toString());
		String cardId = praMap.get("DJcardId") == null ? null : praMap.get("DJcardId").toString();
		Member member = new Member();
		member.setMemberId(memberId);
		member.setCardId(cardId);
		try {
			memberService.update(member);
		} catch (Exception e) {
			return R.error();
		}
		return R.ok();

	}
}
