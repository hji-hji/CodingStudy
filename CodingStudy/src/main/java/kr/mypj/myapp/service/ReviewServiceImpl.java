package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.ReviewVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;
import kr.mypj.myapp.persistence.ReviewService_Mapper;
import kr.mypj.myapp.persistence.TeacherService_Mapper;

@Service
public class ReviewServiceImpl implements ReviewService{

    ReviewService_Mapper rsm;
	
	@Autowired
	public ReviewServiceImpl(SqlSession sqlSession) {		
		this.rsm =sqlSession.getMapper(ReviewService_Mapper.class);
	}
	
	
	@Override
	public int reviewInsert(String writer, String content, int tidx,int midx, String ip) {
					
		int value = 0;		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("writer", writer);
		hm.put("content", content);
		hm.put("tidx", tidx);
		hm.put("midx", midx);
		hm.put("ip", ip);		
		
		value = rsm.reviewInsert(hm);
		
		return value;		
		
	}


	@Override
	public ArrayList<ReviewVo> reviewSelectAll(int tidx) {
		ArrayList<ReviewVo> rlist = new ArrayList<ReviewVo>();
		
		rlist = rsm.reviewSelectAll(tidx);
		
		return rlist;
	}


	@Override
	public int reviewDelete(int ridx, int tidx, int midx, String ip) {
	
		int value = 0;	
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("ridx", ridx);
		hm.put("tidx", tidx);
		hm.put("midx", midx);
		hm.put("ip", ip);
		
		value = rsm.reviewDelete(hm);
		return value;
	}
	

}
