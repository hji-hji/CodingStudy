package kr.mypj.myapp.persistence;


import java.util.ArrayList;
import java.util.HashMap;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;

public interface ApplyService_Mapper {
	
	
	public int applyInsert(HashMap<String,Object> hm);
	
	
//	
//	public int teacherDelete(int tidx, int midx);
//	
//	public TeacherDto teacherSelectOne(int tidx);
}
