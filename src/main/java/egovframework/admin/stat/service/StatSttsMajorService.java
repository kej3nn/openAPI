package egovframework.admin.stat.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface StatSttsMajorService {
	
	List<Record> statSttsMajorList(Params params);
	
	List<Record> statTblItmCombo(Params params);
	
	List<Record> statTblOptDtadvsCombo(Params params);
	
	Record statSttsMajorDtl(Params params);
	
	List<Record> statTblPopupList(Params params);
	
	Result deleteStatSttsMajor(Params params);
	
	Result saveStatSttsMajorOrder(Params params);
	
	Object saveStatSttsMajor(HttpServletRequest request, Params params);
}
