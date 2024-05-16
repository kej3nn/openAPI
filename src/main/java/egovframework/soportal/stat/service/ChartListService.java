package egovframework.soportal.stat.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface ChartListService {

	public Map<String, Object> easyChartJson(Params params);
	
	public Map<String, Object> multiChartJson(Params params);
	
	public List<Record> statMapJsonDetail(Params params);
	
	public Map<String, Object> statMapDataJson(Params params);
	
}
