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
<title>k币充值中心——添加管理员页面</title>
<script type="text/javascript">
//切换验证码
function change(){
	var img1=document.getElementById("checkImg");
	img1.src="${pageContext.request.contextPath}/checkImgAction.action?"+new Date().getTime(); //加时间戳防止缓存
}

</script>
<style type="text/css">
   .form input{
       border-color:#e7dfdf;
       color:black;
   }
   .containerT {
    width: 700px;
    text-align: center;
    position: absolute;
    top: 30%;
    left: 50%;
    margin: -150px 0 0 -340px;
    border-radius: 3px;
}
</style>
</head>
<body>
<div id="container">
   <div id="output">
   <div class="containerT">
       <h1>k币充值中心——添加管理员</h1>
       <s:form action="userAction_register" method="post" namespace="/" class="form" theme="simple">
       <input type="hidden" name="role" value="1">
       <input type="text" placeholder="请输入账号,以字母开头，长度在5-16个字节，允许字母数字下划线" name="username" id="username" onblur="checkUsername()" required="required"/>
       <h3 id="check1"></h3>
       <input type="password" placeholder="请输入密码,以字母开头，长度在8-16个字节，只能包含字母数字和下划线" name="password" id="password" onblur="checkPassword()" required="required"/>
       <h3 id="check2"></h3>
       <input type="text" placeholder="请输入密保问题" name="question" required="required"/>
       <input type="text" placeholder="请输入密保答案" name="answer" required="required"/>
       <s:select list="gamelist" listKey="id" listValue="name" name="gameId" headerKey="" headerValue="请选择所属游戏"></s:select>
       <input type="text" id="checkcode" name="checkcode" maxlength="4" autocomplete="off" placeholder="请输入下方验证码" required="required">
       <img id="checkImg" class="captchaImage" src="${pageContext.request.contextPath }/checkImgAction.action" onclick="change()" title="点击更换验证码"/>
       <h3><s:actionerror/></h3>
       <input type="submit" class="submit" name="registerBt" value="注册"/>
       </s:form>
   </div>
   </div>
</div>
<script type="text/javascript">
    
  //检测用户账号是否符合正则表达式
    function checkUsername(){
 	   var name = document.getElementById("username").value;
 	   var check1 = document.getElementById("check1");
 	   var reg = /^[a-zA-Z][a-zA-Z0-9_]{4,15}$/;
 	   if(!reg.test(name)){
 		   check1.innerHTML="格式检测不通过".fontcolor("red");
 		   return false;
 	   }else{
 		   check1.innerHTML="格式检测通过".fontcolor("green");
 	       return true;
 	   }
    }
    //检测密码格式是否符合要求
    function checkPassword(){
 	   var pwd = document.getElementById("password").value;
 	   var check2 = document.getElementById("check2");
 	   var reg = /^[a-zA-z]\w{7,15}$/;
 	   if(!reg.test(pwd)){
 		   check2.innerHTML="格式检测不通过".fontcolor("red");
 		   return false;
 	   }else{
 		   check2.innerHTML="格式检测通过".fontcolor("green");
 		   return false;
 	   }
    }
</script>
</body>
</html>