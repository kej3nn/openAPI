package egovframework.portal.bpm.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface BpmPrcService {

	Paging searchPrcDate(Params params);
	
	Paging searchPrcItmPrcLaw(Params params);
	
	Paging searchPrcItmPrcBdg(Params params);
	
	Paging searchPrcPrcd(Params params);
	
	List<Record> selectPrcDate(Params params);
	
	List<Record> selectPrcItmPrcLaw(Params params);
	
	List<Record> selectPrcItmPrcBdg(Params params);
	
	List<Record> selectPrcPrcd(Params params);
}
