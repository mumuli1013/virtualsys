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
<s:form id="saveForm" action="gameClassAction_update" method="post" namsepace="/" theme="simple">
<s:hidden name="id" value="%{model.id}"/>
<p>分类名称：</p>
<s:textfield name="gameCname" value="%{model.gameCname}"/>
<p>状态:</p>
<s:select list="#{1:'正常',2:'废弃' }" listKey="key" listValue="value" name="status"/>
<s:submit value="确定"/>
</s:form>
</body>
</html>