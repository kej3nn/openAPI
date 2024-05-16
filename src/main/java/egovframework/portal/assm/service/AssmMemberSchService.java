package egovframework.portal.assm.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface AssmMemberSchService {

	public List<Record> searchAssmMembCommCd(Params params);
	
	public Paging searchAssmMemberSchPaging(Params params);
	
	public int searchAssmMemberAllCnt();
	
	public int searchAssmHistMemberAllCnt(Params params);

	List<Record> selectAssmMemberSchPaging(Params params);
	
	List<Record> searchAssmNaElectCd(Params params);
}
