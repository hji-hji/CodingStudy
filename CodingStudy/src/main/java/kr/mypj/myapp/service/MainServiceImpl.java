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
	public HashMap<String, Object> teacherSelectAll(String cateNameReq, String areaNameReq, int block) {
		
		String[] cateName = null;
		if (!cateNameReq.equals("")) {
			cateName = cateNameReq.split(",");	
		}
		
		String[] areaName = null;
		if (!areaNameReq.equals("")) {
			areaName = areaNameReq.split(",");	
		}	
		
		int perBlockNum = 20;
		
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("cateName", cateName);
		hm.put("areaName", areaName);
		hm.put("blockCnt", block*perBlockNum);
		
		int cnt = msm.teacherSelectTotal(hm);
		
		ArrayList<TeacherDto> telist = msm.teacherSelectAll(hm);
		
		HashMap<String, Object> hm2 = new HashMap<String, Object>();
		hm2.put("cnt", cnt);
		hm2.put("telist", telist);
		
		return hm2;
	}

	@Override
	public ArrayList<TeacherDto> teacherRandomSelectAll() {
		ArrayList<TeacherDto> telist = msm.teacherRandomSelectAll();
		return telist;
	}
	
	
	
	
	
}
