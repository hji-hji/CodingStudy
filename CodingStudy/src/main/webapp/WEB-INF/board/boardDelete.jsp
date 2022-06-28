<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% int bidx = (Integer)request.getAttribute("bidx");
String gubun = (String)request.getAttribute("gubun");
String title="";
if (gubun.equals("c")){
	title = "커뮤니티";
}else{
	title = "문의";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>

a {
  text-decoration: none;
} 
body
{
  margin: 0 auto;
  width: 800px;
}
</style>
<script>
<%	if (request.getAttribute("msg") != null) { %>
		alert('<%=request.getAttribute("msg")%>');
<%	} %>
</script>
<script language = "javascript">
	function check(){
//	alert("test");
	if (document.frm.password.value =="")	{
		alert("비밀번호를 입력하세요");
		document.frm.password.focus();
		return;
	}
		document.frm.action ="<%=request.getContextPath()%>/board/boardDeleteAction.do";
		document.frm.method = "post";
		document.frm.submit();	

	return;
}
</script>
</head>
<body>

 <%@include file="/common/header.jsp"%>

<h1><%=title %> 게시판</h1>
<form name="frm"> 
<input type="hidden" name="bidx" value="<%=bidx%>">
<input type="hidden" name="gubun" value="<%=gubun%>">
 <table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td>비밀번호</td>
<td><input type="password" name="password" size="30"></td>
</tr>
<tr>
<td colspan=2>
<input type="button" name ="button1" value="저장" onclick="check();"> 
<input type="button" name ="button2" value="목록" onclick="location.href='<%=request.getContextPath()%>/board/boardList.do?gubun=<%=gubun%>'"> 
</td>
</table>

 <%@include file="/common/footer.jsp"%>

</body>
</html>