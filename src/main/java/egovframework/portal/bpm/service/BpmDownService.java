package egovframework.portal.bpm.service;

import java.util.Map;

import egovframework.common.base.model.Params;

public interface BpmDownService {

	Map<String, Object> setPrcData(Params params);
	
	Map<String, Object> setCmpData(Params params);
	
	Map<String, Object> setDateData(Params params);
	
	Map<String, Object> setCohData(Params params);
	
	Map<String, Object> setPetData(Params params);
	
}
