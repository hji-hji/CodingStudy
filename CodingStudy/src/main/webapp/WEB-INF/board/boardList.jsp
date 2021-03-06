<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %> 
<%@ page import = "kr.mypj.myapp.domain.*" %>
<% ArrayList<BoardVo> alist =  (ArrayList<BoardVo>)request.getAttribute("alist"); 
PageMaker pm = (PageMaker)request.getAttribute("pm");
String gubun = (String)request.getAttribute("gubun");
String title="";
if (gubun.equals("c")){
	title = "커뮤니티";
}else{
	title = "문의";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글목록</title>
<style>

a {
  text-decoration: none;
} 
body
{
  margin: 0 auto;
  width: 1000px;
}
</style>
</head>
<body>

 <%@include file="/common/header.jsp"%>

<h1><%=title %> 게시판</h1>
<form name='frm' action='<%=request.getContextPath()%>/board/boardList.do' method='post'>
<input type="hidden" name="gubun" value="<%=gubun%>">
<table border ="0" width="1000px">
<tr>	
 <td width="800px" align="right">
 <select name="searchType">
 <option value="subject">제목</option>
 <option value="writer">작성자</option>
 </select>
 </td>
<td width="150px" align="right">
<input type='text' name='keyword' size=15>
</td>
<td>
<input type='submit' name='submit' value='검색' />
</td>
</tr>	
</table>
</form>
<table border= "1" width="1000px">
<tr align="center">
<td>번호</td>
<td width="500px">제목</td>
<td width="100px">작성자</td>
<td>작성일</td>
<td>조회수</td>
</tr>

<% for (BoardVo bv : alist){ %>
<tr>
<td><%= (pm.getTotalCount()-(pm.getScri().getPage()-1)*pm.getScri().getPerPageNum()) -alist.indexOf(bv) %></td>
<td>
<% 
for (int i=1;i<=bv.getLevel_();i++){
	out.print("&nbsp;&nbsp;");
	if (i == bv.getLevel_()){
		out.print("└");
	}
} 
%>
<a href="<%=request.getContextPath()%>/board/boardContent.do?gubun=<%=gubun%>&bidx=<%=bv.getBidx()%>"><%=bv.getSubject() %></a></td>
<td><%=bv.getWriter() %></td>
<td><%=bv.getWriteday().substring(0, 10) %></td>
<td><%=bv.getViewcnt() %></td>
</tr>
<% } %>
</table>

<br>
	
	<table border= "0" width="1000px">
	<tr>
		 	<td width="300px" align="right">
		 	<%if (pm.isPrev() == true) { %>
	 			<a href="<%=request.getContextPath() %>/board/boardList.do?gubun=<%=gubun%>&page=<%=pm.getStartPage()-1%>&keyword=<%=pm.encoding(pm.getScri().getKeyword())%>"> 			
		 			◀
	 			</a> 		
 			<% } %> 			
			</td>
 	 	<td width="200px" align="center">
 	 	  <% for(int i= pm.getStartPage(); i<=pm.getEndPage(); i++) { %>
        
           		<a href="<%=request.getContextPath() %>/board/boardList.do?gubun=<%=gubun%>&page=<%=i %>&keyword=<%=pm.encoding(pm.getScri().getKeyword())%>"><%=i %></a>
  
          <% } %>
  		</td>
		 	<td width="300px" align="left">
		 	<% if (pm.isNext() && pm.getEndPage() >0) { %>
 			<a href="<%=request.getContextPath() %>/board/boardList.do?gubun=<%=gubun%>&page=<%=pm.getEndPage()+1%>&keyword=<%=pm.encoding(pm.getScri().getKeyword())%>">
	 			▶
 			</a>
 			<% } %>
			</td>
		 </tr>
	 </table>
	
	<table border= 0  width="1000px">
	<tr>
	<td colspan=3 style="text-align:right"><a href="<%=request.getContextPath() %>/board/boardWrite.do?gubun=<%=gubun%>"> 글쓰기</a></td>
	</tr>
	</table>

 <%@include file="/common/footer.jsp"%>

</body>
</html>