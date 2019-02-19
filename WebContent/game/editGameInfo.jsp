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
<title>edit</title>
</head>
<body>
<s:form id="saveForm" action="gameInfoAction_update" method="post" namsepace="/" theme="simple">
<s:hidden name="id" value="%{model.id}"/>
<p>游戏名称：</p>
<s:textfield name="name" value="%{model.name}"/>
<p>游戏描述：</p>
<s:textfield name="detail" value="%{model.detail}"/>
<p>游戏分类</p>
<s:select list="list" value="%{model.id}" listKey="id" listValue="gameCname" name="gcId" headerKey="" headerValue="请选择"></s:select>
<s:submit value="确定"/>
</s:form>
</body>
</html>