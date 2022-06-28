<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>  
<%@ page import="java.util.*" %>
<%@ page import ="kr.mypj.myapp.domain.*" %>
<% 
	ArrayList<BoardVo> blist =  (ArrayList<BoardVo>)request.getAttribute("blist");

%>
   
<!DOCTYPE HTML>
<HTML>
 <HEAD>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <TITLE> 비밀번호 변경 </TITLE>
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
 
 </HEAD>

 <BODY>
 
  <%@include file="/WEB-INF/views/common/header.jsp"%>

<center><h1>내가 남긴 문의</h1></center>
<hr></hr>

<table border="1" style="width:800px;">
<tr>
<td style="width:200px;vertical-align:top;">
<a href="<%=request.getContextPath()%>/member/memberModify.do">회원정보수정</a><br><br>
<a href="<%=request.getContextPath()%>/member/memberPwdChange.do">비밀번호 변경</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberApplyList.do">내가 신청한 과외</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberReviewList.do">내가 남긴 리뷰</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberBoardList.do">내가 남긴 문의</a><br><br>
<a href="<%=request.getContextPath() %>/teacher/teacherMypage.do">선생님 등록정보</a><br><br>
<a href="<%=request.getContextPath() %>/member/memberOut.do">회원탈퇴<br></a><br>

</td>

<td style="vertical-align:top;">
<table border= "1" width="600px">
<tr align="center" style="color:green;">
<td>번호</td>
<td width="300px">제목</td>
<td width="100px">작성자</td>
<td>작성일</td>
<td>조회수</td>
</tr>
<tr align="center" style="color:green;">
<td colspan=5>문의 내용</td>
</tr>

<% for (BoardVo bv : blist) { %>
<tr align="center">
<td><%=bv.getBidx() %></td>
<td width="300px"><%=bv.getSubject() %></td>
<td width="100px"><%=bv.getWriter()%></td>
<td><%=bv.getWriteday().substring(0, 10) %></td>
<td><%=bv.getViewcnt() %></td>
</tr>
<tr>
<td colspan=5><%=bv.getContents()%></td>
</tr>
<tr>
<td colspan=5>ㄴ<%=bv.getAnswer()%></td>
</tr>
<%} %>

</table>
</td>
</tr>
</table> 

 <%@include file="/WEB-INF/views/common/footer.jsp"%>

 </BODY>
</HTML>
