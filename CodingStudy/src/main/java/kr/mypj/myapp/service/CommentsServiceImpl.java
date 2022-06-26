package kr.mypj.myapp.service;

import java.util.ArrayList;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mypj.myapp.domain.CommentsVo;
import kr.mypj.myapp.persistence.CommentsService_Mapper;


@Service("commentsServiceImpl")
public class CommentsServiceImpl implements CommentsService {

	CommentsService_Mapper csm;
	
	@Autowired
	public CommentsServiceImpl(SqlSession sqlSession) {		
		this.csm =sqlSession.getMapper(CommentsService_Mapper.class);
		
	}	
	
	@Override
	public ArrayList<CommentsVo> selectCommentsAll(int bidx) {
	
		ArrayList<CommentsVo> alist =  csm.selectCommentsAll(bidx);
		
		return alist;
	}
	
	@Override
	public ArrayList<CommentsVo> getCommentsMore(int bidx, int block,int perBlockNum) {
			
		int blcok_perBlockNum = block*perBlockNum;
		ArrayList<CommentsVo> alist =  csm.getCommentsMore(bidx,blcok_perBlockNum);
		
		return alist;
	}
	

	@Override
	public int insertComments(CommentsVo cv) {						
		
		int result = csm.insertComments(cv);	

		return result;
	}

	@Override
	public int deleteComments(CommentsVo cv) {		
		
		int result = csm.deleteComments(cv);		
		
		return result;
	}

	@Override
	public int commentsCnt(int bidx) {
		int value = csm.commentsCnt(bidx);
		return value;
	}

}
