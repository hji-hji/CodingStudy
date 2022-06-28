<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.mypj.myapp.domain.*" %>
<%@ page import="java.util.*" %>   
<% 
TeacherDto tedto = (TeacherDto)request.getAttribute("tedto");
ArrayList<ReviewVo> rlist = (ArrayList<ReviewVo>)request.getAttribute("rlist");
ArrayList<ApplyDto> aplist = (ArrayList<ApplyDto>)request.getAttribute("aplist");

int cnt= 0;
String checkYn= "N";

for (ApplyDto apdto : aplist){
	
	cnt = apdto.getCnt();
	System.out.println("cnt"+cnt);
	
	if (apdto.getCheckYn().equals("Y")){
		checkYn = apdto.getCheckYn();		
		break;
	}	
}	

String memberName= "";
	if (session.getAttribute("memberName") != null){
	memberName = (String)session.getAttribute("memberName");
	}
	int midx = 0;
	if (session.getAttribute("midx") != null){
			midx = Integer.parseInt(session.getAttribute("midx").toString());
	}	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>
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
<%//	if (request.getAttribute("msg") != null) { %>
	//	alert('<%//=request.getAttribute("msg")%>');
<%	//} %>
</script>
<script type="text/javascript">

function save(){
	
	var memberApproveYn = "<%=session.getAttribute("memberApproveYn")%>";
	var cnt = <%=cnt%>;
	var checkYn = "<%=checkYn%>";
	
	if (memberApproveYn != "Y"){
		alert("인증하신 회원만 글을 작성하실수 있습니다.");
		return;
	}
	if (cnt ==0){
		alert("과외 신청을 해야 등록이 가능합니다.");
		return;
	}
	if (checkYn =='N'){
		alert("선생님이 과외 신청정보를 확인하면 작성이 가능합니다.");
		return;
	}
	
	var fm = document.frm;
  	
  	if (fm.content.value ==""){
  		alert("내용을 등록 해주세요");
  		fm.content.focus();
  		return;
  	}	
	
  	fm.action = "<%=request.getContextPath()%>/review/reviewWriteAction.do";
  	fm.method = "post";
  	fm.submit();
	return;
}

function reviewDelete(tidx,ridx){
	
	if (confirm("삭제하시겠습니까?")){
		
		location.href="<%=request.getContextPath()%>/review/reviewDeleteAction.do?tidx="+tidx+"&ridx="+ridx;
	}
}


</script>

</head>
<body>

 <%@include file="/WEB-INF/views/common/header.jsp"%>

<h1>리뷰</h1>
<table border="1" style="text-align:left;width:800px;height:100px">
<tr>
<td style="width:400px;height:50px"><%=tedto.getCateName() %> </td>
<td><%=tedto.getTeacherName() %> </td>
</tr>

</table>

<form name="frm">
<input type="hidden" name="tidx" value="<%=tedto.getTidx()%>">
<table border="1" style="text-align:left;width:800px;">
<tr>
<td style="width:100px;height:30px">작성자</td>
<td><input type="text" name="writer" value="<%=memberName%>" readonly></td>
<td rowspan=2><input type="button" name="btn" value="저장" onclick="save();"> </td>
</tr>
<tr>
<td style="width:100px;height:50px">내용</td>
<td  style="width:600px;height:50px">
<textarea name="content" cols=80 rows=3 placeholder="회원 인증한 회원만 작성할수 있어요"></textarea>
</td>
</tr>
</table>
</form>
<% for (ReviewVo rv : rlist) {%>
<hr>
<%=rv.getWriter() %>:<br>
<%=rv.getContent()%>
<% if (rv.getMidx() == midx) {%>
<button onclick="reviewDelete(<%=rv.getTidx()%>,<%=rv.getRidx()%>);">삭제</button>
<%} %>
<br>

<%} %>

<hr>

 <%@include file="/WEB-INF/views/common/footer.jsp"%>

</body>
</html>