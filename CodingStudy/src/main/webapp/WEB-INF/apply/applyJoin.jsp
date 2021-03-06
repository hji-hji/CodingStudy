<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>  
<%@ page import="java.util.*" %>
<%@ page import="kr.mypj.myapp.domain.*" %>    
<% 
ArrayList<StudyareaVo> slist  = (ArrayList<StudyareaVo>)request.getAttribute("slist");
TeacherDto tedto = (TeacherDto)request.getAttribute("tedto");
%>    
    
      
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
 
//	if (confirm("신청하시면 회원님 이름과 회신 연락처는 코딩쌤에게 전달됩니다.")) {
		var fm = document.frm;
	  	
	  	if (fm.contact.value ==""){
	  		alert("연락처를 입력하세요");
	  		fm.contact.focus();
	  		return;
	  	}  
	  		fm.action = "<%=request.getContextPath()%>/apply/applyJoinAction.do";
	  		fm.method = "post";
	  		fm.submit();  	
	  
	  		return;
		
		
//	}else{
//		alert('취소되었습니다.');
//	}  
  }
  
  </script>
 </HEAD>

 <BODY>
 
  <%@include file="/common/header.jsp"%>  

<center><h1>과외 신청</h1></center>
<hr></hr>
<form name="frm"> 
<input type="hidden" name="tidx" value="<%=tedto.getTidx()%>">
 <table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td style="width:150px">선생님 정보</td>
<td>
<img src='<%=request.getContextPath()%>/displayFile.do?fileName=<%=tedto.getFilename() %>'  width="100px" height="100px">
<br>
<%=tedto.getTeacherName() %>
</td>
</tr>
<tr>
<td>과목</td>
<td><%=tedto.getCateName() %></td>
</tr>
<tr>
<td>신청인</td>
<td><%=session.getAttribute("memberName") %></td>
</tr>
<tr>
<td>희망학습시간</td>
<td> 
<select name="studytime">
<option value="1">1시간</option>
<option value="2" selected>2시간</option>
<option value="3">3시간</option>
<option value="4">4시간</option>
<option value="5">5시간</option>
<option value="협의">협의</option>
</select>
/ 주
</td>
</tr>
<tr>
<td>희망학습비</td>
<td>

<select name="amount">
<option value="1">1만원</option>
<option value="2">2만원</option>
<option value="3">3만원</option>
<option value="4">4만원</option>
<option value="5">5만원</option>
<option value="6">6만원</option>
<option value="7">7만원</option>
<option value="8">8만원</option>
<option value="9">9만원</option>
<option value="10">10만원</option>
<option value="협의">협의</option>
</select>
/ 시간
</td>
</tr>
<tr>
<td>희망학습지역</td>
<td>
<select name="area">
<% for (StudyareaVo sv : slist ) {%>
<option value="<%=sv.getAreaName() %>"><%=sv.getAreaName() %></option>
<%} %>
</select>
</td>
</tr>
<tr>
<td>회신 연락처</td>
<td>
<input type="text" name="contact" size="20" placeholder="010-xxxx-xxxx">

</td>
</tr>
<tr>
<td>요청사항 </td>
<td>
<textarea name="contents" cols="80" rows="5"> </textarea> 
</td>
</tr>


<tr>
<td></td>
<td>
<input type="button" name ="btn" value="확인" onclick="check();"> 
<input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/main/main.do';"> 
</td>
</tr>
 </table>
 </form>
 
  <%@include file="/common/footer.jsp"%>
 
 </BODY>
</HTML>
