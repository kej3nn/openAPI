package egovframework.portal.mailing.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface PortalMailingService {
	
	public List<Record> selectPplrInfoRank(Params params);
	
	List<Record> selectCultureList(Params params);
	
	List<Record> selectWeekDateList(Params params);
	
	public List<Record> selectNaScheduleList(Params params);
}
