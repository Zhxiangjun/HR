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
    	<div v-show="show">
    	<!-- 条件查询区域 -->
		<form class="form-horizontal">
			<table class="form_table">
				<tr>
					<td>账&nbsp;号：</td>
					<td><input type="text" name="account" id="account"></td>
					<td>用户名：</td>
					<td><input type="text" name="username" id="username"></td>
					
				</tr>
				<tr>
					<td>性&nbsp;别：</td>
					<td><select name="sex" id="sex"  style="width:100%;text-align: center;text-align-last: center;">
						<option value="" >-请选择-</option>
						<option value="男"  <c:if test="${formData.sex=='男' }">selected='selected'</c:if>> 男</option>
						<option value="女" <c:if test="${formData.sex=='女' }">selected='selected'</c:if> >女</option>
						</select>
					</td>
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
				<a class="btn btn-primary" @click="add"><i class="fa fa-plus"></i>&nbsp;新增</a>
				<a class="btn btn-primary" @click="update"><i class="fa fa-pencil-square-o"></i>&nbsp;修改</a>
				<a class="btn btn-primary" @click="del"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
		</div>
		<p></p>
		<!-- 2、展示数据的table区 -->
		<table id="jqGrid"></table>
		<!-- 3、分页区 -->
		<div id="jqGridPager"></div>
		</div>
		<!-- 修改新增区域 -->
		<div v-show="!show" class="panel panel-default">
			<form class="form-horizontal" style="padding: 10px">
				
				<div class="form-group">
					<div class="col-sm-2 control-label">用户账号</div>
					<div class="col-sm-10">
						<input type="text" class="form-control"  v-model="member.memberAccount"
							  placeholder="用户账号" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-2 control-label">用户密码</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" v-model="member.memberPassword"
							placeholder="用户密码" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-2 control-label">用户名</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" v-model="member.username"
							placeholder="用户名" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-2 control-label">电话</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" v-model="member.tel"
							 placeholder="电话" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-2 control-label">真实姓名</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" v-model="member.realname"
							placeholder="真实姓名" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-2 control-label">性别</div>
					<div class="col-sm-10">
						
						<select name="sex" class="form-control" v-model="member.memberSex" placeholder="性别" >
						<option value="" >&nbsp;</option>
						<option value="男"  <c:if test="${formData.sex=='男' }">selected='selected'</c:if>> 男</option>
						<option value="女" <c:if test="${formData.sex=='女' }">selected='selected'</c:if> >女</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-2 control-label">身份证号</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" v-model="member.cardId"
							placeholder="身份证号" />
					</div>
				</div>
				<div class="form-group" style="display: none;">
					<div class="col-sm-2 control-label">注册时间</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" v-model="member.createTime"
							placeholder="注册时间" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-2 control-label"></div>
					<input type="button" class="btn btn-primary" @click="saveOrUpdate" value="确定" /> &nbsp;&nbsp;
					<input type="button" @click="cquery" class="btn btn-warning" value="返回" />
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
		show:true,//show是否隐藏的值的绑定
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
			vm.show = true;//页面区域交替显示开关
			$("#jqGrid").jqGrid("setGridParam",{
				//只需要传递查询数据，只需要指定一个属性
				postData:{
					memberAccount:$("#account").val(),
					username:$("#username").val(),
					memberSex:$("#sex").val(),
					cardId:$("#cardId").val()
				}
			}).trigger("reloadGrid");//设置reloadGrid重新加载事件
		},
		cquery:function(){/* 清空之前数据 */
			vm.member.memberAccount="";
			vm.member.memberPassword="";
			vm.member.username="";
			vm.member.tel="";
			vm.member.realname="";
			vm.member.memberSex="";
			vm.member.cardId="";
			vm.query();
		},
		add:function(){
			//清空当前表单，v-model的数据同步方式(数据回显)
			vm.member.memberId=0;
			vm.show = false;	
		},
		update:function(){
			//点击修改按钮，把选中的记录 对应的数据库，同步到vm.member中
			var id = getSelectedRow(); //jqgrid设置的key主键
			/* if(id == undefined ){
				alert("请选择要修改的数据！");
			} */
			//ajax异步获取 要修改的这条记录
			$.ajax({
				url:"${pageContext.request.contextPath}/member/info/"+id,
				type:'get',
				contentType:"application/json",
				data:{},
				dataType:'json',
				success:function(data){
					if(data.code == 0){
						//绑定到vm中的member对象中。
						vm.member = data.info;
						vm.show = false;
					}
				}
			});
		},
		del:function(){
			var ids = getSelectedRows();
			if(ids==null){
				return;
			}
			confirm("确定删除所选记录吗？",function(){
				$.ajax({
					url:"${pageContext.request.contextPath}/member/del",
					data:JSON.stringify(ids), 	//把ids转化成json格式字符串
					type:'post',
					dataType:"json",
					contentType:"application/json",
					success:function(data){
						if(data.code==0){
							alert("删除成功",vm.query());
						}if(data.code==500){
							alert("异常");
						}
						
					}
				});
			});
		},
		saveOrUpdate:function(){
			//alert("1");
			//首先判断是新增还是修改
			var url;
			if(!vm.member.memberAccount){
				alert("账号不能为空！");
				return false;
			}
			if(!vm.member.memberPassword){
				alert("密码不能为空！");
				return false;
			}
			if(!vm.member.username){
				alert("用户名不能为空！");
				return false;
			}
			if(!vm.member.tel){
				alert("电话不能为空！");
				return false;
			}
			if(!vm.member.realname){
				alert("真实姓名不能为空！");
				return false;
			}
			if(!vm.member.memberSex){
				alert("性别不能为空！");
				return false;
			}
			if(!vm.member.cardId){
				alert("身份证号不能为空！");
				return false;
			}
			if(vm.member.memberId==0){
				url="save";
				vm.member.createTime=nowTime();
				var memberStrJson = JSON.stringify(vm.member);
			}else{
				url="update";
				var memberStrJson = JSON.stringify(vm.member);
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/member/"+url,
				type:'post',
				contentType:'application/json',
				data:memberStrJson, //传递一个保存的对象(是一个json格式)
				dataType:'json',
				success:function(data){
					if(data.code==0){
						alert("操作成功", vm.cquery(), vm.query());//显示成功列表页面
						
					}
				}
			});
		}
	}
});
function tableInit(){
	//获取table元素，调用jqGird Ui函数 对象作为参数{}
	$("#jqGrid").jqGrid({
		url:"${pageContext.request.contextPath}/member/list",//请求的地址
		datatype:'json',//服务器返回的数据类型
		mtype:'post',	//请求方式
		postData:{},	//请求提交的参数
		colModel:[
		          {
		        	  label:'用户ID',
		        	  name:'memberId',
		        	  width:80,
		        	  key:true
		          },
		          {
		        	  label:'用户账号',
		        	  name:'memberAccount',
		        	  width:100
		          },
		          {
		        	  label:'用户密码',
		        	  name:'memberPassword',
		        	  width:100
		          },
		          {
		        	  label:'用户名',
		        	  name:'username',
		        	  width:100,
		        	 
		          },
		          {
		        	  label:'联系电话',
		        	  name:'tel',
		        	  width:100,
		        	 
		          },
		          {
		        	  label:'真实姓名',
		        	  name:'realname',
		        	  width:100,
		        	 
		          },
		          {
		        	  label:'性别',
		        	  name:'memberSex',
		        	  width:50
		          },
		          {
		        	  label:'身份证号',
		        	  name:'cardId',
		        	  width:200
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
/*
 * 获取当前时间（考虑浏览器的兼容性：不同的浏览器自动获取当前时间显示格式不同，此方法可以保证所有浏览器返回与数据库统一格式的数据格式）
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