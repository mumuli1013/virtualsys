<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/login.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jQuery.md5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/vector.js"></script>
<title>k币充值中心——忘记页面</title>
</head>
<body> 
<div id="container">
   <div id="output">
     <div class="containerT">
       <h1>k币充值中心-忘记密码页面(一)</h1>
       <s:form action="userAction_isExistName" method="post" namespace="/" class="form">
        <input type="text" placeholder="请输入账号" name="username" required="required"/>
        <!-- 返回错误信息 -->
        <h3><s:actionerror/></h3>
        <input type="submit" class="submit" name="loginbt" value="下一步"/>
      </s:form>
      <a href="${pageContext.request.contextPath }/userAction_loginUI.action">返回登录页面</a>
    </div>
  </div>
</div>
<script type="text/javascript">
    $(function(){
        Victor("container", "output");   //登录背景函数
        $("#entry_name").focus();
        $(document).keydown(function(event){
            if(event.keyCode==13){
                $("#entry_btn").click();
            }
        });
    });
</script>
</body>
</html>