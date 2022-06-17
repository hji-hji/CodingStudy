package kr.mypj.myapp.service;


import java.util.ArrayList;

import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;

public interface ApplyService {
	
	
	public int applyInsert(int tidx, int midx, String studytime, int amount, String area, String contact, String contents);
	

//	public ArrayList<TeacherVo> teacherSelectAll(int midx);
//	
//	public int teacherDelete(int tidx, int midx);
//	
//	public TeacherDto teacherSelectOne(int tidx);
}
