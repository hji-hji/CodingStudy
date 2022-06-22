package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.MemberVo;
import kr.mypj.myapp.domain.ReviewDto;
import kr.mypj.myapp.persistence.MemberService_Mapper;

@Service
public class MemberServiceImpl implements MemberService  {

	MemberService_Mapper msm;
	
	@Autowired
	public MemberServiceImpl(SqlSession sqlSession) {		
		this.msm =sqlSession.getMapper(MemberService_Mapper.class);
	}
	
	@Override
	public int memberInsert(String memberId, String memberPwd, String memberName, String memberPhone,
			String memberEmail, String memberGender, String memberBirth,String memberApproveYn) {
			
		int value = 0;		
		HashMap<String,String> hm = new HashMap<String,String>();
		hm.put("memberId", memberId);
		hm.put("memberPwd", memberPwd);
		hm.put("memberName", memberName);
		hm.put("memberPhone", memberPhone);
		hm.put("memberEmail", memberEmail);
		hm.put("memberGender", memberGender);
		hm.put("memberBirth", memberBirth);		
		hm.put("memberApproveYn", memberApproveYn);		
		
		value = msm.memberInsert(hm);
		return value;		
	}

	@Override
	public int idCheck(String memberId) {
		int value=0;
	
		value = msm.idCheck(memberId);		
		return value;
	}	
	
	@Override
	public MemberVo memberLogin(String memberId) {
		
		MemberVo mv = msm.memberLogin(memberId);		
		
		return mv;
	}

	@Override
	public MemberVo memberSelectOne(int midx) {
	
		MemberVo mv = msm.memberSelectOne(midx);
		return mv;
	}

	@Override
	public int memberModify(String memberName, String memberPhone, String memberEmail, String memberGender,
			String memberBirth, int midx) {
		
		int value = 0;		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("memberName", memberName);
		hm.put("memberPhone", memberPhone);
		hm.put("memberEmail", memberEmail);
		hm.put("memberGender", memberGender);
		hm.put("memberBirth", memberBirth);	
		hm.put("midx", midx);	

		value = msm.memberModify(hm);
		
		
		return value;
	}

	@Override
	public int passwordChange(String memberPwd,int midx) {
		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("memberPwd", memberPwd);
		hm.put("midx", midx);
		
		int value = msm.passwordChange(hm);
		
		return value;
	}

	@Override
	public int memberDelete(int midx, String reason) {
		
		HashMap<String,Object> hm = new HashMap<String,Object>();
		hm.put("midx", midx);
		hm.put("reason", reason);
		int value = msm.memberDelete(hm);
		
		return value;
	}

	@Override
	public String memberIdFind(String memberName, String memberEmail) {
		
		String memberId = msm.memberIdFind(memberName, memberEmail);
		
		return memberId;
	}

	@Override
	public String memberPwdFind(String memberId, String memberEmail) {

		String memberPwd  = msm.memberPwdFind(memberId, memberEmail);
		
		return memberPwd;
	}
	
	@Override
	public ArrayList<ApplyDto> memberApplyList(int midx) {
		
		ArrayList<ApplyDto> aplist = msm.memberApplyList(midx);
		
		return aplist;
	}

	@Override
	public int memberApproveYnUpdate(int midx) {
		int value = msm.memberApproveYnUpdate(midx);
		return value;
	}

	@Override
	public ArrayList<ReviewDto> memberReviewList(int midx) {
		ArrayList<ReviewDto> relist = msm.memberReviewList(midx);
		return relist;
	}
	
}
