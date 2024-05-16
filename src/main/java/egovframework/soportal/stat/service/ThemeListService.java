package egovframework.soportal.stat.service;

import java.util.List;
import java.util.Map;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface ThemeListService {
	
	public List<Object> statThemeLookList(Params params);
	
	public Map<String, Object> mapStatDataList(Params params);
}
