package kr.mypj.myapp.persistence;

import java.util.ArrayList;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;



public interface MainService_Mapper {
		
	public ArrayList<CategoryVo> categorySelectAll();
	
	public ArrayList<StudyareaVo> studyareaSelectAll();
	}
