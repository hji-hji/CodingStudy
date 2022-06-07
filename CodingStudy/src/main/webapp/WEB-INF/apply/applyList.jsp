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

<H1>이달의 과외 신청</H1>

<table border=1 style="width:800px">
<tr style="color:green;">
<th>번호</th>
<th>과정</th>
<th>선생님</th>
<th>연락처</th>
</tr>
<tr style="color:green;">
<th>지역</th>
<th>금액</th>
<th>과외날짜</th>
<th>작성일/확인여부</th>
</tr>
<tr style="color:green;">
<th colspan=4>요청내용</th>
</tr>
<tr style="hegith:10px;">
<th colspan=4></th>
</tr>
<tr>
<td>1</td>
<td>자바</td>
<td>홍길동</td>
<td>010 2222 5555</td>
</tr>
<tr>
<td>서울</td>
<td>10만원</td>
<td>2021.06.01</td>
<td>2022.06.01/N</td>
</tr>
<tr>
<td colspan=4>안녕하세요</td>
</tr>


<tr>
<td>1</td>
<td>자바</td>
<td>홍길동</td>
<td>010 2222 5555</td>
</tr>
<tr>
<td>서울</td>
<td>10만원</td>
<td>2021.06.01</td>
<td>2022.06.01/N</td>
</tr>
<tr>
<td colspan=4>안녕하세요</td>
</tr>

<tr>
<td>1</td>
<td>자바</td>
<td>홍길동</td>
<td>010 2222 5555</td>
</tr>
<tr>
<td>서울</td>
<td>10만원</td>
<td>2021.06.01</td>
<td>2022.06.01/N</td>
</tr>
<tr>
<td colspan=4>안녕하세요</td>
</tr>



</table>
</body>
</html>