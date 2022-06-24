package kr.mypj.myapp.interceptor;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class LoginInterceptor extends HandlerInterceptorAdapter {
		
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,Object handler,ModelAndView modelAndView) throws Exception{
				
	 Object midx = modelAndView.getModel().get("midx");
	 Object memberApproveYn = modelAndView.getModel().get("memberApproveYn");
	 Object memberName = modelAndView.getModel().get("memberName");
	 
	 modelAndView.getModel().clear();  //파리미터 model 값 지우기
	
	 if(midx != null){
		 //컨트롤러에서 담은 모델값 꺼내서 세션에 담기
		 request.getSession().setAttribute("midx", midx);
		 request.getSession().setAttribute("memberApproveYn", memberApproveYn);
		 request.getSession().setAttribute("memberName", memberName);
		 
		 System.out.println("useCookie:"+request.getParameter("useCookie"));
		 
		 if (request.getParameter("useCookie") != null ) {
		 
		//	 DateFormat df = new SimpleDateFormat("yyMMdd");   
		//	 String Cookiedate = df.format(new Date());	 
		//	 int sessionLimit = Integer.parseInt(Cookiedate);
		//	 System.out.println("sessionLimit:"+sessionLimit);
						 
			 Cookie loginCookie = new Cookie("loginCookie",request.getSession().getId());
			 loginCookie.setPath("/");
			 //7일동안 클라이언트 쿠키보관한다
			 loginCookie.setMaxAge(60*60*24*7);				 
			 response.addCookie(loginCookie);		
		 }
		}	
	}
	 @Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler) throws Exception{
			
		 HttpSession session = request.getSession();		 
		 
		 if(session.getAttribute("midx") != null){
			 session.removeAttribute("midx");
			 session.removeAttribute("memberApproveYn");
			 session.removeAttribute("memberName");
		 }
		 
		 return true;		
	 	}
	 }
