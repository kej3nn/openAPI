package egovframework.admin.stat.service;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface StatUsageStateService {

	public List<Record> statUsageStateList(Params params);
	
	public Record statUsageStateChart(Params params);
	
	public List<Record> menuUsageStateList(Params params);
	
	public List<Record> cateUsageStateList(Params params);
	
	public List<Record> statblUsageStateList(Params params);
	
	public List<Record> orgUsageStateList(Params params);
	
	public Paging selectUserUsageStateListPaging(Params params);
	
	public Paging selectApiUsageStateListPaging(Params params);
	
	public List<LinkedHashMap<String,?>> userUsageStatePie(Params params) throws DataAccessException, Exception;
	
	public List<LinkedHashMap<String,?>> apiUsageStateGraph(Params params) throws DataAccessException, Exception;
	
}
