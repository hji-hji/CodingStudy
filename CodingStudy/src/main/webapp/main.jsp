<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.mypj.myapp.domain.*" %>    
<%  
		ArrayList<CategoryVo> clist  = (ArrayList<CategoryVo>)request.getAttribute("clist");
		ArrayList<StudyareaVo> slist  = (ArrayList<StudyareaVo>)request.getAttribute("slist");
		ArrayList<TeacherDto> telist  = (ArrayList<TeacherDto>)request.getAttribute("telist");

		int midx = 0;
		if (session.getAttribute("midx") != null){
				midx = Integer.parseInt(session.getAttribute("midx").toString());
		}

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
var arr2=[];
var arr3=[];
$(function(){
	
	$("#more").css('display','none');
	
	
  $('input[name=cateName]').click(function(){
    var value = $(this).val();
    
    var index = arr.indexOf(value);
    var index3 = arr3.indexOf(value);
    //선택한 항목이 있으면(체크를 해제하면)
    if(index3 >=0){
    	$(this).css("color", "black");	
      arr.splice(index,1);
      arr3.splice(index3,1);
    //선택한 항목이 없으면(체크하면)
    }else{
    	$(this).css("color", "red");
      arr.push(value);
      arr3.push(value);
    }         
    $('.view-box').text(arr3.join(','));
    $('input[name=cateNameReq]').val(arr.join(','));
  });
 
  $('input[name=areaName]').click(function(){
	    var value = $(this).val();
	    	    
	    var index2 = arr2.indexOf(value);
	    var index3 = arr3.indexOf(value);
	    //선택한 항목이 있으면(체크를 해제하면)
	    if(index3 >=0){
	    	$(this).css("color", "black");	
	      arr2.splice(index2,1);
	      arr3.splice(index3,1);     
	    //선택한 항목이 없으면(체크하면)
	    }else{
	    	$(this).css("color", "red");
	      arr2.push(value);	
	      arr3.push(value);
	    }	
	
	    $('.view-box').text(arr3.join(','));	    
	    
	    $('input[name=areaNameReq]').val(arr2.join(','));
	  });  
})
</script>
<script type="text/javascript">
function teacherSelectAll(i){	
	  
	var block = 0;
	 if (i ==1){
		 block = $("#nextBlock").val();  
	  }else{
		 block= 1; 
	  }	
	  
	  var cateNameReq = $('#cateNameReq').val();
	  var areaNameReq = $('#areaNameReq').val();
 	  var str = "";
 	  var midx = <%=midx%>;
 	  var sttr="";
 	  var teacherExp="";
 	  var teacherGender="";
	  var teacherPayStr="";
	  var index=0;
	  
	  $.ajax({ 
 			type: 'post',        	
			url: '<%=request.getContextPath()%>/main/mainSearch.do', 
			data: {"cateNameReq" : cateNameReq,"areaNameReq" : areaNameReq, "block" :block},
			dataType : 'json', 			
			success: function(data) {				
		
				$("#nextBlock").val(data.nextBlock);
				
				if (data.nextBlock !=0){
					  $("#more").css('display','block');
				}else{
					  $("#more").css('display','none');
				}
				
				 $.each(data.telist, function (i, item) {				
				
					 sttr = "";
					 if(item.midx !=midx){
			          sttr = "<button onclick=location.href='<%=request.getContextPath()%>/apply/applyJoin.do?tidx="+item.tidx+"'>과외 신청</button>";
			             }	
					 teacherExp ="";
					 if(item.teacherExp =="6"){
						 teacherExp = "5년이상";
				     }else if (item.teacherExp =="0"){
				    	 teacherExp = "1년이내";
				     }else {
				    	 teacherExp = item.teacherExp+"년";
				     }	
					 teacherGender="";
					 if(item.teacherGender =="M"){
						 teacherGender = "남성";
					 }else{
						 teacherGender = "여성";
					 }
					 teacherPayStr="";
					 if (item.teacherPay !="협의"){
						 teacherPayStr ="만원/시간";
					 }						 
					 
	             str = str + "<table border=1 style='width:650px;vertical-align:top;'><tr>"
	             +"<td style='width:100px;'><img src='<%=request.getContextPath()%>/displayFile.do?fileName="+item.filename+"' width='100px' height='100px' alt='사진'></td>"
	             +"<td>이름:"+item.teacherName 
	             +"<br>과목:"+item.cateName
	             +" <br>경력:"+teacherExp
	             +"<br>성별:"+teacherGender
	             +"<br>지역:"+item.areaName
	             +"<br>학습비:"+item.teacherPay + teacherPayStr
	             +"<br>자기소개:"+item.teacherInfo
	             +"</td>"
	             +"<td width='100px'>"
	             +"<button onclick=location.href='<%=request.getContextPath()%>/review/reviewList.do?fileName="+item.filename+"'>리뷰보기</button>"
	             + sttr   
	             +"</td></tr></table>"; 
				 });
				
				
				$("#cont").html(str); 				
				
			},
			error : function(){
				alert('서버요청실패');
			}
		}); 	 
 
 }

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
<input type="hidden" name="cateNameReq" id="cateNameReq" size=35>
<input type="hidden" name="areaNameReq" id="areaNameReq" size=35>
<tr>
<td class="view-box"></td>
<td><input type="button" name="btn" id="btn" value="검색" onclick="teacherSelectAll(0);"></td>
</tr>
</form>
</table> 

 <table border="1" style="width:800px;">
<tr>
<td style="width:150px;vertical-align:top;">

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
<td id="cont">
<% for (TeacherDto tedto : telist){ %>
<table border=1 style='width:650px;vertical-align:top;'>
<tr>
<td style='width:100px;''><img src='<%=request.getContextPath()%>/displayFile.do?fileName=<%=tedto.getFilename() %>'  width="100px" height="100px"></td>
<td>이름 : <%=tedto.getTeacherName()%>
<br>과목 : <%=tedto.getCateName() %> 
<br>경력 :<% if (tedto.getTeacherExp().equals("6")) {
	        	  out.println("5년이상");
               }else if(tedto.getTeacherExp().equals("0")){
            	   out.println("1년이내");
			  }else{ 
	        	  out.println(tedto.getTeacherExp()+"년");
	          } %> 
<br>성별:<% if (tedto.getTeacherGender().equals("M")){out.println("남성");}else{out.println("여성");} %>
<br>지역: <%=tedto.getAreaName() %> 
<br>학습비:<%=tedto.getTeacherPay() %> <% if (!tedto.getTeacherPay().equals("협의")) {%>만원/시간<%} %> 
<br>자기소개:<%=tedto.getTeacherInfo() %>
 </td>
<td width='100px'>
<button onclick="location.href='<%=request.getContextPath()%>/review/reviewList.do?tidx=<%=tedto.getTidx()%>'">리뷰보기</button>
<%if (tedto.getMidx() != midx){%>
<button onclick="location.href='<%=request.getContextPath()%>/apply/applyJoin.do?tidx=<%=tedto.getTidx()%>'">과외신청</button>
<%} %>
</td>
</tr>
</table>

<%} %>
</td>
</tr>


<tr>
<td></td>
<td>
<input id='nextBlock' type='hidden' />
<input type="button" id='more' onclick="teacherSelectAll(1);" value="더보기">
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