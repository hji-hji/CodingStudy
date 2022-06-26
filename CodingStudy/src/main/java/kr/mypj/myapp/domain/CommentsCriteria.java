package kr.mypj.myapp.domain;

public class CommentsCriteria {

	private int block;
	private int perBlockNum;
	
	public CommentsCriteria(){
		this.block = 1;
		this.perBlockNum = 10;
	}
	
	public int getBlock() {
		return block;
	}
	public void setBlock(int block) {
		if(block <=1){
			this.block = 1;
			return;
		}
		this.block = block;
	}
	public int getPerBlockNum() {
		return perBlockNum;
	}
	public void setPerBlockNum(int perBlockNum) {
		if(perBlockNum <=0 || perBlockNum > 100){ 		
			this.perBlockNum = 10;
			return;
		}
		this.perBlockNum = perBlockNum;
	}
	
//	public int getNextBlock(){
//		int block =0;
//		
//		block = this.block+1;		
//		return block;
//	}	
	
	@Override
	public String toString() {
		return "CommentsCriteria [block=" + block + ", perBlockNum=" + perBlockNum + "]";
	}
}