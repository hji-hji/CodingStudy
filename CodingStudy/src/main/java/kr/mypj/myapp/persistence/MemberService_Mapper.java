package kr.mypj.myapp.persistence;


import java.util.ArrayList;
import java.util.HashMap;

import kr.mypj.myapp.domain.ApplyDto;
import kr.mypj.myapp.domain.MemberVo;



public interface MemberService_Mapper {
		
	public int memberInsert(HashMap<String,String> hm);	
	
	public int idCheck(String memberId);
	
	//public ArrayList<StockNewsDto> stockNewsSelectAll(HashMap<String,String> hm);	

	public MemberVo memberLogin(String memberId, String memberPwd);
	
	public MemberVo memberSelectOne(int midx);
	
	public int memberModify(HashMap<String,Object> hm);	
	
	public int passwordChange(HashMap<String,Object> hm);
	
	public int memberDelete(HashMap<String,Object> hm);
	
	public String memberIdFind(String memberName, String memberEmail);
	
	public String memberPwdFind(String memberId, String memberEmail);

	public ArrayList<ApplyDto> memberApplyList(int midx);
	
	public int memberApproveYnUpdate(int midx);
	}
