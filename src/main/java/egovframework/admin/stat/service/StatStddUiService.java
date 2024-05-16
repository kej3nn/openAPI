package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatStddUiService {
	
	public List<Record> statStddUiList(Params params);
	
	public Map<String, Object> statStddUiDtl(Map<String, String> paramMap);
	
	public Result saveStatStddUi(Params params);
	
	public Map<String, Integer> statStddUiDupChk(Params params);
	
	Result saveStatStddUiOrder(Params params);
	
	public List<Record> statStddGrpUiListPaging(Params params);
	
	public List<Record> statStddUiPopList(Params params);

}
