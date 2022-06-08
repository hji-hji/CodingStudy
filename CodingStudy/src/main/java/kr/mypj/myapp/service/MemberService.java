package kr.mypj.myapp.service;

import kr.mypj.myapp.domain.MemberVo;

public interface MemberService {

	public int memberInsert(String memberId,String memberPwd,String memberName,String memberPhone,String memberEmail,String memberGender,String memberBirth);
		
	public int idCheck(String memberId);
	
	public MemberVo memberLogin(String memberId, String memberPwd);	
	
	public MemberVo memberSelectOne(int midx);
	
	public int memberModify(String memberName, String memberPhone, String memberEmail, String memberGender, String memberBirth, int midx);
	
	public int passwordChange(String memberPwd, int midx);
	
	public int memberDelete(int midx, String reason);
}
