package kr.mypj.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.MemberVo;
import kr.mypj.myapp.domain.ReviewDto;
import kr.mypj.myapp.persistence.MemberService_Mapper;
import kr.mypj.myapp.util.MailHandler;


@Service
public class MemberServiceImpl implements MemberService  {

	MemberService_Mapper msm;
	
	@Autowired(required=false)
	JavaMailSender mailSender;
	 
	
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

	@Override
	public int updatePwd(String memberId, String randomPwd) {
		int value = msm.updatePwd(memberId, randomPwd);
		return value;
	}

	@Override
	public void sendEmail(MemberVo mv, String div) throws Exception {
		
	//	System.out.println("mailSender"+mailSender);
		
		String FROM_ADDRESS = "codingssam@codingssam.com";
		
		String subject = "";
		String msg = "";
		
		if(div.equals("findpw")) {
			subject = "코딩쌤 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += mv.getMemberId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += mv.getMemberPwd() + "</p></div>";		
		}
		try {
			MailHandler mailHandler = new MailHandler(mailSender);
			mailHandler.setTo(mv.getMemberEmail());
			mailHandler.setFrom(FROM_ADDRESS);
			mailHandler.setSubject(subject);
			String htmlContent =  msg;
			mailHandler.setText(htmlContent, true);
			mailHandler.send();
			
		}catch(Exception e) {
			e.printStackTrace();
		}		
	
	}
	
	
	public int keeplogin(int midx, String sessionKey, String sessionLimit) {
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("midx", midx);
		map.put("sessionKey", sessionKey);
		map.put("sessionLimit", sessionLimit);				
		
		int result = msm.keepLogin(map);	
		System.out.println("result"+result);
		return result;
	}
	
	public MemberVo checkAutoLogin(String sessionKey){		
		
		MemberVo mv = msm.checkAutoLogin(sessionKey);
		
		return 	mv;	
	}
	
	
	public int memberLogOut(int midx) {
		
		int value = msm.memberLogOut(midx);
		
		return value;
	}
	
	
	
}
