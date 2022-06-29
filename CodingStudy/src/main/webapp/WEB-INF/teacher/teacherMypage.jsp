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
  width: 1000px;
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
	//	alert("취소 되었습니다.");
	}
	
	return;
}
function review(i){
	
	$("#cont"+[i]).html(""); 	
	
	var t_idx = document.getElementsByName("t_idx")[i].value;	
	var flag = document.getElementsByName("flag")[i].value;	
//	alert(t_idx);
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
			url: '<%=request.getContextPath()%>/teacher/teacherReviewList.do', 
			data: {"tidx" : t_idx},
			dataType : 'json', 			
			success: function(data) {				
						
	//			alert(data.length);
				
				 $.each(data, function (i, item) {	   
					 
				 str = str + "<table border=0 style='width:800px;vertical-align:top;'>"
				 		   +"<tr><td style='background-color:#000000'></td></tr><tr><td>"	  
	          			   +" 작성자: "+item.writer+"<br>"
	          			   +"내용: "+item.content+"<br>"	           
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

function apply(i){
	
	$("#cont"+[i]).html(""); 	
	
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
	 var amountStr= "";
	 var studyTimeStr="";
	 var checkYnStr="";
	 $.ajax({ 
			type: 'post',        	
			url: '<%=request.getContextPath()%>/teacher/teacherMyApplyList.do', 
			data: {"tidx" : t_idx},
			dataType : 'json', 			
			success: function(data) {				
		
			//	alert(data.length);
				
				 $.each(data, function (i, item) {	   
		//		 alert("신청인 : "+item.memberName);
		
				 studyTimeStr="";
				 if (item.studyTime !="협의"){
					 studyTimeStr ="시간/주";
				 }	
				 amountStr="";
				 if (item.amount !="협의"){
					 amountStr ="만원/시간";
				 }	
				 checkYnStr="";
				 if (item.checkYn =="N"){
					 checkYnStr ="<button id =chk"+item.apidx+"  onclick='checkUpdate("+item.apidx+");return false; '>신청확인</button>";
				 }	
					 
	            str = str + "<table border=0 style='width:800px;vertical-align:top;'>"
	            +"<tr><td colspan=3 style='background-color:#000000;width:800px'></td></tr>"
	            +"<tr><td style='width:300px'>"	  
	            +"신청인: "+item.memberName+"<br>"
	            +"지역: "+item.area+"<br>"
	            +"연락처:"+item.contact+"<br>"
	            +"희망수업시간:"+item.studyTime+studyTimeStr+"<br>"
	            +"희망과외금액:"+item.amount+amountStr+" <br>"
	          //  +"요청사항:"+item.contents+"<br>"
	            +"등록일:"+item.writeday+"<br>"
	            +"</td><td style='width:400px;vertical-align:top;'>요청사항:<br>"+item.contents+"</td><td style='width:100px'>"+checkYnStr+"</td></tr></table>"; 
	    		 });			 
			
				$("#cont"+[i]).html(str); 					
			},
			error : function(){
				alert('서버요청실패');
			}
		}); 	  	
}

function checkUpdate(apidx){
//	alert(apidx);
	
	 $.ajax({ 
			type: 'post',        	
			url: '<%=request.getContextPath()%>/apply/applyCheckYnUpdate.do', 
			data: {"apidx" : apidx},
			dataType : 'json', 			
			success: function(data) {				
		
		//		alert("신청 확인하였습니다.");
			
				if (data.check ==1){
					$("#chk"+[apidx]).hide();
				}
			},
			error : function(){
				alert('서버요청실패');
			}
		}); 	  	

	return;
}

</script> 
 </HEAD>

 <BODY>
 
  <%@include file="/common/header.jsp"%>

<center><h1>선생님 등록정보</h1></center>
<hr></hr>
<table border="0" style="width:1000px;">
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
<table border="1" style="text-align:left;height:300px;width:800px;">
<tr>

<td colspan=4>
<img src='<%=request.getContextPath()%>/displayFile.do?fileName=<%=tedto.getFilename() %>'  width="100px" height="100px">
(<%=tedto.getTeacherName() %>)
</td>
</tr>
<tr>
<td style="text-align:left;width:100px;">과정:</td>
<td  style="width:180px"><%=tedto.getCateName() %></td>
<td style="width:50px">과외비</td>
<td><%=tedto.getTeacherPay() %> <%if (!tedto.getTeacherPay().equals("협의")) {%>만원/시간<%} %></td>
</tr>
<tr>
<td>등록일:</td>
<td><%=tedto.getWriteday().substring(0,10) %></td>
<td style="width:80px">자기소개:</td>
<td rowspan=5 style="vertical-align:top;"><%=tedto.getTeacherInfo() %></td>
</tr>
<tr>
<td>성별:</td>
<td colspan=2>
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
<td>연락처:</td>
<td colspan=2>
<%=tedto.getTeacherPhone() %>
</td>
</tr>
<tr>
<td>지역:</td>
<td colspan=2>
<%=tedto.getAreaName() %>
</td>
</tr>
<tr>
<td>경력 및 경험:</td>
<td colspan=2>
<% if (tedto.getTeacherExp().equals("6")){
	out.println("5년이상");	
}else{
	out.println(tedto.getTeacherExp()+"년");
} 

%> 
</td>
</tr>


<tr>
<td></td>
<td colspan=3>
<input type="button"  value="과외 신청정보 확인하기" onclick="apply(<%=i %>)">
<input type="button"  value="과정 리뷰보기" onclick="review(<%=i %>)">

 <input type="hidden" name="flag" id="flag<%=i %>" value="0">
 <input type="hidden" name="t_idx" value="<%=tedto.getTidx() %>">
<input type="button" value="선생님 회원등록 삭제" onclick="memberDelete(<%=i %>)">

</td>
</tr>
<tr>
<td  colspan=4  id="cont<%=i %>" width="800px"></td>
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

 <%@include file="/common/footer.jsp"%>

 </BODY>
</HTML>
