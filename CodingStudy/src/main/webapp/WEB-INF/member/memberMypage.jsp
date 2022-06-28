<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>
 <%@ page import = "kr.mypj.myapp.domain.*" %>    
 <% MemberVo mv = (MemberVo)request.getAttribute("mv"); %>      
       
       
<!DOCTYPE HTML>
<HTML>
 <HEAD>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <TITLE> New Document </TITLE>
  <style>

body
{
  margin: 0 auto;
  width: 800px;
}
a{
text-decoration:none;
}
</style>  
<script>
<%	if (request.getAttribute("msg") != null) { %>
		alert('<%=request.getAttribute("msg")%>');
<%	} %>
</script>
 </HEAD>

 <BODY>
 
  <%@include file="/WEB-INF/views/common/header.jsp"%>

<h1><center>회원정보</center>  </h1>
<hr></hr>
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
<table border="0" style="text-align:left;height:300px">
<tr>
<td style="width:100px">아이디</td>
<td style="width:300px"><%=mv.getMemberId() %></td>
</tr>
<tr>
<td>이름</td>
<td><%=mv.getMemberName() %></td>
</tr>
<tr>
<td>이메일</td>
<td><%=mv.getMemberEmail() %></td>
</tr>
<tr>
<td>성별</td>
<td>
<%=mv.getMemberGender() %><br><br>
</td>
</tr>
<tr>
<td>연락처</td>
<td>
<%=mv.getMemberPhone() %><br><br>
</td>
</tr>
<tr>
<td>생년월일</td>
<td><%=mv.getMemberBirth() %><br><br>
</td>
</tr>
<tr>
<td>회원인증여부</td>
<td><%=mv.getMemberApproveYn() %>
<% if (mv.getMemberApproveYn().equals("N")){ %>
<button onclick="location.href='<%=request.getContextPath() %>/member/memberAuth.do'">인증하기</button><br>
<%} %>
</td>
</tr>
 </table>
</td>
</tr>
</table> 
 
  <%@include file="/WEB-INF/views/common/footer.jsp"%>
 
 </BODY>
</HTML>
