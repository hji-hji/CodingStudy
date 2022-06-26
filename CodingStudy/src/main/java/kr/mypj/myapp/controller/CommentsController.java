package kr.mypj.myapp.controller;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import kr.mypj.myapp.domain.CommentsCriteria;
import kr.mypj.myapp.domain.CommentsVo;
import kr.mypj.myapp.service.CommentsService;



@RestController
public class CommentsController {
	
	@Autowired
	private CommentsService commentsService;
	
	//처음 10개 가져오기
	@RequestMapping(value="/comments/{bidx}/all.do")
	public HashMap<String,Object> commentsList(@PathVariable("bidx") int bidx){
		
		ArrayList<CommentsVo> alist =  commentsService.selectCommentsAll(bidx);
		int totalCnt = commentsService.commentsCnt(bidx);
		
		String moreView = "N";
		
		if (totalCnt > 10) {
			moreView = "Y";	
		}
		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("alist", alist);
		hm.put("moreView", moreView);			
		
		return hm;		
	}	
	
	//추가 부분 가져오기
	@RequestMapping(value="/comments/{nextBlock}/{bidx}/more.do")
	public HashMap<String,Object> moreCommentsList(@PathVariable("bidx") int bidx,@PathVariable("nextBlock") int nextBlock){
			
		CommentsCriteria cc = new CommentsCriteria();
		
//		int defaultBlock = cc.getBlock();
		int perBlockNum =  cc.getPerBlockNum();	
		
		ArrayList<CommentsVo> alist =  commentsService.getCommentsMore(bidx,nextBlock,perBlockNum);
		int totalCnt = commentsService.commentsCnt(bidx);
		
		int nextBlock_ = 0;		
		if (totalCnt > nextBlock*perBlockNum ) {
			nextBlock_ = nextBlock+1;	
		}
		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("alist", alist);
		hm.put("nextBlock", nextBlock_);			
		
		return hm;			
	}		
	
	@RequestMapping(value="/comments/{cidx}/{bidx}/{nextBlock}/del.do", method=RequestMethod.GET)
	public HashMap<String,Object> commentsDelete(
													@PathVariable("cidx") int cidx,
													@PathVariable("bidx") int bidx,
													@PathVariable("nextBlock") int nextBlock,												
													HttpSession session) 
	throws Exception{		
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());		
		String ip = InetAddress.getLocalHost().getHostAddress();				
		
		CommentsVo cv = new CommentsVo();		
		cv.setCidx(cidx);
		cv.setMidx(midx);
		cv.setIp(ip);		
		
		int value = commentsService.deleteComments(cv);
		
		HashMap<String,Object> hm = moreCommentsList(bidx,nextBlock-1);			
					
		return hm;
	}
	
	@RequestMapping(value="/comments/commentsWrite.do",   method=RequestMethod.POST)
	public HashMap<String,Object> commentsWrite(											
											@RequestParam("bidx") int bidx,
											@RequestParam("cwriter") String cwriter,
											@RequestParam("ccontent") String ccontent,
											@RequestParam("nextBlock") int nextBlock,											
											HttpSession session) 
	throws Exception{	
		
		String ip = InetAddress.getLocalHost().getHostAddress();		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		CommentsVo cv = new CommentsVo();
		cv.setBidx(bidx);
		cv.setCwriter(cwriter);
		cv.setCcontent(ccontent);
		cv.setIp(ip);
		cv.setMidx(midx);		
		
		int value = commentsService.insertComments(cv);
		
		HashMap<String,Object> hm = moreCommentsList(bidx,nextBlock-1);
		
		return hm;
	}
	
	
}
