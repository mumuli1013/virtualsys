<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<title>游戏公司虚拟币系统——主页面</title>
</head>
<body>
<s:if test="#session.existUser==null">
<h2 style="color:red;">请先<a href="${pageContext.request.contextPath }" target="_parent">登录</a>！！</h2>
</s:if>
<s:else>
<div class="rechr">
<h2 class="ta-c wra-h">虚拟币支付</h2>
<s:form action="payAction_createPayOrder" method="post" namespace="/" theme="simple">
<input type="hidden" name="userId" value="<s:property value="#session.existUser.id"/>"/>
<p>游戏:</p>
<s:select list="list" listKey="id" listValue="name" name="gameId" headerKey="" headerValue="请选择"></s:select>
<p>游戏用户:</p>
<input type="text" name="name"/>
<p>充值的虚拟币数量:</p>
<input type="text" name="vcoin">
<s:actionerror/>
<input type="submit" value="提交">
</s:form>
</div>
</s:else>
</body>
</html>