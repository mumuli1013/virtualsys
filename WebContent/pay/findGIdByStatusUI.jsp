<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.lili.domain.Page"%>
<%@page import="com.lili.util.DBConnection" %>
<%@page import="com.lili.domain.Pay"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link style="type/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link style="type/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<title>虚拟币系统-支付记录</title>
<style type="text/css">
td{
   text-align:center;
}
</style>
</head>
<body>
<%
		Date d = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String currTime = df.format(d);
%>

<div class="rec_reco">
<h2 class="ta-c wra-h">查询支付虚拟币记录</h2>
   <table border="1">
       <tr>
          <th>支付时间</th>
          <th>支付账号</th>
          <th>游戏名称</th>
          <th>游戏ID</th>
          <th>充值虚拟币数量</th>
          <th>支付状态</th>
       </tr>
       <%
         Page<Pay> pages = (Page)request.getSession().getAttribute("page");
         System.out.println("你的页面数据为 : " + pages.getCurrentPage());
         List<Pay> list = (List<Pay>) pages.getSmallList();
         //数据库连接
        DBConnection db = new DBConnection();       
        for(Pay pay : list){	
            Integer userId = pay.getUserId();
            Integer status = pay.getStatus();
            Integer gameId = pay.getGameId();
            Integer gameUserId = pay.getGameUserId();
            String username,gamename,gusername;
            String sts;
            String payTime;
            if(pay.getPayTime()!= null)
            	payTime = df.format(pay.getPayTime());
            else 
            	payTime = "";
            if(userId == null)
            	username="";
            else
            {
                username = db.getUsername(userId); //将充值到账Id转换为账号
            }
            if(gameId == null)
            	gamename="";
            else
            {
            	gamename = db.getGameName(gameId); //将充值到账Id转换为账号
            }
            if(gameUserId == null)
            	gusername="";
            else
            {
            	//System.out.println(gameUserId);
                gusername = db.getGameUserName(gameUserId); //将充值到账Id转换为账号
            }
            if(status == null)
            {
            	sts = "";
            }
            else{
            	if(status == 0)
            	{
            		sts="支付成功";
            	}
            	else
            	{
            		sts="支付失败";
            	}
            }
      %>
       <tr>
       <td><%=payTime %></td>
       <td><%=username %></td>
       <td><%=gamename %></td>
       <td><%=gusername %></td>
       <td><%=pay.getVAmount() %></td>
       <td><%=sts %></td>
       </tr>
       <%
        }
       %>
   </table>
   <div>
       	共 <font color="red"><%=pages.getTotalRow() %></font> 条数据   
  		当前第 <font color="red"><%=pages.getCurrentPage() %></font> 页  
  		共 <font color="red"><%=pages.getPageTotal() %></font> 页  
  		<%
  		   int yeshu = pages.getPageTotal();
  		   int currentPage = pages.getCurrentPage();
  		   int pageTotal = pages.getPageTotal();
  		 %>
         <a href="${pageContext.request.contextPath }/payAction_findGIdByStatus.action?currentPage=1&status=<s:property value="#session.status"/>&gameId=<s:property value="#session.existUser.gameId"/>">首页</a>
         <%
            if(currentPage!=1){
          %>
          <a href="${pageContext.request.contextPath }/payAction_findGIdByStatus.action?currentPage=<%=currentPage-1%>&status=<s:property value="#session.status"/>>&gameId=<s:property value="#session.existUser.gameId"/>">上一页</a>
          <%
             }
           %>
         <%
             if(currentPage<pages.getPageTotal()){
          %>
         <a href="${pageContext.request.contextPath }/payAction_findGIdByStatus.action?currentPage=<%=currentPage+1%>&status=<s:property value="#session.status"/>>&gameId=<s:property value="#session.existUser.gameId"/>">下一页</a>
         <%
             }
          %>
          <%
             if(currentPage!=pages.getPageTotal()){
          %>
          <a href="${pageContext.request.contextPath }/payAction_findGIdByStatus.action?currentPage=<%=pageTotal%>&status=<s:property value="#session.status"/>>&gameId=<s:property value="#session.existUser.gameId"/>">尾页</a>
          <%
             }
          %>
      </div>
</div>
</body>
</html>