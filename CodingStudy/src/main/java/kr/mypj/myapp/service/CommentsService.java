package kr.mypj.myapp.service;

import java.util.ArrayList;

import kr.mypj.myapp.domain.CommentsVo;


public interface CommentsService {
	
	public ArrayList<CommentsVo> selectCommentsAll(int bidx);
	
	public ArrayList<CommentsVo> getCommentsMore(int bidx, int blcok,int perBlockNum);
	
	public int insertComments(CommentsVo cv);

	public int deleteComments(CommentsVo cv);
	
	public int  commentsCnt(int bidx);
}
