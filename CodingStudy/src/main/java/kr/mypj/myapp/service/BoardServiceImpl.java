package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.mypj.myapp.domain.BoardVo;
import kr.mypj.myapp.domain.SearchCriteria;
import kr.mypj.myapp.persistence.BoardService_Mapper;


@Service
public class BoardServiceImpl implements BoardService{
	
	BoardService_Mapper bsm;
	
	@Autowired
	public BoardServiceImpl(SqlSession sqlSession) {		
		this.bsm =sqlSession.getMapper(BoardService_Mapper.class);
	}	
	
	@Override
	public int boardTotal(SearchCriteria scri) {
			
		int cnt = bsm.boardTotal(scri);	
		
		return cnt;
	}
	
	@Override
	public ArrayList<BoardVo> boardselectAll(SearchCriteria scri) {
				
		ArrayList<BoardVo> alist = bsm.boardselectAll(scri);
		
		return alist;
	}	
	
	
	public int boardInsert(String subject,String contents,String writer,String ip, String password, int midx,String gubun,String filename) {
		
		int value = 0;
		
	//	int originbidx = bsm.rtnOriginbidx();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
	//	map.put("originbidx", originbidx);
		map.put("subject", subject);
		map.put("contents", contents);
		map.put("writer", writer);		
		map.put("ip", ip);	
		map.put("password", password);
		map.put("midx", midx);
		map.put("gubun", gubun);
		map.put("filename",filename);
		
		bsm.boardInsert(map);		
		value = bsm.boardBidxUpdate(map.get("bidx"));				 
				 
		return value;
	}

	@Override
	public int boardView(int bidx) {		
		
		int value = bsm.boardView(bidx);
		
		return value;
	}

	@Override
	public BoardVo boardSelectOne(int bidx) {
				
		BoardVo bv = bsm.boardSelectOne(bidx);
		
		return bv;
	}

	@Override
	public int boardUpdate(String subject, String contents, String writer, int bidx, String password) {
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("subject", subject);
		map.put("contents", contents);
		map.put("writer", writer);
		map.put("bidx", bidx);	
		map.put("password", password);
		
		int value  = bsm.boardUpdate(map);	
		
		return value;
	}

	@Override
	public int boardDelete(int bidx, String password) {
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("bidx", bidx);
		map.put("password", password);		
			
		int value  = bsm.boardDelete(map);
		
		return value;
	}

	@Transactional
	@Override
	public int boardReply(int bidx, int originbidx, int depth, int level_, String subject, String content,
			String writer, String password, String ip, int midx,String gubun) {
		
		System.out.println("gubun:"+gubun);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("bidx", bidx);
		map.put("originbidx", originbidx);
		map.put("depth", depth);
		map.put("level_", level_);
		map.put("subject", subject);
		map.put("contents", content);
		map.put("writer", writer);
		map.put("password", password);
		map.put("ip", ip);	
		map.put("midx", midx);
		map.put("gubun", gubun);
		map.put("filename","");
		
		bsm.boardReplyUpdate(originbidx, depth);
		int value  = bsm.boardReplyInsert(map);				
		
		return value;
	}

	@Override
	public int boardRecommend(int bidx) {				
		
		int value= bsm.boardRecommend(bidx);
		
		return value;
	}

	@Override
	public ArrayList<BoardVo> boardMyQuestion(int midx) {
		
		ArrayList<BoardVo> blist  = bsm.boardMyQuestion(midx);		
		
		return blist;
	}

	
	}
