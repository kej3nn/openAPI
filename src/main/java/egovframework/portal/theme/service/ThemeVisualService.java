package egovframework.portal.theme.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface ThemeVisualService {
	public Object selectTreeMapData(Params params);
	
	public Object selectColumnReeleData(Params params);
	
	public Object selectPieData(Params params);
	
	public Object selectColumnAgeData(Params params);
	
	public Object selectHgNumSeat(Params params);
	
	public Object selectParliamentData(Params params);
}
