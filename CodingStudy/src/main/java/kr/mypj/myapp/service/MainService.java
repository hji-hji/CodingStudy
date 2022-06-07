package kr.mypj.myapp.service;

import java.util.ArrayList;

import kr.mypj.myapp.domain.CategoryVo;
import kr.mypj.myapp.domain.StudyareaVo;

public interface MainService {

	public ArrayList<CategoryVo> categorySelectAll();
	
	public ArrayList<StudyareaVo> studyareaSelectAll();
}
