package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Result;

public interface StatStddMetaService {
	
	public List<Map<String, Object>> statStddMetaListPaging(Params params);
	
	public Map<String, Object> statStddMetaDtl(Map<String, String> paramMap);
	
	public Result saveStatStddMeta(Params params);
	
	public Result saveStatStddMetaOrder(Params params);

}
