<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<HTML>
 <HEAD>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <TITLE> New Document </TITLE> 
  <style type="text/css">
body
{
  margin: 0 auto;
  width: 1000px;
}
a {
  text-decoration: none;
} 
table {
    margin-left:auto; 
    margin-right:auto;
}
</style>
  <script>
<%	if (request.getAttribute("msg") != null) { %>
		alert('<%=request.getAttribute("msg")%>');
<%	} %>
</script>
  <script>
  function check(){
 // 	alert("테스트");
  	
  	var fm = document.frm;
  	
  	if (fm.memberId.value ==""){
  		alert("아이디를 입력하세요");
  		fm.memberId.focus();
  		return;
  	}else if (fm.memberPwd.value ==""){
  		alert("비밀번호를 입력하세요");
  		fm.memberPwd.focus();
  		return;
  	}  		
  	
  		// 가상경로를 사용해서 페이지 이동시킨다
  		fm.action = "<%=request.getContextPath()%>/member/memberLoginAction.do";
  		fm.method = "post";
  		fm.submit();
  	
  
   return;
  }
  
  </script>
 </HEAD>

 <BODY>
 
  <%@include file="/common/header.jsp"%>
 
<center>
<h1>로그인</h1><hr></hr></center>
<form name="frm"> 
 <table border="0" style="text-align:left;width:400px;height:100px">
 <tr>
<td colspan=3 style="height:20px"></td>
</tr>
<tr>
<td style="text-align:left;height:20px;vertical-align:top;">
아이디
<br>
비밀번호
</td>
<td>
<input type="text" name="memberId" size="30"><br>
<input type="password" name="memberPwd" size="30"><br>
<input type="checkbox" name="useCookie" id="useCookie" />자동로그인

</td>
<td style="text-align:left;height:20px;vertical-align:top;">
<input type="button" name ="btn" value="확인" onclick="check();"> <br>
<input type="button" value="취소" onclick="history.back(-1);"> 
</td>
</tr>
<tr>
<td colspan=3><hr></hr></td>
</tr>

<tr>
<td></td>
<td colspan=2 style="text-align:left;height:10px">
<a href="<%=request.getContextPath()%>/member/memberJoin.do">회원가입</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
<a href="<%=request.getContextPath()%>/member/memberIdFind.do">아이디</a>/
<a href="<%=request.getContextPath()%>/member/memberPwdFind.do">비밀번호 찾기</a>
</td>
</tr>
 </table>
 </form>

  <%@include file="/common/footer.jsp"%>
 
 </BODY>
</HTML>
