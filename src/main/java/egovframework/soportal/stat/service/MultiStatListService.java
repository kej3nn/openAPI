package egovframework.soportal.stat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface MultiStatListService {

	public Map<String, Object> selectMultiStatDtl(Params params);

	public Map<String, Object> multiTblItm(Params params);
	
	public List<Record> statMultiDtacycleList(Params params);
	
	public List<Record> statMultiTblDtadvs(Params params);
	
	public List<Record> statMultiPreviewList(Params params);
	
	public List<Record> statMultiWrtTimeOption(Params params);
	
	public List<Record> statMultiTblUi(Params params);
	
	public Record saveStatMultiUserTbl(Params params);
	
	public Record statMultiUserTbl(Params params);
	
	public List<Record> selectMultiName(Params params);
	
	public void makeStatTabMVal(Params params);
	
	public void downloadStatSheetDataCUD(HttpServletRequest request, HttpServletResponse response, Params params);
}
