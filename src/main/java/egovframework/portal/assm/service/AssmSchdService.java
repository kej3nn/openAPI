package egovframework.portal.assm.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface AssmSchdService {

	Paging searchAssmSchd(Params params);
	
	List<Record> selectAssmSchd(Params params);
}
