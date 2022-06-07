<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.mypj.myapp.domain.BoardVo" %>    
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
<meta charset="UTF-8">
<title>글내용</title>
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
</head>
<body>
<table border="1" style="width:800px;">
<tr>
<td style="width:300px"><a href="<%=request.getContextPath() %>/main/main.do"><img src="test.jpg" width="300px" height="100px" alt="로고이미지"></a></td>
<td><a href="<%=request.getContextPath() %>/board/boardList.do?gubun=c">커뮤니티</a></td>
<td><a href="<%=request.getContextPath() %>/board/boardList.do">문의게시판</a></td>
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
<table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td style="width:100px;height:50px">제목</td>
<td><%=bv.getSubject() %></td>
<td style="width:50px">작성자</td>
<td><%=bv.getWriter() %></td>
<td style="width:50px">조회수</td>
<td><%=bv.getViewcnt() %></td>
</tr>

<tr>
<td style="height:300px">내용</td>
<td colspan=5>
<%=bv.getContents() %>
</td>
</tr>
<tr>
<td colspan="6" style="text-align:left;">
<a href="<%=request.getContextPath()%>/board/boardModify.do?gubun=<%=gubun%>&bidx=<%=bv.getBidx()%>">수정</a>
<a href="<%=request.getContextPath()%>/board/boardDelete.do?gubun=<%=gubun%>&bidx=<%=bv.getBidx()%>">삭제</a>
<a href="<%=request.getContextPath()%>/board/boardReply.do?gubun=<%=gubun%>&bidx=<%=bv.getBidx()%>&originbidx=<%=bv.getOriginbidx() %>&depth=<%=bv.getDepth()%>&level_=<%=bv.getLevel_()%>">답변</a>
<a href="<%=request.getContextPath()%>/board/boardList.do?gubun=<%=gubun%>">목록</a>

</td>
</tr>
</table>

<% if (gubun.equals("c")){ %>

<table border="1" style="text-align:left;width:800px;">
<tr>
<td style="width:100px;height:30px">작성자</td>
<td><input type="text" name="anem"></td>
<td rowspan=2><button>저장</button></td>
</tr>
<tr>
<td style="width:100px;height:50px">내용</td>
<td  style="width:600px;height:50px">
<textarea cols=80 rows=3>dddddd</textarea>
</td>
</tr>
</table>
<hr>
홍길동:<br>
안녕하세요 반갑습니다.&nbsp;&nbsp;<button>삭제</button><br>
<hr>
홍길동:<br>
안녕하세요 반갑습니다.&nbsp;&nbsp;<button>삭제</button><br>
<hr>
<%} %>

</body>
</html>