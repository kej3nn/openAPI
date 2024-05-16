package egovframework.portal.search.service;

import java.io.Serializable;
import java.util.ArrayList;



import java.util.HashMap;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.json.simple.JSONObject;

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
public class SearchResultVO extends CommVo implements Serializable {
	
	private String debugStr = "";
	private int errorCode = 0;
	private ArrayList<CollectionVO> collectionList = null;
	private int allCount = 0;
	//private HashMap<String, Object> hMap = null;
	
	public String getDebugStr() {
		return debugStr;
	}
	public void setDebugStr(String debugStr) {
		this.debugStr = debugStr;
	}
	public int getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}

	public ArrayList<CollectionVO> getCollectionList() {
		ArrayList<CollectionVO> collectionListR;
		if ( collectionList != null && collectionList.size() > 0 ) {
			collectionListR = new ArrayList<CollectionVO>();
			for (CollectionVO c : collectionList) {
				collectionListR.add(c);
			}
			return collectionListR;
		}
		else {
			return null;
		}
		
	}
	
	public void setCollectionList(ArrayList<CollectionVO> collectionList) {
		if ( collectionList != null && collectionList.size() > 0 ) {
			this.collectionList = new ArrayList<CollectionVO>();
			for ( int i=0; i < collectionList.size(); i++ ) {
				if ( collectionList.get(i) != null ) {
					this.collectionList.add(collectionList.get(i));
				}
			}
		}
		else {
			this.collectionList = null;
		}
	}
	

	public int getAllCount() {
		return allCount;
	}
	public void setAllCount(int allCount) {
		this.allCount = allCount;
	}
	
/*	public HashMap<String, Object> gethMap() {
		return hMap;
	}
	public void sethMap(HashMap<String, Object> hMap) {
		this.hMap = hMap;
	}*/
	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
	

}