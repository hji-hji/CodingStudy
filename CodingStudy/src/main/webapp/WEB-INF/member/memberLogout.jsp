<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그아웃페이지</title>
<style type="text/css">
body
{
  margin: 0 auto;
  width: 1000px;
}
a {
  text-decoration: none;
} 
</style>
</head>
<body>

 <%@include file="/common/header.jsp"%>
<table border="0" style="width:1000px;">
<tr>
<td>
로그아웃 되었습니다.<br>
<a href="<%=request.getContextPath()%>/main/main.do"> 메인가기</a>
</td>
</tr>
</table>
 <%@include file="/common/footer.jsp"%>
</body>
</html>