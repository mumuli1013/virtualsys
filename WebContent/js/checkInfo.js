/**
 * 
 */
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
   
 //切换验证码
   function change(){
   	var img1=document.getElementById("checkImg");
   	img1.src="${pageContext.request.contextPath}/checkImgAction.action?"+new Date().getTime(); //加时间戳防止缓存
   }
