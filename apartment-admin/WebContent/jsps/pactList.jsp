<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>公寓出租-后台管理-合同信息管理</title>

</head>
<body>
	<div id="myapp">
		<!-- 列表区 -->
		<div>
			<!-- 条件查询区域 -->
			<form class="form-horizontal">
				<table class="form_table">
					<tr>
						<td>姓&nbsp;名：</td>
						<td><input type="text" name="realname" id="realname"></td>

						<td>证件号：</td>
						<td><input type="text" maxlength="18" name="cardId"
							id="cardId"></td>
						<td><input type="reset" value="重置" class="btn btn-primary" />
							<a href="javascript:void(0);" v-on:click="query"
							class="btn btn-primary">查询</a></td>
					</tr>
				</table>

			</form>
			<!-- 按钮 -->
			<div class="grid-btn">
				<a class="btn btn-primary" @click="addinfo"><i
					class="fa fa-pencil"></i>&nbsp;填写信息</a> <a class="btn btn-primary"
					@click="checkpact"><i class="fa fa-search"></i>&nbsp;查看合同</a>
			</div>
			<p></p>
			<!-- 2、展示数据的table区 -->
			<table id="jqGrid"></table>
			<!-- 3、分页区 -->
			<div id="jqGridPager"></div>

			<div v-show="!show" style="padding-top: 10px">
				<form class="ui-jqgrid">
					<div style="padding-top: 10px; margin: 0 auto;">
						<table class="form_table">
							<caption>
								<a style="color: blue; font-size: 14px; text-decoration: none;">合同信息单</a>
							</caption>
							<tr>
								<td><a
									style="color: red; font-size: 14px; text-decoration: none;">*
								</a>月&nbsp;租&nbsp;金：</td>
								<td><input type="text" name="payMoney" id="payMoney"></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><a
									style="color: red; font-size: 14px; text-decoration: none;">*
								</a>押&nbsp;&nbsp;&nbsp;&nbsp;金：</td>
								<td><input type="text" name="cashMoney" id="cashMoney"></td>
							</tr>
							<tr>
								<td><a
									style="color: red; font-size: 14px; text-decoration: none;">*
								</a>水表底数：</td>
								<td><input type="text" name="waterNum" id="waterNum"></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><a
									style="color: red; font-size: 14px; text-decoration: none;">*
								</a>电表底数：</td>
								<td><input type="text" name="powerNum" id="powerNum"></td>

							</tr>
						</table>

						<div style="padding-top: 10px; padding-bottom: 10px">
							<table align="center">
								<tr>
									<td align="center"><a class="btn btn-primary"
										@click="addpact"><i class="fa fa-refresh"></i>&nbsp;生成合同</a></td>

								</tr>
							</table>
						</div>
					</div>
				</form>
			</div>

	<!-- 合同页面 -->
		<div v-show="!pow" id="hetong">
			<a class="btn btn-primary" @click="previews"><i class="fa fa-print"></i>&nbsp;打印合同</a>
			<!--startprint-->
			<div class="container a4-endwise" id="test"
				style="width: 794px; height: 1123px; border: 1px #000 solid; overflow: hidden; padding-left: 10px; padding-right: 10px; padding-top: 20px; word-break: break-all; text-indent: 2em;">
				<p style="text-align: center; font-size: 30px;">
					<strong>房屋租赁合同</strong>
				</p>
				<p style="text-align: right; font-size: 20px;">第{{pactVo.SCcompactId}}号</p>
				<p style="font-size: 20px;">出租方：{{pactVo.SChouseholder}}(以下简称甲方)</p>
				<p>
				<p style="font-size: 20px;">承租方：{{pactVo.SCrenter}} (以下简称乙方)</p>
				<p></p>
				<p style="font-size: 20px;">一、甲方将位于{{pactVo.SCaddr}}房屋出租给乙方居住使用，租赁期限自{{pactVo.SCstartTime}}到{{pactVo.SCendTime}}。</p>
				<p></p>
				<p style="font-size: 20px;">二、本房屋租金为人民币{{pactVo.SCpayMoney}}元/月，按月结算，每月5日内，乙方向甲方支付租金。</p>
				<p></p>
				<p style="font-size: 20px;">三、乙方租赁期间，水费、电费、由乙方居住而产生的费用由乙方负担。租赁结束时乙方须交清欠费。附：电表底数{{pactVo.SCpowerNum}}度，水表底数{{pactVo.SCwaterNum}}度。</p>
				<p></p>
				<p style="font-size: 20px;">四、乙方同意预交{{pactVo.SCcashMoney}}元作为保证金，合同终止时，房租交清归还乙方。</p>
				<p></p>
				<p style="font-size: 20px;">五、租赁期间，任何一方要求终止合同，须提前两个月通知对方，并偿付对方总剩余月份50%费用违约金；如果甲方转让该房屋，乙方有优先购买权。</p>
				<p></p>
				<p style="font-size: 20px;">六、因租用该房屋所放生的除土地费、大修费以外其他费用，由乙方承担。</p>
				<p></p>
				<p style="font-size: 20px;">七、在承租期间、未经甲方同意，乙方无权转租或转借该房屋；不得改变房屋结构及用途，由于乙方人为原因造成该房屋及其配套设施损坏的，由乙方承担赔偿责任。</p>
				<p></p>
				<p style="font-size: 20px;">八、就本合同发生纠纷，双方协商解决，解决不成，任何一方均有权向人民法院提起诉讼请求司法解决。本合同一式二份，甲乙双方各执一份。自双方签字之日起生效。</p>
				<p></p>
				<p style="font-size: 20px;">九、乙方不得在房屋内从事违法行为，并注重房屋及自身财产和人身安全。如发生违法行为及人身安全事故自行负责。甲方不承担一切法律及民事责任。</p>
				<p></p>
				<p style="font-size: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;甲方签字：</p>
				<p>
				<p style="font-size: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;乙方签字：</p>
				<p></p>
				<p style="font-size: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;盖章处：</p>
				<p style="text-align: right; font-size: 20px;">{{pactVo.SCstartTime}}</p>
			</div>
			<!--endprint-->
		</div>
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
		pow:true,
		member:{},	//新增修改数据对象，绑定对象
		pactVo:{}
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
					realname:$("#realname").val(),
					cardId:$("#cardId").val()
				}
			}).trigger("reloadGrid");//设置reloadGrid重新加载事件
		},
		
		addinfo:function(){
			vm.pow = true;
			vm.pactVo = {};
			var id = getSelectedRow();
	     	$.ajax({
	     		url:"${pageContext.request.contextPath}/intake/info/"+id,
	     		type:'get',
	     		contentType:"application/json",
	     		data:{},
	     		dataType:'json',
	     		success:function(data){
	     			if(data.code == 0){
						//绑定到vm中的apartmentVo对象中。
						var intakeMoney = data.info;
						if(intakeMoney.compactId != null){
							alert("该记录已存在合同，详情点击查看合同！");
							vm.show = true;
						}
						document.getElementById("payMoney").value = intakeMoney.money;
					}if(data.code == 500){
						vm.show = true;
					}
	     		}
	     	}); 
			vm.show=false;
		},
		checkpact:function(){
			vm.show = true;
			vm.pow = true;
			vm.pactVo = {};
			var id = getSelectedRow();
			var cr = {"id":id};
			var crJson = JSON.stringify(cr);
	     	$.ajax({
	     		url:"${pageContext.request.contextPath}/intake/checkpact",
	     		type:'post',
	     		contentType:"application/json",
	     		data:crJson,
	     		dataType:'json',
	     		success:function(data){
	     			if(data.code == 0){
						//绑定到vm中的apartmentVo对象中。
						vm.pactVo = data.info;
						vm.pow = false;
					}if(data.code == 500){
					}
					
	     		}
	     	}); 
	     	
	     	
		},
		addpact:function(){
			var id = getSelectedRow();
			var crpayMoney = $("#payMoney").val();
			var crcashMoney =$("#cashMoney").val();
			var crwaterNum =$("#waterNum").val();
			var crpowerNum =$("#powerNum").val();
			var cr = {"crpayMoney":crpayMoney,"crcashMoney":crcashMoney,"crwaterNum":crwaterNum,"crpowerNum":crpowerNum,"id":id};
			var crJson = JSON.stringify(cr);
	     	$.ajax({
	     		url:"${pageContext.request.contextPath}/intake/addpact",
	     		type:'post',
	     		contentType:"application/json",
	     		data:crJson,
	     		dataType:'json',
	     		/* beforeSend: function(){       //ajax发送请求时的操作，得到请求结果前有效
	     			$('#myModal').modal({							
	     				backdrop:'static'      //设置模态框之外点击无效
	     			});						
	     			$('#myModal').modal('show');   //弹出模态框					
	     		},					
	     		complete: function(){            //ajax得到请求结果后的操作						
	     			$('#myModal').modal('hide');  //隐藏模态框
	     		}, */
	     		
	     		success:function(data){
	     			if(data.code == 0){
	     				vm.pactVo = data.info;
	     				vm.pow = false;
	     				/* preview(); */
					}if(data.code == 500){
						alert("生成合同失败，请联系管理员！");
					}
	     		}
	     	}); 
		},
		previews:function(){
			preview();
		}
		
	}
});

function preview()
{	
	debugger;
    bdhtml=window.document.body.innerHTML;//获取当前页的html代码
    sprnstr= "startprint-->";//设置打印开始区域
    eprnstr= "<!--endprint-->";//设置打印结束区域
    prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+15); //从开始代码向后取html
    prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
    var ow = window.open();    //新窗口打开
    ow.document.write(prnhtml);
    ow.print();
    
    /* window.document.body.innerHTML=prnhtml;
    window.print();
    window.document.body.innerHTML=bdhtml; */
}

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
		        	  label:'出租时间',
		        	  name:'rentTime',
		        	  width:120,
		        	  
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
		height:115,//表格的高度
		rowNum:3,//表格展示的行数
		rowList:[3,8,10,20], //表格可以改变的记录数
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