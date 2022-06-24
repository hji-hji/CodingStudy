package kr.mypj.myapp.service;

import java.util.ArrayList;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.MemberVo;
import kr.mypj.myapp.domain.ReviewDto;

public interface MemberService {

	public int memberInsert(String memberId,String memberPwd,String memberName,String memberPhone,String memberEmail,String memberGender,String memberBirth,String memberApproveYn);
		
	public int idCheck(String memberId);
	
	public MemberVo memberLogin(String memberId);	
	
	public MemberVo memberSelectOne(int midx);
	
	public int memberModify(String memberName, String memberPhone, String memberEmail, String memberGender, String memberBirth, int midx);
	
	public int passwordChange(String memberPwd, int midx);
	
	public int memberDelete(int midx, String reason);
	
	public String memberIdFind(String memberName, String memberEmail);
	
	public String memberPwdFind(String memberId, String memberEmail);
	
	public ArrayList<ApplyDto> memberApplyList(int midx);
	
	public int memberApproveYnUpdate(int midx);
	
	public ArrayList<ReviewDto> memberReviewList(int midx);
	
	public int updatePwd(String memberId, String randomPwd); 
	
	//이메일발송
	public void sendEmail(MemberVo mv, String div) throws Exception;
	
	public int keeplogin(int midx, String sessionKey, String sessionLimit);
	
	public MemberVo checkAutoLogin(String sessionKey);
	
	
	
	
	
	
}
