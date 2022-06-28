<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그아웃페이지</title>
<style type="text/css">
body
{
  margin: 0 auto;
  width: 800px;
}
a {
  text-decoration: none;
} 
</style>
<script type="text/javascript">

function check(){

	var fm = document.frm;
	
	fm.action="<%=request.getContextPath()%>/member/memberOutAction.do";
	fm.method="post";
	fm.submit();
	
	
}
</script>
</head>
<body>

 <%@include file="/WEB-INF/views/common/header.jsp"%>

<center>회원 탈퇴 이유를 적어주세요.
<form name="frm">
<table border="0" style="width:800px;text-align:center;">
<tr><td>
<textarea name="reason"  cols="100" rows="5"></textarea>
<br>
<button onclick="check();">확인</button>
<button onclick="location.href='<%=request.getContextPath() %>/member/memberMypage.do'" >취소</button>

</td></tr>
</table>
</form>
</center>

 <%@include file="/WEB-INF/views/common/footer.jsp"%>
 
</body>
</html>