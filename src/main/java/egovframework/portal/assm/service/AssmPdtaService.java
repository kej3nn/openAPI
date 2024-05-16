package egovframework.portal.assm.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface AssmPdtaService {

	Paging searchAssmPdta(Params params);
	
	List<Record> selectAssmPdta(Params params);
}
