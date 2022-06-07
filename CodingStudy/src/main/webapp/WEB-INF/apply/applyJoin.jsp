<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>    
<!DOCTYPE HTML>
<HTML>
 <HEAD>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <TITLE> New Document </TITLE>
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
  function check(){
  //	alert("테스트");
  	
  	var fm = document.frm;
  	
  	if (fm.memberId.value ==""){
  		alert("아이디를 입력하세요");
  		fm.memberId.focus();
  		return;
  	}else if (fm.checkYn.value =="N"){
  		alert("아이디 중복체크를 해주세요");
  		fm.checkYn.focus();
  		return;
  	}else if (fm.memberPwd.value ==""){
  		alert("비밀번호를 입력하세요");
  		fm.memberPwd.focus();
  		return;
  	}else if (fm.memberPwd2.value ==""){
  		alert("비밀번호 확인을 입력하세요");
  		fm.memberPwd2.focus();
  		return;
  	}else if (fm.memberPwd.value != fm.memberPwd2.value){
  		alert("비밀번호가 일치하지 않습니다.");
  		fm.memberPwd2.value = "";
  		fm.memberPwd2.focus();
  		return;
  	}else if (fm.memberName.value == ""){
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
  
  		fm.action = "<%=request.getContextPath()%>/apply/applyJoinAction.do";
  		fm.method = "post";
  		fm.submit();  	
  
  		return;
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

<center><h1>과외 신청</h1></center>
<hr></hr>
<form name="frm"> 
 <table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td style="width:150px">선생님 정보</td>
<td>
<img src="test.jpg" width="200px" height="100px" alt="이미지"> 
<br>
(홍길동)
</td>
</tr>
<tr>
<td>과목</td>
<td>파이썬</td>
</tr>
<tr>
<td>과외시간</td>
<td><select name="Subject">
<option value="1">1시간</option>
<option value="2">2시간</option>
<option value="협의">협의</option>
</td>
</tr>
<tr>
<td>과외가능 날짜 및 시간</td>
<td><input type="text" name="teacherPhone" size="20">-<input type="text" name="teacherPhone" size="20"><button>등록</button>
<br> 2022년 06월 01일 13:00,  2022년 06월 01일 13:00
</td>
</tr>
<tr>
<td>과외비</td>
<td>
시간당
<select name="applyPay">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="협의">협의</option>
</select>
만원
</td>
</tr>
<tr>
<td>지역</td>
<td>
<select name="applyArea">
<option value="서울">서울</option>
<option value="경기">경기</option>
<option value="대전">대전</option>
<option value="부산">부산</option>
<option value="전북">전북</option>
</select>
</td>
</tr>
<tr>
<td>요청사항 </td>
<td>
<textarea cols=80 rows=5>초등학교 4학년인데요</textarea> 
</td>
</tr>
<tr>
<td>연락처</td>
<td>
<input type="text" name="teacherPhone" size="20">
</td>
</tr>

<tr>
<td></td>
<td>
<input type="button" name ="btn" value="확인" onclick="location.href='<%=request.getContextPath()%>/apply/applyList.do';"> 
<input type="button" value="다시작성" onclick="location.href='<%=request.getContextPath()%>/member/memberJoin.do';"> 
</td>
</tr>
 </table>
 </form>
 </BODY>
</HTML>
