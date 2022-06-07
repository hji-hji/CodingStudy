package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;
import kr.mypj.myapp.persistence.MainService_Mapper;



@Service
public class MainServiceImpl implements MainService  {

	MainService_Mapper msm;
	
	@Autowired
	public MainServiceImpl(SqlSession sqlSession) {		
		this.msm =sqlSession.getMapper(MainService_Mapper.class);
	}

	@Override
	public ArrayList<CategoryVo> categorySelectAll() {
				
		ArrayList<CategoryVo> clist = msm.categorySelectAll();
				
		return clist;
	}

	@Override
	public ArrayList<StudyareaVo> studyareaSelectAll() {

		ArrayList<StudyareaVo> slist = msm.studyareaSelectAll();
		
		return slist;
	}
	
	
	
	
	
}
