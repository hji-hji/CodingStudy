<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>  
<%@ page import="kr.mypj.myapp.domain.*" %>    
<%  
		ArrayList<CategoryVo> clist  = (ArrayList<CategoryVo>)request.getAttribute("clist");
		ArrayList<StudyareaVo> slist  = (ArrayList<StudyareaVo>)request.getAttribute("slist");
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

.fileDrop {
width: 100%;
height:200px;
border:1px dotted blue;
}

small {
margin-left:3px;
font-weight:bold;
color:gray;
}
</style>
  <!-- jQuery 3.3.1 -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script type="text/javascript">
 // function addFilePath(msg){
//		alert(msg);	
//	}

	function checkImageType(fileName){
		
		var pattern = /jpg$|gif$|png$|jpeg$/i;
	//	alert(fileName.match(pattern));
		
		return fileName.match(pattern);
	}

	function getOriginalName(fileName){
//		alert(fileName);
		//이미지파일이면 원본이름 안쓴다
		if (checkImageType(fileName)) {
			return;
		}
		
		var idx = fileName.lastIndexOf("_")+1;
		
	//	alert(idx);
		return fileName.substr(idx);
	}

	//파일이 이미지일경우
	function getImageLink(fileName){
		if (!checkImageType(fileName)) {
			return;
		}
		//위치 폴더뽑기
		var front = fileName.substr(0,12);
		//파일이름뽑기
		//_는 빼고
		var end = fileName.substr(14);
		
		return front+end;	
	}

	$(document).ready(function(){
		
		$(".fileDrop").on("dragenter dragover",function(event){
		
			event.preventDefault();		
		});
		
		$(".fileDrop").on("drop",function(event){
		//	alert("drop");
			event.preventDefault();
			
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];
		//	alert(file);
			var formData = new FormData();
			
			formData.append("file",file);
			
			$.ajax({
				url:'<%=request.getContextPath()%>/uploadAjax.do',
				data: formData,
				dataType:'text',
				processData:false,
				contentType:false,
				type:'POST',
				success : function(data){
					
					//  /2018/05/30/s-sdsdsd-ssd22q.jpg
				//	alert(data);
				
					// input--> sdsdsd-ssd22q.jpg
					$("#uploadfile").val(data.replace("s-",""));		
					
					var str ="";
					
					if(checkImageType(data)){
						str ="<div>"
						+ "<a href='<%=request.getContextPath()%>/displayFile.do?fileName="+getImageLink(data)+"'>"
						+ "<img src='<%=request.getContextPath()%>/displayFile.do?fileName="+data+"' />"
					//	+ getImageLink(data) 
						+ "</a>"
						+ "</div>";
					}else{
						str = "<div>"
							+ "<a href='/displayFile.do?fileName="+data+"'>"
							+ getOriginalName(data) 
							+ "</a>"
							+ "</div>";
					}
					
					$(".uploadedList").append(str);
				}		
				
			});	
			
		});	
		
	});  
  </script>
  <script>
  function check(){
  //	alert("테스트");
  	
  	var fm = document.frm;
  	
  	if (fm.uploadfile.value ==""){
  		alert("사진을 등록 해주세요");
  		fm.uploadfile.focus();
  		return;
  	}else if (fm.tearchName.value ==""){
  		alert("이름을 입력해주세요");
  		fm.tearchName.focus();
  		return;
  	}else if (fm.caidx.value ==""){
  		alert("과목을 입력해주세요");
  		fm.caidx.focus();
  		return;
  	}else if (fm.teacherPay.value ==""){
  		alert("금액를 입력하세요");
  		fm.teacherPay.focus();
  		return;
  	}else if (fm.teacherPhone.value == ""){
  		alert("연락처를 입력해주세요");
   		fm.teacherPhone.focus();
  		return;
  	}else if (fm.stidx.value == ""){
  		alert("지역을 입력해주세요");  		
  		fm.stidx.focus();
  		return;
  	}else if (fm.teacherExp.value == ""){
  		alert("경력 및 경험을 입력해주세요");  		
  		fm.teacherExp.focus();
  		return;
  	}else if (fm.teacherInfo.value == ""){
  		alert("자기소개를 입력하세요");  		
  		fm.teacherInfo.focus();
  		return;
  	}else if (fm.memberApproveYn.value == "N"){
  		alert("회원인증을 하셔야 등록하실수 있습니다");  		
  		fm.memberApproveYn.focus();
  		return;
  	}		
  
  		fm.action = "<%=request.getContextPath()%>/teacher/teacherJoinAction.do";
  		fm.method = "post";
  		fm.submit();  	
  
  		return;
  }
  
  </script>
  
  
  
  
 </HEAD>

 <BODY>
 
  <%@include file="/WEB-INF/views/common/header.jsp"%>

<center><h1>선생님 회원등록</h1></center>
<hr></hr>
<form name="frm"> 
 <table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td style="width:150px">사진등록<br>(1.사진을 드래그해서 올려주세요 2.jpg/gif/png 파일만 가능합니다)</td>
<td class="fileDrop">
<input type="hidden" id ="uploadfile" name="uploadfile">

<div class="uploadedList"></div>

</td>
</tr>
<tr>
<td>이름</td>
<td><input type="text" name="tearchName" size="20"></td>
</tr>
<tr>
<td>과목</td>
<td>
<select name="caidx">
<option value="">-선택-</option>
<%for(CategoryVo cavo : clist) {%>
<option value="<%=cavo.getCaidx()%>"><%=cavo.getCateName() %></option>
<%} %>
</select>
</td>
</tr>
<tr>
<td>금액</td>
<td>
<select name="teacherPay">
<option value="">-선택-</option>
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
</select>/시간
</td>
</tr>
<tr>
<td>성별</td>
<td>
<input type="radio" name="teacherGender" value="M" checked> 남
<input type="radio" name="teacherGender" value="F"> 여
</td>
</tr>
<tr>
<td>연락처</td>
<td>
<input type="text" name="teacherPhone" size="20" placeholder="010-xxxx-xxxx">
</td>
</tr>
<tr>
<td>이메일</td>
<td>
<input type="text" name="teacherEmail" size="20" placeholder="test@test.com">
</td>
</tr>
<tr>
<td>지역</td>
<td>
<select name="stidx">
<option value="">-선택-</option>
<%for(StudyareaVo stvo : slist) {%>
<option value="<%=stvo.getStidx()%>"><%=stvo.getAreaName() %></option>
<%} %>
</select>
</td>
</tr>
<tr>
<td>경력및 경험</td>
<td>
<select name="teacherExp">
<option value="">-선택-</option>
<option value="0">1년이내</option>
<option value="1">1년</option>
<option value="2">2년</option>
<option value="3">3년</option>
<option value="4">4년</option>
<option value="5">5년</option>
<option value="6">5년이상</option>
</select>	
</td>
</tr>
<tr>
<td>자기소개</td>
<td><textarea name="teacherInfo" cols="50" rows="5"></textarea>	
</td>
</tr>
<tr>
<td></td>
<td>
<% String memberApproveYn = (String)session.getAttribute("memberApproveYn");%>   
<input type="hidden" name="memberApproveYn" value="<%=memberApproveYn%>">
<input type="button" name ="btn" value="확인" onclick="check();"> 
<input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/main/main.do';"> 
</td>
</tr>
 </table>
 </form>

  <%@include file="/WEB-INF/views/common/footer.jsp"%>
  
 </BODY>
</HTML>
