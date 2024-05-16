package egovframework.portal.search.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

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
public class CollectionVO extends CommVo implements Serializable {
	
	
	//컬렉션의 검색결과 리스트
		private ArrayList<HashMap<String, Object>> srchList = null;
		//컬렉션의 총검색 건수
		private int totalCount = 0;
		//걸렉션의 반환되는 검색 건수
		private int resultCount = 0;
		
		private int allCount = 0;
		
		//컬렉션 영문명
		private String colIndexName = "";
		//컬렉션 한글명
		private String colDisplayName = "";
		

		public ArrayList<HashMap<String, Object>> getSrchList() {
			//return srchList;
			
			ArrayList<HashMap<String, Object>> searchListR;
			if ( srchList != null && srchList.size() > 0 ) {
				searchListR = new ArrayList<HashMap<String, Object>>();
				for (HashMap<String, Object> c : srchList) {
					searchListR.add(c);
				}
				return searchListR;
			}
			else {
				return null;
			}
		}

		public void setSrchList(ArrayList<HashMap<String, Object>> srchList) {
			
			if ( srchList != null && srchList.size() > 0 ) {
				this.srchList =  new ArrayList<HashMap<String, Object>>();
				for ( int i=0; i < srchList.size(); i++ ) {
					if ( srchList.get(i) != null ) {
						this.srchList.add(srchList.get(i));
					}
				}
			}
			else {
				this.srchList = null;
			}
		}
		public int getTotalCount() {
			return totalCount;
		}

		public void setTotalCount(int totalCount) {
			this.totalCount = totalCount;
		}

		public int getResultCount() {
			return resultCount;
		}

		public void setResultCount(int resultCount) {
			this.resultCount = resultCount;
		}

		public String getColIndexName() {
			return colIndexName;
		}

		public void setColIndexName(String colIndexName) {
			this.colIndexName = colIndexName;
		}

		public String getColDisplayName() {
			return colDisplayName;
		}

		public void setColDisplayName(String colDisplayName) {
			this.colDisplayName = colDisplayName;
		}
		

		public int getAllCount() {
			return allCount;
		}

		public void setAllCount(int allCount) {
			this.allCount = allCount;
		}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
}

}