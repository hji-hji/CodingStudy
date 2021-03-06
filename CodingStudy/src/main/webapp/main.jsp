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
  width: 1000px;
}
a {
  text-decoration: none;
} 

.view-box{ 
  width: 950px; min-height: 20px; border: 1px solid black; 
}
 .view-box2{ 
  width: 950px; min-height: 20px; border: 1px solid black;      
}
td,input { 
   	/* 둥글게 만들기 */
   border-top-left-radius: 15px; border-top-right-radius: 15px;
   border-bottom-left-radius: 15px; border-bottom-right-radius: 15px;
}
 input:focus {outline: none;}  
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
    $('.view-box').html("&nbsp;&nbsp;"+arr3.join(','));
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
	
	    $('.view-box').html("&nbsp;&nbsp;"+arr3.join(','));	    
	    
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
					 
	             str = str + "<table border=0 style='width:850px;vertical-align:top;'><tr>"
	             +"<td style='width:100px;'><img src='<%=request.getContextPath()%>/displayFile.do?fileName="+item.filename+"' width='100px' height='100px' alt='사진'></td>"
	             +"<td style='width:170px;'>이름:"+item.teacherName 
	             +"<br>과목:"+item.cateName
	             +" <br>경력:"+teacherExp
	             +"<br>성별:"+teacherGender
	             +"<br>지역:"+item.areaName
	             +"<br>과외비:"+item.teacherPay + teacherPayStr
	             +"</td><td style='text-align:left;vertical-align:top;'>"
	             +"자기소개:<br>"+item.teacherInfo
	             +"</td>"
	             +"<td width='100px'>"
	             +"<button onclick=location.href='<%=request.getContextPath()%>/review/reviewList.do?tidx="+item.tidx+"'>리뷰보기</button>"
	             + sttr   
	             +"</td></tr>"
	             +"<tr><td colspan=4 style='background-color:gray;'></td>"
	             +"</tr>"	             
	             +"</table>"; 
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
 
 <%@include file="/common/header.jsp"%>  

<table border="1" style="width:1000px;border-top: none;border-bottom: none;border-left: none;border-right: none;">
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
<td style="background-color:#80a0e0">&nbsp;
<input type="text" name="cateName"  value="<%=clist.get(j).getCateName() %>"  size=15  readonly style="height:30px;border:none;background-color:#80a0e0;font-size:12pt;">
</td>
<%} %>
</tr>
<%} %>
 </table>
 
<form name="frm">
<input type="hidden" name="cateNameReq" id="cateNameReq">
<input type="hidden" name="areaNameReq" id="areaNameReq"> 
<table>
<tr><td colspan=2 style="height:1px"></td></tr>
<tr>
<td class="view-box"></td>
<td><input type="button" name="btn" id="btn" value="검색" style="font-size:12pt;" onclick="teacherSelectAll(0);"></td>
</tr>
</table>
</form> 
 <table border="0" style="width:1000px;">
<tr>
<td style="width:150px;vertical-align:top;" rowspan=2>

<%
int cnt2 = slist.size();
for (int i2=0 ; i2< cnt2 ; i2 = i2+2) {
	
	 for(int j2 = i2; j2<i2+2; j2++) {
		 if (j2 == cnt2){
			 break;
		 }			 
%>
	<input type="text" name="areaName" value="<%=slist.get(j2).getAreaName()%>"  size=2  readonly style="text-align:center;height:40px;border:none;background-color:#80a0e0;font-size:12pt;">			
<%		 
	 }
	 out.println("<br>");
}
%>

</td>
<td id="cont" style="vertical-align:top;">
<% for (TeacherDto tedto : telist){ %>
<table border=0 style='width:850px;vertical-align:top;'>
<tr>
<td style='width:100px;'><img src='<%=request.getContextPath()%>/displayFile.do?fileName=<%=tedto.getFilename() %>'  width="100px" height="100px"></td>
<td style='width:170px;'>이름 : <%=tedto.getTeacherName()%>
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
<br>과외비:<%=tedto.getTeacherPay() %> <% if (!tedto.getTeacherPay().equals("협의")) {%>만원/시간<%} %> 
</td>
<td style="text-align:left;vertical-align:top;">
자기소개:<br><%=tedto.getTeacherInfo() %>
 </td>
<td width='100px'>
<button onclick="location.href='<%=request.getContextPath()%>/review/reviewList.do?tidx=<%=tedto.getTidx()%>'">리뷰보기</button>
<%if (tedto.getMidx() != midx){%>
<button onclick="location.href='<%=request.getContextPath()%>/apply/applyJoin.do?tidx=<%=tedto.getTidx()%>'">과외신청</button>
<%} %>
</td>
</tr>
<tr>
<td colspan=4 style="background-color:gray;"></td>
</tr>
</table>
<%} %>
</td>
</tr>

<tr>

<td height="20">
<input id='nextBlock' type='hidden' />
<input type="button" id='more' onclick="teacherSelectAll(1);" value="더보기">
</td>
</tr>
</table>

 <%@include file="/common/footer.jsp"%>

</body>
</html>