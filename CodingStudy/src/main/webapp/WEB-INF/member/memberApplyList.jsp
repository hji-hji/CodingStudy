<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="kr.mypj.myapp.domain.*" %>   
<%@ page import = "java.util.*" %> 

<% ArrayList<ApplyDto> aplist = (ArrayList<ApplyDto>)request.getAttribute("aplist"); %>    
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
<script>
<%	if (request.getAttribute("msg") != null) { %>
		alert('<%=request.getAttribute("msg")%>');
<%	} %>
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

<H1><center>내가 신청한 과외</center></H1>
<hr>

<table border="1" style="width:800px;">
<tr>
<td style="width:200px;vertical-align:top;">
<a href="<%=request.getContextPath()%>/member/memberModify.do">회원정보수정</a><br><br>
<a href="<%=request.getContextPath()%>/member/memberPwdChange.do">비밀번호 변경</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberApplyList.do">내가 신청한 과외</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberReviewList.do">내가 남긴 리뷰</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberBoardList.do">내가 남긴 문의</a><br><br>
<a href="<%=request.getContextPath() %>/teacher/teacherMypage.do">선생님 등록정보<br><br>
<a href="<%=request.getContextPath() %>/member/memberOut.do">회원탈퇴<br><br>
</td>

<td>
<table border=1 style="width:600px">
<tr style="color:green;">
<th>번호</th>
<th>과목/과정</th>
<th>선생님 이름</th>
<th>본인 연락처</th>
</tr>
<tr style="color:green;">
<th>희망 학습지역</th>
<th>희망 학습금액</th>
<th>희망 학습시간</th>
<th>작성일/확인여부</th>
</tr>
<tr style="color:green;">
<th colspan=4>요청내용</th>
</tr>


<% for (ApplyDto apdto : aplist) { %>
<tr>
<td><%=apdto.getApidx() %></td>
<td><%=apdto.getCateName() %></td>
<td><%=apdto.getTeacherName() %></td>
<td><%=apdto.getContact() %></td>
</tr>
<tr>
<td><%=apdto.getArea() %></td>
<td><%=apdto.getAmount() %><%if (!apdto.getAmount().equals("협의")) { %>만원/시간<% }%></td>
<td><%=apdto.getStudyTime() %><%if (!apdto.getStudyTime().equals("협의")) { %>시간/주<% }%></td>
<td><%=apdto.getWriteday() %>/ <%=apdto.getCheckYn() %></td>
</tr>
<tr>
<td colspan=4 height="30"><%=apdto.getContents() %></td>
</tr>
<%} %>
</table>
</td>
</tr>
</table> 

</body>
</html>