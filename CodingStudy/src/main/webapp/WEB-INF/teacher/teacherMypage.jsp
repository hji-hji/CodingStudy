<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>
 <%@ page import="java.util.*" %>   
 <%@ page import = "kr.mypj.myapp.domain.*" %>    
 <% ArrayList<TeacherVo> tlist = (ArrayList<TeacherVo>)request.getAttribute("tlist"); %>      
              
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

function check(i){
	
		
	
	if (confirm("선생님 회원 등록을 삭제하시겠습니까?")){
		
		var t_idx = document.getElementsByName("t_idx")[i].value;	
		var fm = document.frm;
		fm.tidx.value = t_idx;
		
		fm.action = "<%=request.getContextPath()%>/teacher/teacherDeleteAction.do";
		fm.method = "post";
		fm.submit();		
	}else{
		alert("취소 되었습니다.");
	}
	
}


</script> 
 </HEAD>

 <BODY>
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

<center><h1>선생님 등록정보</h1></center>
<hr></hr>
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
<form name="frm">
<input type="hidden" name="tidx">
<% 
int i = 0;
for (TeacherVo tevo : tlist)  {%>
<table border="1" style="text-align:left;height:300px">
<tr>
<td style="width:150px">사진 및 이름</td>
<td colspan=3>
<img src='<%=request.getContextPath()%>/displayFile.do?fileName=<%=tevo.getFilename() %>'  width="100px" height="100px">
   <%=tevo.getTeacherName() %>
</td>
</tr>
<tr>
<td>과정</td>
<td><%=tevo.getCaidx() %></td>
<td>과외비</td>
<td>시간당 <%=tevo.getTeacherpay() %></td>
</tr>
<tr>
<td>등록일</td>
<td colspan=3><%=tevo.getWriteday().substring(0,10) %></td>
</tr>
<tr>
<td>성별</td>
<td colspan=3>
<%=tevo.getTeachergender() %>
</td>
</tr>
<tr>
<td>연락처</td>
<td colspan=3>
<%=tevo.getTeacherPhone() %>
</td>
</tr>
<tr>
<td>지역</td>
<td colspan=3>
<%=tevo.getStidx() %>
</td>
</tr>
<tr>
<td>경력 및 경험</td>
<td colspan=3>
<%=tevo.getTeacherexp() %>
</td>
</tr>
<tr>
<td>자기소개</td>
<td colspan=3><%=tevo.getTeacherinfo() %></td> 
</tr>

<tr>
<td></td>
<td colspan=3>
<button onclick="location.href='<%=request.getContextPath()%>/apply/applyList.do';">과외 신청정보 확인</button> 
<button onclick="location.href='<%=request.getContextPath()%>/review/reviewList.do';">과정 리뷰보기</button> 
<input type="hidden" name="t_idx" value="<%=tevo.getTidx() %>">
<input type="button" value="선생님 회원등록 삭제" onclick="check(<%=i %>)">

</td>
</tr>
</table>
 <%
i = i+1; 
}
%>
 </form>

</td>

</tr>

</table>

 
 </BODY>
</HTML>
