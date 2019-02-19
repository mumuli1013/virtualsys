<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type ="text / javascript" src ="${pageContext.request.contextPath }/dwr/interface/userService.js"> </script>
<script type ="text / javascript" src ="${pageContext.request.contextPath }/dwr/engine.js "> </script>
<script type ="text / javascript" src ="${pageContext.request.contextPath }/dwr/util.js "> </script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<title>Insert title here</title>

<script type="text/javascript">
	function onclick(){
		var d1 = document.getElementById("d1");
		d1.innerHTML=userService.findNameById(40);
	}
</script>
</head>
<body>
<a href="javascript:onclick()">点击</a>
<div id="d1"></div>
</body>
</html>