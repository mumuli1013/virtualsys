<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.qrcode.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="qrcode"></div>
<span id="qc"><s:property value="#session.qrCode"/></span>
<script>
    $(function(){
    	var qc=$("#qc").html();
    	$('#qrcode').qrcode(qc);
})
</script>
</body>
</html>