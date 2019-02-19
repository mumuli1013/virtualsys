<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/login.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jQuery.md5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/vector.js"></script>
<title>test</title>
</head>
<style type="text/css">
   .form input{
       border-color:#e7dfdf;
       color:black;
   }
   .containerT {
    width: 700px;
    text-align: center;
    position: absolute;
    top: 30%;
    left: 50%;
    margin: -150px 0 0 -340px;
    border-radius: 3px;
}
</style>
<body>
<div id="container">
   <div id="output">
   <div class="containerT">
   <h1>添加游戏</h1>
<s:form id="saveForm" action="gameInfoAction_addGame" method="post" namsepace="/" theme="simple" class="form">
<input type="text" name="name" placeholder="游戏名称" required="required"/>
<input type="text" name="detail" placeholder="游戏描述"/>
<s:select list="list" listKey="id" listValue="gameCname" name="gcId" headerKey="" headerValue="请选择游戏分类"></s:select>
<input type="submit" class="submit" value="添加">
</s:form>
</div>
</div>
</div>
</body>
</html>