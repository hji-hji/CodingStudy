<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.mypj.myapp.domain.BoardVo" %>  
<%@ page import="java.net.URLEncoder"  %>
  
<% BoardVo bv = (BoardVo)request.getAttribute("bv"); 
String gubun = (String)request.getAttribute("gubun");
String title="";
if (gubun.equals("c")){
	title = "커뮤니티";
}else{
	title = "문의";
}
int midx = 0 ;
if (session.getAttribute("midx") != null){
	midx =  Integer.parseInt(session.getAttribute("midx").toString());
}
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글내용</title>

<style>
a {
  text-decoration: none;
} 
body
{
border : 1px solid bold;
  margin: 0 auto;
  width: 800px;
}
#tbl {
	width:100%;	
}
#morebtn {
	width:100%;	
	text-align:center;
}

#tbl ul, #commenttbl ul {	
	list-style: none; 
	margin: 0;
	padding: 0; 
	
}
#tbl li.title1,#tbl li.title2,#tbl li.title3,#tbl li.title4 {	
	height:30px;
	background-color:#b2ebf4;	
	border-bottom:1px solid #000;
	text-align:center;
	}
#tbl li.sub1,#tbl li.sub2,#tbl li.sub4 {	
	height:60px;
	background-color:#FFFFFF;	
	border-bottom:1px solid #000;
	text-align:center;
}
#tbl li.sub1,li.title1 {
	float:left;
	width:5%;		
}
#tbl li.sub2,li.title2 {
	float:left;
	width:15%;		
}
#tbl li.sub3,li.title3 {
	float:left;
	width:70%;	
	height:60px;
	background-color:#FFFFFF;	
	border-bottom:1px solid #000;
}
#tbl li.sub4,li.title4 {
	float:left;
	width:10%;		
}
</style>
    <!-- jQuery 3.3.1 -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
//alert("str");

$(function(){	
	
	var originalFileName = getOriginalFileName('<%=bv.getFilename()%>');
	
	var str ="";
	
	if(checkImageType('<%=bv.getFilename()%>')){
		str ="<div>"
		+ "<a href='<%=request.getContextPath()%>/displayFile.do?fileName="+getImageLink('<%=bv.getFilename()%>')+"'>"
		+ "<img src='<%=request.getContextPath()%>/displayFile.do?fileName=<%=bv.getFilename()%>' /></a>"
		+ "<a href='<%=request.getContextPath()%>/displayFile.do?fileName="+getImageLink('<%=bv.getFilename()%>')+"&down=1'>"
		+ originalFileName 
		+ "</a>"
		+ "</div>";
	}else{
		str = "<div>"
			+ "<a href='<%=request.getContextPath()%>/displayFile.do?fileName=<%=URLEncoder.encode(bv.getFilename(),"UTF-8")%>'>"
			+ originalFileName
			+ "</a>"
			+ "</div>";
	}
	
	
	$("#download").html(str);
	
	
		
		$.boardCommentList();
		
		$('#more').click(function(){
		
			var nextBlock = $("#nextBlock").val();			
						
			$.ajax({
				type : "GET",
				url  : "<%=request.getContextPath()%>/comments/"+nextBlock+"/<%=bv.getBidx()%>/more.do",
				datatype : "text",
				cache : false,
				error : function(){				
					alert("error");
				},
				success : function(data){
					//alist와 nextBlock나온다
					
					$("#nextBlock").val(data.nextBlock);
			//		alert("다음예정페이지:"+data.nextBlock);
					if (data.nextBlock !=999){
						  $("#more").css('display','block');
					}else{
						  $("#more").css('display','none');
					}									
					
					commentList(data.alist);
					}			
			});	 
			
		});
		 
		 $('#save').click(function(){			
				
			 var bidx = <%=bv.getBidx()%>;	
			 var cwriter = $("#cwriter").val();
			 var ccontent = $("#ccontent").val();		
			 var nextBlock = $("#nextBlock").val();
		
			 $.ajax({
					type : "POST",
					url  : "<%=request.getContextPath()%>/comments/commentsWrite.do",
					datatype : "text",
					data : {						
						bidx : bidx,
						cwriter : cwriter,
						ccontent : ccontent,
						nextBlock:nextBlock
					},
					cache : false,
					error : function(){				
						alert("error");
					},
					success : function(data){		
							 
						if (data.moreView =="N"){
							$("#more").css('display','none');
						}else{
							$("#more").css('display','block');
						}
						commentList(data.alist);
							
							$("#bidx").val("");
							$("#cwriter").val("");
							$("#ccontent").val("");
							$("#nextBlock").val("2");
							}			
				});	
		});			 
});

$.boardCommentList = function(){
	
	$.ajax({
		type : "GET",
		url  : "<%=request.getContextPath()%>/comments/<%=bv.getBidx()%>/all.do",
		datatype : "text",
		cache : false,
		error : function(){				
			alert("error");
		},
		success : function(data){	
			
			if (data.moreView =="N"){
				$("#more").css('display','none');
			}else{
				$("#more").css('display','block');
			}
			commentList(data.alist);
			
			}			
	});	 	
}

$.del = function(cidx){
	
	 var nextBlock = $("#nextBlock").val();
	 	 
	 $.ajax({
			type : "GET",
			url  : "<%=request.getContextPath()%>/comments/"+cidx+"/<%=bv.getBidx()%>/"+nextBlock+"/del.do",		
			datatype : "text",				
			cache : false,
			error : function(){				
				alert("error");
			},
			success : function(data){			
						
				$("#nextBlock").val(data.nextBlock);
		//		alert("삭제하기"+data.nextBlock);
				if (data.nextBlock !=999){
					  $("#more").css('display','block');
				}else{
					  $("#more").css('display','none');
				}	
				commentList(data.alist);
	
			}			
			});	
}	

function commentList(data){
	var str = '';						
	var midx = <%=midx%>;
	
	$(data).each(function(){
		
		var delinput = "";
		if (midx == this.midx) {
			delinput ="<li class='sub4'><button class='btn btn-danger' onclick='$.del("+this.cidx+")'>삭제</button></li>";
			}
		
		str += "<ul><li class='sub1'>"+this.cidx   + "</li>" 
			+  "<li class='sub2'>"+this.cwriter + "</li>"
			+  "<li class='sub3'>"+this.ccontent  + "</li>"
			+  delinput
			+  "</ul>";					
	});
	
	$('#tbl').html("<ul><li class='title1'>번호</li>"
					+"<li class='title2'>작성자</li>"
					+"<li class='title3'>내용</li>"
					+"<li class='title4'>삭제여부</li>"
					+"</ul>"
					+str+"");				
}
function checkImageType(fileName){
	
	var pattern = /jpg$|gif$|png$|jpeg$/i;
//	alert(fileName.match(pattern));
	
	return fileName.match(pattern);
}

function getOriginalFileName(fileName){
	//이미지 파일이면 그만
//	if (checkImageType(fileName)) {
//		return;
//	}
	
	var idx = fileName.lastIndexOf("_")+1;
//	alert("ori"+idx);
	
	return fileName.substr(idx);
}
//파일이 이미지일경우
function getImageLink(fileName){
	if (!checkImageType(fileName)) {
		return;
	}
	//위치 폴더뽑기
	var front = fileName.substr(0,12);
	//alert(front);
	//파일이름뽑기
	var end = fileName.substr(14);
	//alert(end);
	return front+end;	
}
</script>
</head>
<body>

<table border="1" style="width:800px;">
<tr>
<td style="width:300px"><a href="<%=request.getContextPath() %>/main/main.do"><img src="test.jpg" width="300px" height="100px" alt="로고이미지"></a></td>
<td><a href="<%=request.getContextPath() %>/board/boardList.do?gubun=c">커뮤니티</a></td>
<td><a href="<%=request.getContextPath() %>/board/boardList.do?gubun=q">문의게시판</a></td>
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
<h1><%=title %> 게시판</h1>
<table border="1" style="text-align:left;width:800px;height:300px">
<tr>
<td style="width:100px;height:50px">제목</td>
<td><%=bv.getSubject() %></td>
<td style="width:50px">작성자</td>
<td><%=bv.getWriter() %></td>
<td style="width:50px">조회수</td>
<td><%=bv.getViewcnt() %></td>
</tr>

<tr>
<td style="height:100px">파일</td>
<td colspan=5>
<div id="download"></div>
</td>
</tr>
<tr>
<td style="height:300px">내용</td>
<td colspan=5>

<%=bv.getContents() %>
</td>
</tr>

<tr>
<td colspan="6" style="text-align:left;">
<a href="<%=request.getContextPath()%>/board/boardModify.do?gubun=<%=gubun%>&bidx=<%=bv.getBidx()%>">수정</a>
<a href="<%=request.getContextPath()%>/board/boardDelete.do?gubun=<%=gubun%>&bidx=<%=bv.getBidx()%>">삭제</a>
<a href="<%=request.getContextPath()%>/board/boardReply.do?gubun=<%=gubun%>&bidx=<%=bv.getBidx()%>&originbidx=<%=bv.getOriginbidx() %>&depth=<%=bv.getDepth()%>&level_=<%=bv.getLevel_()%>">답변</a>
<a href="<%=request.getContextPath()%>/board/boardList.do?gubun=<%=gubun%>">목록</a>

</td>
</tr>
</table>

<% if (gubun.equals("c")){ %>

<div id="commenttbl">
	<table border="1" style="width:800px;">
	<tr>
	<td>작성자</td>
	<td rowspan=4>
	<input id='nextBlock' type='hidden' value='2' />
	<input type="button" name="save" id="save" value="저장" class="comment_input" />	
	</td>
	</tr>
	<tr>
	<td>
	<input type="text" class="form-control" name="cwriter" id ="cwriter" placeholder="이름입력하세요" />
	</td>
	</tr>
		
	<tr>
	<td>내용</td>
	</tr>
	<tr>
	<td>
	<textarea class="form-control" name="ccontent" id="ccontent" rows="3" cols="100" placeholder="내용입력하세요"></textarea>
	</td>
	</tr>
	</table>
</div>

<div id="tbl"></div>
<div id="morebtn">
<button id='more'>더보기</button>
</div>

<%} %>

</body>
</html>