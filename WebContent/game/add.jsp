<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/login.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jQuery.md5.js"></script>
<title>游戏公司虚拟币系统——测试页面</title>
</head>
<body>
<s:form action="gameClassAction_add" method="post" namespace="/">
<p>游戏分类：</p>
<div><input type="text" name="gameCname"/></div>
<s:actionerror/>
<div><input type="submit" value="确定"/></div>
</s:form>
</html>