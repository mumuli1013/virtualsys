<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page import="com.lili.domain.*" %>
<%@ page import="com.lili.util.DBConnection" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    GameInfo gi = (GameInfo) request.getSession().getAttribute("gameInfo");
    DBConnection db = new DBConnection();
    String gameName = db.getGameName(gi.getId());
    String gameCname = db.getGameClass(gi.getGcId());
    Date d = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	String createTime;
	if(gi.getCreateTime() != null)
	    createTime = df.format(gi.getCreateTime());
	else
		createTime = "";
	int GuserNum = db.findGUCountByGId(gi.getId());
%>
    <p>游戏名称：<%=gameName %></p>
    <p>游戏类型：<%=gameCname %></p>
    <p>游戏描述：<s:property value="#session.gameInfo.detail"/></p>
    <p>游戏用户总人数：<%=GuserNum %>人</p>
    <p>创建时间：<%=createTime %></p>
</body>
</html>