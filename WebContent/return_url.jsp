<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>电脑网站支付return_url</title>
</head>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.alipay.config.AlipayConfig"%>
<%@ page import="com.alipay.api.*"%>
<%@ page import="com.alipay.api.internal.util.*"%>
<%@ page import="com.alipay.api.request.*"%>
<%@ page import="com.alipay.api.response.*"%>
<%@ page import="com.lili.domain.*" %>
<%@ page import="com.lili.service.*" %>
<%@ page import="com.lili.service.impl.*" %>
<%@ page import="com.lili.action.*" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.lang.Long" %>
<%

	//获取支付宝POST过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map<String,String[]> requestParams = request.getParameterMap();
	for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
			valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用
		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		params.put(name, valueStr);
	}
	
	boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

	if(signVerified) {//验证成功
		//商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
	
		//支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//获得初始化的AlipayClient
		AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
		
		//设置请求参数
		AlipayTradeQueryRequest alipayRequest = new AlipayTradeQueryRequest();
		
		//请二选一设置
		alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","+"\"trade_no\":\""+ trade_no +"\"}");
		
		AlipayTradeQueryResponse alipayResponse;
	    alipayResponse = alipayClient.execute(alipayRequest);
		//交易状态
		String trade_status = alipayResponse.getTradeStatus();
		ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		RechargeOrderAction rechargeAction = (RechargeOrderAction) ctx.getBean("rechargeOrderAction");
		RechargeOrder ro = rechargeAction.findByNo(out_trade_no);
		out.println(ro.getId());
		Date currTime = new Date();
		
		UserService userService = (UserService) ctx.getBean("userService");
		if(ro.getStatus()==1)
		{
			out.println("交易已存在！");
		}
		else{
		if(trade_status.equals("TRADE_FINISHED")||trade_status.equals("TRADE_SUCCESS")){
			ro.setUpdateTime(currTime);
			ro.setStatus(1);
			ro.setRechargeTime(alipayResponse.getSendPayDate());
			rechargeAction.updateROrder(ro);
			//修改充值到账用户的虚拟币数量
			User user = userService.findUserById(ro.getRechargeUserId());
			int addV = ro.getVAmount();
			int oldV = user.getVAmount();
			int newV = addV+oldV;
			user.setVAmount(newV);
			user.setUpdateTime(currTime);
			userService.update(user);
		}else{
			//交易失败,即等待支付状态/交易不存在
			ro.setStatus(2);
			ro.setUpdateTime(currTime);
			rechargeAction.updateROrder(ro);
		}
		out.println("success");
		}		
	}
	else {//验证失败
		
		out.println("fail");
	
	}

	
%>
<body>
<span style="font-size:18px;">3秒后自动跳转回主页，或者点击<a href="${pageContext.request.contextPath }/user/index.jsp">跳转</a> </span>
<span style="font-size:24px;">
<span style="font-size:18px;"> </span>
<span style="font-size:24px;"><meta http-equiv="refresh" content="3;URL=http://localhost:8080/VirtualCoinSystem/user/index.jsp"> </span> 
<span style="font-size:24px;"></span> 
</span>
</html>