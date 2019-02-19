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
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css">
<title>login</title>
</head>
<body>
<table border="1">
       <tr>
          <th>创建时间</th>
          <th>账号</th>
          <th>角色</th>
          <th>密保问题</th>
          <th>密保答案</th>
          <s:if test="#session.role == 1">
          <th>所属游戏</th>
          </s:if>
          <th>操作</th>
       </tr>
<%
		Date d = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Page<User> pages = (Page<User>)request.getSession().getAttribute("page");
        System.out.println("你的页面数据为 : " + pages.getCurrentPage());
        List<User> list = (List<User>) pages.getSmallList();
        //数据库连接
       DBConnection db = new DBConnection();       
       for(User user : list){	
    	   String createTime,role,gameName;
    	   if(user.getCreateTime()!=null)
    	   {
    		   createTime = df.format(user.getCreateTime());
    	   }
    	   else
    	   {
    		   createTime = "";
    	   }
    	   if(user.getRole()!=null){
    		   if(user.getRole()==1)
    		   {
    			   role = "普通管理员";
    		   }else if(user.getRole()==2){
    			   role = "用户";
    		   }else{
    			   role = "黑名单用户";
    		   }
    	   }else{
    		   role = "";
    	   }
    	   gameName = db.getGameName(user.getGameId());
    	   if(gameName==null)
    		   gameName="";
%>
<tr>
   <td><%=createTime %></td>
   <td><%=user.getUsername() %></td>
   <td><%=role %></td>
   <td><%=user.getQuestion() %></td>
   <td><%=user.getAnswer() %></td>
   <s:if test="#session.role == 1">
   <td><%=gameName %></td>
   </s:if>
   <td>
      <a href="${pageContext.request.contextPath }/userAction_delete.action?id=<%=user.getId() %>">删除</a>
      <a href="${pageContext.request.contextPath }/userAction_edit.action?id=<%=user.getId() %>">修改</a>
  </td>
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
         <a href="${pageContext.request.contextPath }/userAction_findAllByRole.action?currentPage=1&role=<s:property value="#session.role"/>">首页</a>
         <%
            if(currentPage!=1){
          %>
          <a href="${pageContext.request.contextPath }/userAction_findAllByRole.action?currentPage=<%=currentPage-1%>&role=<s:property value="#session.role"/>">上一页</a>
          <%
             }
           %>
         <%
             if(currentPage<pages.getPageTotal()){
          %>
         <a href="${pageContext.request.contextPath }/userAction_findAllByRole.action?currentPage=<%=currentPage+1%>&role=<s:property value="#session.role"/>">下一页</a>
         <%
             }
          %>
          <%
             if(currentPage!=pages.getPageTotal()){
          %>
          <a href="${pageContext.request.contextPath }/userAction_findAllByRole.action?currentPage=<%=pageTotal%>&role=<s:property value="#session.role"/>">尾页</a>
          <%
             }
          %>
      </div>
</body>
</html>