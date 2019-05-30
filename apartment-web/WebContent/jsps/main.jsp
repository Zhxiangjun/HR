<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,com.shiend.apartment.pojo.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<title>公寓出租-后台管理</title>
<!-- 引入各种CSS样式表 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/tether.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">    		<!-- 修改自Bootstrap官方Demon-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-change.css">     <!-- 将默认字体从宋体换成微软雅黑 -->  
<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/jqgrid/ui.jqgrid-bootstrap-ui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/jqgrid/ui.jqgrid-bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/ztree/css/metroStyle/metroStyle.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/calendar-blue.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui/jquery-ui.min.css">
<link rel="icon" href="${pageContext.request.contextPath}/img/favicon.ico" type="image/x-icon" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/distpicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/tether.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/vue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/vue-resource.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/jqgrid/grid.locale-cn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/ztree/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/calendar.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-ui/jquery-ui.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">   <%-- 在IE运行最新的渲染模式 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">   <%-- 初始化移动浏览显示 --%>
<meta name="Author" content="ShienD">

</head>
    
    <body>
    <!-- 顶部菜单（来自bootstrap官方Demon）==================================== -->
        <nav class="navbar navbar-inverse navbar-fixed-top"  >
              <div class="container">
                <div class="navbar-header">
                	 <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" >
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                	 <ul class="nav navbar-nav"> 
                  		<li><a href="javascript:void(0);" onclick="showAtRight('0')"><i class="fa fa-users"></i> 用户列表</a></li>    
                        <li><a href="javascript:void(0);" onclick="showAtRight('1.jsp')"><i class="fa fa-home"></i> 房源审核</a></li>
                        <li><a href="javascript:void(0);" onclick="showAtRight('2.jsp')" ><i class="fa fa-bed"></i> 入住列表</a></li> 
                        <li><a href="javascript:void(0);" onclick="showAtRight('3.jsp')" ><i class="fa fa-list"></i> 数据统计</a></li> 
                         <li><a href="javascript:void(0);" onclick="showAtRight('2.jsp')" ><i class="fa fa-bed"></i> 入住列表</a></li> 
                        <li><a href="javascript:void(0);" onclick="showAtRight('3.jsp')" ><i class="fa fa-list"></i> 数据统计</a></li> 
                      </ul>
                </div>
                
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right"> 
                        <li><a href="javascript:void(0);" onclick="exit()"></a><i class="fa fa-users"></i>欢迎你！{{name}}</li>
                        <li><a href="javascript:void(0);" onclick="exit()" ><i class="fa fa-power-off"></i> 退出</a></li> 
                    </ul>
                </div>
              </div>
        </nav>
        <div id="info" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                    <h1 class="page-header">
                   
                   	 	<i class="fa fa-cog fa-spin"></i>&nbsp;控制台
                    	<small>&nbsp;&nbsp;&nbsp;欢迎使用公寓出租后台管理系统</small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	
						 <small><small>&nbsp;&nbsp;&nbsp;管理员:{{name}}&nbsp;&nbsp;&nbsp;工号: {{jobId}}</small></small>
                    </h1>
                        
                        <!-- 载入左侧菜单指向的jsp（或html等）页面内容 -->
                          <div id="content" style="padding-bottom: 50px;">
               
                               <h4>                    
                                   <strong>使用指南：此网站为公寓出租后台管理系统<small>（推荐使用谷歌浏览器使用本网站）</small></strong><br>
                                   <p></p>
                                   <p style="font-size: 16px">用户列表管理：本网站注册使用的用户列表</p>
                                   <p></p>
                                   <p style="font-size: 16px">公寓信息管理：房东欲出租的公寓所提交的公寓信息</p>
                                   <p style="font-size: 16px">房源配置管理：房东欲出租公寓的家具、配置信息</p>
                                   <p style="font-size: 16px">房源信息审核：管理员对与出租公寓信息进行核实，并予以审批</p>
                                   <p style="font-size: 16px">房源价格查询：房东欲出租公寓的价格信息</p>
                                   <p style="font-size: 16px">审核上架管理：管理员对核实并审批通过的公寓进行上架，将会展示于用户操作系统</p>
                                   <p></p>
                                   <p style="font-size: 16px">入住列表查询：完成房租缴费的用户列表</p>
                                   <p style="font-size: 16px">入住信息登记：用户欲租赁进行下单，其他用户不可再租赁，待付款</p>
                                   <p style="font-size: 16px">合同信息管理：下单用户对欲租赁公寓签订租赁合同</p>
                                   <p style="font-size: 16px">缴费信息管理：签订合同后进行租房付款，完成后列入入住列表</p>
                                   <p></p>
                                   <p style="font-size: 16px">信息数据统计：用户注册量、公寓租赁情况等数据的图表展示</p>
                                   <p style="font-size: 16px">权限发放设置：超级管理员账号对不同等级管理员账号进行功能权限发放</p>
                                   <p></p>
                                   		如有问题,请联系QQ981515898
                                  </div> 
                               </h4>                                 
                          </div>  
      


<script type="text/javascript">
$(function(){
	
});
       /*  var jsonStr = sessionStorage.getItem("admin");
        if(jsonStr==null||jsonStr==''){
        	alert('登录信息过期！请重新登录！');
        	window.location.replace('../index.jsp');
        }else{
        	 adminEnti = JSON.parse(jsonStr);
             var name = adminEnti.name;
             var jobId = adminEnti.jobId;
             var vm = new Vue({ 
             	  el: '#info', 
             	  data: { 
             	    name:name,
             	    jobId:jobId
             	  } 
             });
        } */
       
        /*
         * 对选中的标签激活active状态，对先前处于active状态但之后未被选中的标签取消active
         * （实现左侧菜单中的标签点击后变色的效果）
         */
        $(document).ready(function () {
            $('ul.nav > li').click(function (e) {
                //e.preventDefault();    加上这句则导航的<a>标签会失效
                $('ul.nav > li').removeClass('active');
                $(this).addClass('active');
            });
        });
    
        /*
         * 解决ajax返回的页面中含有javascript的办法：
         * 把xmlHttp.responseText中的脚本都抽取出来，不管AJAX加载的HTML包含多少个脚本块，我们对找出来的脚本块都调用eval方法执行它即可
         */
        function executeScript(html){
            var reg = /<script[^>]*>([^\x00]+)$/i;
            //对整段HTML片段按<\/script>拆分
            var htmlBlock = html.split("<\/script>");
            for (var i in htmlBlock){
                var blocks;//匹配正则表达式的内容数组，blocks[1]就是真正的一段脚本内容，因为前面reg定义我们用了括号进行了捕获分组
                if (blocks = htmlBlock[i].match(reg)) {
                    //清除可能存在的注释标记，对于注释结尾-->可以忽略处理，eval一样能正常工作
                    var code = blocks[1].replace(/<!--/, '');
                    try {
                        eval(code) //执行脚本
                    } 
                    catch (e){
                    }
                }
            }
        }
        
        /*
         * 利用div实现左边点击右边显示的效果（以id="content"的div进行内容展示）
         * 注意：
         *   ①：js获取网页的地址，是根据当前网页来相对获取的，不会识别根目录；
         *   ②：如果右边加载的内容显示页里面有css，必须放在主页（即例中的main.jsp）才起作用
         *   （如果单纯的两个页面之间include，子页面的css和js在子页面是可以执行的。 主页面也可以调用子页面的js。但这时要考虑页面中js和渲染的先后顺序 ）
        */
        function showAtRight(url) {
            var xmlHttp;
            if (window.XMLHttpRequest) {
                // code for IE7+, Firefox, Chrome, Opera, Safari
                xmlHttp=new XMLHttpRequest();    //创建 XMLHttpRequest对象
            }else {
                // code for IE6, IE5
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlHttp.onreadystatechange=function() {        
                //onreadystatechange — 当readystate变化时调用后面的方法
                if (xmlHttp.readyState == 4) {
                    //xmlHttp.readyState == 4    ——    finished downloading response
                    if (xmlHttp.status == 200) {
                        //xmlHttp.status == 200        ——    服务器反馈正常            
                        document.getElementById("content").innerHTML=xmlHttp.responseText;    //重设页面中id="content"的div里的内容
                        executeScript(xmlHttp.responseText);    //执行从服务器返回的页面内容里包含的JavaScript函数
                    }else if (xmlHttp.status == 404){//错误状态处理
                        alert("出错了☹   （错误代码：404 Not Found），请联系管理员！"); 
                        /* 对404的处理 */
                        return;
                    }else if (xmlHttp.status == 403) {  
                        alert("出错了☹   （错误代码：403 Forbidden），请联系管理员！"); 
                        /* 对403的处理  */ 
                        return;
                    }else {
                        alert("出错了☹   （错误代码：" + request.status + "），请联系管理员！"); 
                        /* 对出现了其他错误代码所示错误的处理   */
                        return;
                    }   
                } 
            }
            xmlHttp.open("GET", url, true);        //true表示异步处理
            xmlHttp.send();
        }        
        function exit(){
        	confirm("确定要退出吗？", function(){
        		sessionStorage.removeItem("admin");
           		window.location.replace('../index.jsp');
                window.history.back(-1);
        	});
        	 
        }
        
       

       
 </script>
  </body>
</html>