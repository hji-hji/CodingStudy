package kr.mypj.myapp.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.stereotype.Component;

@Component
public class PageMaker {
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;	
	private int displayPageNum = 10;	//  <- 1 2 3 4 5 6 7 8 9 10 ->
	private SearchCriteria scri;
	
	public SearchCriteria getScri() {
		return scri;
	}
	public void setScri(SearchCriteria scri) {
		this.scri = scri;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	//	System.out.println("totalCount:"+totalCount);
		calcData();
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}	
	
	public void calcData(){
		endPage = (int) (Math.ceil(scri.getPage()/(double)displayPageNum) * displayPageNum);
	//	System.out.println("endPage:"+endPage);
		
		startPage = (endPage - displayPageNum)+1;
		
		int tempEndPage = (int) (Math.ceil(totalCount/(double) scri.getPerPageNum()));
//		System.out.println("tempEndPage:"+tempEndPage);

		if(endPage>tempEndPage) {
			endPage = tempEndPage;
		}		
		prev = startPage == 1 ? false : true;		
		next = endPage * scri.getPerPageNum() >= totalCount ? false : true;
	}	
	
//	public String makeQuery(int page){
//		UriComponents uriComponents = 
//				UriComponentsBuilder
//				.newInstance()
//				.queryParam("page", page)
//			//	.queryParam("perPageNum", scri.getPerPageNum())
//				.build();
//				
//		return uriComponents.toUriString();
//	}
	
//	public String makeSearch(int page){
//		UriComponents uriComponents = 
//				UriComponentsBuilder
//				.newInstance()
//				.queryParam("page", page)
//			//	.queryParam("perPageNum", scri.getPerPageNum())
//				.queryParam("searchType", sscri.getSearchType())
//				.queryParam("keyword", encoding(sscri.getKeyword()))
//				.build();
//				
//		return uriComponents.toUriString();
//	}
	
	public String encoding(String keyword){
		
		if(keyword==null || keyword.trim().length()==0){
			return "";
		}		
		try{
			return URLEncoder.encode(keyword, "UTF-8");
		}catch(UnsupportedEncodingException e){
			return "";			
		}
	}
	
	}

