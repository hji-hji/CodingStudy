<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메일발송</title>
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
</head>
<body>
 <%@include file="/WEB-INF/views/common/header.jsp"%>

<table border="0" style="width:800px;">
<tr><td>
이메일이 발송되었습니다.<br>
<a href="<%=request.getContextPath()%>/main/main.do"> 메인가기</a>
</td>
</tr>
</table>
 <%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>