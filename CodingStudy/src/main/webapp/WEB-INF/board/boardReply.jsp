<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	int bidx = (Integer)request.getAttribute("bidx");
	int originbidx = (Integer)request.getAttribute("originbidx");
	int depth = (Integer)request.getAttribute("depth");
	int level_= (Integer)request.getAttribute("level_");
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
		document.frm.bwriter.focus();
		return;
	}
		document.frm.action ="<%=request.getContextPath()%>/board/boardReplyAction.do";
		document.frm.method = "post";
		document.frm.submit();	

	return;
}
</script>
</head>
<body>
<table border="1" style="width:800px;">
<tr>
<td style="width:300px"><a href="<%=request.getContextPath() %>/main/main.do"><img src="test.jpg" width="300px" height="100px" alt="로고이미지"></a></td>
<td><a href="<%=request.getContextPath() %>/board/boardList.do?gubun=c">커뮤니티</a></td>
<td><a href="<%=request.getContextPath() %>/board/boardList.do?gubun=q">문의게시판</a></td>
<td><a href="<%=request.getContextPath() %>/teacher/teacherJoin.do">선생님등록</a></td>
<%if(session.getAttribute("midx") == null) {%>
<td><a href="<%=request.getContextPath() %>/member/memberJoin.do">회원가입</a></td>
<td><a href="<%=request.getContextPath() %>/member/memberLogin.do">로그인</a>&nbsp;<button>검색</button></td>
<%}else{ %>
<td><a href="<%=request.getContextPath() %>/member/memberMypage.do">마이페이지</a></td>
<td><a href="<%=request.getContextPath() %>/member/memberLogout.do">로그아웃</a>&nbsp;<button>검색</button></td>
<%} %>
</tr>
<tr>
<td colspan=6 style="width:800px;height:200px" >
<img src="test.jpg" width="800px" height="200px" alt="이미지">
</td>
</tr>
</table>
<h1><%=title %> 게시판</h1>

<form name="frm"> 
<input type="hidden" name="bidx" value="<%=bidx%>">
<input type="hidden" name="originbidx" value="<%=originbidx%>">
<input type="hidden" name="depth" value="<%=depth%>">
<input type="hidden" name="level_" value="<%=level_%>">
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
<td><input type="text" name="password" size="30"></td>
</tr>
<tr>
<td colspan=2>
<input type="button" name ="button1" value="저장" onclick="check();"> 
</td>
</table>
</body>
</html>