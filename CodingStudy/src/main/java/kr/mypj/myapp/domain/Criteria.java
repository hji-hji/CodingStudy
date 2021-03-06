package kr.mypj.myapp.domain;

public class Criteria {

	public Criteria(){
		this.page = 1;
		this.perPageNum = 15;
	}	
	
	private int page;			// 페이지
	private int perPageNum;  // 화면리스트 출력개수
	private String gubun;	
	
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}	
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page <=1){
			this.page = 1;
			return;
		}
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <=0 || perPageNum > 100){ 		
			this.perPageNum = 15;
			return;
		}
		this.perPageNum = perPageNum;
	}
	public int  getPageStart(){
		//return(this.page-1)*perPageNum+1;
		return(this.page-1)*perPageNum;
	}
	public int  getPageEnd(){
		return (this.page-1)*perPageNum + perPageNum;
		
	}
	
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
}