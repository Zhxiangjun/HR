<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公寓出租-后台管理-公寓信息管理</title>

</head>
<body>
    <div id="myapp">
    	<!-- 列表区 -->
    	<div  v-show="show">
    	<!-- 条件查询区域 -->
		<form class="form-horizontal">
			
			<table class="form_table">
				<tr>
					<td>所在地区：</td>
					<td colspan="3">
						 <div data-toggle="distpicker" class="choose_city" id="distpicker">
                        <select id="eprovinceName" data-province="-- 选择省 --" name="provinceName"></select>
                        <select id="ecityName" data-city="-- 选择市 --" name="cityName"></select>
                        <select id="edistrictName" data-district="-- 选择区 --" name="districtName"></select>
                    	</div>
					</td>
					<td>详细地址：</td>
					<td><input type="text" name="location" id="location" ></td>
				</tr>
				<tr>
					<td>公寓ID：</td>
					<td ><input type="text" name="apartmentId" id="apartmentId"  maxlength="8" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();"></td>
					
					<td>房东姓名：</td>
					<td><input type="text" name="realname" id="realname" ></td>
					<td >出租类型：</td>
					<td >
					<select name="rentType" id="rentType"  style="width:100%;text-align: center;text-align-last: center;">
						<option value="" >-请选择-</option>
						<option value="1"  <c:if test="${formData.rentType==1 }">selected='selected'</c:if>>整租</option>
						<option value="2" <c:if test="${formData.rentType==2}">selected='selected'</c:if> >合租</option>
						</select>
					</td>
					<td>
						<input type="reset" value="重置" class="btn btn-primary"/>
						<a href="javascript:void(0);" v-on:click="query" class="btn btn-primary" >查询</a>
					</td>
				</tr>
			</table>
			
		</form>
		<!-- 按钮 -->
      	<div class="grid-btn">
      			<a class="btn btn-primary" @click="checkInfo"><i class="fa fa-search-plus"></i>&nbsp;查看房间信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btn btn-primary" @click="change"><i class="fa fa-pencil-square-o"></i>&nbsp;修改公寓信息</a>&nbsp;
				
		</div>
		<p ></p>
		<!-- 2、展示数据的table区 -->
		<table id="jqGrid"></table>
		<!-- 3、分页区 -->
		<div id="jqGridPager"></div>
    	</div>
    	
    	<!-- 查看详情、修改新增区域 -->
	
		<div v-show="!show" >
			<form class="form-horizontal">
			
			<table class="form_table">
				<!-- 查询详情 -->
				
				<table class="form_table" v-show="ischeck">
				<tr>
					<td>所在地区1：</td>
					<td >
						<input type="text" name="info" v-model="apartmentVo.city" readonly="readonly" >
					</td>
					<td>详细地址：</td>
					<td>
						<input type="text" name="info" v-model="apartmentVo.location" readonly="readonly">
					</td>
					<td>公寓户型：</td>
					<td ><input type="text" name="info" v-model="apartmentVo.apartmentType"  readonly="readonly"></td>
				</tr>
				
				<tr>
					<td>朝向：</td>
					<td><input type="text" name="info" v-model="apartmentVo.direction" readonly="readonly"></td>
					
					<td>楼层：</td>
					<td><input type="text" name="info" v-model="apartmentVo.floor" readonly="readonly"></td>
					
					<td>面积：</td>
					<td><input type="text" name="info" v-model="apartmentVo.area" readonly="readonly"></td>
					
				</tr>
				<tr>
					<td>房东姓名：</td>
					<td><input type="text" name="info" v-model="apartmentVo.member.realname" readonly="readonly"></td>
					
					<td>身份证号：</td>
					<td><input type="text" name="info" v-model="apartmentVo.member.cardId" readonly="readonly" ></td>
				</tr>
				<tr>
					<td colspan="6" align="left"><a>{{apartmentVo.apartmentId}}号公寓房间信息</a></td>
				</tr>
				</table>
				
				<!-- 修改  -->
				<table class="form_table" v-show="!ischeck">
				<tr>
					<td><a style="color:red;font-size: 14px;text-decoration:none;">*</a>所在地区：</td>
					<td colspan="3">
						 <div data-toggle="distpicker" class="choose_city" id="distpicker1" >
                        <select id="eprovinceName1" data-province="-- 选择省 --" name="provinceName" ></select>
                        <select id="ecityName1" data-city="-- 选择市 --" name="cityName"></select>
                        <select id="edistrictName1" data-district="-- 选择区 --" name="districtName"></select>
                    	</div>
					</td>
					<td>详细地址：</td>
					<td>
						<input type="text" name="location1"  v-model="apartmentVo.location" id="location1" >
						<input type="hidden" name="apartmentId1"  v-model="apartmentVo.apartmentId" id="apartmentId1" >
					</td>
				</tr>
				
				<tr>
					<td>公寓户型：</td>
					<td ><input type="text" name="apartmentType1" v-model="apartmentVo.apartmentType"  id="apartmentType1"  ></td>
					<td>朝向：</td>
					<td><input type="text" name="direction1" v-model="apartmentVo.direction" id="direction1" ></td>
					<td>楼层：</td>
					<td><input type="text" name="floor1"  v-model="apartmentVo.floor"  id="floor1" ></td>
				</tr>
				<tr>
					<td>面积：</td>
					<td><input type="text" name="area1" v-model="apartmentVo.area" id="area1"></td>
					<td colspan="2" align="left"><a href="javascript:void(0);" v-on:click="update" class="btn btn-primary" id="baocun" >保存公寓信息</a> </td>
					<td colspan="3"><a style="color:red;font-size: 14px;text-decoration:none;">*注：所在地区如果为空，将不会更改，默认为原所在地区</a></td>
				</tr>
				
				<tr>
					<td colspan="6" align="left"><a>{{apartmentVo.apartmentId}}号公寓房间信息</a></td>
				</tr>
				</table>
			</table>
			</form>
			<p> </p>
			<!-- 展示数据的table区 -->
			
			<table id="jqGrid1" ></table>
			
			
			
			<!-- 返回区 -->
			<div v-show="ccc">
			<table class="form_table">
				<tr>
					<td colspan="6">
						<a href="javascript:void(0);" v-on:click="fanhui" class="btn btn-primary" >返回公寓列表</a>
					</td>
				</tr>
			</table>
			</div>
			<div v-show="aaa">
			<table class="form_table">
				<tr>
					<td colspan="6">
						<a href="javascript:void(0);" v-on:click="xgroom" class="btn btn-primary" >修改房间信息</a>
						<a href="javascript:void(0);" v-on:click="fanhui" class="btn btn-primary" >返回公寓列表</a>
					</td>
				</tr>
			</table>
			</div>
			<div v-show="bbb">
				<form class="form-horizontal">
					<table class="form_table">
						<tr>
							<td>房间id：</td>
							<td ><input type="text" name="roomId2" v-model="room.roomId"  id="roomId2"  readonly="readonly"></td>
							<td>房间名：</td>
							<td><input type="text" name="roomName2" v-model="room.roomName" id="roomName2" ></td>
							<td>房间面积：</td>
							<td><input type="text" name="roomArea2"  v-model="room.roomArea"  id="roomArea2">
								<input type="hidden" name="aprId"  v-model="room.apartmentId"  id="aprId">
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<a href="javascript:void(0);" v-on:click="bcroom" class="btn btn-primary" >保存房间信息</a>
								<a href="javascript:void(0);" v-on:click="fanhui" class="btn btn-primary" >返回公寓列表</a>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	
	</div>
	
	<script type="text/javascript"  >
$(function(){
	tableInit();
	changeTableInit();
	$("#distpicker").distpicker();
	$("#distpicker1").distpicker();
	
})
 
var vm = new Vue({
	el:"#myapp",
	data:{
		show:true,
		ischeck:true,
		aaa:false,
		bbb:false,
		ccc:false,
		apartmentVo:{member:{}},//新增修改数据对象，绑定对象
		room:{}
	},
	methods:{
		query:function(){//查询方法
			var name1 = $("#eprovinceName").val();
			var name2 = $("#ecityName").val();
			var name3 = $("#edistrictName").val();
			var cname = name1+name2+name3;
			$("#jqGrid").jqGrid("setGridParam",{
				//只需要传递查询数据，只需要指定一个属性
				postData:{
					city:cname,
					location:$("#location").val(),
					rentType:$("#rentType").val(),
					apartmentId:$("#apartmentId").val(),
					realname:$("#realname").val(),
				}
			}).trigger("reloadGrid");//设置reloadGrid重新加载事件
		},
		change:function(){
			var id = getSelectedRow();
			vm.aaa=true;
			vm.bbb=false;
			vm.ccc=false;
	     	$.ajax({
	     		url:"${pageContext.request.contextPath}/apartment/detailInfo/"+id,
	     		type:'get',
	     		contentType:"application/json",
	     		data:{},
	     		dataType:'json',
	     		success:function(data){
	     			if(data.code == 0){
						//绑定到vm中的apartmentVo对象中。
						
						vm.apartmentVo = data.info;
						vm.show = false;
						
						/* eprovinceName1
						ecityName1
						edistrictName1 */
						document.getElementById("eprovinceName1").value = "-- 选择省 --";
						document.getElementById("ecityName1").value = "-- 选择市 --";
						document.getElementById("edistrictName1").value = "-- 选择区 --";
						vm.ischeck = false;
						
						$("#jqGrid1").jqGrid("setGridParam",{
							datatype:'json',
							
							postData:{
								apartmentId:id
							}
						}).trigger("reloadGrid");//设置reloadGrid重新加载事件
					}
	     		}
	     	}); 
		},
		update:function(){//保存公寓信息
			var name1 = $("#eprovinceName1").val();
			var name2 = $("#ecityName1").val();
			var name3 = $("#edistrictName1").val();
			/* debugger;
			alert(name1+","+name2+","+name3); */
			var cname = null;
			if(name1!=null&&name1!=""){
				if(name2!=null&&name2!=""){
					if(name3!=null&&name3!=""){
						cname = name1+name2+name3;
					}else{
						alert("请完善所在地区！");
						return false;
					}
				}else{
					alert("请完善所在地区！");
					return false;
				}
			}else{
				if(name2==null||name2==""){
					if(name3!=null&&name3!=""){
						alert("请完善所在地区！");
						return false;
					}
				}else{
					alert("请完善所在地区！");
					return false;
				}
			}
			var apartmentId = $("#apartmentId1").val();
			var location = $("#location1").val();
			var apartmentType = $("#apartmentType1").val();
			var direction = $("#direction1").val();
			var floor = $("#floor1").val();
			var area = $("#area1").val();
			var apartment = {
					"apartmentId":apartmentId,
					"city":cname,
					"location":location,
					"apartmentType":apartmentType,
					"direction":direction,
					"floor":floor,
					"area":area,
			};
			var apJson = JSON.stringify(apartment);
			$.ajax({
	     		url:"${pageContext.request.contextPath}/apartment/update",
	     		type:'post',
	     		contentType:"application/json",
	     		data:apJson,
	     		dataType:'json',
	     		success:function(data){
	     			if(data.code == 0){
						alert("公寓信息保存成功！");
					}if(data.code == 500){
						alert("数据保存异常！");
						return false;
					}
					
	     		}
	     	});
			
		},
		fanhui:function(){
			vm.show = true;
			vm.ischeck = true;
			vm.query();
		},
		checkInfo: function(){
			var id = getSelectedRow();
	     	$.ajax({
	     		url:"${pageContext.request.contextPath}/apartment/detailInfo/"+id,
	     		type:'get',
	     		contentType:"application/json",
	     		data:{},
	     		dataType:'json',
	     		success:function(data){
	     			if(data.code == 0){
						//绑定到vm中的apartmentVo对象中。
						vm.apartmentVo = data.info;
						vm.apartmentVo.floor = vm.apartmentVo.floor+"层";
						vm.apartmentVo.area = vm.apartmentVo.area+"m²";
						vm.show = false;
						vm.ischeck = true;
						vm.ccc = true;
						vm.aaa = false;
						vm.bbb = false;
						$("#jqGrid1").jqGrid("setGridParam",{
							datatype:'json',
							postData:{
								apartmentId:id
							}
						}).trigger("reloadGrid");//设置reloadGrid重新加载事件
					}
	     		}
	     	}); 
	     },
	     xgroom:function(){
	    	 var a = "#jqGrid1";
	    	 var id = getjl(a);
	    	 $.ajax({
		     		url:"${pageContext.request.contextPath}/room/info/"+id,
		     		type:'get',
		     		contentType:"application/json",
		     		data:{},
		     		dataType:'json',
		     		success:function(data){
		     			if(data.code == 0){
		     				var rooms =  data.info
							vm.room = data.info;
							if(rooms.upStatus == "1"){
								alert("该房间已上架，请先下架后重试！");
								return false;
							}
							if(rooms.status != "-1"){
								 confirm("该房间已审核过，修改后将会重新审核，确定执行该操作吗？",function(){
									alert("请修改信息");
									vm.aaa = false;
							    	vm.bbb = true;
							    	vm.ccc = false;
								}); 
								
							}else{
								vm.aaa = false;
						    	vm.bbb = true;
						    	vm.ccc = false;
							}
						}else{
							
						}
		     		}
		     	}); 
	     },
	     bcroom:function(){
	    	var roomId = $("#roomId2").val();
			var roomName = $("#roomName2").val();
			var roomArea = $("#roomArea2").val();
			var aprId = $("#aprId").val();
			var room = {
					"roomId":roomId,
					"roomName":roomName,
					"roomArea":roomArea,
			};
			var roJson = JSON.stringify(room);
			$.ajax({
	     		url:"${pageContext.request.contextPath}/room/update",
	     		type:'post',
	     		contentType:"application/json",
	     		data:roJson,
	     		dataType:'json',
	     		success:function(data){
	     			if(data.code == 0){
						alert("房间信息保存成功！");
					}if(data.code == 500){
						alert("数据保存异常！");
						return false;
					}
					$("#jqGrid1").jqGrid("setGridParam",{
						datatype:'json',
						postData:{
							apartmentId:aprId
						}
					}).trigger("reloadGrid");//设置reloadGrid重新加载事件
	     		}
	     	});
	     },
	    
		
	}
});
function changeTableInit(){
	//获取table元素，调用jqGird Ui函数 对象作为参数{}
	$("#jqGrid1").jqGrid({
		url:"${pageContext.request.contextPath}/apartment/detailInfoGrid",
		datatype:'local',//服务器返回的数据类型
		mtype:'post',	//请求方式
		postData:{},	//请求提交的参数
		colModel:[
		          {
		        	  label:'房间ID',
		        	  name:'roomId',
		        	  width:80,
		        	  key:true
		          },
		          
		          {
		        	  label:'房间名',
		        	  name:'roomName',
		        	  width:100,
		          },
		          {
		        	  label:'房间面积',
		        	  name:'roomArea',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		return value+"m&sup2;";
		        	  }
		          },
		          {
		        	  label:'审批状态',
		        	  name:'status',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  if(value == -1){
    						  return '<a style="color:gray;font-size: 14px;text-decoration:none;">未处理</a>';
    					  }else if(value == 0){
    						  return '<a style="color:red;font-size: 14px;text-decoration:none;">未通过×</a>';
    					  }else if(value == 1){
    						  return '<a style="color:green;font-size: 14px;text-decoration:none;">已通过√</a>';
    					  }
			        	}
		          },
		          {
		        	  label:'上架状态',
		        	  name:'upStatus',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  if(value == -1){
    						  return '<a style="color:gray;font-size: 14px;text-decoration:none;">维护中…</a>';
    					  }else if(value == 0){
    						  return '<a style="color:red;font-size: 14px;text-decoration:none;">未上架×</a>';
    					  }else if(value == 1){
    						  return '<a style="color:green;font-size: 14px;text-decoration:none;">已上架√</a>';
    					  }else if(value == 9){
    						  return '<a style="color:blue;font-size: 14px;text-decoration:none;">租赁中…</a>';
    					  }
			        	}
		          },
		          
		          ],
		viewrecoders:true,//定义是否要显示的行
		rownumbers:true,//表格左侧新增一列
		multiselect:true,//是否可以多选
		jsonReader:{//处理后台的数据
			root:"page.rows",//表格数据
			records:"page.records"//总记录数
		}
		
	});
}

function tableInit(){
	//获取table元素，调用jqGird Ui函数 对象作为参数{}
	$("#jqGrid").jqGrid({
		url:"${pageContext.request.contextPath}/apartment/list",//请求的地址
		datatype:'json',//服务器返回的数据类型
		mtype:'post',	//请求方式
		postData:{},	//请求提交的参数
		colModel:[
		          {
		        	  label:'公寓ID',
		        	  name:'apartmentId',
		        	  width:80,
		        	  key:true
		          },
		          
		          {
		        	  label:'所在地区',
		        	  name:'city',
		        	  width:150,
		          },
		          {
		        	  label:'详细地址',
		        	  name:'location',
		        	  width:120,
		          },
		          {
		        	  label:'公寓户型',
		        	  name:'apartmentType',
		        	  width:100,
		        	 
		          },
		          {
		        	  label:'公寓面积',
		        	  name:'area',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		return value+"m&sup2;";
		        	  }
		          },
		          {
		        	  label:'楼层',
		        	  name:'floor',
		        	  width:80,
		        	  formatter:function(value,opt,row){
		        		return value+"层";
		        	  }
		          },
		          {
		        	  label:'朝向',
		        	  name:'direction',
		        	  width:80
		          },
		          {
		        	  label:'房主姓名',
		        	  name:'member',
		        	  width:100,
		        	  formatter:function(value,opt,row){
			        		 return value.realname;
			        	 	 }
		        	  
		          },
		          {
		        	  label:'出租类型',
		        	  name:'rentType',
		        	  width:80,
		        	  formatter:function(value,opt,row){
		        		  if(value == 1){
		        			  return "整租";
		        		  }else if(value == 2){
		        			  return "合租";
		        		  }
		        	  }
		          },
		          
		          {
		        	  label:'房主身份证号',
		        	  name:'member',
		        	  width:120,
		        	  formatter:function(value,opt,row){
			        		 return value.cardId;
			        	 	 }
		          },
		          
		          ],
		viewrecoders:true,//定义是否要显示的行
		height:304,//表格的高度
		rowNum:8,//表格展示的行数
		rowList:[8,10,20,30,50],//表格可以改变的记录数
		rownumbers:true,//表格左侧新增一列
		multiselect:true,//是否可以多选
		pager:"#jqGridPager",//分页导航
		jsonReader:{//处理后台的数据
			root:"page.rows",//表格数据
			page:"page.page",//当前页
			total:"page.pages",//总页数
			records:"page.records"//总记录数
		},
		prmNames:{//提交参数的
			page:"pageNum",
			rows:"pageSize"
		}
	});
}


</script>
</body>

</html>