package egovframework.portal.search.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.nhncorp.lucy.security.xss.XssPreventer;

import egovframework.common.grid.CommVo;
/**
 * 검색결과
 * @author wisenut
 * @since 2019.11.06
 * @version 1.0
 * @see
 *
 */
@SuppressWarnings("serial")
public class SearchVO extends CommVo implements Serializable {
	
	
	private String searchIp;
	private int searchPort;
	private int managerPort;
	private int simplePort;
	private int searchTimeOut;
	private String collection = "ALL";
	
	private String startDate = "19300101"; //시작일
	private String endDate ; //종료일
	private String sort; //정렬항목
	private String sortOrder; //desc/asc 
	private String searchField; //검색필드 title /content
	private String dateRange = "A";
	private String groupField = "A";
	private String detailYn = "N";
	
	/** 디버그 YN*/
	private String debug = "Y";
	private String exquery="";
	/** 검색어 */
	private String query = "" ;
	/** 검색어(최종) */
	private String realQuery = "" ;
	/** 결과내 재검색*/
	private String reQuery = "";
	
	private String colTab = "";
	
	private int startCount = 1;
	private int viewCount = 3;
	
	
	
	
	private List<SearchVO> searchList;

	
	public String getSearchIp() {
		return searchIp;
	}

	public void setSearchIp(String searchIp) {
		this.searchIp = searchIp;
	}

	public int getSearchPort() {
		return searchPort;
	}

	public void setSearchPort(int searchPort) {
		this.searchPort = searchPort;
	}

	public int getManagerPort() {
		return managerPort;
	}

	public void setManagerPort(int managerPort) {
		this.managerPort = managerPort;
	}

	public int getSimplePort() {
		return simplePort;
	}

	public void setSimplePort(int simplePort) {
		this.simplePort = simplePort;
	}

	public int getSearchTimeOut() {
		return searchTimeOut;
	}

	public void setSearchTimeOut(int searchTimeOut) {
		this.searchTimeOut = searchTimeOut;
	}

	public String getCollection() {
		return collection;
	}

	public void setCollection(String collection) {
		this.collection = collection;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	public String getSearchField() {
		return searchField;
	}

	public void setsearchField(String searchField) {
		this.searchField = searchField;
	}

	public String getDebug() {
		return debug;
	}

	public void setDebug(String debug) {
		this.debug = debug;
	}

	public String getExquery() {
		return exquery;
	}

	public void setExquery(String exquery) {
		this.exquery = exquery;
	}

	public String getQuery() {
		return XssPreventer.escape(query);
//		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public String getRealQuery() {
		return realQuery;
	}

	public void setRealQuery(String realQuery) {
		this.realQuery = realQuery;
	}

	public String getReQuery() {
		return reQuery;
	}

	public void setReQuery(String reQuery) {
		this.reQuery = reQuery;
	}

	public int getStartCount() {
		return startCount;
	}

	public void setStartCount(int startCount) {
		this.startCount = startCount;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	
	public String getColTab() {
		return colTab;
	}

	public void setColTab(String colTab) {
		this.colTab = colTab;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}

	public List<SearchVO> getSearchList() {
		List<SearchVO> searchListR;
		if ( searchList != null && searchList.size() > 0 ) {
			searchListR = new ArrayList<SearchVO>();
			for (SearchVO c : searchList) {
				searchListR.add(c);
			}
			return searchListR;
		}
		else {
			return null;
		}
	}
	
	public void setSearchList(List<SearchVO> searchList) {
		if ( searchList != null && searchList.size() > 0 ) {
			this.searchList = new ArrayList<SearchVO>();
			for ( int i=0; i < searchList.size(); i++ ) {
				if ( searchList.get(i) != null ) {
					this.searchList.add(searchList.get(i));
				}
			}
		}
		else {
			this.searchList = null;
		}
	}
	
	
	public String getDateRange() {
		return dateRange;
	}

	public void setDateRange(String dateRange) {
		this.dateRange = dateRange;
	}
	

	public String getGroupField() {
		return groupField;
	}

	public void setGroupField(String groupField) {
		this.groupField = groupField;
	}
	
	

	public String getDetailYn() {
		return detailYn;
	}

	public void setDetailYn(String detailYn) {
		this.detailYn = detailYn;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
}

}