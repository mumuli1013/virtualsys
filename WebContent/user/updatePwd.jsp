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
<title>虚拟币系统-安全设置</title>
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
<s:if test="#session.existUser==null">
<h2 style="color:red;">请先<a href="${pageContext.request.contextPath }" target="_parent">登录</a>！！</h2>
</s:if>
<s:else>
<div class="wrapper sec_set">
<div id="container">
   <div id="output">
   <div class="containerT">
   <h1 class="ta-c">虚拟币系统-忘记密码页面</h1>
   <s:form action="userAction_updateUserPwd" method="post" namespace="/" class="form">
   <input type="hidden" name="id" value="<s:property value="#session.existUser.id"/>"/>
   <input class="in-text" type="text" placeholder="请输入问题" name="question" required="required"/>
   <input class="in-text" type="text" placeholder="请输入答案" name="answer" required="required"/>
   <input class="in-text" type="password" placeholder="请输入密码,以字母开头，长度在8-16个字节，只能包含字母数字和下划线" name="password" id="password" onblur="checkPassword()"  required="required"/>
   <p id="check2"></p>
   <input class="in-text" type="password" placeholder="再次输入密码" name="password2" id="password2" onblur="checkPassword2()"  required="required"/>
   <p id="check3"></p>
   <!-- 返回错误信息 -->
   <h3><s:actionerror/></h3>
   <input type="text" id="checkcode" name="checkcode" maxlength="4" autocomplete="off" placeholder="请输入下方验证码" required="required">
   <img id="checkImg" class="captchaImage" src="${pageContext.request.contextPath }/checkImgAction.action" onclick="change()" title="点击更换验证码"/>
   <input type="submit" class="submit" name="loginbt" value="确认"/>
</s:form>
</div>
</div>
</div>
</div>
</s:else>
<script type="text/javascript">
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