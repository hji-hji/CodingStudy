<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="kr.mypj.myapp.domain.BoardVo" %>    
<% BoardVo bv = (BoardVo)request.getAttribute("bv");
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
	if (document.frm.subject.value =="")	{
		alert("제목 입력");
		document.frm.subject.focus();
		return;
	}else if (document.frm.contents.value==""){
		alert("내용 입력");
		document.frm.contents.focus();
		return;
	}else if (document.frm.writer.value==""){
		alert("작성자 입력");
		document.frm.writer.focus();
		return;
	}else if (document.frm.password.value==""){
		alert("비밀번호 입력");
		document.frm.password.focus();
		return;
	}
	
		document.frm.action ="<%=request.getContextPath()%>/board/boardModifyAction.do";
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
 <table border="1" style="text-align:left;width:800px;height:300px">
 <input type="hidden" name=bidx value="<%=bv.getBidx() %>">
 <input type="hidden" name=gubun value="<%=gubun %>">
<tr>
<td>제목</td>
<td><input type="text" name="subject" size="30" value="<%=bv.getSubject() %>"></td>
</tr>
<tr>
<td>내용</td>
<td><textarea name="contents" rows="10" cols="100"><%=bv.getContents() %></textarea>
</td>
</tr>
<tr>
<td>작성자</td>
<td><input type="text" name="writer" size="30" value="<%=bv.getWriter() %>"></td>
</tr>
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