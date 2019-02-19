<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/index.css" /><base>
<title>游戏公司虚拟币系统——登录页面</title>
</head>
<body>
    <div class="navbar">
        <div class="navbar-inner">
                <ul class="nav pull-right">
                    <li id="fat-menu" class="dropdown">
                        <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="icon-user"></i> <s:property value="#session.existUser.username"/>
                            <i class="icon-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a tabindex="-1" href="${pageContext.request.contextPath }/userAction_userInfoUI.action?id=<s:property value="#session.existUser.id"/>" target="myIframe">我的账户</a></li>
                            <li class="divider"></li>
                            <li><a href="${pageContext.request.contextPath }/userAction_exitLoginUI.action">注销</a></li>
                        </ul>
                    </li>
                    
                </ul>
                <a class="brand" href="index.html">k币充值中心——用户中心</a>
                <s:if test="#session.existUser==null">
                <h2 style="color:red;">请先登录！！即将跳转到登录页面</h2>
                <span style="font-size:24px;"><meta http-equiv="refresh" content="3;URL=${pageContext.request.contextPath }"> </span> 
                </s:if>
        </div>
    </div>
    <script type="text/javascript">
    $(".dropdown").click(function(){
    	$(".dropdown").toggleClass("open"); //toggleClass()是轮流click事件
    })
    </script>
    <div class="sidebar-nav">
    <!-- 虚拟币充值中心 -->
    <a href="#" id="nh1" class="nav-header" data-toggle="collapse">
    <i class="icon-shopping-cart"></i>虚拟币中心</a>
        <ul id="nl1" class="nav nav-list collapse">
            <li><a href="${pageContext.request.contextPath }/rechargeOrderAction_RechargeUI.action?userId=<s:property value="#session.existUser.id"/>" target="myIframe">充值虚拟币</a></li>
            <li><a href="${pageContext.request.contextPath }/payAction_PayUI.action" target="myIframe">支付虚拟币</a></li>
        </ul>
    <!-- 个人中心 -->
    <a href="#" id="nh2" class="nav-header" data-toggle="collapse">
    <i class="icon-briefcase"></i>个人中心</a>
        <ul id="nl2" class="nav nav-list collapse">
            <li><a href="${pageContext.request.contextPath }/userAction_userInfoUI.action?id=<s:property value="#session.existUser.id"/>" target="myIframe">个人信息</a>   
        </ul>  
    <!-- 订单中心 --> 
    <a href="#" id="nh3" class="nav-header" data-toggle="collapse">
    <i class="icon-list-alt"></i>订单查看</a>
        <ul id="nl3" class="nav nav-list collapse">
            <li><a href="${pageContext.request.contextPath }/rechargeOrderAction_findById.action?currentPage=1&userId=<s:property value="#session.existUser.id"/>" target="myIframe">充值记录</a></li> 
            <li><a href="${pageContext.request.contextPath }/payAction_findById.action?userId=<s:property value="#session.existUser.id" />" target="myIframe">支付记录</a></li> 
        </ul> 
    <!-- 安全设置 -->
    <a href="#" id="nh4" class="nav-header" data-toggle="collapse">
    <i class="icon-cog"></i>安全设置</a>
        <ul id="nl4" class="nav nav-list collapse">
            <li><a href="${pageContext.request.contextPath }/userAction_updatePwdUI.action?id=<s:property value="#session.existUser.id"/>" target="myIframe">修改密码</a></li>
        </ul>   
    </div>
    <script type="text/javascript">
    $("#nh1").click(function(){
    	$("#nl1").toggleClass("in");
    });
    $("#nh2").click(function(){
    	$("#nl2").toggleClass("in");
    });
    $("#nh3").click(function(){
    	$("#nl3").toggleClass("in");
    });
    $("#nh4").click(function(){
    	$("#nl4").toggleClass("in");
    });
    </script>
<div class="content">
  <iframe name="myIframe" class="myIframe" frameborder="0" scrolling="no" border="0" >
  </iframe>
</div>
<div class="clear-b"></div>
</body>
</html>