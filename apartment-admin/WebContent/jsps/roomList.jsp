<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公寓出租-后台管理-房源信息审核</title>

</head>
<body>
    <div id="myapp">
    	<!-- 列表区 -->
    	<div >
    	<!-- 条件查询区域 -->
		<form class="form-horizontal">
			
			<table class="form_table">
				
				<tr>
					
					<td >房间ID：</td>
					<td ><input type="text" name="roomId" id="roomId"  maxlength="8" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();"></td>
					<td >公寓ID：</td>
					<td ><input type="text" name="apartmentId" id="apartmentId"  maxlength="8" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();"></td>
					<td >申请时间：</td>
					<td ><input type="text" name="createTime" id="createTime" ></td>
					<td >处理状态：</td>
					<td ><select name="status" id="status"  style="width:100%;text-align: center;text-align-last: center;">
						<option value="" >-请选择-</option>
						<option value="-1"  <c:if test="${formData.status=='-1' }">selected='selected'</c:if>>未处理</option>
						<option value="1"  <c:if test="${formData.status=='1' }">selected='selected'</c:if>>已通过</option>
						<option value="0" <c:if test="${formData.status=='0' }">selected='selected'</c:if> >未通过</option>
						</select>
					</td>
				</tr>
				<tr>
					<td >所在地区：</td>
					<td colspan="3">
						 <div data-toggle="distpicker" class="choose_city" id="distpicker">
                        <select id="eprovinceName" data-province="-- 选择省 --" name="provinceName"></select>
                        <select id="ecityName" data-city="-- 选择市 --" name="cityName"></select>
                        <select id="edistrictName" data-district="-- 选择区 --" name="districtName"></select>
                    	</div>
					</td>
					<td >详细地址：</td>
					<td ><input type="text" name="location" id="location" ></td>
					<td  align="center">
						<input type="reset" value="重置" class="btn btn-primary"/>
					</td>
					<td>
						<a href="javascript:void(0);" v-on:click="query" class="btn btn-primary" >查询</a>
					</td>
				</tr>
				
			</table>
			
		</form>
		<!-- 按钮 -->
      	<div class="grid-btn">
      			<a class="btn btn-primary" @click="checkInfo"><i class="fa fa-search-plus"></i>&nbsp;查看详细信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btn btn-primary" @click="pass"><i class="fa fa-check"></i>&nbsp;通过</a>&nbsp;
				<a class="btn btn-primary" @click="dispass"><i class="fa fa-remove"></i>&nbsp;驳回</a>
		</div>
		<p ></p>
		<!-- 2、展示数据的table区 -->
		<table id="jqGrid"></table>
		<!-- 3、分页区 -->
		<div id="jqGridPager"></div>
		 <!-- 4、详细信息窗口区 -->
		<div id="dialog" title="详情信息" >
  			<table class="form_table">
				<tr>
					<td>所在地区：</td>
					<td id="city"></td>
					<td>详细地址：</td>
					<td id="location2"></td>
				</tr>
				<tr>
					<td>房源户型：</td>
					<td id="apartmentType"></td>
					<td>房源朝向：</td>
					<td id="direction"></td>
				</tr>
				<tr>
					<td>房源楼层：</td>
					<td id="floor"></td>
					<td>房源面积：</td>
					<td id="area"></td>
				</tr>
				<tr>
					<td>该房间名：</td>
					<td id="roomName"></td>
					<td>该房面积：</td>
					<td id="roomArea"></td>
				</tr>
				<tr>
					<td>房东姓名：</td>
					<td id="householder2"></td>
					<td>联系电话：</td>
					<td id="tel"></td>
				</tr>
				<tr>
					<td>房东性别：</td>
					<td id="memberSex"></td>
					<td>家庭住址：</td>
					<td id="address"></td>
					
				</tr>
				<tr>
					<td>用户名：</td>
					<td id="username"></td>
					<td>账号：</td>
					<td id="memberAccount"></td>
				</tr>
			</table>
		</div>
    </div>
</div>
	<script type="text/javascript"  >
$(function(){
	tableInit();
	
	$("#dialog").dialog({
	      autoOpen: false,
	      dialogClass: 'alert',
	      width:600,
	      modal:true,
	      show: {
	        effect: "blind",
	        duration: 1000
	      },
	      hide: {
	        effect: "explode",
	        duration: 1000
	      }
	});	
	
	$("#distpicker").distpicker();
	
})
 
var vm = new Vue({
	el:"#myapp",
	data:{
		room:{}	//新增修改数据对象，绑定对象
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
					status:$("#status").val(),
					createTime:$("#createTime").val(),
					roomId:$("#roomId").val(),
					apartmentId:$("#apartmentId").val()
				}
			}).trigger("reloadGrid");//设置reloadGrid重新加载事件
		},
		pass:function(){
			var id = getSelectedRow(); 
			$.ajax({
				url:"${pageContext.request.contextPath}/room/info/"+id,
				type:'get',
				contentType:"application/json",
				data:{},
				dataType:'json',
				success:function(data){
					var room = data.info;
					if (room.status == "-1"){
						var aptStrJson = JSON.stringify(room);
						confirm("确定通过该条申请吗？",function(){
							$.ajax({
								url:"${pageContext.request.contextPath}/room/pass",
								type:'post',
								contentType:'application/json',
								data:aptStrJson,
								dataType:'json',
								success:function(data){
									if(data.code==0){
										alert("操作成功", vm.query());
									}
								}
							});
						});
					}else{
						alert("该条数据已经批审完成！");
					}
					
				}
			});
		},
		dispass:function(){
			var id = getSelectedRow();
			$.ajax({
				url:"${pageContext.request.contextPath}/room/info/"+id,
				type:'get',
				contentType:"application/json",
				data:{},
				dataType:'json',
				success:function(data){
					var room = data.info;
					if (room.status == "-1"){
						var aptStrJson = JSON.stringify(room);
						confirm("确定驳回该条申请吗？",function(){
							$.ajax({
								url:"${pageContext.request.contextPath}/room/dispass",
								type:'post',
								contentType:'application/json',
								data:aptStrJson, 
								dataType:'json',
								success:function(data){
									if(data.code==0){
										alert("操作成功", vm.query());
									}
								}
							});
						});
					}else{
						alert("该条数据已经批审完成！");
					}
				}
			});
		},
		checkInfo: function(){
	     	var id = getSelectedRow();
	     	$.ajax({
	     		url:"${pageContext.request.contextPath}/room/detailInfo/"+id,
	     		type:'get',
	     		contentType:"application/json",
	     		data:{},
	     		dataType:'json',
	     		success:function(data){
	     			var info = data.info;
	     			document.getElementById("city").innerHTML=info.city;
	     			document.getElementById("location2").innerHTML=info.location;
	     			document.getElementById("apartmentType").innerHTML=info.apartmentType;
	     			document.getElementById("direction").innerHTML=info.direction;
	     			document.getElementById("floor").innerHTML=info.floor+"层";
	     			document.getElementById("area").innerHTML=info.area+"m&sup2;";
	     			document.getElementById("householder2").innerHTML=info.realname;
	     			document.getElementById("tel").innerHTML=info.tel;
	     			document.getElementById("memberSex").innerHTML=info.memberSex;
	     			document.getElementById("address").innerHTML=info.cardId;
	     			document.getElementById("username").innerHTML=info.username;
	     			document.getElementById("roomName").innerHTML=info.roomName;
	     			document.getElementById("roomArea").innerHTML=info.roomArea+"m&sup2;";
	     			document.getElementById("memberAccount").innerHTML=info.memberAccount;
	     			$("#dialog").dialog("open");
	     		}
	     	});
	     }
		
	}
});


function tableInit(){
	//获取table元素，调用jqGird Ui函数 对象作为参数{}
	$("#jqGrid").jqGrid({
		url:"${pageContext.request.contextPath}/room/list",//请求的地址
		datatype:'json',//服务器返回的数据类型
		mtype:'post',	//请求方式
		postData:{},	//请求提交的参数
		colModel:[
		          {
      				  label:'处理状态',
    				  name:'status',
    				  width:80,
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
		        	  label:'房间ID',
		        	  name:'roomId',
		        	  width:80,
		        	  key:true
		          },
		          {
		        	  label:'公寓ID',
		        	  name:'apartmentId',
		        	  width:80,
		        	 
		          },
		          
		         
		          {
		        	  label:'所在地区',
		        	  name:'apartments',
		        	  width:150,
		        	  formatter:function(value,opt,row){
		        		 return value[0].city;
		        	 	 }
		          },
		          {
		        	  label:'详细地址',
		        	  name:'apartments',
		        	  width:120,
		        	  formatter:function(value,opt,row){
			        		 return value[0].location;
			         	 }
		          },
		          {
		        	  label:'房源户型',
		        	  name:'apartments',
		        	  width:100,
		        	  formatter:function(value,opt,row){
			        		 return value[0].apartmentType;
			        	  }
		        	 
		          },
		          {
		        	  label:'出租类型',
		        	  name:'apartments',
		        	  width:80,
		        	  formatter:function(value,opt,row){
		        		  if(value[0].rentType == 1){
		        			  return "整租";
		        		  }else if(value[0].rentType == 2){
		        			  return "合租";
		        		  }
		        	  }
		          },
		          
		          {
		        	  label:'申请时间',
		        	  name:'createTime',
		        	  width:120,
		          },
		          {
		        	  label:'处理时间',
		        	  name:'passTime',
		        	  width:120,
		          }
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
Calendar.setup({
	inputField : "createTime",
	ifFormat : "%Y-%m-%d",
	showsTime : false,
	timeFormat : "24"
	});

</script>
</body>

</html>