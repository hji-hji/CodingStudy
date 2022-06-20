package kr.mypj.myapp.controller;


import java.net.InetAddress;
import java.net.UnknownHostException;
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
import kr.mypj.myapp.domain.ReviewVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.service.MemberService;
import kr.mypj.myapp.service.ReviewService;
import kr.mypj.myapp.service.TeacherService;


@Controller
public class ReviewController {
			
	@Autowired
	TeacherService teacherService;
	
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping(value = "/review/reviewList.do", method = RequestMethod.GET)
	public String reviewList(@RequestParam("tidx") int tidx, Model model) {						
	//	System.out.println("reviewList");
		
		TeacherDto tedto = teacherService.teacherSelectOne(tidx);
		ArrayList<ReviewVo> rlist = reviewService.reviewSelectAll(tidx); 
		
		model.addAttribute("tedto", tedto);
		model.addAttribute("rlist", rlist);
		
		return "/WEB-INF/review/reviewList";
	}
	
	@RequestMapping(value = "/review/reviewWriteAction.do")
	public String reviewWriteAction(
			@RequestParam("tidx") int tidx,
			@RequestParam("writer") String writer,
			@RequestParam("content") String content,		
			RedirectAttributes rttr,
			HttpSession session
			) throws UnknownHostException {	
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		String ip = InetAddress.getLocalHost().getHostAddress();
		
		int value= 0;
		String path= "";
		try {			
			value = reviewService.reviewInsert(writer, content, tidx, midx, ip);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	//	System.out.println("value"+value);
		
		if (value == 1) {				
			rttr.addFlashAttribute("msg", "리뷰가 작성 되었습니다.");				
		}
		path = "redirect:/review/reviewList.do?tidx="+tidx;
		return path;
	}
	
	@RequestMapping(value = "/review/reviewDeleteAction.do")
	public String reviewDeleteAction(
			@RequestParam("tidx") int tidx,	
			@RequestParam("ridx") int ridx,
			RedirectAttributes rttr,
			HttpSession session
			) throws UnknownHostException {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		String ip = InetAddress.getLocalHost().getHostAddress();
		
		int value= 0;
		String path= "";
		try {			
			value = reviewService.reviewDelete(ridx, tidx, midx, ip);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		if (value == 1) {				
			rttr.addFlashAttribute("msg", "리뷰가 삭제 되었습니다.");				
		}
		path = "redirect:/review/reviewList.do?tidx="+tidx;
		return path;
	}
	
}
