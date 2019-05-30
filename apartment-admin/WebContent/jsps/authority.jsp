<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>公寓出租-后台管理-权限管理</title>

</head>
<body>
     <div id="adapp">
    	<!-- boss管理员区 -->
    	<div>
    		
			
		</form>
		<!-- 按钮 -->
      	<div class="grid-btn">
				<a class="btn btn-primary" ><i class="fa fa-plus"></i>&nbsp;新增</a>
				<a class="btn btn-primary" ><i class="fa fa-pencil-square-o"></i>&nbsp;修改</a>
				<a class="btn btn-primary"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
		</div>
		<p></p>
		<!-- 2、展示数据的table区 -->
		<table id="jqGrid"></table>
		<!-- 3、分页区 -->
		<div id="jqGridPager"></div>
		</div>
		<!-- 普通管理员区 -->
		<div class="panel panel-default">
			
		</div>
    </div>
</body>
<script type="text/javascript"  >
$(function(){
	var falg = true;
	powerInit();
	tableInit();
	
});
function powerInit(){
	var jsonStr = sessionStorage.getItem("admin");
	adminEnti = JSON.parse(jsonStr);
	var name = adminEnti.name;
	var jobId = adminEnti.jobId;
	var power = adminEnti.power;
	if(power==3){
		flag = true;
		alert(name+"您是超级管理员，您可在此页面审批权限！");
	}else{
		flag = false;
		alert(name+"您是普通管理员，无权限操作！",function(){
			window.location.href = "main.jsp";
		});
	}
}


var vm = new Vue({
	el:"#adapp",
	data:{
		show:true,//show是否隐藏的值的绑定
		admin:{}	//新增修改数据对象，绑定对象
	},
	methods:{
		query:function(){//查询方法
			vm.show = true;//页面区域交替显示开关
			$("#jqGrid").jqGrid("setGridParam",{
				//只需要传递查询数据，只需要指定一个属性
				postData:{
					
				}
			}).trigger("reloadGrid");//设置reloadGrid重新加载事件
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
			confirm("确定删除所选账号吗？",function(){
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
			
			if(vm.member.memberId==0){
				url="save";
			}else{
				url="update";
			}
			var memberStrJson = JSON.stringify(vm.member);
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
	if(flag==false){
		return;
	}else{
		//获取table元素，调用jqGird Ui函数 对象作为参数{}
		$("#jqGrid").jqGrid({
			url:"${pageContext.request.contextPath}/adminLogin/list",//请求的地址
			datatype:'json',//服务器返回的数据类型
			mtype:'post',	//请求方式
			postData:{},	//请求提交的参数
			colModel:[
			          {
			        	  label:'管理员ID',
			        	  name:'adminId',
			        	  width:100,
			        	  key:true
			          },
			          {
			        	  label:'工号',
			        	  name:'adminJobId',
			        	  width:100,
			        	 
			          },
			          {
			        	  label:'账号',
			        	  name:'adminAccount',
			        	  width:100
			          },
			          {
			        	  label:'密码',
			        	  name:'adminPassword',
			        	  width:100
			          },
			          {
			        	  label:'姓名',
			        	  name:'adminName',
			        	  width:100,
			        	 
			          },
			          
			          {
			        	  label:'权限',
			        	  name:'power',
			        	  width:100,
			        	  formatter:function(value,opt,row){
			        		 if(value==1){
			        			 return '初级管理员';
			        		 }else if(value==2){
			        			 return '中级管理员';
			        		 }else{
			        			 return '高级管理员';
			        		 }
			        	  }
			        	 
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
	}
	

</script>
</html>