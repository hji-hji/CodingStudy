package kr.mypj.myapp.service;

import java.util.ArrayList;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;

public interface MainService {

	public ArrayList<CategoryVo> categorySelectAll();
	
	public ArrayList<StudyareaVo> studyareaSelectAll();
	
	public ArrayList<TeacherDto> teacherSelectAll(String cateNameReq, String areaNameReq);
}
