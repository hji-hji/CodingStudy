package kr.mypj.myapp.service;


import java.util.ArrayList;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;

public interface ApplyService {
	
	
	public int applyInsert(int tidx, int midx, String studytime, String amount, String area, String contact, String contents);
	
	public ArrayList<ApplyDto> teacherMyApplyList(int tidx);
	
	public int applyCheckYnUpdate(int apidx);
	
	public ArrayList<ApplyDto> applyWriteCheck(int midx,int tidx);
}
