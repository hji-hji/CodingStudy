<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="kr.mypj.myapp.domain.*" %>   
<%@ page import = "java.util.*" %> 

<%
ArrayList<ReviewDto> relist = (ArrayList<ReviewDto>)request.getAttribute("relist");
%>
    
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
<script type="text/javascript">
function reviewDelete(ridx){
	
	if (confirm("삭제하시겠습니까?")){
		
		location.href="<%=request.getContextPath()%>/review/reviewDeleteAction.do?ridx="+ridx;
	}
}

</script>

</head>
<body>

 <%@include file="/common/header.jsp"%>


<H1><center>내가 남긴 리뷰</center></H1>
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
<% for (ReviewDto redto : relist){ %>
<table border="1" style="text-align:left;width:600px;height:100px">
<tr>
<td style="width:400px;height:50px"><%=redto.getCatename() %> </td>
<td><%=redto.getTeacherName() %></td>
</tr>
<tr>
<td style="width:400px;height:50px"><%=redto.getWriter() %>:<br><%=redto.getContent() %> </td>
<td><button onclick="reviewDelete(<%=redto.getRidx()%>);">삭제</button></td>
</tr>
</table>
<% } %>
</td>
</tr>
</table> 


 <%@include file="/common/footer.jsp"%>



</body>
</html>