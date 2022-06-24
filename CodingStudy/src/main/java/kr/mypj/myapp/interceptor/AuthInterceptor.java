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
		 
		 //로그인 하지않은 경우
		 if(session.getAttribute("midx") == null){
			
			//이동할 주소를 담는다
			 saveUrl(request);		
			 
			//본인 pc에 저장된 쿠키 정보를 꺼낸다
			 Cookie loginCookie = WebUtils.getCookie(request,"loginCookie"); 
			 
		//	 System.out.println("uri:"+request.getRequestURI());
			 
			 //저장된 쿠키에 자동 로그인정보가 있으면
			if (loginCookie  != null){ 			
		
			//쿠키에 저장된 키정보와 같은 키가 DB에 있는지 체크해서 있으면 그 회원정보를 담는다 	
			 MemberVo mv =  ms.checkAutoLogin(loginCookie.getValue());
			 if (mv != null) {
				 
				 
				 
				 //자동로그인 기록이 존재하면 세션에 담고
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
				 
				 // DB 테이블에도 날짜 갱신
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
