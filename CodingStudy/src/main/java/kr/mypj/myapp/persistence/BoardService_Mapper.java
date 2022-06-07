package kr.mypj.myapp.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import kr.mypj.myapp.domain.BoardVo;
import kr.mypj.myapp.domain.SearchCriteria;

public interface BoardService_Mapper {
		
	public ArrayList<BoardVo> boardselectAll(SearchCriteria scri);
	
	public int boardTotal(SearchCriteria scri);
	
	public int boardInsert(HashMap<String,Object> map); 
		
	public int boardView(int bidx);
	
	public BoardVo boardSelectOne(int bidx);
	
	public int boardUpdate(HashMap<String,Object> map);
	
	public int boardDelete(HashMap<String,Object> map);
	
	public int boardReplyUpdate(int originbidx, int level_);
	
	public int boardReplyInsert(HashMap<String,Object> map);
	
	public int boardRecommend(int bidx);
	
	public int rtnOriginbidx();
	}
