<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>公寓出租-后台管理-入住信息登记</title>
<style>
* {
	margin: 0;
	padding: 0;
}

ul, ol {
	list-style: none;
}

body {
	font-family: "Helvetica Neue", Helvetica, Arial, "Lucida Grande",
		sans-serif;
}

.tab-head {
	margin-left: 120px;
	margin-bottom: 10px;
}

.tab-content {
	clear: left;
	display: none;
}

h2 {
	cursor:pointer;
	border-bottom: solid #02aaf1 2px;
	width: 200px;
	height: 25px;
	margin: 0;
	float: left;
	text-align: center;
	font-size: 16px;
}

.selected {
	color: #FFFFFF;
	background-color: #02aaf1;
}

.show {
	clear: left;
	display: block;
}

.hidden {
	display: none;
}

.new-btn-login-sp {
	padding: 1px;
	display: inline-block;
	width: 75%;
}

.new-btn-login {
	background-color: #02aaf1;
	color: #FFFFFF;
	font-weight: bold;
	border: none;
	width: 50%;
	height: 30px;
	border-radius: 5px;
	font-size: 16px;
}

#main {
	width: 100%;
	margin: 0 auto;
	font-size: 14px;
}

.red-star {
	color: #f00;
	width: 10px;
	display: inline-block;
}

.null-star {
	color: #fff;
}

.content {
	margin-top: 5px;
}

.content dt {
	width: 100px;
	display: inline-block;
	float: left;
	margin-left: 20px;
	color: #666;
	font-size: 13px;
	margin-top: 8px;
}

.content dd {
	margin-left: 120px;
	margin-bottom: 5px;
}

.content dd input {
	width: 85%;
	height: 28px;
	border: 0;
	-webkit-border-radius: 0;
	-webkit-appearance: none;
}

#foot {
	margin-top: 10px;
	position: absolute;
	bottom: 15px;
	width: 100%;
}

.foot-ul {
	width: 100%;
}

.foot-ul li {
	width: 100%;
	text-align: center;
	color: #666;
}

.note-help {
	color: #999999;
	font-size: 12px;
	line-height: 130%;
	margin-top: 5px;
	width: 100%;
	display: block;
}

#btn-dd {
	margin: 20px;
	text-align: center;
}

.foot-ul {
	width: 100%;
}

.one_line {
	display: block;
	height: 1px;
	border: 0;
	border-top: 1px solid #eeeeee;
	width: 100%;
	margin-left: 20px;
}

.am-header {
	display: -webkit-box;
	display: -ms-flexbox;
	display: box;
	width: 100%;
	position: relative;
	padding: 7px 0;
	-webkit-box-sizing: border-box;
	-ms-box-sizing: border-box;
	box-sizing: border-box;
	background: #1D222D;
	height: 50px;
	text-align: center;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	box-pack: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	box-align: center;
}

.am-header h1 {
	-webkit-box-flex: 1;
	-ms-flex: 1;
	box-flex: 1;
	line-height: 18px;
	text-align: center;
	font-size: 18px;
	font-weight: 300;
	color: #fff;
}
</style>
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
				<a class="btn btn-primary" @click="pay"><i class="fa fa-paypal"></i>&nbsp;缴费</a>
				
		</div>
		<p></p>
		<!-- 2、展示数据的table区 -->
		<table id="jqGrid"></table>
		<!-- 3、分页区 -->
		<div id="jqGridPager"></div>
		</div>
		<!-- 支付区域 -->
		<div v-show="!shows" class="panel panel-default" id="maindiv">
			 <div id="main">
		<div id="tabhead" class="tab-head">
			<h2 id="tab1" class="selected" name="tab">付 款</h2>
			<h2 id="tab2" name="tab">交 易 查 询</h2>
			<h2 id="tab3" name="tab">退 款</h2>
			<h2 id="tab4" name="tab">退 款 查 询</h2>
			<h2 id="tab5" name="tab">交 易 关 闭</h2>
		</div>
		<form name=alipayment action=alipay.trade.page.pay.jsp method=post target="_blank">
			<div id="body1" class="show" name="divcontent">
			
				<dl class="content">
					<dt>商户订单号 ：</dt>
					<dd>
						<input id="WIDout_trade_no"  name="WIDout_trade_no" readonly="readonly"/>
					</dd>
					<hr class="one_line">
					<dt>订单名称 ：</dt>
					<dd>
						<input id="WIDsubject"  name="WIDsubject" />
					</dd>
					<hr class="one_line">
					<dt>付款金额 ：</dt>
					<dd>
						<input id="WIDtotal_amount"  name="WIDtotal_amount" readonly="readonly"/>
					</dd>
					<hr class="one_line">
					<dt>支付状态：</dt>
					<dd>
						<input id="WIDbody"  name="WIDbody" readonly="readonly"/>
						<input id="WIDintake_id" name="WIDintake_id" type="hidden"/>
						<input id="WIDroom_id" name="WIDroom_id" type="hidden"/>
					</dd>
					<hr class="one_line">
					<dt></dt>
					<dd id="btn-dd">
							<table class="form_table">
								<tr >
									<td width="500px"><button class="new-btn-login" type="submit" style="text-align: center;">付 款</button></td>
									<!-- <td width="500px"><a href="javascript:void(0);" v-on:click="fukuan" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">付 款</a></td>	 -->								
									<td width="500px"><a href="javascript:void(0);" v-on:click="fanhui" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">返 回</a></td> 							
								</tr>
							</table>
						 <span class="note-help">如果您点击“付款”按钮，即表示您同意该次的执行操作。</span>
					</dd>
				</dl>
			</div>
		</form>
		
		<form name=tradequery action=alipay.trade.query.jsp method=post  target="_blank">
			<div id="body2" class="tab-content" name="divcontent">
				<dl class="content">
					<dt>商户订单号 ：</dt>
					<dd>
						<input id="WIDTQout_trade_no" name="WIDTQout_trade_no" />
					</dd>
					<hr class="one_line">
					<dt>支付宝交易号 ：</dt>
					<dd>
						<input id="WIDTQtrade_no" name="WIDTQtrade_no" />
					</dd>
					<hr class="one_line">
					<dt></dt>
					<dd id="btn-dd">
						<table class="form_table">
								<tr >
									<td width="500px"><button class="new-btn-login" type="submit" style="text-align: center;">交易查询</button></td>
									<!-- <td width="500px"><a  href="javascript:void(0);" v-on:click="jyquery" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">交易查询</a></td> -->									
									<td width="500px"><a href="javascript:void(0);" v-on:click="fanhui" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">返 回</a></td> 							
								</tr>
						</table>
						<span class="note-help">商户订单号与支付宝交易号二选一，如果您点击“交易查询”按钮，即表示您同意该次的执行操作。</span>
					</dd>
				</dl>
			</div>
		</form>
		<form name=traderefund target="_blank">
			<div id="body3" class="tab-content" name="divcontent">
				<dl class="content">
					<dt>商户订单号 ：</dt>
					<dd>
						<input id="WIDTRout_trade_no" name="WIDTRout_trade_no" />
					</dd>
					<hr class="one_line">
					<dt>支付宝交易号 ：</dt>
					<dd>
						<input id="WIDTRtrade_no" name="WIDTRtrade_no" />
					</dd>
					<hr class="one_line">
					<dt>退款金额 ：</dt>
					<dd>
						<input id="WIDTRrefund_amount" name="WIDTRrefund_amount" />
					</dd>
					<hr class="one_line">
					<dt>退款原因 ：</dt>
					<dd>
						<input id="WIDTRrefund_reason" name="WIDTRrefund_reason" />
					</dd>
					<hr class="one_line">
					<dt>退款请求号 ：</dt>
					<dd>
						<input id="WIDTRout_request_no" name="WIDTRout_request_no" />
					</dd>
					<hr class="one_line">
					<dt></dt>
					<dd id="btn-dd">
						<table class="form_table">
								<tr >
									<!-- <td width="500px"><a href="javascript:void(0);" v-on:click="tuikuan" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">退 款</a></td> -->									
									<td width="500px"><a href="javascript:void(0);" v-on:click="fanhui" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">返 回</a></td> 							
								</tr>
							</table>
						<span class="note-help">商户订单号与支付宝交易号二选一，如果您点击“退款”按钮，即表示您同意该次的执行操作。</span>
					</dd>
				</dl>
			</div>
		</form>
		<form name=traderefundquery target="_blank">
			<div id="body4" class="tab-content" name="divcontent">
				<dl class="content">
					<dt>商户订单号 ：</dt>
					<dd>
						<input id="WIDRQout_trade_no" name="WIDRQout_trade_no" />
					</dd>
					<hr class="one_line">
					<dt>支付宝交易号 ：</dt>
					<dd>
						<input id="WIDRQtrade_no" name="WIDRQtrade_no" />
					</dd>
					<hr class="one_line">
					<dt>退款请求号 ：</dt>
					<dd>
						<input id="WIDRQout_request_no" name="WIDRQout_request_no" />
					</dd>
					<hr class="one_line">
					<dt></dt>
					<dd id="btn-dd">
						<table class="form_table">
								<tr >
									<!-- <td width="500px"><a href="javascript:void(0);" v-on:click="tkquery" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">退款查询</a></td> -->									
									<td width="500px"><a href="javascript:void(0);" v-on:click="fanhui" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">返 回</a></td> 							
								</tr>
						</table>
						 <span class="note-help">商户订单号与支付宝交易号二选一，如果您点击“退款查询”按钮，即表示您同意该次的执行操作。</span>
					</dd>
				</dl>
			</div>
		</form>
		<form name=tradeclose target="_blank">
			<div id="body5" class="tab-content" name="divcontent">
				<dl class="content">
					<dt>商户订单号 ：</dt>
					<dd>
						<input id="WIDTCout_trade_no" name="WIDTCout_trade_no" />
					</dd>
					<hr class="one_line">
					<dt>支付宝交易号 ：</dt>
					<dd>
						<input id="WIDTCtrade_no" name="WIDTCtrade_no" />
					</dd>
					<hr class="one_line">
					<dt></dt>
					<dd id="btn-dd">
						<table class="form_table">
								<tr >
									<!-- <td width="500px"><a href="javascript:void(0);" v-on:click="payclose" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">关闭交易</a></td> -->									
									<td width="500px"><a href="javascript:void(0);" v-on:click="fanhui" class="btn btn-primary" style="background-color:#02aaf1;width:300px;">返 回</a></td> 							
								</tr>
						</table>
						<span class="note-help">商户订单号与支付宝交易号二选一，如果您点击“交易关闭”按钮，即表示您同意该次的执行操作。</span>
					</dd>
				</dl>
			</div>
		</form>
		
		<div id="foot">
			<ul class="foot-ul">
				<li>该页面由支付宝版权所有 2015-2018 ALIPAY.COM</li>
			</ul>
		</div>
	</div>
			
		</div>
		<!-- 支付区域结束 -->
    </div>
</body>
<script type="text/javascript"  >
$(function(){
	tableInit();
	
})
	var tabs = document.getElementsByName('tab');
	var contents = document.getElementsByName('divcontent');
	
	(function changeTab(tab) {
	    for(var i = 0, len = tabs.length; i < len; i++) {
	        tabs[i].onclick = showTab;
	    }
	})();
	
	function showTab() {
	    for(var i = 0, len = tabs.length; i < len; i++) {
	        if(tabs[i] === this) {
	            tabs[i].className = 'selected';
	            contents[i].className = 'show';
	        } else {
	            tabs[i].className = '';
	            contents[i].className = 'tab-content';
	        }
	    }
	}
	
	function AddDataINHTML(a,b,c,d,e,f) {
		
		document.getElementById("WIDout_trade_no").value = a;
		document.getElementById("WIDsubject").value = b;
		document.getElementById("WIDtotal_amount").value = c;
		document.getElementById("WIDintake_id").value = d;
		document.getElementById("WIDroom_id").value = e;
		document.getElementById("WIDbody").value = f;
	}
	function GetDateNow() {
		var vNow = new Date();
		var sNow = "";
		sNow += String(vNow.getFullYear());
		sNow += String(vNow.getMonth() + 1);
		sNow += String(vNow.getDate());
		sNow += String(vNow.getHours());
		sNow += String(vNow.getMinutes());
		sNow += String(vNow.getSeconds());
		sNow += String(vNow.getMilliseconds());
		return sNow;
	}
 
var vm = new Vue({
	el:"#myapp",
	data:{
		shows:true,//show是否隐藏的值的绑定
		member:{},	//新增修改数据对象，绑定对象
		
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
		
		pay:function(){
			var id = getSelectedRow(); //jqgrid设置的key主键
			$.ajax({
				url:"${pageContext.request.contextPath}/intake/info/"+id,
				type:'get',
				contentType:"application/json",
				data:{},
				dataType:'json',
				success:function(data){
					debugger;
					if(data.code == 0){
						var intake = data.info;
						if (intake.compactId==null){
							alert("请先签订合同再进行付款！");
							vm.shows = true;
							return false;
						}else{
							//订单保存
							var sn = GetDateNow();
							var sb = intake.compactId+'号合同房租';
							var mon = intake.money;
							mon = mon*1;
							var camon = intake.cashMoney;
							camon = camon*1;
							var sm = mon+camon;
							var roomid = intake.roomId;
							var intakeid = intake.intakeId;
							var order = {"WIDout_trade_no":sn,
									"WIDsubject":sb,
									"WIDtotal_amount":sm,
									"intakeId":intake.intakeId,
									"roomId":intake.roomId};
							var orderStrJson = JSON.stringify(order);
							$.ajax({
								url:"${pageContext.request.contextPath}/order/savaorder",
								type:'post',
								contentType:"application/json",
								data:orderStrJson, 
								dataType:'json',
								success:function(datas){
									if(datas.code == 0){
										
										var oder = datas.info;
										var sn1 = oder.oderId;
										var sd = oder.payStatus;
										//进行页面数据填写
										AddDataINHTML(sn1,sb,sm,intakeid,roomid,sd);
										alert("已生成订单！");
										vm.shows=false;
									}
								}
							});
							
							
						}
					}if(data.code == 500){
						vm.shows = true;
						return false;
					}
				}
			});
			
		},
		/* jyquery:function(){
			
		},
		tuikuan:function(){
			
		},
		tkquery:function(){
			
		},
		payclose:function(){
			
		}, */
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