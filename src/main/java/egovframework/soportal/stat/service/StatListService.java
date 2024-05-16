package egovframework.soportal.stat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatListService {

	public List<Record> selectOption(Params params);
	
	public List<Record> selectSTTSOption(Params params);
	
	public List<Record> statDtacycleList(Params params);
	
	public List<Record> statWrtTimeOption(Params params);
	
	public List<Record> statQrtTimeOption(Params params);
	
	public List<Record> statTblUi(Params params);
	
	public List<Record> statTblDtadvs(Params params);
	
	public List<Map<String, Object>> statEasyList(Params params);
	
	public List<Map<String, Object>> statHitList(Params params);
	
	public List<Record> statNewList(Params params);
	
	public Paging statMobileListPaging(Params params);
	
	public List<Record> statEasySearchList(Params params);
	
	public Map<String, Object> selectStatDtl(Params params);
	
	//public List<Map<String, Object>> statItmJson(Params params);
	public List<Record> statItmJson(Params params);
	
	public Map<String, Object> statTblItm(Params params);
	
	public List<Record> ststPreviewList(Params params);
	
	public Record statUserTbl(Params params);
	
	public Record saveStatUserTbl(Params params);
	
	public void insertLogSttsStat(Params params);
	
	public void insertLogSttsTbl(Params params);
	
	public List<Record> statCateTopList(Params params);

	public List<Record> statHistDtacycleList(Params params);
	
	public List<Record> statHisSttsCycleList(Params params);
	
	public void downloadStatSheetDataCUD(HttpServletRequest request, HttpServletResponse response, Params params);
	
	public List<Record> selectContentsList(Params params);
	
	public Paging selectContentsFileList(Params params);
	
	public Map<String, Object> selectContentsNabo(Params params);
	
	public Paging selectContentsNaboList(Params params);
	
	public List<Record> selectDtlAnalysisList(Params params);
	
	public List<Record> statEasyOriginList(Params params);
	
	public List<Record> selectStatCmmtList(Params params);
	
	public Record selectSttsCateInfo(String statblId);
	
	public Record selectSttsMeta(Params params);
	
	public Record insertSttsTblAppr(Params params);
	
}
