<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>페이지</title>
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
<table border="1" style="width:800px;">
<tr>
<td style="width:300px"><a href="<%=request.getContextPath() %>/main/main.do"><img src="test.jpg" width="300px" height="100px" alt="로고이미지"></a></td>
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


개인정보 수집 및 이용 안내
다락 개인정보 수집 및 이용 안내
1. 개인정보 수집항목 및 이용목적
 다락(이하 “회사”)은 사이트 이용을 위해 필요한 최소한의 범위로 개인정보를 수집합니다. 회사는 이용자의 사전 동의 없이는 이용자의 개인 정보를 공개하지 않으며, 다음과 같은 목적을 위하여 개인정보를 수집하고 이용합니다.

1.서비스 제공
견적서·요청서 정보 제공 및 프로필 광고노출, 멤버십 등 기본적인 서비스 제공, 서비스 제공에 관한 계약 체결·유지·이행·관리·개선 및 서비스 제공에 따른 요금 정산 및 컨텐츠 서비스 이용, 구매 및 요금결제, 물품 배송 또는 청구지 등 발송, 이용자 레슨 정보 및 서비스 이용 정보 제공

2.회원관리
회원제 서비스에 따른 본인 확인, 개인 식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 회원 가입∙유지∙탈퇴 의사 확인, 연령확인, 만 14세 미만 아동 개인정보수집 시 법정 대리인 동의 여부 확인, 법정 대리인 권리행사 시 본인 확인, 법령상 의무 이행, 법령 및 약관 위반 여부에 관한 조사, 고객 센터 운영 불만처리 등 민원 처리, 고지사항 전달, 보증 금액 지급 시 본인 확인 등

3.마케팅 및 광고에 활용
신규 서비스(제품) 개발 및 특화, 뉴스레터, 이벤트 등 광고성 정보 전달, 인구통계학적 특성에 따른 서비스 제공 및 광고 게재, 마케팅 및 광고 등에 활용, 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계

-수집방법		
1.회원가입 
2.프로필 작성 
3.결제	

-수집항목
1.성명, 이메일, 휴대전화번호, 비밀번호	
2.대표서비스, 리뷰, 활동지역, 이동가능거리, 연락가능시간, 사업자등록증, 자격증 및 기타 서류, 서비스 상세설명, 사진 및 동영상 등
3.신용카드정보(카드사 이름, 카드 번호 16자리, 카드 유효기간, 카드 명의자 생년월일)	

-수집 및 이용목적
1.회원제 서비스 이용에 따른 본인 확인,회원 가입·유지·탈퇴, 고객 문의에 대한 응답,고지사항 전달,새로운 서비스 및 이벤트 정보 등의 안내
2.견적서 활동을 위한 정보 제공 및 프로필 광고 노출
3.서비스 및 부가 서비스 이용에 대한 요금 결제

2. 개인정보의 보유 및 이용기간

1.법령에서 별도로 정하거나 귀하와 별도 합의하는 등의 특별한 사정이 없는 한 이용자가  회원으로서 회사에 제공하는 서비스를 이용하는 동안 또는 제1조에서 정한 목적을 달성할 때까지 회사는 이용자들의 개인정보를 계속적으로 보유하며 서비스 제공 등을 위해 이용합니다.

2.이용자의 개인정보는 다음과 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기하는 것을 원칙으로 합니다. 다만, 회사는 서비스 혼선 방지, 수사기관에 대한 협조, 불량 회원의 부정한 이용의 재발 및 재가입을 방지하고 분쟁 해결을 위하여 이용계약 해지일로부터 6개월간 해당 회원의 이름, 아이디, 연락처, 부정이용 내역(서비스 이용기록, 접속로그, 쿠키, 접속IP정보)을 보관합니다.

3.상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.

-표시. 광고에 관한 기록: 6월 (전자상거래등에서의 소비자보호에 관한 법률)
-계약 또는 청약철회 등에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)
-대금결제 및 재화 등의 공급에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)
-소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 (전자상거래등에서의 소비자보호에 관한 법률)









</body>
</html>