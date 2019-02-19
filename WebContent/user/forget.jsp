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
<script type="text/javascript">
//切换验证码
function change(){
	var img1=document.getElementById("checkImg");
	img1.src="${pageContext.request.contextPath}/checkImgAction.action?"+new Date().getTime(); //加时间戳防止缓存
}

</script>
</head>
<body> 
<div id="container">
   <div id="output">
     <div class="containerT">
       <s:form action="userAction_forget" method="post" namespace="/" class="form">
        <h2 class="ta-c">k币充值中心-忘记密码页面</h2>
        <input type="hidden" name="id" value="<s:property value="#session.existUser.id"/>"/>
        <input type="text" placeholder="请输入问题" name="question" required="required"/>
        <input type="text" placeholder="请输入答案" name="answer" required="required"/>
        <input type="password" placeholder="请输入密码,以字母开头，长度在8-16个字节，只能包含字母数字和下划线" name="password" id="password" onblur="checkPassword()"  required="required"/>
        <p id="check2"></p>
        <input class="in-text" type="password" placeholder="再次输入密码" name="password2" id="password2" onblur="checkPassword2()"  required="required"/>
        <p id="check3"></p>
        <!-- 返回错误信息 -->
        <h3><s:actionerror/></h3>
        <input type="text" id="checkcode" name="checkcode" maxlength="4" autocomplete="off" placeholder="请输入下方验证" required="required">
        <img id="checkImg" class="captchaImage" src="${pageContext.request.contextPath }/checkImgAction.action" onclick="change()" title="点击更换验证码"/>
        <input type="submit" class="submit" name="loginbt" value="确认"/>
      </s:form>
      <a href="${pageContext.request.contextPath }/userAction_forgetPwdUI.action" class="buta">返回上一步</a>
      <a href="${pageContext.request.contextPath }/userAction_loginUI.action" class="buta">返回登录页面</a>
    </div>
  </div>
</div>
</body>
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
		   return true;
	   }
}
   function checkPassword2(){
	   var pwd = document.getElementById("password").value;
	   var pwd2 = document.getElementById("password2").value;
	   var check3 = document.getElementById("check3");
	   if(pwd!=pwd2)
		   {
		   check3.innerHTML="两次密码输入不一致".fontcolor("red");
		   }
	   else{
		   check3.innerHTML="输入一致".fontcolor("green");
	   }
   }
</script>
</html>