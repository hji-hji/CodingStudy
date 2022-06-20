package kr.mypj.myapp.persistence;

import java.util.ArrayList;
import java.util.HashMap;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.ReviewVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;

public interface ReviewService_Mapper {

	
	public int reviewInsert(HashMap<String,Object> hm);

	public ArrayList<ReviewVo> reviewSelectAll(int tidx);
	
	public int reviewDelete(HashMap<String,Object> hm);
	
//	public TeacherDto teacherSelectOne(int tidx);
	
	
}