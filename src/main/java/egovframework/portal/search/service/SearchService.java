package egovframework.portal.search.service;

import java.util.HashMap;

import egovframework.common.base.model.Params;

public interface SearchService {
	
	public SearchResultVO getSearch(SearchVO srchVo) ;
	
	public HashMap<String, Object> getGroup(SearchVO srchVo) ;
	
	public String getArk(Params params) ;
	
	public String getPopword(Params params) ;
	
}
