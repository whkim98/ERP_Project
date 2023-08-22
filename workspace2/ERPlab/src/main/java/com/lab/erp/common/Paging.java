package com.lab.erp.common;

public class Paging {
	private final int perPage = 2;
	private int pageCount;
	private int boardCount;
	private int first;
	private int last;
	private final int perSection = 4;
	private int begin;
	private int end;
	private int section;
	private int page;
	
	private boolean prev;
	private boolean next;
	
	public Paging(int page,int boardCount) {
		this.page = page;
		this.boardCount = boardCount;
		
		pageCount = boardCount / perPage;
		pageCount += (boardCount % perPage) == 0 ? 0 : 1;
		
		first = (page - 1) * perPage + 1;
		last = first + perPage - 1;
		
		section = (page - 1) / perSection;
		
		begin = perSection * section + 1;
		end = begin + perSection - 1;
		end = end > pageCount ? pageCount : end;
		
		prev = section != 0;
		next = boardCount > perPage * end;
	}
	
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}
	public int getFirst() {
		return first;
	}
	public void setFirst(int first) {
		this.first = first;
	}
	public int getLast() {
		return last;
	}
	public void setLast(int last) {
		this.last = last;
	}
	public int getBegin() {
		return begin;
	}
	public void setBegin(int begin) {
		this.begin = begin;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getSection() {
		return section;
	}
	public void setSection(int section) {
		this.section = section;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
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
	public int getPerPage() {
		return perPage;
	}
	public int getPerSection() {
		return perSection;
	}
}
