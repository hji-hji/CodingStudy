package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.TeacherVo;
import kr.mypj.myapp.persistence.TeacherService_Mapper;

@Service
public class TeacherServiceImpl implements TeacherService{

    TeacherService_Mapper tsm;
	
	@Autowired
	public TeacherServiceImpl(SqlSession sqlSession) {		
		this.tsm =sqlSession.getMapper(TeacherService_Mapper.class);
	}
	
	
	@Override
	public int teacherInsert(String teacherName, int caidx, String teacherPay, String teacherGender, String teacherPhone,int stidx, String teacherExp, String teacherInfo, String filename,String teacherEmail,String teacherIp, int midx) {
	//	System.out.println("teacherInsert");
	//	System.out.println(teacherName+ caidx+ teacherPay+ teacherGender+ teacherPhone+ stidx+ teacherExp+ teacherInfo+ filename+ teacherEmail+ teacherIp+ midx);
		
				
		int value = 0;		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("teacherName", teacherName);
		hm.put("caidx", caidx);
		hm.put("teacherPay", teacherPay);
		hm.put("teacherGender", teacherGender);
		hm.put("teacherPhone", teacherPhone);
		hm.put("stidx", stidx);
		hm.put("teacherExp", teacherExp);	
		hm.put("teacherInfo", teacherInfo);
		hm.put("filename", filename);
		hm.put("teacherEmail", teacherEmail);
		hm.put("teacherIp", teacherIp);
		hm.put("midx", midx);
		
		value = tsm.teacherInsert(hm);
		
		return value;		
		
	}


	@Override
	public ArrayList<TeacherVo> teacherSelectAll(int midx) {
		ArrayList<TeacherVo> tlist = new ArrayList<TeacherVo>();
		
		tlist = tsm.teacherSelectAll(midx);
		
		return tlist;
	}


	@Override
	public int teacherDelete(int tidx, int midx) {
		
		int value = tsm.teacherDelete(tidx, midx);
		
		return value;
	}


	

}
