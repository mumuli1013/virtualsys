<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<title>游戏公司虚拟币系统——主页面</title>
</head>
<body>
<div class="rechr">
<h2 class="ta-c wra-h">虚拟币充值</h2>
<s:form action="rechargeOrderAction_addRO" method="post" namespace="/">
<input type="hidden" name="userId" value="<s:property value="#session.existUser.id"/>">
<input type="hidden" name="outTradeNo" value="<s:property value="#session.outTradeNo"/>"/>
<div id="chr_1">
    <div class="chr_left float-l">充值游戏账号 ：</div>
    <div class="float-l"><input type="text" name="username" required="required"/></div>
    <s:actionerror/>
</div>
<div class="clear-b"></div>
<div id="chr_3">
<div class="float-l chr_left">请选择充值金额 ：</div>
<div class="float-l chr_right">
<div>
    <h3>充值面额(1元=10虚拟币)</h3>
    <label>
        <input type="radio" name="cha_den" value="1" onclick="getValue()" checked="checked">1元
    </label>
    <label>
        <input type="radio" name="cha_den" value="10" onclick="getValue()">10元
    </label>
    <label>
        <input type="radio" name="cha_den" value="20" onclick="getValue()">20元
    </label>
    <label>
        <input type="radio" name="cha_den" value="50" onclick="getValue()">50元
    </label>
    <label>
        <input type="radio" name="cha_den" value="100" onclick="getValue()">100元
    </label>
    
</div>
<div>
    <h3>充值数量</h3>
    <label>
        <input type="radio" name="cha_num" value="1" onclick="getValue()" checked="checked">1
    </label>
    <label>
        <input type="radio" name="cha_num" value="2" onclick="getValue()">2
    </label>
    <label>
        <input type="radio" name="cha_num" value="3" onclick="getValue()">3
    </label>
    <label>
        <input type="radio" name="cha_num" value="4" onclick="getValue()">4
    </label>
    <label>
        <input type="radio" name="cha_num" value="5" onclick="getValue()">5
    </label>
</div>
</div>
</div>
<div class="clear-b"></div>
<div id="chr_4">
     <div class="float-l chr_left">应付金额 ：</div>
     <div class="float-l chr_right">
     <input type="text" name="rmbAmount" id="rmb" value="1" readonly="readonly" style="border:none"/>
     <span>元</span>
     </div>
</div>
<div class="clear-b"></div>
<div class="ta-c chr_agree"><input type="radio" name="pro-chr" value="pro-chr" required="required"/>我已阅读并同意<a href="" style="display:inline;">《虚拟币用户充值服务协议》</a></div>
<div class="ta-c recBt"><input type="submit" name="chr_ok" value="立即充值" ></div>
</s:form>
</div>
  <script>
    function getValue() {
      var chaden = document.getElementsByName("cha_den");
      var chanum = document.getElementsByName("cha_num");
      var rmb = document.getElementById("rmb");
      var v1,v2;
      for (i = 0; i < chaden.length; i++) {
        if (chaden[i].checked) {
          v1=chaden[i].value;
        }
      }
      for (i = 0; i < chanum.length; i++) {
          if (chanum[i].checked) {
            v2=chanum[i].value;
          }
        }
      rmb.value = v1*v2;
    };
  </script>
</body>
</html>