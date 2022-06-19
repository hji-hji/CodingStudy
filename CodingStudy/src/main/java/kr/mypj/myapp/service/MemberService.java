package kr.mypj.myapp.service;

import java.util.ArrayList;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.MemberVo;

public interface MemberService {

	public int memberInsert(String memberId,String memberPwd,String memberName,String memberPhone,String memberEmail,String memberGender,String memberBirth);
		
	public int idCheck(String memberId);
	
	public MemberVo memberLogin(String memberId, String memberPwd);	
	
	public MemberVo memberSelectOne(int midx);
	
	public int memberModify(String memberName, String memberPhone, String memberEmail, String memberGender, String memberBirth, int midx);
	
	public int passwordChange(String memberPwd, int midx);
	
	public int memberDelete(int midx, String reason);
	
	public String memberIdFind(String memberName, String memberEmail);
	
	public String memberPwdFind(String memberId, String memberEmail);
	
	public ArrayList<ApplyDto> memberApplyList(int midx);
	
	public int memberApproveYnUpdate(int midx);
}
