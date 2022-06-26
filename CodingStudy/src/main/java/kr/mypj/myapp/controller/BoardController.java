package kr.mypj.myapp.controller;


import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import kr.mypj.myapp.domain.BoardVo;
import kr.mypj.myapp.domain.PageMaker;
import kr.mypj.myapp.domain.SearchCriteria;
import kr.mypj.myapp.service.BoardService;
import kr.mypj.myapp.util.UploadFileUtiles;


@Controller
public class BoardController  {
	
	@Autowired
	BoardService bd;
	
	@Autowired(required= false)
	PageMaker pageMaker;
	
	
	@Resource(name="uploadPath")
	private String uploadPath;	

	
	@RequestMapping(value = "/board/boardList.do")
	public String boardList(
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			SearchCriteria scri, 
			Model model) {
			
	//	System.out.println("gubun"+gubun);
	
		scri.setGubun(gubun);
		int cnt = bd.boardTotal(scri);					
	
		pageMaker.setScri(scri);		
		pageMaker.setTotalCount(cnt);
		
		ArrayList<BoardVo> alist =  bd.boardselectAll(scri);
			
		model.addAttribute("alist", alist);
		model.addAttribute("pm", pageMaker);	
		model.addAttribute("gubun", gubun);
		
		return "/WEB-INF/board/boardList";
	}
	
	@RequestMapping(value="/board/boardWrite.do")
	public String boardWrite(@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			Model model) {
		
		model.addAttribute("gubun", gubun);
		
		return "/WEB-INF/board/boardWrite";
	}
	
	@RequestMapping(value="/board/boardWriteAction.do")
	public String boardWriteAction(
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			@RequestParam("subject") String subject,
			@RequestParam("contents") String contents,
			@RequestParam("writer") String writer,	
			@RequestParam("password") String password,
			@RequestParam("uploadfile") MultipartFile  uploadfile,
			Model model,
			HttpSession session
			) throws Exception {		
			
		
			MultipartFile file =uploadfile;
			System.out.println("원본파일이름:"+file.getOriginalFilename());
			
			//복사하고 저장된 파일이름찾기 
//			String savedName = uploadFile(file.getOriginalFilename(),file.getBytes());
//			System.out.println("savedName:"+savedName);
//			
//			model.addAttribute("savedName", savedName);
			String uploadedFileName= "";
			if (!file.getOriginalFilename().equals("")) {
			uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, 
															file.getOriginalFilename(), 
															file.getBytes());		
			}
			String ip= InetAddress.getLocalHost().getHostAddress();
			int midx = Integer.parseInt(session.getAttribute("midx").toString());
				
			int value = bd.boardInsert(subject,contents,writer,ip,password,midx,gubun,uploadedFileName);
		
		return "redirect:/board/boardList.do?gubun="+gubun;
	}	
	
	@RequestMapping(value="/board/boardContent.do")
	public String boardContent(
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			@RequestParam("bidx") int bidx,
			Model model
			) {			
		
		bd.boardView(bidx);
		BoardVo bv = bd.boardSelectOne(bidx);
		
		model.addAttribute("bv",bv);
		model.addAttribute("gubun", gubun);
					
		return "/WEB-INF/board/boardContent";
	}
	
	@RequestMapping(value="/board/boardModify.do")	
	public String boardModify(
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			@RequestParam("bidx") int bidx,
			Model model
			) {
				
		BoardVo bv = bd.boardSelectOne(bidx);
		model.addAttribute("bv",bv);	
		model.addAttribute("gubun", gubun);
		
		return "/WEB-INF/board/boardModify";
	}
	
	@RequestMapping(value="/board/boardModifyAction.do")
	public String boardModifyAction(
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			@RequestParam("subject") String subject,
			@RequestParam("contents") String contents,
			@RequestParam("writer") String writer,
			@RequestParam("bidx") int bidx,
			@RequestParam("password") String password,
			RedirectAttributes rttr
			) {	
		
							
		int value = bd.boardUpdate(subject,contents,writer,bidx,password);
				
		String path = null;
		if (value==1) {		
		path = "/board/boardContent.do?gubun="+gubun+"&bidx="+bidx;
		}else {
		rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");		
		path = "/board/boardModify.do?gubun="+gubun+"&bidx="+bidx;
		}
		return "redirect:"+path;
	}
	
	@RequestMapping(value="/board/boardDelete.do")	
	public String boardDelete(
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			@RequestParam("bidx") int bidx,
			Model model
			) {				
		
		model.addAttribute("bidx",bidx);
		model.addAttribute("gubun", gubun);
		
		return "/WEB-INF/board/boardDelete";
	}						
	
	@RequestMapping(value="/board/boardDeleteAction.do")
	public String boardDeleteAction(			
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			@RequestParam("bidx") int bidx,
			@RequestParam("password") String password,
			RedirectAttributes rttr
			) {			
							
		int value = bd.boardDelete(bidx,password);
				
		String path = null;
		if (value==1) {
		path = "/board/boardList.do?gubun="+gubun;
		}else {
		rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");			
		path = "/board/boardDelete.do?gubun="+gubun+"&bidx="+bidx;
		}
		return "redirect:"+path;
	}
	
	@RequestMapping(value="/board/boardReply.do")
	public String boardReply(
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			@RequestParam("bidx") int bidx,
			@RequestParam("originbidx") int originbidx,
			@RequestParam("depth") int depth,
			@RequestParam("level_") int level_,
			Model model) {
		
			model.addAttribute("bidx", bidx);
			model.addAttribute("originbidx", originbidx);
			model.addAttribute("depth", depth);
			model.addAttribute("level_", level_);
			model.addAttribute("gubun", gubun);
				
		return "/WEB-INF/board/boardReply";
	}
	
	@RequestMapping(value="/board/boardReplyAction.do")
	public String boardReplyAction(
			@RequestParam(value="gubun", required=false, defaultValue="c") String gubun,
			@RequestParam("bidx") int bidx,
			@RequestParam("originbidx") int originbidx,
			@RequestParam("depth") int depth,
			@RequestParam("level_") int level_,
			@RequestParam("subject") String subject,
			@RequestParam("contents") String contents,
			@RequestParam("writer") String writer,	
			@RequestParam("password") String password,	
			Model model,
			HttpSession session) throws UnknownHostException {
		
			String ip = InetAddress.getLocalHost().getHostAddress();
			
			System.out.println("gubun:"+gubun);
			
			int midx = Integer.parseInt(session.getAttribute("midx").toString());
			int value = bd.boardReply(bidx,originbidx,depth,level_,subject,contents,writer,password,ip,midx,gubun);
					
			String path = null;
			if (value==1)
			path = "/board/boardList.do?gubun="+gubun;
			else
			path = "/board/boardReply.do?gubun="+gubun+"&bidx="+bidx+"&originbidx="+originbidx+"&depth="+depth+"&level_="+level_;
			
			return "redirect:"+path;
	}
	
//	@RequestMapping(value="/board/boardRecommend.do")	
//	public String boardRecommend(
//			@RequestParam("bidx") int bidx			
//			) {				
//		
//		int value = bd.boardRecommend(bidx);	
//		
//		String path = null;
//		path = "/board/boardContent.do?bidx="+bidx;
//		
//		return "redirect:/"+path;		
//	}	
	
	
	
	
	
	
	
}
