<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>公寓出租-后台管理-登录</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 引入各种CSS样式表 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">    		<!-- 修改自Bootstrap官方Demon-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-change.css">     <!-- 将默认字体从宋体换成微软雅黑 -->  

<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>


</head>
<body >
	<div id="wrap"  style="background-color: transparent; ">
		<div id="top_content">
			<div id="topheader">
				<h1 id="title">
					<a href="#" >公寓出租-后台管理</a>
				</h1>
			</div>
			<div id="navigation"></div>
			<div id="content" style="background-color: transparent; ">
				<p id="whereami"></p>
				<p>&nbsp;</p>
				<h1 style="text-align: center;">管理员登录</h1>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<form onsubmit="false" method="post">
					<table class="form_table">
						<tr>
							<td>用户名:</td>
							<td><input id="account" type="text" name="account" class="inputgri" 
								value="" /></td>
						</tr>
						<tr>
							<td>密码:</td>
							<td><input id="password" type="password" name="password" class="inputgri" /></td>
						</tr>
						<tr>
							<td>验证码:</td>
							<td><input type="text" name="vcode" id="vcode" onblur="checkimg()" onfocus="clearmsg('#imginfo')" class="inputgri" /></td>
							<td><span id="imginfo"></span></td>
						</tr>
						<tr>
							<td></td>
							<td><img id="img" src="${pageContext.request.contextPath}/adminLogin/imgCode">
								<a href="#" onclick="changeImg()">看不清？换一张</a></td>
							
						</tr>

					</table>
					<p>&nbsp;</p>
					<p style="text-align: center;">
						<a class="btn btn-primary" onclick="login()" type="submit">&nbsp;登录&raquo;</a>
					</p>
				</form>
				<input id="flag" type="hidden" value="${param.code}">
				<input id="name" type="hidden" value="${param.page}">
			</div>
		</div>
		<div id="kongge">
		</div>
		 <!-- 底部菜单========================================= -->
	    <nav class="navbar navbar-inverse navbar-fixed-bottom">
              <div class="container">
                <div class="navbar-bottom">
                     <p class="navbar-brand" ><small>Copyright&copy;2018-2019 ShienD</small></p>
                </div>
              </div>
        </nav>
	</div>
	 
</body>
<script type="text/javascript">
	$(function(){
		
	});

	function changeImg() {
		//var img = document.getElementById("img");
		//img.src = "${pageContext.request.contextPath}/ImgServlet?date=" + new Date();
		$("#img").attr("src","${pageContext.request.contextPath}/adminLogin/imgCode?date=" + new Date());
	}
	
	//验证码验证方法 ajax请求 与imgServlet中设置的 session中的验证码进行对比
	function checkimg(){
		var vcode = $("#vcode").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/adminLogin/checkImgCode",//url请求路径
			type:"post",//请求方式
			data:{vcode:vcode}, //请求的数据
			dataType:"json",//返回类型
			async:true,//false代表非异步请求
			success:function(data){//请求成功后调用 data是服务器返回的数据
				if(data.imgcode == 1){
					$("#imginfo").text("验证码正确");
				}else{
					$("#imginfo").text("验证码错误");
				}
			}
			
		})
	}
	//清除msg
	function clearmsg(id){
		$(id).text("");
	}
	
	
	 // 验证登录
	
	 function login(){
		var account = $("#account").val();
		var password =  $("#password").val();
		var vcode = $("#vcode").val();
			$.ajax({
				url:"${pageContext.request.contextPath}/adminLogin/login", //url请求路径
				type:"post",//请求方式
				data:{
					account:account,
					password:password,
					vcode:vcode
					}, //请求的数据
				dataType:"json",//返回类型
				async:true,
				success:function(data){//请求成功后调用 data是服务器返回的数据
					if(data.code == 0){
						alert("账号或密码错误！请重新登录！");
					}else if(data.code == -1){
						alert("请填写账号或密码！");
					}else if(data.code == -2){
						alert("请填写正确的验证码！");
					}else{
						//往sessionstorage存入信息
						var adminName = data.page.adminName;
						var adminId = data.page.adminId;
						var adminJobId = data.page.adminJobId;
						var power = data.page.power;
						var obj = {"adminId":adminId,"account":account,"name":adminName,"jobId":adminJobId,"power":power};
						var objstr = JSON.stringify(obj);
						sessionStorage.setItem("admin",objstr);
						window.location.href = "jsps/main.jsp";
					}
				}
			});
	 }
	
	
</script>

</html>