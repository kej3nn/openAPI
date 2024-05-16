package egovframework.admin.stat.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatInputService {

	public Paging statInputMainListPaging(Params params);
	
	public Map<String, Object> statInputDtl(Map<String, String> paramMap);
	
	public Map<String, Object> selectStatInputItm(Params params);
	
	public List<Map<String, Object>> statInputList(Params params);
	
	public List<Map<String, Object>> statInputVerifyData(Params params);
	
	public ArrayList<ArrayList<String>> getStatInputSheetFormData(Params params);
	
	public List<Map<String, Object>> statInputCmmtListPaging(Params params);
	
	public Result saveStatInputData(Params params);
	
	public Result saveStatInputExcelData(Params params);
	
	public Result updateWrtstate(Params params);
	
	public Result saveStatInputMark(Params params);
	
	public Result saveStatInputCmmtData(Params params);
	
	public Record selectSttsTblDif(Params params);
	
	public Result saveStatInputDifData(Params params);
	
	List<Record> selectStatLogSttsWrtList(Params params);
	
}
