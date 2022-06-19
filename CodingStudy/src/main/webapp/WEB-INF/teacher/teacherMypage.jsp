<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>
 <%@ page import="java.util.*" %>   
 <%@ page import = "kr.mypj.myapp.domain.*" %>    
 <% ArrayList<TeacherDto> tlist = (ArrayList<TeacherDto>)request.getAttribute("tlist"); %>      
              
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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.0.js"></script>
<script>
<%	if (request.getAttribute("msg") != null) { %>
		alert('<%=request.getAttribute("msg")%>');
<%	} %>

function memberDelete(i){		
	
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

function apply(i){
	
	var t_idx = document.getElementsByName("t_idx")[i].value;	
	var flag = document.getElementsByName("flag")[i].value;	
//	alert(flag);
	if (flag ==1){
		document.getElementById("cont"+i).style.display = "none";
		document.getElementById("flag"+i).value=0;
		return;
		
	}else{
		document.getElementById("cont"+i).style.display = "";
		document.getElementById("flag"+i).value=1;
		
	}
	
	 var str = "";
	
	 $.ajax({ 
			type: 'post',        	
			url: '<%=request.getContextPath()%>/teacher/teacherMyApplyList.do', 
			data: {"tidx" : t_idx},
			dataType : 'json', 			
			success: function(data) {				
		
			//	alert(data.length);
				
				 $.each(data, function (i, item) {	   
		//		 alert("신청인 : "+item.memberName);	 
					 
	            str = str + "<table border=1 style='width:500px;vertical-align:top;'><tr><td>"	  
	            +"신청인: "+item.memberName+"<br>"
	            +"지역: "+item.area+"<br>"
	            +"연락처:"+item.contact+"<br>"
	            +"희망수업시간:"+item.studyTime+"시간/주<br>"
	            +"희망과외금액:"+item.amount+" 만원/시간<br>"
	            +"요청사항:"+item.contents+"<br>"
	            +"등록일:"+item.writeday+"<br>"
	            +"</td></tr></table>"; 
	    		 });			 
			
				$("#cont"+[i]).html(str); 					
			},
			error : function(){
				alert('서버요청실패');
			}
		}); 	  
	
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
<a href="<%=request.getContextPath() %>/teacher/teacherMypage.do">선생님 등록정보</a><br><br>
<a href="<%=request.getContextPath() %>/member/memberOut.do">회원탈퇴</a><br><br>
</td>

<td>
<form name="frm">
<input type="hidden" name="tidx">
<% 
int i = 0;
for (TeacherDto tedto : tlist)  {%>
<table border="1" style="text-align:left;height:300px">
<tr>
<td style="width:150px">선생님 정보</td>
<td colspan=3>
<img src='<%=request.getContextPath()%>/displayFile.do?fileName=<%=tedto.getFilename() %>'  width="100px" height="100px"><br>
<%=tedto.getTeacherName() %>
</td>
</tr>
<tr>
<td>과정</td>
<td><%=tedto.getCateName() %></td>
<td>과외비</td>
<td><%=tedto.getTeacherPay() %> 만원/시간</td>
</tr>
<tr>
<td>등록일</td>
<td colspan=3><%=tedto.getWriteday().substring(0,10) %></td>
</tr>
<tr>
<td>성별</td>
<td colspan=3>
<% 
if (tedto.getTeacherGender().equals("M")) {
out.println("남성");	
}else{
out.println("여성");		
}
%>
</td>
</tr>
<tr>
<td>연락처</td>
<td colspan=3>
<%=tedto.getTeacherPhone() %>
</td>
</tr>
<tr>
<td>지역</td>
<td colspan=3>
<%=tedto.getAreaName() %>
</td>
</tr>
<tr>
<td>경력 및 경험</td>
<td colspan=3>
<% if (tedto.getTeacherExp().equals("6")){
	out.println("5년이상");	
}else{
	out.println(tedto.getTeacherExp()+"년");
} 

%> 
</td>
</tr>
<tr>
<td>자기소개</td>
<td colspan=3><%=tedto.getTeacherInfo() %></td> 
</tr>

<tr>
<td></td>
<td colspan=3>
<input type="button"  value="과외 신청정보 확인하기" onclick="apply(<%=i %>)">
<button onclick="location.href='<%=request.getContextPath()%>/review/reviewList.do';">과정 리뷰보기</button>
 <input type="hidden" name="flag" id="flag<%=i %>" value="0">
 <input type="hidden" name="t_idx" value="<%=tedto.getTidx() %>">
<input type="button" value="선생님 회원등록 삭제" onclick="memberDelete(<%=i %>)">

</td>
</tr>
<tr>
<td  colspan=4 id="cont<%=i %>" wdith="600px"></td>
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
