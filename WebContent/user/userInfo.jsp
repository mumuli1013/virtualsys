<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.lili.domain.*"%>
<%@page import="com.lili.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link style="type/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link style="type/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<title>k币充值中心-安全设置</title>
</head>
<body>
<s:if test="#session.existUser==null">
<h2 style="color:red;">请先<a href="${pageContext.request.contextPath }" target="_parent">登录</a>！！</h2>
</s:if>
<s:else>
<div class="wrapper sec_set">
<h1>查看个人信息</h1>
<s:hidden id="id" value="#session.existUser.id"/>
<p>账号：<s:property value="#session.existUser.username"/></p>
<s:if test="#session.existUser.vAmount==null">
<p>虚拟币余额：0</p>
</s:if>
<s:else>
<p>虚拟币余额：<s:property value="#session.existUser.vAmount"/></p>
</s:else>
<s:if test="#session.existUser.role==1">
<%
   DBConnection db = new DBConnection();
   User user = (User) request.getSession().getAttribute("existUser");
   System.out.println(user.getGameId());
   String gameName;
   if(user.getRole()==1)
      gameName = db.getGameName(user.getGameId());
   else
	   gameName = null;
%>
   <p>所属游戏：<%=gameName %></p>
</s:if>
</div>
</s:else>
</body>
</html>