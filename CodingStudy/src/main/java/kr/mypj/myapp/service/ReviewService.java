package kr.mypj.myapp.service;


import java.util.ArrayList;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.ReviewVo;
import kr.mypj.myapp.domain.TeacherDto;
import kr.mypj.myapp.domain.TeacherVo;

public interface ReviewService {
	
	public ArrayList<ReviewVo> reviewSelectAll(int tidx);
	
	public int reviewInsert(String writer, String content, int tidx,int midx, String ip);
	
	public int reviewDelete(int ridx, int midx, String ip);

	
}
