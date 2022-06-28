<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
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
<title>글쓰기</title>
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
<script language = "javascript">
	function check(){
	//alert("test");
	if (document.frm.subject.value =="")	{
		alert("제목을 입력하세요");
		document.frm.subject.focus();
		return;
	}else if (document.frm.contents.value==""){
		alert("내용을 입력하세요");
		document.frm.contents.focus();
		return;
	}else if (document.frm.writer.value==""){
		alert("작성자를 입력하세요");
		document.frm.writer.focus();
		return;
	}else if (document.frm.password.value==""){
		alert("비밀번호를 입력하세요");
		document.frm.password.focus();
		return;
	}
		document.frm.action ="<%=request.getContextPath()%>/board/boardWriteAction.do";
		document.frm.enctype="multipart/form-data";
		document.frm.method = "post";
		document.frm.submit();	

	return;
}
</script>
</head>
<body>

 <%@include file="/WEB-INF/views/common/header.jsp"%>

<h1><%=title %> 게시판</h1>
<form name="frm"> 
<input type="hidden" name="gubun" value="<%=gubun%>">
 <table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td>제목</td>
<td><input type="text" name="subject" size="30"></td>
</tr>
<tr>
<td>내용</td>
<td><textarea name="contents" rows="10" cols="100"></textarea>
</td>
</tr>
<tr>
<td>작성자</td>
<td><input type="text" name="writer" size="30"></td>
</tr>
<tr>
<td>비밀번호</td>
<td><input type="password" name="password" size="30"></td>
</tr>
<tr>
<td>파일업로드</td>
<td>
<input type="file" id ="uploadfile" name="uploadfile">
</td>
</tr>
<tr>
<td colspan=2>
<input type="button" value="저장" onclick="check();"> 
</td>
</table>
</form>

 <%@include file="/WEB-INF/views/common/footer.jsp"%>

</body>
</html>