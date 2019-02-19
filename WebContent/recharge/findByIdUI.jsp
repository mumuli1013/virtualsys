<%@page import="com.lili.domain.RechargeOrder"%>
<%@page import="com.lili.domain.Page"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>分页显示数据</title>
  </head>
  
<body>
<span id="userId"><s:property value="#session.existUser.id"/></span>
<div class="container-fluid row form-group">
  <div class="panel panel-info"> 
     <div class="panel-heading">
          <strong class="glyphicon glyphicon-home" style="text-align: left;">数据分页</strong>
     </div>
     <div class="panel-body">
      <table class="table table-hover" border="1">
        <tr style="height: 40px;" class="success">
           <td>用户ID</td>
           <td>用户姓名</td>
           <td>用户密码</td>
           <td>账户类型</td>
           <td>账户余额</td>
           <td>账户状态</td>
        </tr>
     <%
         Page pages = (Page)request.getSession().getAttribute("page");
         System.out.println("你的页面数据为 : " + pages.getCurrentPage());
         List<RechargeOrder> list = (List<RechargeOrder>) pages.getSmallList();
         for(RechargeOrder rechargeOrder : list){		 
      %>
      <tr>
         <td><%=rechargeOrder.getUserId() %></td>
         <td><%=rechargeOrder.getUserId() %></td>
         <td><%=rechargeOrder.getUserId() %></td>
         <td><%=rechargeOrder.getUserId() %></td>
         <td><%=rechargeOrder.getUserId() %></td>
         <td><%=rechargeOrder.getUserId() %></td>
      </tr>
      
      <%
        }
       %>
     </table>
     <div style="float: right;">
       	共 <font color="red"><%=pages.getTotalRow() %></font> 条数据   
  		当前第 <font color="red"><%=pages.getCurrentPage() %></font> 页  
  		共 <font color="red"><%=pages.getPageTotal() %></font> 页  
  		<%
  		   int yeshu = pages.getPageTotal();
  		   int currentPage = pages.getCurrentPage();
  		   int pageTotal = pages.getPageTotal();
  		 %>
         <a href="${pageContext.request.contextPath }/rechargeOrderAction_findById.action?currentPage=1&userId=<s:property value="#session.existUser.id"/>">首页</a>
         <%
            if(currentPage!=1){
          %>
          <a href="${pageContext.request.contextPath }/rechargeOrderAction_findById.action?currentPage=<%=currentPage-1%>&userId=<s:property value="#session.existUser.id"/>">上一页</a>
          <%
             }
           %>
         <%
             if(currentPage<pages.getPageTotal()){
          %>
         <a href="${pageContext.request.contextPath }/rechargeOrderAction_findById.action?currentPage=<%=currentPage+1%>&userId=<s:property value="#session.existUser.id"/>">下一页</a>
         <%
             }
          %>
          <%
             if(currentPage!=pages.getPageTotal()){
          %>
          <a href="${pageContext.request.contextPath }/rechargeOrderAction_findById.action?currentPage=<%=pageTotal%>&userId=<s:property value="#session.existUser.id"/>">尾页</a>
          <%
             }
          %>
      </div>
    </div>
  </div>
</div>
</body>
</html>
