package egovframework.portal.bpm.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

public interface BpmDateService {

	Paging searchDate(Params params);
	
	List<Record> searchDateCalendar(Params params);
}
