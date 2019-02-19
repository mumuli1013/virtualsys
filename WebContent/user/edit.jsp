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
<s:if test="#session.existUser==null">
<h2 style="color:red;">请先<a href="${pageContext.request.contextPath }" target="_parent">登录</a>！！</h2>
</s:if>
<s:else>
<div id="container">
   <div id="output">
   <div class="containerT">
       <h1>k币充值中心——修改</h1>
       <s:form action="userAction_updateUser" method="post" namespace="/" class="form" theme="simple">
       <s:hidden name="id" value="%{model.id}"/>
       <s:hidden name="role" value="%{model.role}"/>
       <s:hidden name="username" value="%{model.username}"/>
       <s:hidden name="password" value="%{model.password}"/>
       <s:hidden name="createTime" value="%{model.createTime}"/>
       <p>密保问题</p>
       <s:textfield name="question" value="%{model.question}" placeholder="密保问题" required="required"/>
       <p>密码答案</p>
       <s:textfield name="answer" value="%{model.answer}" placeholder="密保答案" required="required"/>
       <p>密码</p>
       <input type="password" name="password"  placeholder="密码" required="required"/>
       <s:select list="gamelist" listKey="id" listValue="name" name="gameId" headerKey="%{model.gameId}" headerValue="请选择所属游戏"></s:select>
       <input type="text" id="checkcode" name="checkcode" maxlength="4" autocomplete="off" placeholder="请输入下方验证码" required="required">
       <img id="checkImg" class="captchaImage" src="${pageContext.request.contextPath }/checkImgAction.action" onclick="javascript:change()" title="点击更换验证码"/>
       <h3><s:actionerror/></h3>
       <input type="submit" class="submit" value="修改"/>
       </s:form>
   </div>
   </div>
</div>
</s:else>
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