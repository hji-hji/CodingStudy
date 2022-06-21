package kr.mypj.myapp.persistence;

import java.util.ArrayList;
import java.util.HashMap;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;



public interface MainService_Mapper {
		
	public ArrayList<CategoryVo> categorySelectAll();
	
	public ArrayList<StudyareaVo> studyareaSelectAll();
	
	public ArrayList<TeacherDto> teacherSelectAll(HashMap<String, Object> hm);
	
	public int teacherSelectTotal(HashMap<String, Object> hm);
	
	public ArrayList<TeacherDto> teacherRandomSelectAll();
	}
