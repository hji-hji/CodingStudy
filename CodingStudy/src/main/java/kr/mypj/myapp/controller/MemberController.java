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

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.BoardVo;
import kr.mypj.myapp.domain.MemberVo;
import kr.mypj.myapp.service.BoardService;
import kr.mypj.myapp.service.MemberService;


@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
		
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
			RedirectAttributes rttr
			) throws Exception {			
	
		String path= "";			
		int value = memberService.memberInsert(memberId, memberPwd, memberName, memberPhone, memberEmail, memberGender, memberBirth);
			
		if (value == 1) {	
			
			rttr.addFlashAttribute("msg", "회원가입 되었습니다.");	
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
			RedirectAttributes rttr,
			HttpSession session			
			
			) throws Exception {		
			
		MemberVo mv = memberService.memberLogin(memberId,memberPwd);

		String path= "";			
		
		if (mv != null) {
			
			rttr.addAttribute("midx", mv.getMidx());	
			rttr.addAttribute("memberApproveYn", mv.getMemberApproveYn());
			
			if (session.getAttribute("saveUrl") != null) {
				String pj[] = session.getAttribute("saveUrl").toString().split("/");
				String saveUrl = session.getAttribute("saveUrl").toString().substring(pj[1].length()+1 ) ;
				path = "redirect:"+saveUrl;	
			}else {
				path = "redirect:/main/main.do";
			}		
	
		}else {
			rttr.addFlashAttribute("msg", "아이디 및 비밀번호를 확인해주세요");		
			path = "redirect:/member/memberLogin.do";	
		}			

		return path;
	}	
	
	
	@RequestMapping(value="/member/memberLogout.do")
	public String memberLogout(HttpSession session) {	
				
		//세션 삭제
		session.removeAttribute("midx");
		session.invalidate();		
		
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
			
			rttr.addFlashAttribute("msg", "회원정보 수정 되었습니다.");	
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
	public String memberReviewList() {						
		
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
		
		int value = memberService.passwordChange(memberPwd,midx);
				
		String path= "";
		
		if (value == 1) {	
			
			rttr.addFlashAttribute("msg", "비밀번호가 변경 되었습니다.");	
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
	public String memberOut(HttpSession session) {	
				
		return "/WEB-INF/member/memberOut";
	}
	
	
	@RequestMapping(value="/member/memberOutAction.do")
	public String memberOutAction(@RequestParam("reason") String reason, HttpSession session, RedirectAttributes rttr) {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		int value = memberService.memberDelete(midx,reason);
		
		String path= "";
		
		if (value == 1) {	
			//세션 초기화
			session.invalidate();
			
			rttr.addFlashAttribute("msg", "회원탈퇴 되었습니다.");	
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
	
	@RequestMapping(value = "/member/memberPwdFind.do", method = RequestMethod.GET)
	public String memberPwdFind() {						
		
		return "/WEB-INF/member/memberPwdFind";
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
		}else {
			rttr.addFlashAttribute("msg", "해당하는 아이디가 없습니다.");			
		}		
		path = "redirect:/member/memberIdFind.do";
		
		return path;
	}
	
	@RequestMapping(value = "/member/memberPwdFindAction.do", method = RequestMethod.POST)
	public String memberPwdFindAction(
			@RequestParam("memberId") String memberId,
			@RequestParam("memberEmail") String memberEmail,
			RedirectAttributes rttr) {
		
	
		String memberPwd = null;
		String path= "";
		
		memberPwd = memberService.memberPwdFind(memberId,memberEmail);
		System.out.println("memberPwd"+memberPwd);
		
		if (memberPwd != null) {	
			rttr.addFlashAttribute("memberPwd", memberPwd);			
		}else {
			rttr.addFlashAttribute("msg", "해당하는 아이디/이메일이 없습니다.");			
		}		
		path = "redirect:/member/memberPwdFind.do";
		
		return path;		
		
	}	
	
	@RequestMapping(value="/member/memberAuth.do")
	public String memberAuth(HttpSession session, RedirectAttributes rttr) {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		int value = memberService.memberApproveYnUpdate(midx);
		
		String path= "";
		
		if (value == 1) {				
			rttr.addFlashAttribute("msg", "인증되었습니다.");				
		}
		path = "redirect:/member/memberMypage.do";
		return path;
	}
	
	
	
	
	
}
