package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatPreviewService {
	
	public Map<String, Object> statTblItm(Params params);
	
	public List<Record> ststPreviewList(Params params);
	
	public List<Record> statWrtTimeOption(Params params);
	
	public List<Record> statTblUi(Params params);
	
	public List<Record> statTblDtadvs(Params params);
	
	public List<Record> statTblOptVal(Params params);
	
	public List<Record> statTblItmJson(Params params);
	
	public List<Record> statCmmtList(Params params);
	
	public List<Record> statSttsStatMetaList(Params params);
	
	public Record statSttsTblDtl(Params params);
	
	public List<Record> statSttsTblReferenceStatId(Params params);
	
	public Record downloadStatMetaFile(Params params);
	
	public Map<String, Object> statTblDtl(Params params);
	
	public List<Record> statCheckedDtacycleList(Params params);
}
