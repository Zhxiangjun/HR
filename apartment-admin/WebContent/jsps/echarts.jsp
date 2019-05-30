<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>公寓出租-后台管理-数据统计</title>

</head>
	<body>
		<!--如何使用
			1）引入js文件
			2）创建一个可以画图的容器（盒子）
			3）创建参数
			4）初始化echarts实例
			5）设置参数显示
		-->
		<div id="vuchart">
			<table class="form_table">
				<tr>
					<td>图表：</td>
					<td><select name="status" id="kind"  style="width:100%;text-align: center;text-align-last: center;">
						<option value="1">会员注册统计图表</option>
						<option value="2">房屋入住数据图表</option>
						<option value="3">租房缴费数据图表</option>
						</select>
					</td>
					<td>年份：</td>
					<td><select  style="width:100%;text-align: center;text-align-last: center;" name="createTime" id="createTime" >
						
					</select></td>
					<td>
						<a href="javascript:void(0);" v-on:click="getChart" class="btn btn-primary" >查询</a>  
					</td>
				</tr>
			</table>
		
		<div v-show="show" id="myChart" style="width: 400px; height: 400px; margin: 0 auto;"></div>
		<div v-show="!show" id="myChart2" style="width: 400px; height: 400px; margin: 0 auto;"></div>
		</div>
	</body>
<script type="text/javascript">
var myChart = echarts.init(document.getElementById('myChart'));
var myChart2 = echarts.init(document.getElementById('myChart2'));
$(function(){
	year();
});
 function year(){
	var myDate= 2018; 
	var startYear=myDate;//起始年份 
	var endYear=myDate+10;//结束年份 
	var obj=document.getElementById('createTime'); 
	for (var i=startYear;i<=endYear;i++){ 
		obj.options.add(new Option(i,i)); 
	} 
	obj.options[obj.options.length-11].selected=1; 
}  

 /*
  *数据统计  获取echarts图
  
  *
  */
  
  var vm = new Vue({
		el:"#vuchart",
		data:{
			show:true
		},
		methods:{
			getChart:function(){
				var kind = $("#kind").val();
				var xstr = $("#createTime").val();
				var urlstr;
				var echartname;
			  	if(kind==1){
			  		$.ajax({
			  			url: "${pageContext.request.contextPath}/member/memberEchart",
			  			type:"post",
			  			dataType:"json",
			  			data:{xstring:xstr},
			  			async:true,
			  			success:function(datas){
			  				vm.show = true;
			  				myChart.setOption({
			  					title: {
			  						text: xstr + "年会员注册量统计表",
			  					    x:'center'
			  					},
			  					tooltip: {},
			  				    xAxis:{
			  				    	name:'月份',
			  						data:datas.xString
			  					},
			  					yAxis:{
			  						name:'人数',
			  						minInterval : 1
			  					},
			  					series : [{
			  						name: '注册量',
			  						type: 'line',
			  						data: datas.yInteger
			  	              
			  					}]
			  				}); 
			  		 	}
			  		});
			  	}else if(kind==2){
			  		
			  		$.ajax({
			  			url: "${pageContext.request.contextPath}/room/roomEchart",
			  			type:"post",
			  			dataType:"json",
			  			data:{},
			  			async:true,
			  			success:function(datas){
			  				vm.show = false;
			  				var e = datas.info;
			  				myChart2.setOption({
			  					title: {
			  						text: "房屋入住数据图表",
			  					},
			  					
			  					tooltip: {},
			  					series:[{
									name:'房间数',
									type:'pie',
									radius:"65%",
									data:[
										{name:'维护中',value:e.ywh},
										{name:'已下架',value:e.yxj},
										{name:'已上架',value:e.ysj},
										{name:'已入住',value:e.yrz}
									]
								}]
			  				}); 
			  		 	}
			  		});
			  	}else{
			  		
			  		$.ajax({
			  			url: "${pageContext.request.contextPath}/intake/payEchart",
			  			type:"post",
			  			dataType:"json",
			  			data:{},
			  			async:true,
			  			success:function(datas){
			  				vm.show = false;
			  				var e = datas.info;
			  				myChart2.setOption({
			  					title: {
			  						text: "租房缴费数据图表",
			  					},
			  					tooltip: {},
			  					series:[{
									name:'订单量',
									type:'pie',
									radius:"65%",
									data:[
										{name:'已缴费',value:e.yjf},
										{name:'已逾期',value:e.yuqi},
										{name:'待缴费',value:e.djf}
										
									]
								}]
			  				}); 
			  		 	}
			  		});
			  	}
			  	
			},
			
		}
	});

  	
  

</script>
</html>
