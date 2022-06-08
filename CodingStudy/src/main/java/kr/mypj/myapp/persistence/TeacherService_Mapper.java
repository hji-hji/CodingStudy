package kr.mypj.myapp.persistence;

import java.util.ArrayList;
import java.util.HashMap;

import kr.mypj.myapp.domain.TeacherVo;

public interface TeacherService_Mapper {

	
	public int teacherInsert(HashMap<String,Object> hm);

	public ArrayList<TeacherVo> teacherSelectAll(int midx);
	
	public int teacherDelete(int tidx, int midx);
}