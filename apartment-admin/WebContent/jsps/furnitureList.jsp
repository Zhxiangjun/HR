<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>公寓出租-后台管理-用户列表管理</title>

</head>
<body>
    <div id="myapp">
    	<!-- 列表区 -->
    	<div>
    	<!-- 条件查询区域 -->
		<form class="form-horizontal">
			<table class="form_table">
				<tr>
					<td><a style="color:red;font-size: 14px;text-decoration:none;">* </a> 公寓ID：</td>
					<td><input type="text" maxlength="8" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();" name="apartmentId" id="apartmentId"></td>
					<td>房间ID：</td>
					<td><input type='text' maxlength="8" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();" name="roomId" id="roomId"/></td>
					<td>
						<input type="reset" value="重置" class="btn btn-primary"/>
						<a href="javascript:void(0);" v-on:click="query" class="btn btn-primary" >查询</a>
					</td>
				</tr>
				
			</table>
			
		</form>
		<!-- 按钮 -->
      	<div class="grid-btn">
				<a class="btn btn-primary" @click="queryRoom"><i class="fa fa-search"></i>&nbsp;查看</a> 
				<a class="btn btn-primary" @click="update"><i class="fa fa-pencil-square-o"></i>&nbsp;修改</a>
		</div>
		<p></p>
		<!-- 2、展示数据的table区 -->
		<table id="jqGrid" ></table>
		</div>
		<!-- 3、修改区域 -->
		
		<div v-show="show" style="padding-top: 10px" >
			<form class="ui-jqgrid" >
				<!-- 4.1 、公用配置区-->
				
				
				<!-- 4.2 、独立配置区 -->
				<div style="padding-top: 10px">
					<table align="center">
						<tr>
							<td width="10%"><a>设施配置</a></td>
							<td width="7%" align="right"></i>&nbsp;&nbsp;床&nbsp;&nbsp;：</td>
							<td width="7%"><input type="number" name="pr" id="a01" v-model="furniture.a01"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>沙&nbsp;&nbsp;发：</td>
							<td width="7%"><input type="number" name="pr" id="a02" v-model="furniture.a02"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>衣&nbsp;&nbsp;柜：</td>
							<td width="7%"><input type="number" name="pr" id="a03" v-model="furniture.a03"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>空&nbsp;&nbsp;调：</td>
							<td width="7%"><input type="number" name="pr" id="a04" v-model="furniture.a04"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>冰&nbsp;&nbsp;箱：</td>
							<td width="7%"><input type="number" name="pr" id="a05" v-model="furniture.a05"
								min="0" max="5" step="1"  /></td>
							<td width="7%" align="right"></i>电&nbsp;&nbsp;视：</td>
							<td width="7%"><input type="number" name="pr" id="a06" v-model="furniture.a06"
								min="0" max="5" step="1" /></td>
						</tr>
						
						<tr>
							<td width="10%">&nbsp;</td>
							<td width="7%" align="right"></i>洗衣机：</td>
							<td width="7%"><input type="number" name="pr" id="a07" v-model="furniture.a07"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>热水器：</td>
							<td width="7%"><input type="number" name="pr" id="a08" v-model="furniture.a08"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>燃气灶：</td>
							<td width="7%"><input type="number" name="pr" id="a09" v-model="furniture.a09"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>阳&nbsp;&nbsp;台：</td>
							<td width="7%"><input type="number" name="pr" id="a10" v-model="furniture.a10"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>Wi-Fi&nbsp;：</td>
							<td width="7%"><input type="number" name="pr" id="a11" v-model="furniture.a11"
								min="0" max="5" step="1" /></td>
							<td width="7%" align="right"></i>卫生间：</td>
							<td width="7%"><input type="number" name="pr" id="a12" v-model="furniture.a12"
								min="0" max="5" step="1" /></td>
						</tr>
						
					</table>
					<div style="padding-top: 10px;padding-bottom: 10px">
					<table align="center" >
						<tr>
							<td align="center" >
								<input  type="button" class="btn btn-primary" @click="saveToUpdate" value="保存" disabled="disabled"/>
								<!-- &nbsp;&nbsp; <input type="button" @click="cquery" class="btn btn-warning" value="返回" /> -->
							 </td>
						
						</tr>
					</table>
					</div>
				</div>
			</form>
		</div>
    </div>
</body>
<script type="text/javascript"  >
$(function(){
	tableInit(); 
	
})
 
var vm = new Vue({
	el:"#myapp",
	data:{
		show:false,//show是否隐藏的值的绑定
		furniture:{}	//新增修改数据对象，绑定对象
	},
	methods:{
		query:function(){//查询方法
			//alert("1");
			/*1.获取查询条件数据
			 *2.访问后台控制方法/furniture/list
			 *3.接收数据，加载jqgrid
			 *$("#jqGrid").jqGrid("setGridParam",{}).trigger("reloadGrid");
			 * */
			$("input[name='pr']").attr('readonly','readonly');
			$("input[type='button']").attr('disabled','disabled');
			if($("#apartmentId").val()==null || $("#apartmentId").val() ==""){
				alert("<p align='center'>公寓ID不能为空!</p><p align='center'>请在公寓信息管理中查询您要所需的公寓ID!</p>");
				return false;
			} 
			
			vm.show = false;//页面区域交替显示开关
			$("#jqGrid").jqGrid("setGridParam",{
				//需要传递查询数据，设置URL；
				url:"${pageContext.request.contextPath}/furniture/list",
				datatype:'json',//服务器返回的数据类型
				mtype:'post',	//请求方式
				postData:{
					roomId:$("#roomId").val(),
					apartmentId:$("#apartmentId").val()
				}
			}).trigger("reloadGrid");//设置reloadGrid重新加载事件
		},
		queryRoom:function(){
			$("input[name='pr']").removeAttr('readonly');
			var id = getSelectedRow(); //jqgrid设置的key主键
			$.ajax({
				url:"${pageContext.request.contextPath}/furniture/info/"+id,
				type:'get',
				contentType:"application/json",
				data:{},
				dataType:'json',
				success:function(data){
					if(data.code == 0){
						//绑定到vm中的member对象中。
						vm.furniture = data.info;
					}if(data.code == 500){
						vm.show = false;
					}
				}
			});
			$("input[name='pr']").attr('readonly','readonly');
			$("input[type='button']").attr('disabled','disabled');
			vm.show = true;
		},
		
		update:function(){
			$("input[name='pr']").removeAttr('readonly');
			$("input[type='button']").removeAttr('disabled');
			
			//点击修改按钮，把选中的记录 对应的数据库，同步到vm.member中
			var id = getSelectedRow(); //jqgrid设置的key主键
			
			//ajax异步获取 要修改的这条记录
			$.ajax({
				url:"${pageContext.request.contextPath}/furniture/info/"+id,
				type:'get',
				contentType:"application/json",
				data:{},
				dataType:'json',
				success:function(data){
					if(data.code == 0){
						//绑定到vm中的member对象中。
						vm.furniture = data.info;
					}if(data.code == 500){
						vm.show = false;
					}
				}
			});
			vm.show = true;
		},
		saveToUpdate:function(){
			var memberStrJson = JSON.stringify(vm.furniture);
			$.ajax({
				url:"${pageContext.request.contextPath}/furniture/update",
				type:'post',
				contentType:'application/json',
				data:memberStrJson, //传递一个保存的对象(是一个json格式)
				dataType:'json',
				success:function(data){
					if(data.code==0){
						alert("操作成功", vm.query());//显示成功列表页面
						
					}
				}
			});
		}
	}
});
function tableInit(){
	//获取table元素，调用jqGird Ui函数 对象作为参数{}
	$("#jqGrid").jqGrid({
		url:"#",//请求的地址
		datatype:'json',//服务器返回的数据类型
		mtype:'post',	//请求方式
		postData:{},	//请求提交的参数
		colModel:[
		          {
		        	  label:'配置id',
		        	  name:'furnitureId',
		        	  width:100,
		        	  hidden:true,
		        	  key:true
		          },
		          {
		        	  label:'房间ID',
		        	  name:'roomId',
		        	  align:'center',
		        	  width:100,
		        	  
		          },
		          {
		        	  label:'公寓ID',
		        	  name:'apartmentId',
		        	  align:'center',
		        	  width:100
		          },
		          {
		        	  label:'房号(名)',
		        	  name:'rooms',
		        	  align:'center',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  return value[0].roomName;
		        	  }
		          },
		          {
		        	  label:'出租类型',
		        	  name:'apartments',
		        	  align:'center',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  if(value[0].rentType == 1){
		        			  return "整租";
		        		  }else if(value[0].rentType == 2){
		        			  return "合租";
		        		  }
		        	  }
		          },
		          {
		        	  label:'房间面积',
		        	  name:'rooms',
		        	  align:'center',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		return value[0].roomArea +"m&sup2;"
		        	  }
		          },
		          {
		        	  label:'房主ID',
		        	  name:'apartments',
		        	  align:'center',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  return value[0].memberId;
		        	  }
		        	 
		          },
		          {
		        	  label:'房主姓名',
		        	  name:'members',
		        	  align:'center',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  return value[0].realname;
		        	  }
		          }
		          
		          ],
		viewrecoders:true,//定义是否要显示的行
		height:184,//表格的高度
		rowNum:5,//表格展示的行数
		rownumbers:true,//表格左侧新增一列
		multiselect:true,//是否可以多选
		jsonReader:{//处理后台的数据
			root:"page.rows",//表格数据
			records:"page.records"//总记录数
		},
		prmNames:{//提交参数的
			/* page:"pageNum",
			rows:"pageSize" */
		}
	});
}
/*
 * 获取当前时间（考虑浏览器的兼容性）
 */
function nowTime(){
	var d = new Date(); 
	var year = d.getYear()+1900; 
	var month = d.getMonth()+1; 
	var date = d.getDate(); 
	var day = d.getDay(); 
	var hours = d.getHours(); 
	var minutes = d.getMinutes(); 
	var seconds = d.getSeconds(); 
	var curDateTime= year;
	if(month>9){
		curDateTime = curDateTime +"-"+month;
	}else{
		curDateTime = curDateTime +"-0"+month;
	}
	if(date>9){
		curDateTime = curDateTime +"-"+date;
	}else{
		curDateTime = curDateTime +"-0"+date;
	}
	curDateTime = curDateTime+" ";
	if(hours>9){
		curDateTime = curDateTime +""+hours;
	}else{
		curDateTime = curDateTime +"0"+hours;
	}
	if(minutes>9){
		curDateTime = curDateTime +":"+minutes;
	}else{
		curDateTime = curDateTime +":0"+minutes;
	}
	if(seconds>9){
		curDateTime = curDateTime +":"+seconds;
	}else{
		curDateTime = curDateTime +":0"+seconds;
	}
	return curDateTime; 
}

</script>
</html>