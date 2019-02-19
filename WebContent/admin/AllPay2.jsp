<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link style="type/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link style="type/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/main.css" />
<script type="text/javascript" href="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<title>虚拟币系统-支付记录</title>
</head>
<body>
<div class="rec_reco">
<h2 class="ta-c wra-h">查询支付虚拟币记录</h2>
   <form action="" method="get">
       <div class="ta-c">
       <b>开始日期：</b>
       <input type="text" name="start_time"/>
       <input type="button" value="..." onclick="javascript:openFlyBar(divBar)">
       <font color="red">格式：2018-12-14</font>
       </div>
       <div class="ta-c">
       <b>结束日期：</b>
       <input type="text" name="start_time"/>
       <input type="button" value="..." onclick="javascript:openFlyBar(divBar2)">
       <font color="red">格式：2018-12-14</font>
       </div>
       <div class="selectBt ta-c">
          <input type="submit" name="selectBt" value="查询"/>
       </div>
   </form>
   <s:property value="#session.existUser.id"/>
   <s:property value="#session.existUser.username"/>
   <s:property value="#session.existUser.vAmount"/>
   <table border="1">
       <tr>
          <th>支付时间</th>
          <th>用户名</th>
          <th>游戏名称</th>
          <th>游戏ID</th>
          <th>虚拟币数量</th>
          <th>支付状态</th>
       </tr>
       <s:iterator value="list" var="e">
       <tr>
       <td><s:date name="#e.payTime" format="yyyy-MM-dd"/></td>
       <td><s:property value="#e.userId"/></td>
       <td><s:property value="#e.gameId"/></td>
       <td><s:property value="#e.gameUserId"/></td>
       <td><s:property value="#e.vAmount"/></td>
       <td><s:property value="#e.status"/></td>
       </tr>
       </s:iterator>
   </table>
</div>
</body>
</html>