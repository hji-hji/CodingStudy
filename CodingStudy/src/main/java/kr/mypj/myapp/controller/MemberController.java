package kr.mypj.myapp.controller;


import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.BoardVo;
import kr.mypj.myapp.domain.MemberVo;
import kr.mypj.myapp.domain.ReviewDto;
import kr.mypj.myapp.service.BoardService;
import kr.mypj.myapp.service.MemberService;


@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
		
	@RequestMapping(value = "/member/memberJoin.do", method = RequestMethod.GET)
	public String memberJoin() {						
		
		return "/WEB-INF/member/memberJoin";
	}
	
	@RequestMapping(value = "/member/memberJoinAction.do")
	public String memberJoinAction(
			@RequestParam("memberId") String memberId,
			@RequestParam("memberPwd") String memberPwd,
			@RequestParam("memberName") String memberName,
			@RequestParam("memberPhone") String memberPhone,
			@RequestParam("memberEmail") String memberEmail,
			@RequestParam("memberGender") String memberGender,
			@RequestParam("memberBirth") String memberBirth,
			@RequestParam("memberApproveYn") String memberApproveYn,
			RedirectAttributes rttr
			) throws Exception {			
	
		String path= "";			
		String memberPwd2 =  bcryptPasswordEncoder.encode(memberPwd);
		int value = memberService.memberInsert(memberId, memberPwd2, memberName, memberPhone, memberEmail, memberGender, memberBirth,memberApproveYn);
			
		if (value == 1) {	
			
			rttr.addFlashAttribute("msg", "???????? ??????????.");	
			path = "redirect:/main/main.do";
		}else {
			path="redirect:/member/memberJoin.do";
		}
		return path;
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/memberIdCheck.do")
	public String memberIdCheck(
			@RequestParam("memberId") String memberId) {	
		
		int value = memberService.idCheck(memberId);		
//		System.out.println("value"+value);
		
		String str = "{\"checkValue\":"+value+"}";
		
		return str;
	}
	
	@RequestMapping(value="/member/memberLogin.do")
	public String memberLogin() {
				
		return "/WEB-INF/member/memberLogin";
	}
	
	@RequestMapping(value="/member/memberLoginAction.do")
	public String memberLoginAction(
			@RequestParam("memberId") String memberId,
			@RequestParam("memberPwd") String memberPwd,
			@RequestParam(value="useCookie",required=false) String useCookie,
			RedirectAttributes rttr,
			HttpSession session			
			
			) throws Exception {		
			
		MemberVo mv = memberService.memberLogin(memberId);
		
		String path= "";			
		
		if (mv != null &&  bcryptPasswordEncoder.matches(memberPwd, mv.getMemberPwd())) {
			
			rttr.addAttribute("midx", mv.getMidx());	
			rttr.addAttribute("memberApproveYn", mv.getMemberApproveYn());
			rttr.addAttribute("memberName", mv.getMemberName());
			
			System.out.println("useCookie:"+useCookie);
			
			
			if (useCookie != null){
				
				//impl keeplogin ?????? db????					
				Calendar cal = Calendar.getInstance();
			    cal.setTime(new Date());
			    cal.add(Calendar.DATE, 7);
			    DateFormat df = new SimpleDateFormat("yy-MM-dd");   
			    String sessionLimit = df.format(cal.getTime());
			   
				System.out.println(mv.getMidx());
				System.out.println(session.getId());
				System.out.println(sessionLimit);
				
			    memberService.keeplogin(mv.getMidx(), session.getId(), sessionLimit);
				
			}					
			
			if (session.getAttribute("saveUrl") != null) {
				String pj[] = session.getAttribute("saveUrl").toString().split("/");
				String saveUrl = session.getAttribute("saveUrl").toString().substring(pj[1].length()+1 ) ;
				path = "redirect:"+saveUrl;	
			}else {
				path = "redirect:/main/main.do";
			}		
	
		}else {
			rttr.addFlashAttribute("msg", "?????? ?? ?????????? ????????????");		
			path = "redirect:/member/memberLogin.do";	
		}			

		return path;
	}	
	
	
	@RequestMapping(value="/member/memberLogout.do")
	public String memberLogout(HttpSession session) {	
				
		int value=0;
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		value = memberService.memberLogOut(midx);
		
		if (value != 0) {
		//???? ????
		session.removeAttribute("midx");
		session.removeAttribute("memberApproveYn");
		session.removeAttribute("memberName");
		session.invalidate();		
		}
		return "/WEB-INF/member/memberLogout";
	}
	
	
	@RequestMapping(value="/member/memberMypage.do")
	public String memberMypage(HttpSession session, Model model) {
	
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		MemberVo mv = memberService.memberSelectOne(midx);
			
		model.addAttribute("mv", mv);
				
		return "/WEB-INF/member/memberMypage";
	}
	
	@RequestMapping(value = "/member/memberModify.do", method = RequestMethod.GET)
	public String memberModify(HttpSession session, Model model) {		
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		MemberVo mv = memberService.memberSelectOne(midx);
		
		model.addAttribute("mv", mv);
		
		return "/WEB-INF/member/memberModify";
	}
	
	
	@RequestMapping(value = "/member/memberModifyAction.do")
	public String memberModifyAction(
			@RequestParam("memberName") String memberName,
			@RequestParam("memberPhone") String memberPhone,
			@RequestParam("memberEmail") String memberEmail,
			@RequestParam("memberGender") String memberGender,
			@RequestParam("memberBirth") String memberBirth,
			HttpSession session,
			RedirectAttributes rttr
			) {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		int value = memberService.memberModify(memberName, memberPhone, memberEmail, memberGender, memberBirth, midx);
				
		String path= "";
		
		if (value == 1) {	
			
			rttr.addFlashAttribute("msg", "???????? ???? ??????????.");	
			path = "redirect:/member/memberMypage.do";
		}else {
			path="redirect:/member/memberModify.do";
		}
		return path;
	}
	

	@RequestMapping(value = "/member/memberApplyList.do", method = RequestMethod.GET)
	public String memberApplyList(Model model, HttpSession session) {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		ArrayList<ApplyDto> aplist =  memberService.memberApplyList(midx);
		
		model.addAttribute("aplist", aplist);
		
		return "/WEB-INF/member/memberApplyList";
	}
	
	@RequestMapping(value = "/member/memberReviewList.do", method = RequestMethod.GET)
	public String memberReviewList(HttpSession session, Model model) {		
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		ArrayList<ReviewDto> relist = memberService.memberReviewList(midx);
		
		model.addAttribute("relist", relist);
		
		return "/WEB-INF/member/memberReviewList";
	}
	
	
	@RequestMapping(value = "/member/memberPwdChange.do", method = RequestMethod.GET)
	public String memberPwdChange() {						
		
		return "/WEB-INF/member/memberPwdChange";
	}
	
	@RequestMapping(value = "/member/memberPwdChangeAction.do", method = RequestMethod.POST)
	public String memberPwdChangeAction(
			@RequestParam("memberPwd") String memberPwd,
			HttpSession session,
			RedirectAttributes rttr) {	
				
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		String memberPwd2 =  bcryptPasswordEncoder.encode(memberPwd);
		
		int value = memberService.passwordChange(memberPwd2,midx);
				
		String path= "";
		
		if (value == 1) {	
			
			rttr.addFlashAttribute("msg", "?????????? ???? ??????????.");	
			path = "redirect:/member/memberMypage.do";
		}else {
			path = "redirect:/member/memberPwdChange.do";
		}
		
		
		return path;
	}
	
	
	
	@RequestMapping(value = "/member/memberBoardList.do", method = RequestMethod.GET)
	public String memberBoardList(HttpSession session, Model model) {
				
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		
		ArrayList<BoardVo> blist =  boardService.boardMyQuestion(midx);
		
		model.addAttribute("blist", blist);
		
		return "/WEB-INF/member/memberBoardList";
	}
	
	@RequestMapping(value="/member/memberOut.do")
	public String memberOut() {	
				
		return "/WEB-INF/member/memberOut";
	}
	
	
	@RequestMapping(value="/member/memberOutAction.do")
	public String memberOutAction(@RequestParam("reason") String reason, HttpSession session, RedirectAttributes rttr) {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		int value = memberService.memberDelete(midx,reason);
		
		String path= "";
		
		if (value == 1) {	
			//???? ??????
			session.invalidate();
			
			rttr.addFlashAttribute("msg", "???????? ??????????.");	
			path = "redirect:/main/main.do";
		}else {
			path = "redirect:/member/memberOut.do";
		}		
		
		return path;
	}
	
	
	@RequestMapping(value = "/member/memberIdFind.do", method = RequestMethod.GET)
	public String memberIdFind() {						
		
		return "/WEB-INF/member/memberIdFind";
	}
		
	@RequestMapping(value = "/member/memberIdFindAction.do", method = RequestMethod.POST)
	public String memberIdFindAction(
			@RequestParam("memberName") String memberName,
			@RequestParam("memberEmail") String memberEmail,
			RedirectAttributes rttr) {
		
		
		String memberId = null;
		String path= "";
		
		memberId = memberService.memberIdFind(memberName,memberEmail);
		
		
		if (memberId != null) {	
			rttr.addFlashAttribute("memberId", memberId);
			path = "redirect:/member/memberIdMessage.do";
		}else {
			rttr.addFlashAttribute("msg", "???????? ???????? ????????.");			
			path = "redirect:/member/memberIdFind.do";
		}		
		
		
		return path;
	}
	
	@RequestMapping(value = "/member/memberPwdFind.do", method = RequestMethod.GET)
	public String memberPwdFind() {						
		
		return "/WEB-INF/member/memberPwdFind";
	}
	
	@RequestMapping(value = "/member/memberPwdFindAction.do", method = RequestMethod.POST)
	public String memberPwdFindAction(
			@RequestParam("memberId") String memberId,
			@RequestParam("memberEmail") String memberEmail,
			MemberVo mv,
			RedirectAttributes rttr,
			HttpServletResponse response) throws Exception {		
	
		String memberPwd = null;
		String path= "";
		
		memberPwd = memberService.memberPwdFind(memberId,memberEmail);		
		
		//?????? ??????????
		if (memberPwd != null) {	
		//	rttr.addFlashAttribute("memberPwd", memberPwd);		
						
			// ???? ???????? ????
			String randomPwd = "";
			for (int i = 0; i < 12; i++) {
				randomPwd += (char) ((Math.random() * 26) + 97);
			}
			//?????????? ????
			String memberPwd2 =  bcryptPasswordEncoder.encode(randomPwd);
			// ???????? ????
			int value = memberService.updatePwd(memberId,memberPwd2);
						
			mv.setMemberId(memberId);
			mv.setMemberPwd(randomPwd);
			mv.setMemberEmail(memberEmail);
			
			// ???????? ???? ???? ????
			memberService.sendEmail(mv, "findpw");			
			
			path = "redirect:/member/memberSendEmailMessage.do";
		}else {
			rttr.addFlashAttribute("msg", "???????? ??????/???????? ????????.");			
			path = "redirect:/member/memberPwdFind.do";
		}		
		
		
		return path;		
		
	}	
	
	@RequestMapping(value="/member/memberAuth.do")
	public String memberAuth(HttpSession session, RedirectAttributes rttr) {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		int value = memberService.memberApproveYnUpdate(midx);
		
		String path= "";
		
		if (value == 1) {				
			rttr.addFlashAttribute("msg", "??????????????.");	
			session.setAttribute("memberApproveYn", "Y");
		}
		path = "redirect:/member/memberMypage.do";
		return path;
	}
	
	
	@RequestMapping(value = "/member/memberSendEmailMessage.do", method = RequestMethod.GET)
	public String memberSendEmailMessage() {						
		
		return "/WEB-INF/member/memberSendEmailMessage";
	}
	
	@RequestMapping(value = "/member/memberIdMessage.do", method = RequestMethod.GET)
	public String memberIdMessage() {						
		
		return "/WEB-INF/member/memberIdMessage";
	}
	
}
