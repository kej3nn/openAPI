package egovframework.portal.assm.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface AssmLawmService {

	public List<Record> searchAssmLawmCommCd(Params params);
	
	Paging searchLawmDegtMotnLgsb(Params params);
	
	Paging searchLawmClboMotnLgsb(Params params);
	
	Paging searchLawmVoteCond(Params params);
	
	Record selectLawmVoteCondResultCnt(Params params);
	
	public Object searchDegtMotnLgsbTreeMap(Params params);
	
	public Object searchDegtMotnLgsbColumn(Params params);
	
	public Object searchLawmClboMotnLgsbTreeMap(Params params);
	
	public Object searchLawmClboMotnLgsbColumn(Params params);
	
	Paging searchLawmSdcmAct(Params params);
	List<Record> selectLawmSdcmAct(Params params);
	
	Paging searchLawmRschOrg(Params params);
	List<Record> selectLawmRschOrg(Params params);
	
	Paging searchCombLawmPttnReport(Params params);
	
	Paging searchCombLawmVideoMnts(Params params);
	List<Record> selectCombLawmVideoMnts(Params params);

	List<Record> selectCombLawmPttnReport(Params params);
}
