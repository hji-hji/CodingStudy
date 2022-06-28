<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>    
<!DOCTYPE HTML>
<HTML>
 <HEAD>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <TITLE>회원가입</TITLE>
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
  <!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 <script>
    $(document).ready(function(){ 
        $('#idCheck').click(function(){
        	if ($("#memberId").val()==""){
        		alert('아이디를 입력해주세요');	
        		return;
        	}        	
        	var memberId = $("#memberId").val();
     
        	$.ajax({ 
        		type: 'post',        	
    			url: '<%=request.getContextPath()%>/member/memberIdCheck.do', 
    			data: {"memberId" : memberId},
    			dataType : 'json', 
    			success: function(data) {
    		//		alert(data.checkValue);
    				if(data.checkValue == 1){
    					$("#prt").html('사용할수 없는 아이디입니다.');
    					$("#prt").css('color','red');
    					$("#memberId").val("");
    				}else{
    					$("#prt").html('사용할수 있는 아이디입니다.');
    					$("#prt").css('color','green'); 
    					$("#memberId").attr('readonly',true); 
    				}
    				
    				$("#checkYn").val("Y");
    			},
    			error : function(){
    				alert('서버요청실패');
    			}
    		}); 
        });
    });
</script>
  <script>
  function check(){
  //	alert("테스트");
  	
  	var fm = document.frm;
  	var chk = /^[0-9]+$/; 
  	
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
  	}else if (fm.memberPwd.value.length < 4){
  		alert("비밀번호는 4자리이상 입력해주세요");
  		fm.memberPwd.focus();
  		return;
  	}else if (fm.memberPwd2.value ==""){
  		alert("비밀번호 확인을 입력하세요");
  		fm.memberPwd2.focus();
  		return;
  	}else if (fm.memberPwd2.value.length < 4){
  		alert("비밀번호 확인은 4자리이상 입력해주세요");
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
  	}else if (!chk.test(fm.memberBirth.value)){
  		alert("숫자만 입력하세요"); 
  		fm.memberBirth.value = "";
  		fm.memberBirth.focus();
  		return;
  	}else if (fm.memberApproveYn.value == "N"){
  		alert("회원인증을 해주세요");  		
  		fm.memberApproveYn.focus();
  		return;
  	}else if (fm.termsofService.checked == false){
  		alert("이용약관을 체크해주세요");  		
  		fm.termsofService.focus();
  		return;
  	}else if (fm.personInfomation.checked == false){
  		alert("개인정보 수집 및 이용 체크 해주세요");  		
  		fm.personInfomation.focus();
  		return;
  	} 	  	
  
  		fm.action = "<%=request.getContextPath()%>/member/memberJoinAction.do";
  		fm.method = "post";
  		fm.submit();  	
  
  		return;
  }
  
  function approve(){
	  alert('인증되었습니다');
	  document.frm.memberApproveYn.value="Y";
	 $("#appmsg").text("인증완료");
	  return;
  }
  
  </script>
 </HEAD>

 <BODY>
 
  <%@include file="/common/header.jsp"%>

<center><h1>회원가입</h1></center>
<hr></hr>
<form name="frm"> 
 <table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td style="width:150px">아이디</td>
<td>
<input type="text" name="memberId" id="memberId" size="20">
<input type="button"  id="idCheck"  value="아이디 중복체크">  <span id="prt"></span>
<input type="hidden" id="checkYn" value="N">
</td>
</tr>
<tr>
<td>비밀번호</td>
<td><input type="password" name="memberPwd" size="20">(4자리 이상 입력해주세요)</td>
</tr>
<tr>
<td>비밀번호확인</td>
<td><input type="password" name="memberPwd2" size="20">(4자리 이상 입력해주세요)</td>
</tr>
<tr>
<td>이름</td>
<td><input type="text" name="memberName" size="20"></td>
</tr>
<tr>
<td>이메일</td>
<td><input type="email" name="memberEmail" size="20" placeholder="test@test.com"></td>
</tr>
<tr>
<td>성별</td>
<td>
<input type="radio" name ="memberGender" value="M" checked>남자
<input type="radio" name ="memberGender" value="F">여자
</td>
</tr>
<tr>
<td>연락처</td>
<td>
<input type="text" name="memberPhone" size="15" placeholder="010-xxxx-xxxx">
</td>
</tr>
<tr>
<td>생년월일<br>(주민번호앞6자리)</td>
<td>
<!-- select name="birthYear">
<% //for (int i= 1940; i<=2020; i++) {%>
<option value="<%//=i%>"><%//=i%></option>
<%//} %>
</select>
<select name="birthMonth">
<%// for (int i= 1; i<=12; i++) { %>
<option value="<%//=i%>"><%//=i%></option>
<%//} %>
</select>
<select name="birthDay">
<%// for (int i= 1; i<=31; i++) { %>
<option value="<%//=i%>"><%//=i%></option>
<%//} %>
</select -->


<input type="text" name="memberBirth" maxlength="6" size="6" placeholder="xxxxxx">	


</td>
</tr>
<tr>
<td>회원인증</td>
<td id ="appmsg">미인증

<button onclick="approve();return false;">회원인증</button>
</td>
</tr>
<tr>
<td>이용약관/개인정보 수집 및 이용</td>
<td>
<input type="checkbox" name="termsofService" value="Y">
<a href="#" onclick="window.open('<%=request.getContextPath()%>/etc/memberTermsOfService.jsp','tos','width=1200, height=600, menubar=no, status=no, toolbar=no');">이용약관</a><br>

<input type="checkbox" name="personInfomation" value="Y">
<a href="#" onclick="window.open('<%=request.getContextPath()%>/etc/memberPersonInformation.jsp','pi','width=1200, height=600, menubar=no, status=no, toolbar=no');">개인정보 수집 및 이용</a>
</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="memberApproveYn" size="10" value="N" readonly style="border:none;">	
<input type="button" name ="btn" value="확인" onclick="check();"> 
<input type="button" value="다시작성" onclick="location.href='<%=request.getContextPath()%>/member/memberJoin.do';"> 
</td>
</tr>
 </table>
 </form>
 
  <%@include file="/common/footer.jsp"%>
 
 </BODY>
</HTML>
