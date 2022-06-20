package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.ApplyDto;
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
	public int applyInsert(int tidx, int midx,  String studytime, String amount, String area, String contact, String contents) {
					
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


	@Override
	public ArrayList<ApplyDto> teacherMyApplyList(int tidx) {
		ArrayList<ApplyDto> aplist =  asm.teacherMyApplyList(tidx);
		
		return aplist;
	}


	@Override
	public int applyCheckYnUpdate(int apidx) {
		int value = asm.applyCheckYnUpdate(apidx);
		return value;
	}



	

}
