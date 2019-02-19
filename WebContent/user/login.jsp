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
<title>k币充值中心——登录页面</title>
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
       <h1>k币充值中心——游戏用户登录</h1>
       <s:form action="userAction_login" method="post" namespace="/" class="form">
       <input type="hidden" id="role" name="role" value="2"/>
       <input type="text" placeholder="请输入账号" name="username" required="required"/>
       <input type="password" placeholder="请输入密码" name="password"  required="required"/>
       <input type="text" id="checkcode" name="checkcode" maxlength="4" autocomplete="off" placeholder="请输入下方验证码" required="required">
       <img id="checkImg" class="captchaImage" src="${pageContext.request.contextPath }/checkImgAction.action" onclick="change()" title="点击更换验证码"/>
       <!-- 返回错误信息 -->
       <h3><s:actionerror/></h3>
       <input type="submit" class="submit" name="loginbt" value="登录"/>
       </s:form>
       <a href="${pageContext.request.contextPath }/userAction_registerUI.action" class="buta">未有账号？点击注册</a>
       <a href="${pageContext.request.contextPath }/userAction_forgetPwdUI.action" class="buta">忘记密码</a>
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