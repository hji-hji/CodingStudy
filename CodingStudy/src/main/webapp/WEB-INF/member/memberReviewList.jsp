<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="kr.mypj.myapp.domain.*" %>   
<%@ page import = "java.util.*" %> 

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
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

<H1><center>내가 남긴 리뷰</center></H1>
<hr>

<table border="1" style="width:800px;">
<tr>
<td style="width:200px">
<a href="<%=request.getContextPath()%>/member/memberModify.do">회원정보수정</a><br><br>
<a href="<%=request.getContextPath()%>/member/memberPwdChange.do">비밀번호 변경</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberApplyList.do">내가 신청한 과외</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberReviewList.do">내가 남긴 리뷰</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberBoardList.do">내가 남긴 문의</a><br><br>
<a href="<%=request.getContextPath() %>/teacher/teacherMypage.do">선생님 등록정보<br><br>
<a href="<%=request.getContextPath() %>/member/memberOut.do">회원탈퇴<br><br>
</td>

<td>
<table border="1" style="text-align:left;width:600px;height:100px">
<tr>
<td style="width:400px;height:50px">자바 </td>
<td>홍길동 선생님</td>
</tr>

</table>
<hr>
홍길순:<br>
안녕하세요 수고하셨습니다..&nbsp;&nbsp;<button>삭제</button><br>
<hr>
<table border="1" style="text-align:left;width:600px;height:100px">
<tr>
<td style="width:400px;height:50px">자바 </td>
<td>홍길동 선생님</td>
</tr>

</table>
홍길순:<br>
안녕하세요 수고하셨습니다..&nbsp;&nbsp;<button>삭제</button><br>
<hr>
</td>
</tr>
</table> 






</body>
</html>