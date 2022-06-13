package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;
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

	@Override
	public ArrayList<TeacherDto> teacherSelectAll(String cateNameReq, String areaNameReq) {
		
		String[] cateName = null;
		if (!cateNameReq.equals("")) {
			cateName = cateNameReq.split(",");	
		}
		
		String[] areaName = null;
		if (!areaNameReq.equals("")) {
			areaName = areaNameReq.split(",");	
		}	
		
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("cateName", cateName);
		hm.put("areaName", areaName);
		
		ArrayList<TeacherDto> telist = msm.teacherSelectAll(hm);
		System.out.println("t==>"+telist);
		
		return telist;
	}
	
	
	
	
	
}
