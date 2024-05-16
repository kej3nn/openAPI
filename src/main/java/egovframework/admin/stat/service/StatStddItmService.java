package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

public interface StatStddItmService {
	
	public List<Map<String, Object>> statStddItmListPaging(Params params);
	
	public Map<String, Object> statStddItmDtl(Map<String, String> paramMap);
	
	public Result saveStatStddItm(Params params);
	
	public Result saveStatStddItmNm(Params params);
	
	public Result saveStatStddItmOrder(Params params);

}
