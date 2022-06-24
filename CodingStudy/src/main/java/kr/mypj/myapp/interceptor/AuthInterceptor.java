package kr.mypj.myapp.interceptor;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.mypj.myapp.domain.MemberVo;
import kr.mypj.myapp.service.MemberService;




public class AuthInterceptor extends HandlerInterceptorAdapter {
		
	@Autowired
	MemberService ms;
	
	 @Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler) throws Exception{
			
		 HttpSession session = request.getSession();		
		 
		 //�α��� �������� ���
		 if(session.getAttribute("midx") == null){
			
			//�̵��� �ּҸ� ��´�
			 saveUrl(request);		
			 
			//���� pc�� ����� ��Ű ������ ������
			 Cookie loginCookie = WebUtils.getCookie(request,"loginCookie"); 
			 
		//	 System.out.println("uri:"+request.getRequestURI());
			 
			 //����� ��Ű�� �ڵ� �α��������� ������
			if (loginCookie  != null){ 			
		
			//��Ű�� ����� Ű������ ���� Ű�� DB�� �ִ��� üũ�ؼ� ������ �� ȸ�������� ��´� 	
			 MemberVo mv =  ms.checkAutoLogin(loginCookie.getValue());
			 if (mv != null) {
				 
				 
				 
				 //�ڵ��α��� ����� �����ϸ� ���ǿ� ���
//				 request.getSession().setAttribute("midx", mv.getMidx());
//				 request.getSession().setAttribute("memberApproveYn", mv.getMemberApproveYn());
//				 request.getSession().setAttribute("memberName", mv.getMemberName());	
				 session.setAttribute("midx", mv.getMidx());
				 session.setAttribute("memberApproveYn", mv.getMemberApproveYn());
				 session.setAttribute("memberName", mv.getMemberName());
				 
				
				 Cookie loginCookie2 = new Cookie("loginCookie",loginCookie.getValue());
				 loginCookie2.setPath("/");
				 loginCookie2.setMaxAge(60*60*24*7);
				 response.addCookie(loginCookie2);	
				 
				 // DB ���̺��� ��¥ ����
				 Calendar cal = Calendar.getInstance();
				 cal.setTime(new Date());
				 cal.add(Calendar.DATE, 7);
				 DateFormat df1 = new SimpleDateFormat("yy-MM-dd");   
				 String sessionLimit = df1.format(cal.getTime());
				 
				 ms.keeplogin(mv.getMidx(), loginCookie.getValue(), sessionLimit);				
			 
				
				 
			 }else {
					
				 if (request.getRequestURI().equals(request.getContextPath()+"/main/main.do")) {				
					 return true;
				 }else {
					 response.sendRedirect(request.getContextPath()+"/member/memberLogin.do");	
					 return false;
				 }
				 
				 
			 }
			 
			}else {			
				 if (request.getRequestURI().equals(request.getContextPath()+"/main/main.do")) {				
					 return true;
				 }else {
					 response.sendRedirect(request.getContextPath()+"/member/memberLogin.do");	
					 return false;
				 }
			}	 			 
		 }
		 
		 return true;		
	 	}
	
	 private void saveUrl(HttpServletRequest req){
	
		 String uri = req.getRequestURI();		 
		 String query = req.getQueryString();
		
		 
		 if (query ==null || query.equals("null")){
			 query = "";
		 }else {
			 query = "?" + query;
		 }		
		 
		 if (req.getMethod().equals("GET")){
			 req.getSession().setAttribute("saveUrl", uri+query);	
		 }		 
	 }	
}
