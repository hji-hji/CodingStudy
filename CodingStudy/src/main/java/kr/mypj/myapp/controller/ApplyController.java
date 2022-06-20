package kr.mypj.myapp.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mypj.myapp.domain.MemberVo;
import kr.mypj.myapp.domain.StudyareaVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;
import kr.mypj.myapp.service.ApplyService;
import kr.mypj.myapp.service.MainService;
import kr.mypj.myapp.service.MemberService;
import kr.mypj.myapp.service.TeacherService;


@Controller
public class ApplyController {
	
	@Autowired
	TeacherService teacherService;
	
	@Autowired
	ApplyService applyService;
	
	@Autowired
	MainService mainservice;
	
		
	@RequestMapping(value = "/apply/applyJoin.do", method = RequestMethod.GET)
	public String applyJoin(@RequestParam("tidx") int tidx, Model model) {
		
		
		ArrayList<StudyareaVo> slist = mainservice.studyareaSelectAll();
		TeacherDto  tedto  = teacherService.teacherSelectOne(tidx);
		
		model.addAttribute("tedto", tedto);
		model.addAttribute("slist", slist);
		
		return "/WEB-INF/apply/applyJoin";
	}
	
	
	@RequestMapping(value = "/apply/applyList.do", method = RequestMethod.GET)
	public String applyList() {						
		
		return "/WEB-INF/apply/applyList";
	}
	
	@RequestMapping(value = "/apply/applyJoinAction.do")
	public String memberJoinAction(
			@RequestParam("tidx") int tidx,
			@RequestParam("studytime") String studytime,
			@RequestParam("amount") String amount,
			@RequestParam("area") String area,
			@RequestParam("contact") String contact,
			@RequestParam("contents") String contents,			
			RedirectAttributes rttr,
			HttpSession session
			) {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		int value= 0;
		String path= "";
		try {			
			value = applyService.applyInsert(tidx, midx, studytime, amount, area, contact, contents);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	//	System.out.println("value"+value);
		
		if (value == 1) {	
			
			rttr.addFlashAttribute("msg", "과외 신청이 되었습니다.");	
			path = "redirect:/member/memberApplyList.do";
		}else {
			path="redirect:/apply/applyJoin.do";
		}
		return path;
	}
	
	@ResponseBody
	@RequestMapping(value = "/apply/applyCheckYnUpdate.do")
	public String applyCheckYnUpdate(
			@RequestParam("apidx") int apidx) {	
		
		String checkYn = "N";
		int value = applyService.applyCheckYnUpdate(apidx);		
//		System.out.println("value"+value);
		
		
		String str = "{\"check\":"+value+"}";
		
		return str;
	}
	
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
