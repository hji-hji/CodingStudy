package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;
import kr.mypj.myapp.persistence.ApplyService_Mapper;
import kr.mypj.myapp.persistence.TeacherService_Mapper;

@Service
public class ApplyServiceImpl implements ApplyService{

	ApplyService_Mapper asm;
	
	@Autowired
	public ApplyServiceImpl(SqlSession sqlSession) {		
		this.asm =sqlSession.getMapper(ApplyService_Mapper.class);
	}
	
	
	@Override
	public int applyInsert(int tidx, int midx,  String studytime, int amount, String area, String contact, String contents) {
					
		int value = 0;		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("tidx", tidx);
		hm.put("midx", midx);
		hm.put("studytime", studytime);
		hm.put("amount", amount);
		hm.put("area", area);
		hm.put("contact", contact);
		hm.put("contents", contents);		
		
		value = asm.applyInsert(hm);
		
		return value;		
		
	}

	
	


//	@Override
//	public ArrayList<TeacherVo> teacherSelectAll(int midx) {
//		ArrayList<TeacherVo> tlist = new ArrayList<TeacherVo>();
//		
//		tlist = tsm.teacherSelectAll(midx);
//		
//		return tlist;
//	}
//
//
//	@Override
//	public int teacherDelete(int tidx, int midx) {
//		
//		int value = tsm.teacherDelete(tidx, midx);
//		
//		return value;
//	}
//
//
//	@Override
//	public TeacherDto teacherSelectOne(int tidx) {
//		TeacherDto tedto  = tsm.teacherSelectOne(tidx);
//		
//		return tedto;
//	}


	


	

}
