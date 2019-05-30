<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>公寓出租-后台管理-房源价格查询</title>

</head>
<body>
    <div id="myapp">
    	<!-- 列表区 -->
    	<div v-show="show">
    	<!-- 条件查询区域 -->
		<form class="form-horizontal">
			<table class="form_table">
				
				<tr>
					<td>房间ID：</td>
					<td><input type="text" name="roomId" id="roomId"  maxlength="8" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();"></td>
					<td>公寓ID：</td>
					<td><input type="text" name="apartmentId" id="apartmentId"  maxlength="8" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();"></td>
					<td >出租类型：</td>
					<td ><select name="rentType" id="rentType"  style="width:100%;text-align: center;text-align-last: center;">
						<option value="" >-请选择-</option>
						<option value="1"  <c:if test="${formData.rentType==1 }">selected='selected'</c:if>>整租</option>
						<option value="2" <c:if test="${formData.rentType==2}">selected='selected'</c:if> >合租</option>
						</select>
					</td>
					
				</tr>
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
					<td>
						<input type="reset" value="重置" class="btn btn-primary"/>
						<a href="javascript:void(0);" v-on:click="query" class="btn btn-primary" >查询</a>
					</td>
				</tr>
			</table>
			
		</form>
		<!-- 按钮 -->
      	<div class="grid-btn">
			<!-- 房源价格管理员只需要查询即可！无需增删改 -->				
		</div>
		<p></p>
		<!-- 2、展示数据的table区 -->
		<table id="jqGrid"></table>
		<!-- 3、分页区 -->
		<div id="jqGridPager"></div>
		</div>
		<!-- 修改新增区域无  房源价格管理员只需要查询即可！无需增删改	-->
		
    </div>
</body>
<script type="text/javascript"  >
$(function(){
	tableInit();
	$("#distpicker").distpicker();


})
 	
var vm = new Vue({
	el:"#myapp",
	data:{
		show:true,//show是否隐藏的值的绑定
		member:{}	//新增修改数据对象，绑定对象
	},
	methods:{
		query:function(){//查询方法
			
			vm.show = true;//页面区域交替显示开关
			var name1 = $("#eprovinceName").val();
			var name2 = $("#ecityName").val();
			var name3 = $("#edistrictName").val();
			var cname = name1+name2+name3;
			
			$("#jqGrid").jqGrid("setGridParam",{
				//只需要传递查询数据，只需要指定一个属性
				postData:{
					city:cname,
					location:$("#location").val(),
					roomId:$("#roomId").val(),
					apartmentId:$("#apartmentId").val(),
					rentType:$("#rentType").val()
					
				}
			}).trigger("reloadGrid");//设置reloadGrid重新加载事件
		}
	}
});
function tableInit(){
	//获取table元素，调用jqGird Ui函数 对象作为参数{}
	$("#jqGrid").jqGrid({
		url:"${pageContext.request.contextPath}/room/pricelist",//请求的地址
		datatype:'json',//服务器返回的数据类型
		mtype:'post',	//请求方式
		postData:{},	//请求提交的参数
		colModel:[
		          {
		        	  label:'房源ID',
		        	  name:'roomId',
		        	  width:100,
		        	  key:true
		          },
		          {
		        	  label:'公寓ID',
		        	  name:'apartmentId',
		        	  width:100,
		        	 
		          },
		          {
		        	  label:'房号(名)',
		        	  name:'roomName',
		        	  width:70,
		        	 
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
		        	  label:'月租',
		        	  name:'monthPrice',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  return value+"元";
		        	  }
		          },
		          {
		        	  label:'季租',
		        	  name:'seasonPrice',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  return value+"元";
		        	  }
		          },
		          {
		        	  label:'半年租',
		        	  name:'halfYearPrice',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  return value+"元";
		        	  }
		          },
		          {
		        	  label:'年租',
		        	  name:'yearPrice',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  return value+"元";
		        	  }
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
		        	  label:'审批时间',
		        	  name:'passTime',
		        	  width:180,
		        	 
		          }
		          
		          ],
		viewrecoders:true,//定义是否要显示的行
		height:296,//表格的高度
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
</html>