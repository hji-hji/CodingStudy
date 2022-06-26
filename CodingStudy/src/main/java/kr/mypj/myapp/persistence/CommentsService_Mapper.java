package kr.mypj.myapp.persistence;

import java.util.ArrayList;

import kr.mypj.myapp.domain.CommentsVo;


public interface CommentsService_Mapper {
	
	public ArrayList<CommentsVo> selectCommentsAll(int bidx);
	
	public ArrayList<CommentsVo> getCommentsMore(int bidx, int blcok_perBlockNum);
	
	public int insertComments(CommentsVo cv);

	public int deleteComments(CommentsVo cv);
	
	public int  commentsCnt(int bidx);
	
	
}
