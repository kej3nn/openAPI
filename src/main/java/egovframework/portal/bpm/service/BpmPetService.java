package egovframework.portal.bpm.service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;

public interface BpmPetService {

	Paging searchPetAssmMemb(Params params);
	
	Paging searchPetAprvNa(Params params);
}
