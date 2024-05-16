package egovframework.portal.bpm.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface BpmCmpService {
	
	List<Record> selectCmpDivCdList(Params params);
	
	List<Record> selectCommitteeCdList(Params params);
	
	List<Record> selectPolyGroupList(Params params);
	
	Paging searchCmpCond(Params params);
	
	Paging searchCmpList(Params params);
	
	Paging searchCmpDate(Params params);
	
	Paging searchCmpMoob(Params params);
	
	public List<Record> searchCmpMoobCommCd(Params params);
	
	Paging searchCmpRefR(Params params);
	
	Paging searchCmpReport(Params params);
}
