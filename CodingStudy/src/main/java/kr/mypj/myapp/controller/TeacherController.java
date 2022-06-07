package kr.mypj.myapp.controller;


import java.io.FileInputStream;
import java.io.InputStream;
import java.net.InetAddress;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mypj.myapp.util.MediaUtils;
import kr.mypj.myapp.util.UploadFileUtiles;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;
import kr.mypj.myapp.domain.TeacherVo;
import kr.mypj.myapp.service.MainService;
import kr.mypj.myapp.service.TeacherService;


@Controller
public class TeacherController {
	
	@Autowired
	MainService mainService;
	
	@Autowired
	TeacherService teacherService;
	
	@Resource(name="uploadPath")
	private String uploadPath;	
		
	@RequestMapping(value = "/teacher/teacherJoin.do", method = RequestMethod.GET)
	public String memberJoin(Model model) {	
		
		ArrayList<CategoryVo> clist = mainService.categorySelectAll();
		
		ArrayList<StudyareaVo> slist = mainService.studyareaSelectAll();		
		
		model.addAttribute("clist", clist);
		
		model.addAttribute("slist", slist);
		
		
		return "/WEB-INF/teacher/teacherJoin";
	}
	
	@RequestMapping(value = "/teacher/teacherMypage.do", method = RequestMethod.GET)
	public String teacherMypage(HttpSession session, Model model) {	
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		ArrayList<TeacherVo> tlist = teacherService.teacherSelectAll(midx);
		
		model.addAttribute("tlist", tlist);
		
		return "/WEB-INF/teacher/teacherMypage";
	}
	
	@ResponseBody
	@RequestMapping(value="/uploadAjax.do",method=RequestMethod.POST,produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception{
		
		System.out.println("원본이름:"+file.getOriginalFilename());		
	
		String uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, 
				file.getOriginalFilename(), 
				file.getBytes());
		
		
		ResponseEntity<String> entity = null;
		entity = new ResponseEntity<String>(uploadedFileName,HttpStatus.CREATED);
		
		//  /2018/05/30/s-dfsdfsdf-dsfsff.jsp
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/displayFile.do", method=RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		
	//	System.out.println("fileName:"+fileName);
		
		InputStream in = null;		
		ResponseEntity<byte[]> entity = null;
		
	//	logger.info("FILE NAME :"+fileName);
		
		try{
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			HttpHeaders headers = new HttpHeaders();		
			 
			in = new FileInputStream(uploadPath+fileName);
			
			
			if(mType != null){
				headers.setContentType(mType);
			}else{
				
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\""+
						new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");				
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
					headers,
					HttpStatus.CREATED);
			
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally{
			in.close();
		}
		return entity;
	} 
		
	
	@RequestMapping(value = "/teacher/teacherJoinAction.do")
	public String memberJoinAction(
			@RequestParam("tearchName") String tearchName,
			@RequestParam("caidx") int caidx,
			@RequestParam("teacherPay") String teacherPay,
			@RequestParam("teacherGender") String teacherGender,
			@RequestParam("teacherPhone") String teacherPhone,
			@RequestParam("stidx") int stidx,
			@RequestParam("teacherExp") String teacherExp,
			@RequestParam("teacherInfo") String teacherInfo,
			@RequestParam("uploadfile") String filename,
			@RequestParam("teacherEmail") String teacherEmail,
			HttpSession session,
			RedirectAttributes rttr
			) {	
		
		
		
		String teacherIp = null;
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		
		
		
		int value= 0;
		String path= "";
		try {			
			teacherIp = InetAddress.getLocalHost().getHostAddress();
		//	System.out.println(tearchName+ caidx+ teacherPay+ teacherGender+ teacherPhone+ stidx+ teacherExp+ teacherInfo+ filename+ teacherEmail+ teacherIp+ midx);
			value = teacherService.teacherInsert(tearchName, caidx, teacherPay, teacherGender, teacherPhone, stidx, teacherExp, teacherInfo, filename, teacherEmail, teacherIp, midx);
	//		System.out.println(value);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	//	System.out.println("value"+value);
		
		if (value == 1) {	
			
			rttr.addFlashAttribute("msg", "선생님 회원등록 되었습니다.");	
			path = "redirect:/teacher/teacherMypage.do";
		}else {
			path="redirect:/teacher/teacherJoin.do";
		}
		return path;
	}
	
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
