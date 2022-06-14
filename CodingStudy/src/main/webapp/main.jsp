<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.mypj.myapp.domain.*" %>    
<%  
		ArrayList<CategoryVo> clist  = (ArrayList<CategoryVo>)request.getAttribute("clist");
		ArrayList<StudyareaVo> slist  = (ArrayList<StudyareaVo>)request.getAttribute("slist");
%>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코딩과외 매칭 플랫폼 - 코딩쌤</title>
<style type="text/css">
body
{
  margin: 0 auto;
  width: 800px;
}
a {
  text-decoration: none;
} 
</style>
<style>
    .view-box{ 
      width: 750px; min-height: 20px; border: 1px solid black; 
    }
     .view-box2{ 
      width: 750px; min-height: 20px; border: 1px solid black;      
    }
   
  </style>
<script>
<%	if (request.getAttribute("msg") != null) { %>
		alert('<%=request.getAttribute("msg")%>');
<%	} %>
</script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.0.js"></script>
<script type="text/javascript">

var arr=[];

$(function(){
  $('input[name=cateName]').click(function(){
    var value = $(this).val();
    
    var index = arr.indexOf(value);
    //선택한 항목이 있으면(체크를 해제하면)
    if(index >=0){
    	$(this).css("color", "black");	
      arr.splice(index,1);
    //선택한 항목이 없으면(체크하면)
    }else{
    	$(this).css("color", "red");
      arr.push(value);
    }
    $('.view-box').text(arr.join(','));
    $('input[name=cateNameReq]').val(arr.join(','));
  });
  var arr2=[];
  $('input[name=areaName]').click(function(){
	    var value = $(this).val();
	    
	    var index = arr2.indexOf(value);
	    //선택한 항목이 있으면(체크를 해제하면)
	    if(index >=0){
	    	$(this).css("color", "black");	
	      arr2.splice(index,1);
	    //선택한 항목이 없으면(체크하면)
	    }else{
	    	$(this).css("color", "red");
	      arr2.push(value);
	    }
	    $('.view-box2').text(arr2.join(','));
	    $('input[name=areaNameReq]').val(arr2.join(','));
	  });
  
  $('#btn').click(function(){
	  
	  var cateNameReq = $('#cateNameReq').val();
	  var areaNameReq = $('#areaNameReq').val();
  
	  alert(cateNameReq);
	  alert(areaNameReq);
	  $.ajax({ 
  			type: 'post',        	
			url: '<%=request.getContextPath()%>/main/mainSearch.do', 
			data: {"cateNameReq" : cateNameReq,"areaNameReq" : areaNameReq},
			dataType : 'json', 			
			success: function(data) {				
		
				alert("success");
				
				 $.each(data, function (i, item) {
	                    alert("i : "+i);
	                    alert("item : "+item.areaName);
	                    alert("item : "+item.cateName);
	                });
				
							
			},
			error : function(){
				alert('서버요청실패');
			}
		}); 
	  
	  
  
  });
})
</script>

</head>
<body>

 <table border="1" style="width:800px;">
<tr>
<td style="width:310px">
<a href="<%=request.getContextPath() %>/main/main.do"><img src="test.jpg" width="300px" height="100px" alt="로고이미지"></a>
</td>
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

<table border="1" style="width:800px;">
<%
	   int cnt = clist.size();
	   for (int i=0 ; i< cnt; i = i+5) {
%>
<tr>
<% 
for(int j = i; j<i+5; j++) { 
	 if (j == cnt){
		 break;
	 }
%>
<td>
<input type="text" name="cateName"   value="<%=clist.get(j).getCateName() %>"  size=12  readonly >
</td>
<%} %>
</tr>
<%} %>

 </table>
 
<table>
<form name="frm">
<input type="hidden" name="cateNameReq" id="cateNameReq">
<input type="hidden" name="areaNameReq" id="areaNameReq">
<tr>
<td><div class="view-box"></div></td>
<td rowspan=2><input type="button" name="btn" id="btn" value="검색"></td>
</tr>
<tr>
<td><div class="view-box2"></div></td>
</tr>
</form>
</table>
 
 
 <table border="1" style="width:800px;">
<tr>
<td rowspan="4" style="width:150px;vertical-align:top;">

<%
int cnt2 = slist.size();
for (int i2=0 ; i2< cnt2 ; i2 = i2+2) {
	
	 for(int j2 = i2; j2<i2+2; j2++) {
		 if (j2 == cnt2){
			 break;
		 }
			 
%>
	<input type="text" name="areaName"   value="<%=slist.get(j2).getAreaName()%>"  size=2  readonly >			
<%		 
	 }
	 out.println("<br>");
}
%>

</td>
<td style="width:100px"><img src="test.jpg" width="100px" height="30px" alt="사진"></td>
<td>
&nbsp;이름 : 홍길동 <br>
&nbsp;과외 : C/C++ <br>
&nbsp;지역 : 서울  <br>
&nbsp;자기 소개 : test <br>
&nbsp;경력 및 경험 : 10년 

</td>
<td style="text-align:center;width:100px;">
<button onclick="location.href='<%=request.getContextPath()%>/review/reviewList.do'">리뷰보기</button>
<button onclick="location.href='<%=request.getContextPath()%>/apply/applyJoin.do'">과외 신청</button>
</td>
</tr>
<tr>
<td><img src="test.jpg" width="100px" height="30px" alt="사진"></td>
<td>
&nbsp;이름 : 홍길동 <br>
&nbsp;과외 : C/C++ <br>
&nbsp;지역 : 서울  <br>
&nbsp;자기 소개 : test <br>
&nbsp;경력 및 경험 : 10년 
</td>
<td  style="text-align:center;">
<button onclick="location.href='<%=request.getContextPath()%>/review/reviewList.do'">리뷰보기</button>
<button onclick="location.href='<%=request.getContextPath()%>/apply/applyJoin.do'">과외 신청</button>
</td>
</tr>
<tr>
<td><img src="test.jpg" width="100px" height="30px" alt="사진"></td>
<td>
&nbsp;이름 : 홍길동 <br>
&nbsp;과외 : C/C++ <br>
&nbsp;지역 : 서울  <br>
&nbsp;자기 소개 : test <br>
&nbsp;경력 및 경험 : 10년 
</td>
<td  style="text-align:center;">
<button onclick="location.href='<%=request.getContextPath()%>/review/reviewList.do'">리뷰보기</button>
<button onclick="location.href='<%=request.getContextPath()%>/apply/applyJoin.do'">과외 신청</button>
</td>
</tr>
<tr>
<td style="text-align:left;" colspan="3">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button>더보기</button>
</td>
</tr>
</table>
<table border="1" style="width:800px;">
<tr>
<td>
회사명 : 다락 <br>
대표자 : 홍길동<br>
사업자 번호 : 111-11-11111<br>
주소 : 전북 전주시 ~<br>
연락처 : 010-111-1111<br>
</td>
</tr>
<tr>
<td>
@all right reserved
</td>
</tr>
 </table>

</body>
</html>