<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>公寓出租-后台管理-入住列表查询</title>

</head>
<body>
    <div id="myapp">
    	<!-- 列表区 -->
    	<div v-show="shows">
    	<!-- 条件查询区域 -->
		<form class="form-horizontal">
			<table class="form_table">
				<tr>
					<td>姓&nbsp;名：</td>
					<td><input type="text" name="realname" id="realname"></td>
					
					<td>证件号：</td>
					<td><input type="text" maxlength="18"  name="cardId" id="cardId"></td>
					<td>
						<input type="reset" value="重置" class="btn btn-primary"/>
						<a href="javascript:void(0);" v-on:click="query" class="btn btn-primary" >查询</a>
					</td>
				</tr>
			</table>
			
		</form>
		<!-- 按钮 -->
      	<div class="grid-btn">
				<!-- <a class="btn btn-primary" @click="pay"><i class="fa fa-paypal"></i>&nbsp;缴费</a> -->
				
		</div>
		<p></p>
		<!-- 2、展示数据的table区 -->
		<table id="jqGrid"></table>
		<!-- 3、分页区 -->
		<div id="jqGridPager"></div>
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
		shows:true,//show是否隐藏的值的绑定
		member:{}	//新增修改数据对象，绑定对象
		
	},
	methods:{
		query:function(){//查询方法
			//alert("1");
			/*1.获取查询条件数据
			 *2.访问后台控制方法/member/list
			 *3.接收数据，加载jqgrid
			 *$("#jqGrid").jqGrid("setGridParam",{}).trigger("reloadGrid");
			 * */
			vm.shows = true;//页面区域交替显示开关
			$("#jqGrid").jqGrid("setGridParam",{
				//只需要传递查询数据，只需要指定一个属性
				postData:{
					realname:$("#realname").val(),
					cardId:$("#cardId").val()
				}
			}).trigger("reloadGrid");//设置reloadGrid重新加载事件
		},
		
		
		fanhui:function(){
			var orderId = $("#WIDout_trade_no").val();
			var intakeId =  $("#WIDintake_id").val();
			var roomId =  $("#WIDroom_id").val();
			var oder = {"orderId":orderId,"intakeId":intakeId,"WIDbody":WIDbody,"roomId":roomId};
			var orderStrJson = JSON.stringify(oder);
			$.ajax({
				url:"${pageContext.request.contextPath}/order/fanhui",
				type:'post',
				contentType:"application/json",
				data:orderStrJson,
				dataType:'json',
				success:function(data){
					if(data.code==0){
						vm.query();
					}else if(data.code==0){
						alert(data.msg);
					}
				}
			});
			
			vm.shows=true;
		},
		saveOrUpdate:function(){
			
		}
		
	}
});

function tableInit(){
	//获取table元素，调用jqGird Ui函数 对象作为参数{}
	$("#jqGrid").jqGrid({
		url:"${pageContext.request.contextPath}/intake/paylist",//请求的地址
		datatype:'json',//服务器返回的数据类型
		mtype:'post',	//请求方式
		postData:{},	//请求提交的参数
		colModel:[
		          {
		        	  label:'事件ID',
		        	  name:'intakeId',
		        	  width:80,
		        	  hidden:true,
		        	  key:true
		          },
		          {
		        	  label:'房间ID',
		        	  name:'roomId',
		        	  width:80
		          },
		          {
		        	  label:'房主ID',
		        	  name:'householderId',
		        	  width:80
		          },
		          {
		        	  label:'入住日期',
		        	  name:'intakeTime',
		        	  width:100,
		        	  formatter:function(value,opt,row){
    					  return value.substring(0,10);
    					 
  			  		  }
		          },
		          {
		        	  label:'租客ID',
		        	  name:'rentId',
		        	  width:80
		          },
		          {
		        	  label:'租客姓名',
		        	  name:'realname',
		        	  width:100
		          },
		          {
		        	  label:'支付状态',
		        	  name:'payStatus',
		        	  width:100,
		        	  formatter:function(value,opt,row){
    					  if(value == 0){
    						  return '<a style="color:red;font-size: 14px;text-decoration:none;">待支付</a>';
    					  }else if(value == 1){
    						  return '<a style="color:green;font-size: 14px;text-decoration:none;">已支付</a>';
    					  }
  			  		  }
		        	 
		          },
		          {
		        	  label:'下次缴费日期',
		        	  name:'nextPayTime',
		        	  width:100,
		        	  formatter:function(value,opt,row){
    					  return value.substring(0,10);
    					 
  			  		  }
		          },
		          {
		        	  label:'合同详情',
		        	  name:'compactId',
		        	  width:100,
		        	  formatter:function(value,opt,row){
		        		  if(value != null){
		        			  return '<a style="color:blue;font-size: 14px;text-decoration:none;">'+value+'</a>' ;
		        		  }else{
		        			  return '<a style="color:red;font-size: 14px;text-decoration:none;">暂无合同</a>' ;
		        		  }
    					
    					 
  			  		  }
		          }
		         
		          ],
		viewrecoders:true,//定义是否要显示的行
		height:296,//表格的高度
		rowNum:8,//表格展示的行数
		rowList:[8,10,20], //表格可以改变的记录数
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