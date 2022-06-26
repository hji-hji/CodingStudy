package kr.mypj.myapp.service;

import java.util.ArrayList;

import kr.mypj.myapp.domain.BoardVo;
import kr.mypj.myapp.domain.SearchCriteria;



public interface BoardService {
		
	public int boardTotal(SearchCriteria scri);
	
	public ArrayList<BoardVo> boardselectAll(SearchCriteria scri);
	
	public int boardInsert(String subject,String contents,String writer,String ip, String password, int midx,String gubun,String filename);
	
	public int boardView(int bidx);
	
	public BoardVo boardSelectOne(int bidx);
	
	public int boardUpdate(String subject,String contents,String writer, int bidx,String password);	
	
	public int boardDelete(int bidx, String password);
	
	public int boardReply(int bidx, int originbidx, int depth, int level_, String subject,
			String content, String writer, String password, String ip, int midx,String gubun);
	
	public int boardRecommend(int bidx);
	
	public ArrayList<BoardVo> boardMyQuestion(int midx);
	
	}
