package kr.mypj.myapp.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mypj.myapp.domain.MemberVo;
import kr.mypj.myapp.service.MemberService;


@Controller
public class ReviewController {
			
	
	@RequestMapping(value = "/review/reviewList.do", method = RequestMethod.GET)
	public String reviewList() {						
	//	System.out.println("reviewList");
		
		return "/WEB-INF/review/reviewList";
	}
	
//	@RequestMapping(value = "/member/memberJoinAction.do")
//	public String memberJoinAction(
//			@RequestParam("memberId") String memberId,
//			@RequestParam("memberPwd") String memberPwd,
//			@RequestParam("memberName") String memberName,
//			@RequestParam("memberPhone") String memberPhone,
//			@RequestParam("memberEmail") String memberEmail,
//			@RequestParam("memberGender") String memberGender,
//			@RequestParam("memberBirth") String memberBirth,
//			RedirectAttributes rttr
//			) {	
//		
//		int value= 0;
//		String path= "";
//		try {			
//			value = memberService.insertMember(memberId, memberPwd, memberName, memberPhone, memberEmail, memberGender, memberBirth);
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//	//	System.out.println("value"+value);
//		
//		if (value == 1) {	
//			
//			rttr.addFlashAttribute("msg", "회원가입 되었습니다.");	
//			path = "redirect:/main/main.do";
//		}else {
//			path="redirect:/member/memberJoin.do";
//		}
//		return path;
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "/member/memberIdCheck.do")
//	public String memberIdCheck(
//			@RequestParam("memberId") String memberId) {	
//		
//		int value = memberService.idCheck(memberId);		
////		System.out.println("value"+value);
//		
//		String str = "{\"checkValue\":"+value+"}";
//		
//		return str;
//	}
//	
//	@RequestMapping(value="/member/memberLogin.do")
//	public String memberLogin() {
//				
//		return "/WEB-INF/member/memberLogin";
//	}
//	
//	@RequestMapping(value="/member/memberLoginAction.do")
//	public String memberLoginAction(
//			@RequestParam("memberId") String memberId,
//			@RequestParam("memberPwd") String memberPwd,
//			RedirectAttributes rttr,
//			HttpSession session			
//			
//			) throws Exception {		
//			
//		MemberVo mv = memberService.memberLogin(memberId,memberPwd);
//
//		String path= "";			
//		
//		if (mv != null) {
//			
//			rttr.addAttribute("midx", mv.getMidx());	
//			
//			if (session.getAttribute("saveUrl") != null) {
//				String pj[] = session.getAttribute("saveUrl").toString().split("/");
//				String saveUrl = session.getAttribute("saveUrl").toString().substring(pj[1].length()+1 ) ;
//				path = "redirect:"+saveUrl;	
//			}else {
//				path = "redirect:/main/main.do";
//			}		
//	
//		}else {
//			rttr.addFlashAttribute("msg", "아이디 및 비밀번호를 확인해주세요");		
//			path = "redirect:/member/memberLogin.do";	
//		}			
//
//		return path;
//	}	
//	
//	
//	@RequestMapping(value="/member/memberLogout.do")
//	public String memberLogout(HttpSession session) {	
//				
//		//세션 삭제
//		session.removeAttribute("midx");
//		session.invalidate();		
//		
//		return "/WEB-INF/member/memberLogout";
//	}
//	
//	
//	@RequestMapping(value="/member/memberMypage.do")
//	public String memberMypage() {
//				
//		return "/WEB-INF/member/memberMypage";
//	}
//	
//	@RequestMapping(value = "/member/memberModify.do", method = RequestMethod.GET)
//	public String memberModify() {						
//		
//		return "/WEB-INF/member/memberModify";
//	}
//	
	
}
