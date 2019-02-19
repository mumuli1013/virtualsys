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
          <th>游戏名称</th>
          <th>游戏描述</th>
          <th>更新时间</th>
       </tr>
       <%
         Page<GameInfo> pages = (Page)request.getSession().getAttribute("page");
         System.out.println("你的页面数据为 : " + pages.getCurrentPage());
         List<GameInfo> list = (List<GameInfo>) pages.getSmallList();
         //数据库连接    
        for(GameInfo gameInfo : list){	
           String createTime,updateTime,sts;
           createTime = df.format(gameInfo.getCreateTime());
           
           if(gameInfo.getUpdateTime()!=null)
           {
        	   updateTime = df.format(gameInfo.getUpdateTime());
           }else{
        	   updateTime = "";
           }
      %>
       <tr>
       <td><%=createTime %></td>
       <td><%=gameInfo.getName() %></td>
       <td><%=gameInfo.getDetail() %></td>
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
         <a href="${pageContext.request.contextPath }/gameInfoAction_findAll.action?currentPage=1">首页</a>
         <%
            if(currentPage!=1){
          %>
          <a href="${pageContext.request.contextPath }/gameInfoAction_findAll.action?currentPage=<%=currentPage-1%>">上一页</a>
          <%
             }
           %>
         <%
             if(currentPage<pages.getPageTotal()){
          %>
         <a href="${pageContext.request.contextPath }/gameInfoAction_findAll.action?currentPage=<%=currentPage+1%>">下一页</a>
         <%
             }
          %>
          <%
             if(currentPage!=pages.getPageTotal()){
          %>
          <a href="${pageContext.request.contextPath }/gameInfoAction_findAll.action?currentPage=<%=pageTotal%>">尾页</a>
          <%
             }
          %>
      </div>
</div>
</body>
</html>