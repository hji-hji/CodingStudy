<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>  
  <%@ page import = "kr.mypj.myapp.domain.*" %>   
 <% MemberVo mv = (MemberVo)request.getAttribute("mv"); %>    
<!DOCTYPE HTML>
<HTML>
 <HEAD>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <TITLE> 회원정보수정 </TITLE>
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
  	
  //	if (fm.memberPwd.value != "" || fm.memberPwd2.value != ""){
  		
 // 		if (fm.memberPwd.value !=fm.memberPwd2.value){
  //			alert("변경 비밀번호가 일치 하지 않습니다.");  		
  //			fm.memberPwd.value = "";
  //			fm.memberPwd2.value = "";
  //			fm.memberPwd.focus();
  //	  		return;
  //		}  		
  //	}  	
  	
    if (fm.memberName.value == ""){
  		alert("이름을 입력하세요");  		
  		fm.memberName.focus();
  		return;
  	}else if (fm.memberEmail.value == ""){
  		alert("이메일을 입력하세요");  		
  		fm.memberEmail.focus();
  		return;
  	}else if (fm.memberPhone.value == ""){
  		alert("연락처를 입력하세요");  		
  		fm.memberPhone.focus();
  		return;
  	}else if (fm.memberBirth.value == ""){
  		alert("생년월일을 입력하세요");  		
  		fm.memberBirth.focus();
  		return;
  	} 	  	
  
  		fm.action = "<%=request.getContextPath()%>/member/memberModifyAction.do";
  		fm.method = "post";
  		fm.submit();  	
  
  		return;
  }
  
  </script>
 </HEAD>

 <BODY>
 
  <%@include file="/common/header.jsp"%>

<center><h1>회원정보수정</h1></center>
<hr></hr>

<table border="1" style="width:1000px;">
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

<td style="width:800px">
<form name="frm"> 
 <table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td style="width:150px">아이디</td>
<td>
<%=mv.getMemberId() %>
</td>
</tr>
<tr>
<td>이름</td>
<td><input type="text" name="memberName" size="20" value="<%=mv.getMemberName()%>" <%if (mv.getMemberApproveYn().equals("Y")) {out.println("readonly style='background-color:#808080'");} %>></td>
</tr>
<tr>
<td>이메일</td>
<td><input type="email" name="memberEmail" size="20" value="<%=mv.getMemberEmail()%>"></td>
</tr>
<tr>
<td>성별</td>
<td>
<input type="radio" name ="memberGender" value="M" <% if (mv.getMemberGender().equals("M") ) { %> checked<%}%> >남자
<input type="radio" name ="memberGender" value="F"  <% if (mv.getMemberGender().equals("F") ) { %> checked<%}%>>여자
</td>
</tr>
<tr>
<td>연락처</td>
<td>
<input type="text" name="memberPhone" size="15" value="<%=mv.getMemberPhone()%>"  <%if (mv.getMemberApproveYn().equals("Y")) {out.println("readonly style='background-color:#808080'");} %> >
</td>
</tr>
<tr>
<td>생년월일</td>
<td><input type="text" name="memberBirth" size="10" value="<%=mv.getMemberBirth()%>">	
</td>
</tr>

<tr>
<td></td>
<td>
<input type="button" name ="btn" value="회원정보수정" onclick="check();"> 
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
