<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>  

   
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
  width: 1000px;
}
</style>
 
  <script>
  function check(){
  //	alert("테스트");
  	
  	var fm = document.frm;
  	
    if (fm.memberPwd.value == ""){
  		alert("변경 비밀번호를 입력하세요");  		
  		fm.memberPwd.focus();
  		return;
  	}else if (fm.memberPwd2.value == ""){
  		alert("변경 비밀번호 확인을 입력하세요");  		
  		fm.memberPwd2.focus();
  		return;
  	}else if (fm.memberPwd.value !=fm.memberPwd2.value){
  		alert("변경 비밀번호가 일치 하지 않습니다.");  		
  		fm.memberPwd.value = "";
  		fm.memberPwd2.value = "";
  		fm.memberPwd.focus();
  	  	return;
  	}
  		fm.action = "<%=request.getContextPath()%>/member/memberPwdChangeAction.do";
  		fm.method = "post";
  		fm.submit();  	
  
  		return;
  }
  
  </script>
 </HEAD>

 <BODY>
 
  <%@include file="/common/header.jsp"%>

<center><h1>비밀번호 변경</h1></center>
<hr></hr>

<table border="0" style="width:1000px;">
<tr>
<td style="width:200px">
<a href="<%=request.getContextPath()%>/member/memberModify.do">회원정보수정</a><br><br>
<a href="<%=request.getContextPath()%>/member/memberPwdChange.do">비밀번호 변경</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberApplyList.do">내가 신청한 과외</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberReviewList.do">내가 남긴 리뷰</a><br><br> 
<a href="<%=request.getContextPath() %>/member/memberBoardList.do">내가 남긴 문의</a><br><br>
<a href="<%=request.getContextPath() %>/teacher/teacherMypage.do">선생님 등록정보</a><br><br>
<a href="<%=request.getContextPath() %>/member/memberOut.do">회원탈퇴</a><br><br>

</td>

<td style="vertical-align:top;">

<form name="frm"> 
 <table border="1" style="text-align:left;width:800px;height:100px">
<tr>
<td style="width:150px">변경 비밀번호<br>변경 비밀번호 확인</td>
<td>
<input type="password" name="memberPwd" size="20"><br>
<input type="password" name="memberPwd2" size="20">
</td>
</tr>
<tr>
<td></td>
<td>
<input type="button" name ="btn" value="비밀번호수정" onclick="check();"> 
<input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/member/memberMypage.do';"> 

</td>
</tr>
 </table>
 </form>



</td>
</tr>
</table> 


 <%@include file="/common/footer.jsp"%>






 </BODY>
</HTML>
