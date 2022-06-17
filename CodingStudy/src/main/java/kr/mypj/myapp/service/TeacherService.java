package kr.mypj.myapp.service;


import java.util.ArrayList;

import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;

public interface TeacherService {
	
	
	public int teacherInsert(String tearchName,int caidx,String teacherPay,String teacherGender,
			String teacherPhone,int stidx,String teacherExp,String teacherInfo,String filename,
			String teacherEmail,String teacherIp, int midx);
	

	public ArrayList<TeacherVo> teacherSelectAll(int midx);
	
	public int teacherDelete(int tidx, int midx);
	
	public TeacherDto teacherSelectOne(int tidx);
}
