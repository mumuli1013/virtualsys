<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.lili.domain.RechargeOrder"%>
<%@page import="com.lili.domain.Page"%>
<%@page import="com.lili.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link style="type/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link style="type/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<title>虚拟币系统-充值记录</title>
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
<s:if test="#session.existUser==null">
<h2 style="color:red;">请先<a href="${pageContext.request.contextPath }" target="_parent">登录</a>！！</h2>
</s:if>
<s:else>
<div class="rec_reco">
<h2 class="ta-c wra-h">查询充值记录</h2>
   <form action="rechargeOrderAction_findByTime" method="get">
   <input type="hidden" value="<s:property value="#session.existUser.id"/>" name="userId"/>
       <div class="ta-c">
       <b>开始日期：</b>
       <input type="date" name="startTime" id="st"/>
       <!-- <font color="red">格式：<%=currTime %></font> -->
       </div>
       <div class="ta-c">
       <b>结束日期：</b>
       <input type="date" name="endTime" id="et"/>
       <!-- <font color="red">格式：<%=currTime %></font> -->
       </div>
       <div class="ta-c">
       <s:actionerror/>
       </div>
       <div class="selectBt ta-c">
          <input type="submit" name="selectBt" value="查询"/>
       </div>
   </form>
   <a href="${pageContext.request.contextPath }/rechargeOrderAction_findByIs.action?userId=<s:property value="#session.existUser.id"/>&status=1">查询成功订单</a>
   <table border="1">
       <tr>
          <th>充值时间</th>
          <th>充值账号</th>
          <th>虚拟币到账账号</th>
          <th>充值金额</th>
          <th>虚拟币数量</th>
          <th>充值状态</th>
       </tr>
       <%
         Page<RechargeOrder> pages = (Page)request.getSession().getAttribute("page");
         System.out.println("你的页面数据为 : " + pages.getCurrentPage());
         List<RechargeOrder> list = (List<RechargeOrder>) pages.getSmallList();
         SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
         //数据库连接
        DBConnection db = new DBConnection();       
        for(RechargeOrder rechargeOrder : list){	
        	Integer rechargeUserId = rechargeOrder.getRechargeUserId();
            Integer userId = rechargeOrder.getUserId();
            Integer status = rechargeOrder.getStatus();
            String username,rechargeNo;
            String sts;
            if(userId == null)
            	username="";
            else
            {
                username = db.getUsername(userId); //将充值到账Id转换为账号
            }
            if(rechargeUserId == null)
            	rechargeNo="";
            else
            {
            	rechargeNo = db.getUsername(rechargeUserId); //将充值到账Id转换为账号
            }
            if(status == null)
            {
            	sts = "";
            }else{
            	if(status == 1)
            	{
            		sts="支付成功";
            	}
            	else
            	{
            		sts="支付失败";
            	}
            }
            String createTime = dateFormat.format(rechargeOrder.getCreateTime());
      %>
          <tr>
             <td><%=createTime %></td>
             <td><%=username %></td>
             <td><%=rechargeNo %></td>
             <td><%=rechargeOrder.getRmbAmount() %></td>
             <td><%=rechargeOrder.getVAmount() %></td>
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
</s:else>
</body>
</html>