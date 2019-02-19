<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.lili.domain.Page"%>
<%@page import="com.lili.util.DBConnection" %>
<%@page import="com.lili.domain.*"%>
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
          <th>创建时间</th>
          <th>游戏账号</th>
          <th>游戏昵称</th>
          <th>虚拟币数量</th>
          <th>状态</th>
          <th>更新时间</th>
       </tr>
       <%
         Page<GameUser> pages = (Page)request.getSession().getAttribute("page");
         System.out.println("你的页面数据为 : " + pages.getCurrentPage());
         List<GameUser> list = (List<GameUser>) pages.getSmallList();
         //数据库连接    
        for(GameUser gameUser : list){	
           String createTime,updateTime,sts;
           createTime = df.format(gameUser.getCreateTime());
           updateTime = df.format(gameUser.getUpdateTime());
           if(gameUser.getStatus()!=null)
           {
        	   if(gameUser.getStatus() == 1)
        		   sts = "正常";
        	   else
        		   sts = "废弃";
           }
           else
           {
        	   sts="";
           }
      %>
       <tr>
       <td><%=createTime %></td>
       <td><%=gameUser.getName() %></td>
       <td><%=gameUser.getNiname() %></td>
       <td><%=gameUser.getVAmount() %></td>
       <td><%=sts %></td>
       <td><%=updateTime %></td>
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
         <a href="${pageContext.request.contextPath }/gameUserAction_findByGId.action?currentPage=1&gameId=<s:property value="#session.gameId"/>">首页</a>
         <%
            if(currentPage!=1){
          %>
          <a href="${pageContext.request.contextPath }/gameUserAction_findByGId.action?currentPage=<%=currentPage-1%>&gameId=<s:property value="#session.gameId"/>">上一页</a>
          <%
             }
           %>
         <%
             if(currentPage<pages.getPageTotal()){
          %>
         <a href="${pageContext.request.contextPath }/gameUserAction_findByGId.action?currentPage=<%=currentPage+1%>&gameId=<s:property value="#session.gameId"/>">下一页</a>
         <%
             }
          %>
          <%
             if(currentPage!=pages.getPageTotal()){
          %>
          <a href="${pageContext.request.contextPath }/gameUserAction_findByGId.action?currentPage=<%=pageTotal%>&gameId=<s:property value="#session.gameId"/>">尾页</a>
          <%
             }
          %>
      </div>
</div>
</body>
</html>